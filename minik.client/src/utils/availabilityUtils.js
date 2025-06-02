/* This util creating ranges dates for availability by looking at the availability, reservations and maintenance dates
 and returns the ranges of dates that are available
 It takes the availability, reservations and maintenance dates as input and returns the ranges of dates that are available

example usage 
maintenance table
id	tinyHouseId	maintenanceType	maintenanceDate	maintenanceStatus
6	6	Yol Bakımı	2025-04-23	pending


id tinyHouseId availabile_from  availabile_to is_available
6	6	2025-05-01	2025-05-10	True


id  userId tinyHouseId check_in check_out total_price reservationStatus
4	4	6	2025-05-07	2025-05-10	4800,00	confirmed


reservationStatus can be pending, confirmed, cancelled, completed

maintenanceStatus can be pending, completed, cancelled

so we need to return the ranges of dates that are available
if maintenance is pending is_available is false rezervation status is confirmed then this cases house not availible
 */ 

import { 
  getAvailabilityByTinyHouseId, 
  getMaintenancesByTinyHouseId, 
  getReservationsByTinyHouseId 
} from '../services/availabity.js';

/**
 * Fetches all availability data for a specific tiny house
 * @param {number} tinyHouseId - The ID of the tiny house
 * @returns {Promise<Object>} Object containing availability, maintenance, and reservation data
 */
export const fetchAvailabilityData = async (tinyHouseId) => {
  try {
    const [availability, maintenances, reservations] = await Promise.all([
      getAvailabilityByTinyHouseId(tinyHouseId),
      getMaintenancesByTinyHouseId(tinyHouseId),
      getReservationsByTinyHouseId(tinyHouseId)
    ]);

    return {
      availability,
      maintenances,
      reservations
    };
  } catch (error) {
    console.error('Error fetching availability data:', error);
    throw error;
  }
};

/**
 * Converts a date string to Date object at start of day
 * @param {string} dateStr - Date string
 * @returns {Date} Date object
 */
const toDate = (dateStr) => {
  const date = new Date(dateStr);
  date.setHours(0, 0, 0, 0);
  return date;
};

/**
 * Checks if two date ranges overlap
 * @param {Date} start1 - Start date of first range
 * @param {Date} end1 - End date of first range
 * @param {Date} start2 - Start date of second range
 * @param {Date} end2 - End date of second range
 * @returns {boolean} True if ranges overlap
 */
const dateRangesOverlap = (start1, end1, start2, end2) => {
  return start1 <= end2 && end1 >= start2;
};

/**
 * Gets all unavailable date ranges based on maintenance and reservations
 * @param {Array} maintenances - Array of maintenance records
 * @param {Array} reservations - Array of reservation records
 * @returns {Array} Array of unavailable date ranges
 */
const getUnavailableDateRanges = (maintenances, reservations) => {
  const unavailableRanges = [];

  // Add pending maintenance dates
  maintenances.forEach(maintenance => {
    if (maintenance.maintenanceStatus === 'pending') {
      const maintenanceDate = toDate(maintenance.maintenanceDate);
      unavailableRanges.push({
        start: maintenanceDate,
        end: maintenanceDate,
        reason: 'maintenance'
      });
    }
  });

  // Add confirmed reservation date ranges
  reservations.forEach(reservation => {
    if (reservation.reservationStatus === 'confirmed' || reservation.reservationStatus === 'pending') {
      unavailableRanges.push({
        start: toDate(reservation.check_in),
        end: toDate(reservation.check_out),
        reason: 'reservation'
      });
    }
  });

  return unavailableRanges;
};

/**
 * Checks if a requested date range is available for reservation
 * @param {string} requestedStartDate - Requested start date
 * @param {string} requestedEndDate - Requested end date
 * @param {number} tinyHouseId - The ID of the tiny house
 * @returns {Promise<boolean>} True (1) if available, False (0) if not available
 */
export const checkDateRangeAvailability = async (requestedStartDate, requestedEndDate, tinyHouseId) => {
  try {
    const { availability, maintenances, reservations } = await fetchAvailabilityData(tinyHouseId);
    
    const requestedStart = toDate(requestedStartDate);
    const requestedEnd = toDate(requestedEndDate);

    // Check if tiny house has any availability periods
    if (!availability || availability.length === 0) {
      return 0; // Not available
    }

    // Check if requested dates fall within available periods
    let isWithinAvailablePeriod = false;
    for (const period of availability) {
      if (period.is_available) {
        const availableStart = toDate(period.availabile_from);
        const availableEnd = toDate(period.availabile_to);
        
        if (requestedStart >= availableStart && requestedEnd <= availableEnd) {
          isWithinAvailablePeriod = true;
          break;
        }
      }
    }

    if (!isWithinAvailablePeriod) {
      return 0; // Not within any available period
    }

    // Get all unavailable date ranges
    const unavailableRanges = getUnavailableDateRanges(maintenances, reservations);

    // Check if requested dates overlap with any unavailable period
    for (const unavailable of unavailableRanges) {
      if (dateRangesOverlap(requestedStart, requestedEnd, unavailable.start, unavailable.end)) {
        return 0; // Overlaps with unavailable period
      }
    }

    return 1; // Available
  } catch (error) {
    console.error('Error checking date availability:', error);
    return 0; // Return not available on error
  }
};

/**
 * Gets all available date ranges for a tiny house
 * @param {number} tinyHouseId - The ID of the tiny house
 * @returns {Promise<Array>} Array of available date ranges
 */
export const getSelectableDateRanges = async (tinyHouseId) => {
  try {
    const { availability, maintenances, reservations } = await fetchAvailabilityData(tinyHouseId);
    
    if (!availability || availability.length === 0) {
      return [];
    }

    const selectableRanges = [];
    
    // Process each availability period
    for (const period of availability) {
      if (period.is_available) {
        const periodStart = toDate(period.availabile_from);
        const periodEnd = toDate(period.availabile_to);
        
        // Get unavailable ranges
        const unavailableRanges = getUnavailableDateRanges(maintenances, reservations);
        
        // Sort unavailable ranges by start date
        unavailableRanges.sort((a, b) => a.start - b.start);
        
        // Find available slots within this period
        let currentStart = periodStart;
        
        for (const unavailable of unavailableRanges) {
          // If unavailable range is completely outside this period, skip
          if (unavailable.end < periodStart || unavailable.start > periodEnd) {
            continue;
          }
          
          // If there's a gap before this unavailable range, add it as available
          if (currentStart < unavailable.start) {
            selectableRanges.push({
              start: new Date(currentStart),
              end: new Date(unavailable.start.getTime() - 24 * 60 * 60 * 1000) // Day before unavailable starts
            });
          }
          
          // Move current start to after the unavailable period
          currentStart = new Date(unavailable.end.getTime() + 24 * 60 * 60 * 1000); // Day after unavailable ends
        }
        
        // If there's still time left in the period after all unavailable ranges
        if (currentStart <= periodEnd) {
          selectableRanges.push({
            start: new Date(currentStart),
            end: new Date(periodEnd)
          });
        }
      }
    }
    
    return selectableRanges;
  } catch (error) {
    console.error('Error getting selectable date ranges:', error);
    return [];
  }
};

/**
 * Utility function to format date ranges for display
 * @param {Array} dateRanges - Array of date range objects
 * @returns {Array} Formatted date ranges
 */
export const formatDateRanges = (dateRanges) => {
  return dateRanges.map(range => ({
    start: range.start.toISOString().split('T')[0],
    end: range.end.toISOString().split('T')[0],
    startFormatted: range.start.toLocaleDateString('tr-TR'),
    endFormatted: range.end.toLocaleDateString('tr-TR')
  }));
}; 
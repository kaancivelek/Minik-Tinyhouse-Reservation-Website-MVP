import React, { useEffect, useState } from "react";
import DatePicker, { registerLocale } from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import { getSelectableDateRanges } from "../utils/availabilityUtils";
import { addDays, isWithinInterval, format, isSameDay } from "date-fns";
import { tr } from "date-fns/locale";
import "../styles/ReservationCalendar.css";

// Register Turkish locale
registerLocale("tr", tr);

function ReservationCalendar({ tinyHouse, startDate, endDate, onDateChange }) {
  const [selectableRanges, setSelectableRanges] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [monthsToShow, setMonthsToShow] = useState(1);

  useEffect(() => {
    const handleResize = () => {
      setMonthsToShow(window.innerWidth > 768 ? 2 : 1);
    };

    handleResize(); // Set initial value
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  useEffect(() => {
    const fetchSelectableRanges = async () => {
      setIsLoading(true);
      try {
        const ranges = await getSelectableDateRanges(tinyHouse.id);
        setSelectableRanges(ranges);
      } catch (error) {
        console.error("Error fetching selectable ranges:", error);
      } finally {
        setIsLoading(false);
      }
    };

    fetchSelectableRanges();
  }, [tinyHouse.id]);

  // Check if a date is available
  const isDateAvailable = (date) => {
    return selectableRanges.some(range => 
      isWithinInterval(date, { start: range.start, end: range.end })
    );
  };

  // Get all dates between two dates
  const getDatesInRange = (start, end) => {
    const dates = [];
    let currentDate = new Date(start);
    
    while (currentDate <= end) {
      dates.push(new Date(currentDate));
      currentDate = addDays(currentDate, 1);
    }
    
    return dates;
  };

  // Check if a date is in the current selection range
  const isInSelectionRange = (date) => {
    if (!startDate || !endDate) return false;
    return isWithinInterval(date, { start: new Date(startDate), end: new Date(endDate) });
  };

  // Custom day rendering for the calendar
  const renderDayContents = (day, date) => {
    const isAvailable = isDateAvailable(date);
    const isSelected = (startDate && isSameDay(date, new Date(startDate))) || 
                      (endDate && isSameDay(date, new Date(endDate)));
    const isInRange = isInSelectionRange(date);

    return (
      <div className={`custom-day ${!isAvailable ? 'unavailable' : ''} ${isSelected ? 'selected' : ''} ${isInRange ? 'in-range' : ''}`}>
        {format(date, 'd')}
      </div>
    );
  };

  // Handle date selection
  const handleDateChange = (dates) => {
    const [start, end] = dates;
    
    // If selecting start date
    if (start && !end) {
      onDateChange('startDate', start.toISOString().split('T')[0]);
      onDateChange('endDate', '');
      return;
    }

    // If selecting end date, check if entire range is available
    if (start && end) {
      const datesInRange = getDatesInRange(start, end);
      const allDatesAvailable = datesInRange.every(date => isDateAvailable(date));
      
      if (allDatesAvailable) {
        onDateChange('startDate', start.toISOString().split('T')[0]);
        onDateChange('endDate', end.toISOString().split('T')[0]);
      } else {
        // Show error or reset selection
        alert('Seçilen tarih aralığında müsait olmayan günler var. Lütfen farklı tarihler seçin.');
        onDateChange('startDate', '');
        onDateChange('endDate', '');
      }
    }
  };

  if (isLoading) {
    return <div className="calendar-loading">Takvim yükleniyor...</div>;
  }

  return (
    <div className="reservation-calendar">
      <div className="calendar-legend">
        <div className="legend-item">
          <span className="legend-color available"></span>
          <span>Müsait</span>
        </div>
        <div className="legend-item">
          <span className="legend-color unavailable"></span>
          <span>Müsait Değil</span>
        </div>
        <div className="legend-item">
          <span className="legend-color selected"></span>
          <span>Seçili</span>
        </div>
      </div>

      <DatePicker
        selected={startDate ? new Date(startDate) : null}
        onChange={handleDateChange}
        startDate={startDate ? new Date(startDate) : null}
        endDate={endDate ? new Date(endDate) : null}
        selectsRange
        inline
        monthsShown={monthsToShow}
        minDate={new Date()}
        renderDayContents={renderDayContents}
        dayClassName={(date) => isDateAvailable(date) ? 'available-date' : 'unavailable-date'}
        locale="tr"
        dateFormat="dd MMMM yyyy"
      />

      <div className="selected-dates-info">
        {startDate && !endDate && (
          <p>Çıkış tarihini seçin...</p>
        )}
        {startDate && endDate && (
          <p>
            <strong>Giriş:</strong> {format(new Date(startDate), 'dd MMMM yyyy', { locale: tr })} - 
            <strong> Çıkış:</strong> {format(new Date(endDate), 'dd MMMM yyyy', { locale: tr })}
          </p>
        )}
      </div>
    </div>
  );
}

export default ReservationCalendar; 
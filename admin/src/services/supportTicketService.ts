import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL;

export interface SupportTicket {
  id: number;
  userId: number;
  userEmail: string;
  subject: string;
  description: string;
  status: string;
  priority: string;
  createdAt: string;
  updatedAt: string | null;
  assignedTo: number | null;
  assignedToEmail: string | null;
}

export const supportTicketService = {
  getAllTickets: async (): Promise<SupportTicket[]> => {
    const response = await axios.get(`${API_URL}/api/supporttickets`);
    return response.data;
  },

  getTicketById: async (id: number): Promise<SupportTicket> => {
    const response = await axios.get(`${API_URL}/api/supporttickets/${id}`);
    return response.data;
  },

  createTicket: async (ticket: Omit<SupportTicket, 'id' | 'createdAt' | 'updatedAt' | 'userEmail' | 'assignedToEmail'>): Promise<void> => {
    await axios.post(`${API_URL}/api/supporttickets`, ticket);
  },

  updateTicket: async (id: number, ticket: Partial<SupportTicket>): Promise<void> => {
    await axios.patch(`${API_URL}/api/supporttickets/${id}`, ticket);
  },

  deleteTicket: async (id: number): Promise<void> => {
    await axios.delete(`${API_URL}/api/supporttickets/${id}`);
  }
}; 
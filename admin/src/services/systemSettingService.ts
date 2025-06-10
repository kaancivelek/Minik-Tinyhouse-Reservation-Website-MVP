import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL;

export interface SystemSetting {
  id: number;
  category: string;
  key: string;
  value: string;
  description: string;
  dataType: string;
  createdAt: string;
  updatedAt: string | null;
}

export const systemSettingService = {
  getAllSettings: async (): Promise<SystemSetting[]> => {
    const response = await axios.get(`${API_URL}/api/systemsettings`);
    return response.data;
  },

  getSettingsByCategory: async (category: string): Promise<SystemSetting[]> => {
    const response = await axios.get(`${API_URL}/api/systemsettings/category/${category}`);
    return response.data;
  },

  getSettingById: async (id: number): Promise<SystemSetting> => {
    const response = await axios.get(`${API_URL}/api/systemsettings/${id}`);
    return response.data;
  },

  createSetting: async (setting: Omit<SystemSetting, 'id' | 'createdAt' | 'updatedAt'>): Promise<void> => {
    await axios.post(`${API_URL}/api/systemsettings`, setting);
  },

  updateSetting: async (id: number, setting: Partial<SystemSetting>): Promise<void> => {
    await axios.patch(`${API_URL}/api/systemsettings/${id}`, setting);
  },

  deleteSetting: async (id: number): Promise<void> => {
    await axios.delete(`${API_URL}/api/systemsettings/${id}`);
  }
}; 
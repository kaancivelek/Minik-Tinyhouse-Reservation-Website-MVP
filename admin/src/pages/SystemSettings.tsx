import React, { useEffect, useState } from 'react';
import {
  Card,
  Tabs,
  Form,
  Input,
  InputNumber,
  Switch,
  Button,
  message,
  Space,
  Typography,
  Popconfirm,
} from 'antd';
import { systemSettingService, SystemSetting } from '../services/systemSettingService';

const { TabPane } = Tabs;
const { TextArea } = Input;
const { Title } = Typography;

const SystemSettings: React.FC = () => {
  const [settings, setSettings] = useState<SystemSetting[]>([]);
  const [loading, setLoading] = useState(false);
  const [form] = Form.useForm();

  const categories = [
    { key: 'General', label: 'Genel Ayarlar' },
    { key: 'Email', label: 'E-posta Ayarları' },
    { key: 'Notification', label: 'Bildirim Ayarları' },
    { key: 'Reservation', label: 'Rezervasyon Ayarları' },
    { key: 'Payment', label: 'Ödeme Ayarları' },
  ];

  const fetchSettings = async () => {
    setLoading(true);
    try {
      const data = await systemSettingService.getAllSettings();
      setSettings(data);
    } catch (error) {
      message.error('Ayarlar yüklenirken bir hata oluştu.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchSettings();
  }, []);

  const handleUpdate = async (id: number, values: any) => {
    try {
      await systemSettingService.updateSetting(id, values);
      message.success('Ayar başarıyla güncellendi.');
      fetchSettings();
    } catch (error) {
      message.error('Ayar güncellenirken bir hata oluştu.');
    }
  };

  const handleDelete = async (id: number) => {
    try {
      await systemSettingService.deleteSetting(id);
      message.success('Ayar başarıyla silindi.');
      fetchSettings();
    } catch (error) {
      message.error('Ayar silinirken bir hata oluştu.');
    }
  };

  const renderSettingInput = (setting: SystemSetting) => {
    switch (setting.dataType.toLowerCase()) {
      case 'number':
        return <InputNumber style={{ width: '100%' }} />;
      case 'boolean':
        return <Switch />;
      case 'json':
        return <TextArea rows={4} />;
      default:
        return <Input />;
    }
  };

  const renderSettingsForm = (category: string) => {
    const categorySettings = settings.filter(s => s.category === category);

    return (
      <Form layout="vertical">
        {categorySettings.map((setting) => (
          <Form.Item
            key={setting.id}
            label={setting.description}
            name={setting.key}
            initialValue={setting.value}
            rules={[{ required: true, message: 'Bu alan zorunludur' }]}
          >
            {renderSettingInput(setting)}
          </Form.Item>
        ))}
        <Form.Item>
          <Space>
            <Button type="primary" onClick={() => form.submit()}>
              Kaydet
            </Button>
            <Popconfirm
              title="Bu ayarı silmek istediğinizden emin misiniz?"
              onConfirm={() => handleDelete(setting.id)}
              okText="Evet"
              cancelText="Hayır"
            >
              <Button danger>Sil</Button>
            </Popconfirm>
          </Space>
        </Form.Item>
      </Form>
    );
  };

  return (
    <Card>
      <Title level={2}>Sistem Ayarları</Title>
      <Tabs defaultActiveKey="General">
        {categories.map((category) => (
          <TabPane tab={category.label} key={category.key}>
            {renderSettingsForm(category.key)}
          </TabPane>
        ))}
      </Tabs>
    </Card>
  );
};

export default SystemSettings; 
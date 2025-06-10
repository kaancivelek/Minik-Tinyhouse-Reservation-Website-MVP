-- Create system_settings table
CREATE TABLE system_settings (
    id INT IDENTITY(1,1) PRIMARY KEY,
    category NVARCHAR(50) NOT NULL,
    [key] NVARCHAR(100) NOT NULL,
    value NVARCHAR(MAX) NOT NULL,
    description NVARCHAR(500) NOT NULL,
    data_type NVARCHAR(20) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETUTCDATE(),
    updated_at DATETIME NULL,
    CONSTRAINT UQ_SystemSettings_Category_Key UNIQUE (category, [key])
);

-- Insert initial settings
-- General Settings
INSERT INTO system_settings (category, [key], value, description, data_type) VALUES
('General', 'SiteTitle', 'Minik Tiny House', 'Site başlığı', 'String'),
('General', 'SiteDescription', 'Tiny House Rezervasyon Sistemi', 'Site açıklaması', 'String'),
('General', 'ContactEmail', 'info@miniktinyhouse.com', 'İletişim e-posta adresi', 'String'),
('General', 'ContactPhone', '+90 555 123 4567', 'İletişim telefon numarası', 'String'),
('General', 'Address', 'İstanbul, Türkiye', 'Adres bilgisi', 'String'),
('General', 'Currency', 'TRY', 'Para birimi', 'String'),
('General', 'TimeZone', 'Europe/Istanbul', 'Zaman dilimi', 'String'),
('General', 'MaintenanceInterval', '30', 'Bakım kontrol aralığı (gün)', 'Number'),
('General', 'MaxReservationDays', '30', 'Maksimum rezervasyon süresi (gün)', 'Number'),
('General', 'MinReservationDays', '1', 'Minimum rezervasyon süresi (gün)', 'Number');

-- Email Settings
INSERT INTO system_settings (category, [key], value, description, data_type) VALUES
('Email', 'SmtpServer', 'smtp.gmail.com', 'SMTP sunucu adresi', 'String'),
('Email', 'SmtpPort', '587', 'SMTP port numarası', 'Number'),
('Email', 'SmtpUsername', 'noreply@miniktinyhouse.com', 'SMTP kullanıcı adı', 'String'),
('Email', 'SmtpPassword', '', 'SMTP şifresi', 'String'),
('Email', 'FromEmail', 'noreply@miniktinyhouse.com', 'Gönderen e-posta adresi', 'String'),
('Email', 'FromName', 'Minik Tiny House', 'Gönderen adı', 'String'),
('Email', 'EnableSsl', 'true', 'SSL kullan', 'Boolean'),
('Email', 'EnableTls', 'true', 'TLS kullan', 'Boolean');

-- Notification Settings
INSERT INTO system_settings (category, [key], value, description, data_type) VALUES
('Notification', 'EnableEmailNotifications', 'true', 'E-posta bildirimlerini etkinleştir', 'Boolean'),
('Notification', 'EnableSmsNotifications', 'false', 'SMS bildirimlerini etkinleştir', 'Boolean'),
('Notification', 'EnablePushNotifications', 'true', 'Push bildirimlerini etkinleştir', 'Boolean'),
('Notification', 'NotificationEmail', 'notifications@miniktinyhouse.com', 'Bildirim e-posta adresi', 'String'),
('Notification', 'ReservationNotification', 'true', 'Rezervasyon bildirimlerini etkinleştir', 'Boolean'),
('Notification', 'MaintenanceNotification', 'true', 'Bakım bildirimlerini etkinleştir', 'Boolean'),
('Notification', 'PaymentNotification', 'true', 'Ödeme bildirimlerini etkinleştir', 'Boolean');

-- Reservation Settings
INSERT INTO system_settings (category, [key], value, description, data_type) VALUES
('Reservation', 'MinStayDays', '1', 'Minimum konaklama süresi (gün)', 'Number'),
('Reservation', 'MaxStayDays', '30', 'Maksimum konaklama süresi (gün)', 'Number'),
('Reservation', 'CancellationPolicy', '{"freeCancellationDays": 7, "refundPercentage": 80}', 'İptal politikası', 'JSON'),
('Reservation', 'CheckInTime', '14:00', 'Giriş saati', 'String'),
('Reservation', 'CheckOutTime', '12:00', 'Çıkış saati', 'String'),
('Reservation', 'RequireDeposit', 'true', 'Depozito gereksinimi', 'Boolean'),
('Reservation', 'DepositAmount', '500', 'Depozito miktarı', 'Number'),
('Reservation', 'AllowOverlapping', 'false', 'Çakışan rezervasyonlara izin ver', 'Boolean'),
('Reservation', 'AutoApprove', 'false', 'Rezervasyonları otomatik onayla', 'Boolean');

-- Payment Settings
INSERT INTO system_settings (category, [key], value, description, data_type) VALUES
('Payment', 'PaymentMethods', '["credit_card", "bank_transfer"]', 'Ödeme yöntemleri', 'JSON'),
('Payment', 'Currency', 'TRY', 'Para birimi', 'String'),
('Payment', 'TaxRate', '18', 'Vergi oranı (%)', 'Number'),
('Payment', 'EnableOnlinePayment', 'true', 'Online ödemeyi etkinleştir', 'Boolean'),
('Payment', 'EnableCashPayment', 'true', 'Nakit ödemeyi etkinleştir', 'Boolean'),
('Payment', 'MinimumPayment', '100', 'Minimum ödeme tutarı', 'Number'),
('Payment', 'MaximumPayment', '10000', 'Maksimum ödeme tutarı', 'Number'),
('Payment', 'PaymentTimeout', '30', 'Ödeme zaman aşımı (dakika)', 'Number'); 
-- Create audit_logs table
CREATE TABLE audit_logs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NULL,
    action NVARCHAR(50) NOT NULL,
    entity NVARCHAR(50) NOT NULL,
    entity_id INT NULL,
    old_value NVARCHAR(MAX) NULL,
    new_value NVARCHAR(MAX) NULL,
    timestamp DATETIME NOT NULL DEFAULT GETUTCDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Add indexes for better query performance
CREATE INDEX IX_AuditLogs_UserId ON audit_logs(user_id);
CREATE INDEX IX_AuditLogs_Entity ON audit_logs(entity);
CREATE INDEX IX_AuditLogs_Timestamp ON audit_logs(timestamp); 
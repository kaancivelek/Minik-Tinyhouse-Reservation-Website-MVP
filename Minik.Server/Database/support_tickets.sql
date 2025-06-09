CREATE TABLE support_tickets (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    subject NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX) NOT NULL,
    status NVARCHAR(20) NOT NULL DEFAULT 'Open' CHECK (status IN ('Open', 'InProgress', 'Resolved', 'Closed')),
    priority NVARCHAR(20) NOT NULL DEFAULT 'Medium' CHECK (priority IN ('Low', 'Medium', 'High', 'Urgent')),
    created_at DATETIME NOT NULL DEFAULT GETUTCDATE(),
    updated_at DATETIME NULL,
    assigned_to INT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (assigned_to) REFERENCES users(id)
);

CREATE INDEX IX_SupportTickets_UserId ON support_tickets(user_id);
CREATE INDEX IX_SupportTickets_Status ON support_tickets(status);
CREATE INDEX IX_SupportTickets_Priority ON support_tickets(priority);
CREATE INDEX IX_SupportTickets_AssignedTo ON support_tickets(assigned_to); 
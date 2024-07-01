-- auditing_logging.sql
-- This script sets up auditing and logging mechanisms

-- Step 1: Enable the General Query Log
-- Note: Enabling the general query log may have performance implications, so use it judiciously.

-- Enable the general query log
SET GLOBAL general_log = 'ON';

-- Set the log output to TABLE to store logs in a table
SET GLOBAL log_output = 'TABLE';

-- Step 2: Verify that the general query log is enabled
-- The following command should return 'ON'
SHOW VARIABLES LIKE 'general_log';

-- Step 3: Create a backup table for the general log
-- This step is optional but recommended for archiving purposes

-- Create a backup table for the general log
CREATE TABLE IF NOT EXISTS general_log_backup LIKE mysql.general_log;

-- Insert current general log entries into the backup table
INSERT INTO general_log_backup SELECT * FROM mysql.general_log;

-- Step 4: Enable the Audit Log Plugin (requires MySQL Enterprise Edition or MariaDB)
-- Note: This step is for MySQL Enterprise Edition or MariaDB with the audit plugin installed.

-- Install the audit log plugin
-- For MySQL Enterprise Edition:
-- INSTALL PLUGIN audit_log SONAME 'audit_log.so';
-- SET GLOBAL audit_log_policy = 'ALL';

-- For MariaDB:
-- INSTALL SONAME 'server_audit';
-- SET GLOBAL server_audit_logging = 'ON';
-- SET GLOBAL server_audit_events = 'CONNECT,QUERY,TABLE';

-- Step 5: Configure Audit Log Settings
-- Note: Adjust the audit log settings as needed

-- For MySQL Enterprise Edition:
-- SET GLOBAL audit_log_format = 'JSON';
-- SET GLOBAL audit_log_file = '/var/log/mysql/audit.log';
-- SET GLOBAL audit_log_rotate_on_size = 10485760; -- Rotate the log file when it reaches 10MB
-- SET GLOBAL audit_log_rotations = 10; -- Keep the last 10 log files

-- For MariaDB:
-- SET GLOBAL server_audit_output_type = 'FILE';
-- SET GLOBAL server_audit_file_path = '/var/log/mysql/mariadb_audit.log';
-- SET GLOBAL server_audit_file_rotate_size = 10485760; -- Rotate the log file when it reaches 10MB
-- SET GLOBAL server_audit_file_rotations = 10; -- Keep the last 10 log files

-- Step 6: Verify the Audit Log Configuration
-- Check the audit log status and settings
SHOW VARIABLES LIKE 'audit%';

-- Step 7: Enable Binary Logging for Point-in-Time Recovery and Auditing
-- Note: Binary logging is essential for point-in-time recovery and can be used for auditing changes.

-- Add the following lines to your MySQL configuration file (my.cnf or my.ini) under [mysqld] section:
-- [mysqld]
-- log_bin = /var/log/mysql/mysql-bin.log
-- binlog_format = ROW
-- server_id = 1

-- Restart MySQL server to apply changes

-- Step 8: Verify Binary Logging Configuration
-- Check the binary logging status
SHOW VARIABLES LIKE 'log_bin';

-- Step 9: Rotate and Purge Logs Regularly
-- Set binary log expiration to automatically purge old logs
SET GLOBAL expire_logs_days = 7; -- Keep logs for 7 days

-- Step 10: Monitor Logs
-- Regularly monitor and analyze the general query log, audit log, and binary logs for suspicious activity

-- Example: Query to view recent entries in the general query log
SELECT * FROM mysql.general_log ORDER BY event_time DESC LIMIT 100;

-- Example: Query to view recent entries in the audit log (for MySQL Enterprise Edition)
-- SELECT * FROM mysql.audit_log ORDER BY timestamp DESC LIMIT 100;

-- Example: Query to view recent entries in the binary log (requires mysqlbinlog tool)
-- mysqlbinlog --start-datetime="2023-01-01 00:00:00" --stop-datetime="2023-01-02 00:00:00" /var/log/mysql/mysql-bin.000001

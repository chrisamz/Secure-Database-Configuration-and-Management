-- remediation_steps.sql
-- This script applies remediation steps to address security vulnerabilities

-- Step 1: Update Weak Passwords
-- Replace 'weak_user' and 'StrongPassword123!' with actual user and strong password
ALTER USER 'weak_user'@'%' IDENTIFIED BY 'StrongPassword123!';

-- Repeat the above command for each user identified with a weak password

-- Step 2: Remove Users Without Passwords
-- Replace 'no_password_user' with the actual user to be removed
DROP USER 'no_password_user'@'%';

-- Repeat the above command for each user identified without a password

-- Step 3: Revoke Excessive Privileges
-- Replace 'excessive_priv_user' with the actual user to revoke privileges from
REVOKE SUPER, PROCESS ON *.* FROM 'excessive_priv_user'@'%';

-- Repeat the above command for each user identified with excessive privileges

-- Step 4: Remove Wildcard Hosts
-- Replace 'wildcard_user' with the actual user to restrict host
-- Create a new user with restricted host and drop the wildcard host user
CREATE USER 'wildcard_user'@'specific_host' IDENTIFIED BY 'user_password';
DROP USER 'wildcard_user'@'%';

-- Repeat the above commands for each user identified with wildcard hosts

-- Step 5: Update Outdated Software Versions
-- Follow official MySQL upgrade documentation to update to the latest version
-- Reference: https://dev.mysql.com/doc/refman/8.0/en/upgrading.html

-- Step 6: Enable Password Expiration for Accounts
-- Replace 'no_expiry_user' with the actual user
ALTER USER 'no_expiry_user'@'%' PASSWORD EXPIRE;

-- Repeat the above command for each user identified without password expiration

-- Step 7: Remove Anonymous Accounts
-- Replace 'anonymous_user' with the actual user
DROP USER ''@'localhost';
DROP USER ''@'%';

-- Step 8: Remove Test Databases
-- Replace 'test_database' with the actual database to be removed
DROP DATABASE test;

-- Repeat the above command for each test database identified

-- Step 9: Restrict Database Permissions
-- Example: Revoke unnecessary privileges from a user
-- Replace 'unnecessary_priv_user' with the actual user and specify the privileges to revoke
REVOKE SELECT, INSERT, UPDATE, DELETE ON specific_database.* FROM 'unnecessary_priv_user'@'%';

-- Repeat the above command for each user with weak permissions

-- Step 10: Ensure Proper Binary Logging Configuration
-- Add the following lines to your MySQL configuration file (my.cnf or my.ini) under [mysqld] section:
-- [mysqld]
-- log_bin = /var/log/mysql/mysql-bin.log
-- binlog_format = ROW
-- server_id = 1

-- Restart MySQL server to apply changes
-- Example command to restart MySQL (may vary depending on your system):
-- sudo systemctl restart mysql

-- Step 11: Ensure SSL/TLS Configuration
-- Verify that SSL/TLS is configured for secure connections
SHOW VARIABLES LIKE '%ssl%';

-- Step 12: Revoke GRANT OPTION Privilege from Non-Default Users
-- Replace 'grant_priv_user' with the actual user
REVOKE GRANT OPTION ON *.* FROM 'grant_priv_user'@'%';

-- Repeat the above command for each user identified with GRANT OPTION privilege

-- Step 13: Review Stored Procedures or Functions for SQL Injection Risk
-- Example: Review and secure stored procedures or functions
-- Replace 'routine_name' and 'routine_schema' with actual routine details
DELIMITER //
CREATE OR REPLACE PROCEDURE routine_schema.secure_procedure()
BEGIN
    -- Secure procedure implementation
END //
DELIMITER ;

-- Repeat the above command for each procedure or function identified with SQL injection risk

-- Additional Step: Rotate and Purge Logs Regularly
-- Set binary log expiration to automatically purge old logs
SET GLOBAL expire_logs_days = 7; -- Keep logs for 7 days

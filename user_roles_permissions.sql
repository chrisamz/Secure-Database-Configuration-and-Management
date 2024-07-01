-- user_roles_permissions.sql
-- This script sets up user roles and permissions

-- Create roles for different levels of access
-- Note: MySQL 8.0+ supports roles natively

-- Create a read-only role
CREATE ROLE read_only;

-- Grant SELECT privilege to the read_only role
GRANT SELECT ON *.* TO read_only;

-- Create a read-write role
CREATE ROLE read_write;

-- Grant SELECT, INSERT, UPDATE, DELETE privileges to the read_write role
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO read_write;

-- Create an admin role
CREATE ROLE admin;

-- Grant all privileges to the admin role
GRANT ALL PRIVILEGES ON *.* TO admin;

-- Create users and assign roles

-- Create a read-only user and assign the read_only role
CREATE USER 'readonly_user'@'%' IDENTIFIED BY 'readonly_password';
GRANT read_only TO 'readonly_user'@'%';

-- Create a read-write user and assign the read_write role
CREATE USER 'readwrite_user'@'%' IDENTIFIED BY 'readwrite_password';
GRANT read_write TO 'readwrite_user'@'%';

-- Create an admin user and assign the admin role
CREATE USER 'admin_user'@'%' IDENTIFIED BY 'admin_password';
GRANT admin TO 'admin_user'@'%';

-- Set default roles for the users
SET DEFAULT ROLE read_only TO 'readonly_user'@'%';
SET DEFAULT ROLE read_write TO 'readwrite_user'@'%';
SET DEFAULT ROLE admin TO 'admin_user'@'%';

-- Ensure that each user is assigned the appropriate role upon creation
-- The following commands set default roles, which ensures that users get the role privileges automatically

-- Set default role for readonly_user
SET DEFAULT ROLE read_only TO 'readonly_user'@'%';

-- Set default role for readwrite_user
SET DEFAULT ROLE read_write TO 'readwrite_user'@'%';

-- Set default role for admin_user
SET DEFAULT ROLE admin TO 'admin_user'@'%';

-- Verify roles and privileges

-- Show roles for readonly_user
SHOW GRANTS FOR 'readonly_user'@'%';

-- Show roles for readwrite_user
SHOW GRANTS FOR 'readwrite_user'@'%';

-- Show roles for admin_user
SHOW GRANTS FOR 'admin_user'@'%';

-- Revoke roles if necessary (example)
-- REVOKE read_only FROM 'readonly_user'@'%';
-- DROP USER 'readonly_user'@'%';

-- Drop roles if necessary (example)
-- DROP ROLE read_only;
-- DROP ROLE read_write;
-- DROP ROLE admin;

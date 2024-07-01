-- ssl_tls_configuration.sql
-- This script configures SSL/TLS encryption for secure connections

-- Step 1: Prepare SSL/TLS Certificates

-- Note: Ensure that you have the necessary SSL/TLS certificates. 
-- You will need a Certificate Authority (CA) certificate, a server certificate, and a server key.

-- For the purpose of this example, assume the following files are available:
-- - ca-cert.pem (CA certificate)
-- - server-cert.pem (Server certificate)
-- - server-key.pem (Server key)

-- Step 2: Configure MySQL to Use SSL/TLS

-- Add the following lines to your MySQL configuration file (my.cnf or my.ini) under [mysqld] section:
-- [mysqld]
-- ssl-ca = /path/to/ca-cert.pem
-- ssl-cert = /path/to/server-cert.pem
-- ssl-key = /path/to/server-key.pem

-- Save the changes and restart the MySQL server to apply the new configuration.

-- Step 3: Verify SSL/TLS Configuration

-- Connect to the MySQL server and run the following command to verify SSL/TLS configuration:
SHOW VARIABLES LIKE '%ssl%';

-- The output should show the paths to the CA certificate, server certificate, and server key.

-- Step 4: Require SSL for Specific Users

-- Modify existing users to require SSL connections:
ALTER USER 'readonly_user'@'%' REQUIRE SSL;
ALTER USER 'readwrite_user'@'%' REQUIRE SSL;
ALTER USER 'admin_user'@'%' REQUIRE SSL;

-- Step 5: Verify SSL Connections

-- Connect to the MySQL server using SSL from a client to ensure that the SSL configuration is working as expected.
-- Example command for MySQL client:
-- mysql --host=your_host --user=readonly_user --password=readonly_password --ssl-ca=/path/to/ca-cert.pem --ssl-cert=/path/to/client-cert.pem --ssl-key=/path/to/client-key.pem

-- Step 6: Enable SSL/TLS for New Users

-- Create new users and require SSL connections:
CREATE USER 'new_ssl_user'@'%' IDENTIFIED BY 'new_password';
ALTER USER 'new_ssl_user'@'%' REQUIRE SSL;

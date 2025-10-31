-- ==============================================================================
-- POSTGRESQL INITIALIZATION SCRIPT
-- ==============================================================================

-- Create database if it doesn't exist
SELECT 'CREATE DATABASE repairmybike_db'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'repairmybike_db')\gexec

-- Connect to the database
\c repairmybike_db;

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "unaccent";

-- Create indexes for better performance (will be created by Django migrations)
-- These are just placeholders for future optimizations

-- Grant permissions
GRANT ALL PRIVILEGES ON DATABASE repairmybike_db TO postgres;

-- Set timezone
SET timezone = 'Asia/Kolkata';

-- Log successful initialization
DO $$
BEGIN
    RAISE NOTICE 'Database repairmybike_db initialized successfully';
END $$;
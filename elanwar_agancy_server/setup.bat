@echo off
REM PostgreSQL setup
REM Ensure PostgreSQL is installed and the service is running

REM Restore the database
psql -U postgres -d alanwaragency -f database_dump.sql

REM Start the Serverpod backend
bin\serverpod.exe

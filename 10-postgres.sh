#!/bin/bash
echo "Installing PostgreSQL..." >> ${LOG}

apt install -y postgresql-16-postgis-3 < /dev/null
su - postgres -c "echo \"listen_addresses = '*'\" >> /etc/postgresql/16/main/postgresql.conf"
su - postgres -c "echo \"host all all 0.0.0.0/0 scram-sha-256\" >> /etc/postgresql/16/main/pg_hba.conf"
service postgresql restart
su - postgres -c "psql -c \"CREATE USER eoapi WITH PASSWORD 'eoapi';\""
su - postgres -c "createdb -O eoapi eoapi"
su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE eoapi TO eoapi;\""
su - postgres -c "psql -c \"ALTER USER eoapi WITH SUPERUSER;\""

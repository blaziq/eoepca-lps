#!/bin/bash

# Installing Minio S3 storage (basic)
echo -n "Setting up Minio S3 object storage..." >> ${LOG}

# Prerequisite: minio
# We have this locally installed for speed
# wget -q https://dl.min.io/server/minio/release/linux-amd64/minio -O /usr/local/bin/minio && chmod +x /usr/local/bin/minio
# wget -q https://dl.min.io/client/mc/release/linux-amd64/mc -O  /usr/local/bin/mc && chmod +x /usr/local/bin/mc
if [[ -e /tmp/assets/minio.7z ]]; then
    echo -n " client..." >> ${LOG}
    mkdir -p /usr/local/bin/ && 7z x /tmp/assets/minio.7z -o/usr/local/bin/ && chmod +x /usr/local/bin/mc /usr/local/bin/minio
    if [[ "$0" != *"-client.sh" ]]; then
        #echo "Setting up local Minio S3 object storage server..." >> ${LOG}  
        echo -n " server..." >> ${LOG}
        mkdir -p ~/minio && MINIO_ROOT_USER=eoepca MINIO_ROOT_PASSWORD=eoepcatest nohup minio server --quiet ~/minio &>/dev/null &
        sleep 1
        while ! mc config host add minio-local http://minio.eoepca.local:9000/ eoepca eoepcatest; do sleep 1; done
        # mc alias set minio-local http://minio.eoepca.local:9000/ eoepca eoepcatest
        mc mb minio-local/eoepca
    fi
fi

echo " variables..." >> ${LOG}
mkdir -p ~/.eoepca 
echo 'export S3_ENDPOINT="http://minio.eoepca.local:9000/"
export S3_ACCESS_KEY="eoepca" 
export S3_SECRET_KEY="eoepcatest"
export S3_REGION="us-east-1"' >> ~/.eoepca/state

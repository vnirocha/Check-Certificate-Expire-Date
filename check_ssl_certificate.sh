#!/bin/bash

i=0;
NUM_SERVICO_EXP=0;

for URL in "$@"
do
        DATA_EXP=$(echo | openssl s_client -servername $URL -connect $URL:443 2>/dev/null | openssl x509 -enddate -noout | sed 's/notAfter=//g' | awk '{print $2,$1,$4}')
        DATA_EXP_SEGUNDOS=$(date --date="$DATA_EXP" +"%s");
        DATA_EXP_DIAS=$(( DATA_EXP_SEGUNDOS / 86400 ));
        DATA_ATUAL_SEGUNDOS=$(date +"%s");
        DATA_ATUAL_DIAS=$(( DATA_ATUAL_SEGUNDOS / 86400 ));
        echo $(( DATA_EXP_DIAS - DATA_ATUAL_DIAS ));
done

#!/usr/bin/env bash

letsencrypt_path=/etc/letsencrypt
cert_pattern=cert.pem

while read cert ; do
  echo " "
  echo "############"
  if openssl x509 -checkend 86400 -noout -in $cert
  then
    echo "The certificate $cert is good for at least another day!"
    today=`date +%D`
    expiredate=`openssl x509 -enddate -noout -in $cert  | awk -F'=' '{print $2}'`
    expdate="date +%D --date='$expiredate'"
    ed=`eval $expdate`
    daysleft=`echo $(($(($(date -u -d "$ed" "+%s") - $(date -u -d "$today" "+%s"))) / 86400))`
    echo "        Today's date: $today , expiring on: $ed , $daysleft days left to go."
  else
    echo "The certificate $cert has expired or will do so within 24 hours!"
    echo "(or is invalid/not found)"
  fi
  echo "############"
  echo " "
done < <(find $letsencrypt_path -iname $cert_pattern )
#!/bin/bash
certs_crt="/etc/ssl/certs/nginx-selfsigned.crt"
private_key="/etc/ssl/private/nginx-selfsigned.key"
DOMAINE_NAME="aoumad.42.fr"

openssl req -x509 -nodes -days 90 -newkey rsa:4096 -keyout "$private_key" -out "$certs_crt" -subj "/C=MO/ST=khounifra/L=khouribga/O=inception/CN=${DOMAINE_NAME}"
sed -i "s|/etc/ssl/certs/nginx-selfsigned.crt|${certs_crt}|g" "/etc/nginx/sites-enabled/default"
sed -i "s|/etc/ssl/private/nginx-selfsigned.key|${private_key}|g" "/etc/nginx/sites-enabled/default"
sed -i "s/aoumad.42.fr/${DOMAINE_NAME}/g" "/etc/nginx/sites-enabled/default"
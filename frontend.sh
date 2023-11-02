#!/usr/bin/env bash

touch frontend.log

ls /usr/share/nginx/html/ >> frontend.log
rm -rf /usr/share/nginx/html/* >> frontend.log
ls /usr/share/nginx/html/ >> frontend.log

rm -rf /tmp/* >> frontend.log
ls /tmp >> frontend.log

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >> frontend.log
ls /tmp >> frontend.log

cd /usr/share/nginx/html >> frontend.log
unzip /tmp/frontend.zip >> frontend.log
echo "file download status $?"

cd /etc/nginx/default.d >> frontend.log
rm -f /etc/nginx/default.d/expense.conf >> frontend.log
touch expense.conf >> frontend.log
echo 'proxy_http_version 1.1;' >> expense.conf >> frontend.log
echo 'location /api/ { proxy_pass http://localhost:8080/; }' >> expense.conf >> frontend.log
echo "expense.conf add status $?"

systemctl restart nginx >> frontend.log
echo "nginx restart status $?"
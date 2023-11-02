#!/usr/bin/env bash

touch frontend.log

systemctl enable nginx &
systemctl start nginx &
systemctl status nginx &

ls /usr/share/nginx/html/ &
rm -rf /usr/share/nginx/html/* &
ls /usr/share/nginx/html/ &

rm -rf /tmp/* &
ls /tmp &

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &
ls /tmp &

cd /usr/share/nginx/html &
unzip /tmp/frontend.zip &

cd /etc/nginx/default.d &
rm -f /etc/nginx/default.d/expense.conf &
touch expense.conf &
echo 'proxy_http_version 1.1;' >> expense.conf &
echo 'location /api/ { proxy_pass http://localhost:8080/; }' >> expense.conf &

systemctl restart nginx &
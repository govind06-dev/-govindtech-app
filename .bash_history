ssh -i ~/govindtech-key.pem ubuntu@10.0.3.134
scp -i ~/govindtech-key.pem ~/govindtech-key.pem ubuntu@43.205.178.151:~/govindtech-key.pem
exit
chmod 400 ~/govindtech-key.pem
ssh -i ~/govindtech-key.pem ubuntu@10.0.3.134
ssh -i ~/govindtech-key.pem ubuntu@10.0.3.134
ssh -i ~/govindtech-key.pem ubuntu@43.205.178.151
sudo apt update && sudo apt install -y nginx certbot python3-certbot-nginx && echo "Done!"
sudo tee /etc/nginx/sites-available/govindtech > /dev/null << 'NGINXEOF'
server {
    listen 80;
    server_name govindtech.duckdns.org;
    location / {
        proxy_pass http://10.0.3.134:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    location /health {
        proxy_pass http://10.0.3.134:3000/health;
    }
}
NGINXEOF

sudo ln -sf /etc/nginx/sites-available/govindtech /etc/nginx/sites-enabled/ && sudo rm -f /etc/nginx/sites-enabled/default && sudo nginx -t && sudo systemctl reload nginx && echo "Nginx ready!"
curl http://govindtech.duckdns.org/health
nslookup govindtech.duckdns.org
source ~/govindtech-ids.txt
aws ec2 authorize-security-group-ingress   --group-id $BASTION_SG   --protocol tcp   --port 80   --cidr 0.0.0.0/0 && echo "Port 80 opened!"
aws ec2 authorize-security-group-ingress   --group-id $BASTION_SG   --protocol tcp   --port 443   --cidr 0.0.0.0/0 && echo "Port 443 opened!"
curl http://govindtech.duckdns.org/health
source ~/govindtech-ids.txt
aws ec2 authorize-security-group-ingress   --group-id $EC2_SG   --protocol tcp   --port 3000   --cidr 10.0.0.0/16 && echo "Port 3000 opened!"
curl http://10.0.3.134:3000/health
sudo nginx -t && sudo systemctl status nginx
curl http://localhost/health
aws ec2 describe-security-groups --group-ids sg-0558dd8a6682efd1a --query 'SecurityGroups[0].IpPermissions' --output table
aws ec2 authorize-security-group-ingress --group-id sg-0558dd8a6682efd1a --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-0558dd8a6682efd1a --protocol tcp --port 443 --cidr 0.0.0.0/0
echo "Ports opened!"
sudo ufw status
ssh-add ~/govindtech-key.pem
chmod 400 ~/govindtech-key.pem
ssh-add ~/govindtech-key.pem
sudo certbot --nginx -d govindtech.duckdns.org --non-interactive --agree-tos -m admin@govindtech.com

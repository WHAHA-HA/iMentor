#!/bin/sh

# super naive script for bootstrapping a ubuntu instance with:
# * the api app and its python requirements
# * postgres

sudo apt-get update
sudo apt-get -y install python-pip python-dev postgresql postgresql-server-dev-9.3
cd /imentor && ln -sf ./platform ./imi 
cd /imentor/api && pip install -r requirements.pip
sudo mkdir /var/log/uwsgi/
sudo chown vagrant:vagrant /var/log/uwsgi
sudo -upostgres sh -c "psql -f /imentor/api/vagrant/init.sql"
echo -e '\n\n=============================\n'
echo 'TO RUN THE DEV SERVER:'
echo 'vagrant ssh -c "cd /imentor/api/ && ./runserver.py"'

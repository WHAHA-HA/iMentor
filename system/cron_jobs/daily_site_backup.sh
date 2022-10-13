This is only executed on the public website machine. It pushes to rpt01, where we keep 
history going back one week.
#/usr/bin/env bash
curr_date=`date "+%Y%m%d_%H:%M:%S"`
rsync -az -e "ssh -i /home/imentor/.ssh/id_rsa" --no-t /var/www/ imentor@10.12.21.14:/home/imentor/pub_website_backups/current_live/${curr_date}


export PGPASSWORD='7yh8uj9ik0ol'

ids=(`echo "select id from iuser_user where email like 'PURGE_USER%'" | psql -U imentor -h 10.12.21.103 prod_imentor_copy_01  | grep -v 'id' | grep -v '\-\-\-\-' | grep -v rows | sed 's//,/g'`)

for id in "${ids[@]}"
do
echo "Removing user $id"
echo "select delete_cascade('public','iuser_user','" $id "')" | psql -U imentor -h 10.12.21.103 prod_imentor_copy_01

done

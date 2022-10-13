pg_dump -U imentor -h 10.12.21.103 -d prod_imentor_copy_01 -O -t canvas_unit_info > resotre.sql
pg_dump -U imentor -h 10.12.21.103 -d prod_imentor_copy_01 -O -t canvas_grade_info >> restore.sql
pg_dump -U imentor -h 10.12.21.103 -d prod_imentor_copy_01 -O -t canvas_curriculum >> restore.sql
pg_dump -U imentor -h 10.12.21.103 -d prod_imentor_copy_01 -O -t canvas_set >> restore.sql
pg_dump -U imentor -h 10.12.21.103 -d prod_imentor_copy_01 -O -t canvas_app >> restore.sql
pg_dump -U imentor -h 10.12.21.103 -d prod_imentor_copy_01 -O -t canvas_widget >> restore.sql
pg_dump -U imentor -h 10.12.21.103 -d prod_imentor_copy_01 -O -t canvas_widget_content >> restore.sql
pg_dump -U imentor -h 10.12.21.103 -d prod_imentor_copy_01 -O -t canvas_widget_content_response_marker >> restore.sql
pg_dump -U imentor -h 10.12.21.103 -d prod_imentor_copy_01 -O -t canvas_widget_content_marker_reference >> restore.sql

echo "drop table canvas_unit_info cascade" | psql -U imentor -h 10.12.21.103 -d dev_imentor
echo "drop table canvas_grade_info cascade" | psql -U imentor -h 10.12.21.103 -d dev_imentor
echo "drop table canvas_curriculum cascade" | psql -U imentor -h 10.12.21.103 -d dev_imentor
echo "drop table canvas_set cascade" | psql -U imentor -h 10.12.21.103 -d dev_imentor
echo "drop table canvas_app cascade" | psql -U imentor -h 10.12.21.103 -d dev_imentor
echo "drop table canvas_widget cascade" | psql -U imentor -h 10.12.21.103 -d dev_imentor
echo "drop table canvas_widget_content cascade" | psql -U imentor -h 10.12.21.103 -d dev_imentor
echo "drop table canvas_widget_content_response_marker cascade" | psql -U imentor -h 10.12.21.103 -d dev_imentor
echo "drop table canvas_widget_content_marker_reference cascade" | psql -U imentor -h 10.12.21.103 -d dev_imentor

psql -U imentor -h 10.12.21.103 -d dev_imentor < restore.sql

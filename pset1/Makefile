
clean_mysql:
	echo 'drop database uvv;' | sudo mysql 
test_mysql: 
	sudo mysql < ./cc1n_202203061_mysql_hr.sql

clean_pg:
	echo 'drop database uvv;' | sudo -u postgres -i psql
test_pg: 	
	sudo -u postgres -i psql -v ON_ERROR_STOP=1 < cc1n_202203061_postgresql_hr.sql

my: clean_mysql test_mysql
	echo sucesso!  
pg: clean_pg test_pg
	echo sucesso!

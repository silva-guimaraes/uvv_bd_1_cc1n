
clean_mysql:
	echo 'drop database uvv;' | sudo mysql 
clean_pg:
	echo 'drop database uvv' | psql uvv
test_mysql: 
	sudo mysql < ./cc1n_202203061_mysql.sql
test_pg: 	
	sudo mysql < ./cc1n_202203061_postgresql_hr.sql
my: clean_mysql test_mysql
	echo sucesso!  
pg: clean_pg test_pg
	echo sucesso!

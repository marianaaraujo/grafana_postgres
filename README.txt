Subir o docker-compose
docker-compose up -d

Copiar o diretório pgstatspack-2.3.3 para dentro do container do postgres:
docker cp pgstatspack-2.3.3 postgres:/tmp

Entrar no container do postgres
docker exec -it postres bash

Alterar o usuário de root pars postgres
su - postgres

Atualizar o TZ do usuário postgres
export TZ='America/Bahia'

Acessar o diretório tmp
cd /tmp

Executar o script install_pgstats.sh (localizado dentro diretório pgstatspack-2.3.3)
./install_pgstats.sh

Executar o script snapshot.sh (localizado dentro diretório pgstatspack-2.3.3/bin)
./snapshot.sh

Acessar o grafana no navegador:
http://localhost:3000

Configurar o banco de dados:
Name: pg_db
Type: PostgreSQL
Host: postgres:5432
Databse: postgres
User: postgres
Password: admin123
SSL Mode: disable

Importar o dashboard:
ID: 11056 (https://grafana.com/grafana/dashboards/11056)

Acessar o dashboard e alterar em todos os gráficos o DataSource para pg_db
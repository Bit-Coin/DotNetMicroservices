To connect to DB in dev environment options:
1) set up postgres on local machine with role and password used by appsettings.json
2) set up postgres with docker:
`docker run -p 5432:5432 -e POSTGRES_USER=pgadmin -e POSTGRES_PASSWORD=123456 postgres`
3) run `docker-compose up db` inside solution folder to run command, equivalent to above one.
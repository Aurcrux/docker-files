# HAproxy docker container
A docker container to run haproxy and set basic configuration using environment variables.

### Supported ENV variables
##### Mandatory :
- BACKEND_SERVERS : <host_OR_ip:port>
##### Optional :
- GLOBAL_MAXCONN : defaults to 2000
- GLOBAL_USER : defaults to haproxy
- GLOBAL_GROUP : defaults to haproxy
- DEFAULTS_RETRIES : defaults to 3
- DEFAULTS_TIMEOUT_CONNECT : defaults to 5000
- DEFAULTS_TIMEOUT_CLIENT : defaults to 10000
- DEFAULTS_TIMEOUT_SERVER : defaults to 10000
- FRONTEND_NAME : defaults to myapp
- FRONTEND_HOST : defaults to 0.0.0.0
- FRONTEND_PORT : defaults to 8080
- BACKEND_NAME : defaults to mybackend
- BACKEND_BALANCE : defaults to leastconn
- BACKEND_MODE : defaults to http

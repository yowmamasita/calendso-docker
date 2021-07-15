<!-- PROJECT LOGO -->
<div align="right">
  <a href="https://github.com/calendso/calendso">
    <img src="https://calendso.com/calendso-logo.svg" alt="Logo" width="160" height="65">
  </a><br/>
  <a href="https://calendso.com">Website</a>
  ·
  <a href="https://github.com/calendso/calendso-docker/issues">Community Support</a>
</div>

# calendso kubernetes

example deployment: 

1. install a psql database
2. create deployment 

## psql deployment helm

```
helm install calendso-psql bitnami/postgresql \
    --set persistence.size=100Mi \
    --set global.postgresql.postgresqlDatabase=calendso \
    --set global.postgresql.postgresqlUsername=calendso \
    --set global.postgresql.postgresqlPassword=changeme
```

## deployment of calendso

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: calendso-deployment
  labels:
    app: calendso
spec:
  replicas: 1
  selector:
    matchLabels:
      app: calendso
  template:
    metadata:
      labels:
        app: calendso
    spec:
      containers:
      - name: calendso
        image: guestros/calendso-githubbuild:latest
        ports:
        - containerPort: 3000
        env:
          - name: POSTGRES_USER
            value: calendso
          - name: POSTGRES_PASSWORD
            value: changeme
          - name: POSTGRES_DB
            value: calendso
          - name: POSTGRES_HOST
            value: calendso-postgresql
          - name: EMAIL_FROM
            value: "asdasasdasdsad@datafortress.cloud"
          - name: EMAIL_SERVER_HOST
            value: "asasd.adsasdasdasdsad.eu"
          - name: EMAIL_SERVER_PORT
            value: "465"
          - name: EMAIL_SERVER_USER
            value: "asdasdasasdd@datafortress.cloud"
          - name: EMAIL_SERVER_PASSWORD
            value: "asdasdas"
---
apiVersion: v1
kind: Service
metadata:
  name: calendso-service
spec:
  selector:
    app: calendso
  ports:
    - protocol: TCP
      port: 8002
      targetPort: 3000
```


# calendso docker compose
The Docker configuration for Calendso is an effort powered by people within the community. Calendso does not provide official support for Docker, but we will accept fixes and documentation. Use at your own risk.

## Requirements
Make sure you have `docker` & `docker-compose` installed on the server / system.

## Getting Started

1. Clone calendso-docker

    ```bash
    git clone git@github.com:calendso/calendso-docker.git --recursive
    ```

2. Update `.env` if needed 

3. Build and start calendso

    ```
    docker-compose up --build
    ```

4. Start prisma studio 
    ```
    docker-compose exec calendso -- npx prisma studio
    ```
5. Open a browser to [http://localhost:5555](http://localhost:5555) to look at or modify the database content.

6. Click on the `User` model to add a new user record.
7.  Fill out the fields (remembering to encrypt your password with [BCrypt](https://bcrypt-generator.com/)) and click `Save 1 Record` to create your first user.
8. Open a browser to [http://localhost:3000](http://localhost:3000) and login with your just created, first user.
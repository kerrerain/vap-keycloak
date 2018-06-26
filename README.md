# vap-keycloak
Vagrant box for keycloak / postgresql / apache

## Information

| Tool          | Version       |
| ------------- |:-------------:|
| Fedora        | 27            |
| PostgreSQL    | 10.x          |
| Keycloak      | 4.0.0.Beta3   |

## Prerequisite

The box is still under development. It is destroyed and created each time I need to test it. The archive for keycloak takes too long to download. It must be [downloaded](https://downloads.jboss.org/keycloak/4.0.0.Beta3/keycloak-4.0.0.Beta3.tar.gz) and placed at the root of the project.

## Run the project
```
vagrant up
```

## Keycloak service

A systemd service has been created for keycloak. The service is enabled by default.

```
systemctl start keycloak
systemctl stop keycloak
systemctl disable keycloak
...
```
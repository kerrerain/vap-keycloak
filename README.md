# vap-keycloak
Vagrant box for Keycloak / PostgreSQL / Apache

## Introduction

I created this box in order to do software development with Keycloak in a Windows environment.

### Versions

| Tool          | Version       |
| ------------- |:-------------:|
| Fedora        | 27            |
| PostgreSQL    | 10.x          |
| Keycloak      | 4.0.0.Beta3   |
| Apache        | 2.4.x         |

## Prerequisites

The box is still under development. It is destroyed and created each time I need to test it. The archive for keycloak takes too long to download. It must be [downloaded](https://downloads.jboss.org/keycloak/4.0.0.Beta3/keycloak-4.0.0.Beta3.tar.gz) and placed at the root of the project.

## Run the project
```
vagrant up
```

In a windows environment, configure a new host in `C:\Windows\System32\drivers\etc\hosts`:
```
192.168.33.10 vap-keycloak.org
```

Connect to the admin console with the default user admin/admin: [https://vap-keycloak.org/auth](https://vap-keycloak.org/auth)

## Keycloak service

A systemd service has been created for keycloak. The service is enabled by default.

```
sudo systemctl start keycloak
sudo systemctl stop keycloak
sudo systemctl disable keycloak
...
```
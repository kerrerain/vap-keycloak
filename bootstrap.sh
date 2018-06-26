KEYCLOAK_VERSION=4.0.0.Beta3
PROGNAME=$(basename $0)

function error_exit
{
    echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
    exit 1
}

# Postgresql
dnf install -y https://download.postgresql.org/pub/repos/yum/10/fedora/fedora-27-x86_64/pgdg-fedora10-10-4.noarch.rpm
dnf install -y postgresql10 postgresql10-server

echo "Installing postgresql10..."

/usr/pgsql-10/bin/postgresql-10-setup initdb
systemctl enable postgresql-10
systemctl start postgresql-10

su - postgres -c '/usr/pgsql-10/bin/createdb keycloak'

cat << EOF | su - postgres -c 'psql keycloak'
CREATE USER keycloak WITH SUPERUSER PASSWORD 'keycloak';
EOF

sed -i -- 's/ident/md5/g' /var/lib/pgsql/10/data/pg_hba.conf
systemctl restart postgresql-10

# Keycloak archive
dnf install -y wget java-1.8.0-openjdk

# wget -P /tmp https://downloads.jboss.org/keycloak/${KEYCLOAK_VERSION}/keycloak-${KEYCLOAK_VERSION}.tar.gz
if [ ! -f "/tmp/keycloak-${KEYCLOAK_VERSION}.tar.gz" ];
then
  error_exit "Missing keycloak archive."
fi

tar -xzf /tmp/keycloak-${KEYCLOAK_VERSION}.tar.gz -C /opt
mv /opt/keycloak-${KEYCLOAK_VERSION} /opt/keycloak

# Datasource
echo "Configuring JDBC driver..."

wget -P /tmp https://jdbc.postgresql.org/download/postgresql-42.2.2.jar
cp /tmp/postgresql-42.2.2.jar /opt/keycloak

/opt/keycloak/bin/jboss-cli.sh --file=/tmp/provisioning/datasource.cli
/opt/keycloak/bin/add-user-keycloak.sh -u admin -p admin

# Systemd
mkdir /etc/keycloak
cp /tmp/provisioning/keycloak/keycloak.conf /etc/keycloak/
cp /tmp/provisioning/keycloak/keycloak.service /etc/systemd/system/
cp /tmp/provisioning/keycloak/launch.sh /opt/keycloak/bin
chmod 744 /opt/keycloak/bin/launch.sh
restorecon /opt/keycloak/bin/launch.sh
systemctl daemon-reload

# User keycloak
useradd keycloak
chown -R keycloak:keycloak /opt/keycloak/

# Start keycloak
systemctl enable keycloak
systemctl start keycloak
#!/usr/bin/env bash
set -e

SSHD_SERVER=${SSHD_SERVER:='no'}
SSHD_PORT=${SSHD_PORT:='22'}
SSH_PASSWORD=${SSH_PASSWORD:='a'}
SSH_AUTHORIZED_KEY=${SSH_AUTHORIZED_KEY:=''}
SSH_AUTHORIZED_KEY2=${SSH_AUTHORIZED_KEY2:=''}
SSH_AUTHORIZED_KEY3=${SSH_AUTHORIZED_KEY3:=''}
SSH_AUTHORIZED_KEY4=${SSH_AUTHORIZED_KEY4:=''}

echo 'www-data ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/www-data && \
chmod 0440 /etc/sudoers.d/www-data

echo -e "$SSH_PASSWORD\n$SSH_PASSWORD" | passwd www-data && \
echo -e "$SSH_PASSWORD\n$SSH_PASSWORD" | passwd root

usermod -s /bin/bash www-data

# Enable/disable OpenSSH
if [ "$SSHD_SERVER" = "yes" ]; then
    mkdir -p /var/www/.ssh && \
    chmod 0700 /var/www/.ssh && \
    touch /var/www/.ssh/authorized_keys && \
    echo "$SSH_AUTHORIZED_KEY" > /var/www/.ssh/authorized_keys && \
    echo "$SSH_AUTHORIZED_KEY2" > /var/www/.ssh/authorized_keys && \
    echo "$SSH_AUTHORIZED_KEY3" > /var/www/.ssh/authorized_keys && \
    echo "$SSH_AUTHORIZED_KEY4" > /var/www/.ssh/authorized_keys && \
    chmod 0400 /var/www/.ssh/authorized_keys && \
    chown -cR www-data.www-data /var/www/.ssh

    touch /etc/ssh/revoked_keys && \
    echo "" > /etc/ssh/sshd_config && \
    echo "Port $SSHD_PORT" >> /etc/ssh/sshd_config && \
    echo "Subsystem sftp sudo -n true && sudo -n /usr/lib/openssh/sftp-server || /usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AddressFamily inet" >> /etc/ssh/sshd_config && \
    echo "ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config && \
    echo "HostKey /etc/ssh/ssh_host_rsa_key" >> /etc/ssh/sshd_config && \
    echo "HostKey /etc/ssh/ssh_host_ecdsa_key" >> /etc/ssh/sshd_config && \
    echo "HostKey /etc/ssh/ssh_host_ed25519_key" >> /etc/ssh/sshd_config && \
    echo "Protocol 2" >> /etc/ssh/sshd_config && \
    echo "StrictModes yes" >> /etc/ssh/sshd_config && \
    echo "SyslogFacility AUTH" >> /etc/ssh/sshd_config && \
    echo "LogLevel VERBOSE" >> /etc/ssh/sshd_config && \
    echo "Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr" >> /etc/ssh/sshd_config && \
    echo "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256" >> /etc/ssh/sshd_config && \
    echo "KexAlgorithms sntrup4591761x25519-sha512@tinyssh.org,curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256" >> /etc/ssh/sshd_config && \
    echo "LoginGraceTime 30s" >> /etc/ssh/sshd_config && \
    echo "MaxAuthTries 2" >> /etc/ssh/sshd_config && \
    echo "MaxSessions 10" >> /etc/ssh/sshd_config && \
    echo "MaxStartups 10:30:100" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "IgnoreRhosts yes" >> /etc/ssh/sshd_config && \
    echo "IgnoreUserKnownHosts yes" >> /etc/ssh/sshd_config && \
    echo "HostbasedAuthentication no" >> /etc/ssh/sshd_config && \
    echo "UsePAM yes" >> /etc/ssh/sshd_config && \
    echo "AuthenticationMethods any" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config && \
    echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config && \
    echo "KerberosAuthentication no" >> /etc/ssh/sshd_config && \
    echo "KerberosOrLocalPasswd no" >> /etc/ssh/sshd_config && \
    echo "KerberosTicketCleanup yes" >> /etc/ssh/sshd_config && \
    echo "#KerberosGetAFSToken no" >> /etc/ssh/sshd_config && \
    echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config && \
    echo "GSSAPICleanupCredentials yes" >> /etc/ssh/sshd_config && \
    echo "TCPKeepAlive no" >> /etc/ssh/sshd_config && \
    echo "ClientAliveInterval 120" >> /etc/ssh/sshd_config && \
    echo "ClientAliveCountMax 120" >> /etc/ssh/sshd_config && \
    echo "PermitTunnel no" >> /etc/ssh/sshd_config && \
    echo "AllowTcpForwarding local" >> /etc/ssh/sshd_config && \
    echo "AllowAgentForwarding no" >> /etc/ssh/sshd_config && \
    echo "GatewayPorts no" >> /etc/ssh/sshd_config && \
    echo "X11Forwarding no" >> /etc/ssh/sshd_config && \
    echo "X11UseLocalhost yes" >> /etc/ssh/sshd_config && \
    echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config && \
    echo "Compression no" >> /etc/ssh/sshd_config && \
    echo "UseDNS no" >> /etc/ssh/sshd_config && \
    echo "PrintMotd no" >> /etc/ssh/sshd_config && \
    echo "PrintLastLog no" >> /etc/ssh/sshd_config && \
    echo "Banner none" >> /etc/ssh/sshd_config && \
    echo "DebianBanner no" >> /etc/ssh/sshd_config && \
    echo "RevokedKeys /etc/ssh/revoked_keys" >> /etc/ssh/sshd_config && \
    true
else
    #rm -f /etc/supervisor/conf.d/sshd.conf
    true
fi

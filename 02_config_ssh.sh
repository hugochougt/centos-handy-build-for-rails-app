#!/bin/sh

USER=`whoami`

if [ ${USER} == 'root' ]; then
  echo 'Please login as a normal user'
  exit 1
fi

echo 'Backup default sshd_config'
sudo cp /etc/ssh/sshd_config ~/sshd_config.default.bak

echo 'Disable root login'
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

echo 'Disable empty passwords'
sudo sed -i 's/PermitEmptyPasswords yes/PermitEmptyPasswords no/g' /etc/ssh/sshd_config

echo 'Disable tunnelled clear text passwords'
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

echo 'Enable RSA authentication'
sudo sed -i 's/#RSAAuthentication/RSAAuthentication/g' /etc/ssh/sshd_config

echo 'Enable publie key authentication'
sudo sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/g' /etc/ssh/sshd_config

echo 'Enable authorized keys file'
sudo sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config

echo 'Disable DNS'
echo 'UseDNS no' | sudo tee --append /etc/ssh/sshd_config

echo 'add ${USER} to ssh allow user'
echo 'AllowUsers ${USER}' | sudo tee --append /etc/ssh/sshd_config

if [ ! -d ~/.ssh ]; then
  echo 'Creating .ssh/ dir'
  mkdir ~/.ssh
fi

if [ ! -f ~/.ssh/authorized_keys ]; then
  echo 'Creating authorized_keys file'
  touch ~/.ssh/authorized_keys
fi

echo 'Changing mode of authorized_keys file and .ssh/ dir'
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

echo 'Restarting ssh service'
sudo service ssh restart

echo 'ssh config done'
echo 'Now, copy your local public key to authorized_keys file on your server'

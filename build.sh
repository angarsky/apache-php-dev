#!/bin/bash

cp ~/.ssh/authorized_keys .
cp /etc/ssh/sshd_config .
docker build -t angarsky-dev .
rm  authorized_keys sshd_config

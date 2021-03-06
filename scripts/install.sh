#!/bin/bash

# compile agent
go build ./cmd/fw-id-agent

# disable systemd service if it is running
sudo systemctl --global disable fw-id-agent.service
systemctl --user stop fw-id-agent.service

# install agent to /usr/bin/fw-id-agent
sudo rm /usr/bin/fw-id-agent 2>/dev/null
sudo cp fw-id-agent /usr/bin/

# install config to /etc/fw-id-agent.json
sudo cp configs/config.json /etc/fw-id-agent.json

# install systemd service
sudo cp init/fw-id-agent.service /usr/lib/systemd/user

# enable systemd service for all users
sudo systemctl --global enable fw-id-agent.service
systemctl --user daemon-reload
systemctl --user start fw-id-agent.service

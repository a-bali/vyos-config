#!/bin/vbash

# Install tailscale
curl -fsSL https://pkgs.tailscale.com/stable/debian/buster.asc | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/debian/buster.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update && sudo apt-get install tailscale
sudo tailscale up --accept-dns=false --advertise-exit-node --accept-routes=true --advertise-routes=192.168.0.0/24,192.168.1.0/24,192.168.100.0/24

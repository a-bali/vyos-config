#!/bin/vbash

# Forward ECS information to upstream (Pihole)
sudo tee /run/powerdns/recursor.conf <<END >/dev/null
ecs-add-for=0.0.0.0/0
ecs-ipv4-bits=32
edns-subnet-allow-list=0.0.0.0/0
END

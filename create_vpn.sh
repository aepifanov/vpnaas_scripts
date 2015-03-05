#!/bin/bash

NAME=${1?"Name is mandatory"}

PEER_LOCAL=${2?"Local Peer is mandatory"}
SUBNET_LOCAL=${3?"Local SubNet is mandatory"}


PEER_REMOTE=${4?"Remote Peer is mandatory"}
SUBNET_REMOTE=${5?"Remote SubNet is mandatory"}

PROT=${6:-"esp"}
ENCAP=${7:-"tunnel"}


ROUTER_REMOTE=${8:-$SUBNET_REMOTE}
KEY=${9:-"key"}

neutron vpn-ikepolicy-create ${NAME}
neutron vpn-ipsecpolicy-create ${NAME} --encapsulation-mode ${ENCAP} --transform-protocol ${PROT}
neutron vpn-service-create --name ${NAME} ${PEER_LOCAL} ${SUBNET_LOCAL}
neutron ipsec-site-connection-create --name ${NAME} --vpnservice-id ${NAME} --ikepolicy-id ${NAME}  --ipsecpolicy-id ${NAME} --peer-address ${ROUTER_REMOTE} --peer-id ${PEER_REMOTE} --peer-cidr ${SUBNET_REMOTE} --psk ${KEY}

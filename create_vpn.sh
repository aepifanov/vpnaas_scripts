#!/bin/bash

NAME=${1?"Name is mandatory"}

PEER_LOCAL=${2?"Local Peer is mandatory"}
SUBNET_LOCAL=${3?"Local SubNet is mandatory"}


PEER_REMOTE=${4?"Remote Peer is mandatory"}
SUBNET_REMOTE=${5?"Remote SubNet is mandatory"}
ROUTER_REMOTE=${6:-SUBNET_REMOTE}

PROT=${7:-"esp"}
ENCAP=${8:-"tunnel"}

KEY=${7:-key}

neutron vpn-ikepolicy-create ${NAME}
neutron vpn-ipsecpolicy-create ${NAME} --encapsulation-mode ${ENCAP} --transform-protocol ${PROT}
neutron vpn-service-create --name ${NAME} ${PEER_LOCAL} ${SUBNET_LOCAL}
neutron ipsec-site-connection-create --name ${NAME} --vpnservice-id ${NAME} --ikepolicy-id ${NAME}  --ipsecpolicy-id ${NAME} --peer-address ${ROUTER_REMOTE} --peer-id ${PEER_REMOTE} --peer-cidr ${SUBNET_REMOTE} --psk ${KEY}

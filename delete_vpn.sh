#!/bin/bash

NAME=${1?"1st position argument is a name"}

neutron ipsec-site-connection-delete ${NAME}
neutron vpn-ikepolicy-delete ${NAME}
neutron vpn-ipsecpolicy-delete ${NAME}
neutron vpn-service-delete ${NAME}

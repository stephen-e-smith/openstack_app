#!/bin/sh

# Build our instance
/usr/bin/nova boot --flavor m1.small --image CentOS-7.1-x86_64-GenericCloud-1503 --user-data user_data.txt $BUILD_TAG

# Associate a free floating IP with the instance
FLOATING_IP=`/usr/bin/nova floating-ip-list | grep os1_public | grep -w '-' | awk '{print $4}'`
/usr/bin/nova floating-ip-associate $BUILD_TAG $FLOATING_IP



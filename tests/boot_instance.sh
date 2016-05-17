#!/bin/sh

# Get credentials
. ~/.openstackrc

# Get instance config
if [ -f ~/.instancerc ]
then
  . ~/.instancerc
else
  export FLAVOR=m1.small
  export IMAGE=CentOS-7.1-x86_64-GenericCloud-1503
  export KEY_NAME=jenkins
fi

# Find a floating IP for our app.
# Either reuse the one we have or get a free one.
for SERVER in `/usr/bin/nova list | grep jenkins-${JOB_NAME} | awk '{print $2}'`
do
  IP=`/usr/bin/nova floating-ip-list | grep $SERVER | awk '{print $4}'`
  if [ ${IP} ]
  then
    FLOATING_IP_HOST=$SERVER
    FLOATING_IP=${IP}
  fi
done

# If there's already a floating IP, detach it from the current server
if [ $FLOATING_IP ]
then
  /usr/bin/nova floating-ip-disassociate $FLOATING_IP_HOST $FLOATING_IP
  # Spin the server down as well
  /usr/bin/nova stop $FLOATING_IP_HOST
else
  # Else, let's find a free one
  FLOATING_IP=`/usr/bin/nova floating-ip-list | grep ' - ' | awk '{print $4}' | head -1`
fi

# Build our instance
/usr/bin/nova boot --flavor ${FLAVOR} \
  --image ${IMAGE} \
  --key-name ${KEY_NAME} \
  --user-data user_data.txt $BUILD_TAG

# Associate a free floating IP with the instance
if [ $FLOATING_IP ]
then
  /usr/bin/nova floating-ip-associate $BUILD_TAG $FLOATING_IP
  echo "App is available at $FLOATING_IP"
fi


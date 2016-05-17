build :
	cd code && $(MAKE)

test :
	cd tests && $(MAKE)

clean :
	cd pkg && rm -rf *

package :
	mkdir -p pkg
	cd code && tar cpvzf ../pkg/openstack_app.tar.gz *.php

all : build test


build :
	cd code && $(MAKE)

test :
	cd tests && $(MAKE)

clean :
	rm -rf pkg

package :
	mkdir -p pkg
	cd code && tar cpvzf ../pkg/openstack_app.tar.gz *.php

deploy :
	cd tests && sh boot_instance.sh

all : build test


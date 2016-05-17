build :
	cd code && $(MAKE)

test :
	cd tests && $(MAKE)

clean :
	cd pkg && rm -rf *

all : build test


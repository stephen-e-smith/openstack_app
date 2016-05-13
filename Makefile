build :
	cd code && $(MAKE)

test :
	cd tests && $(MAKE)

all : build test


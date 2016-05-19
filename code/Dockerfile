FROM rhel6-python2.6

MAINTAINER Michael Solberg <msolberg@redhat.com>

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/


all: build

build:
	docker build -t mailerq-cloud-single .

run: build
	docker run -v `pwd`/external:/external -it mailerq-cloud-single 

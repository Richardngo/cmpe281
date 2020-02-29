
all: clean 

clean:
	find . -name "*.class" -exec rm -rf {} \;
	rm -rf build/*

compile:
	gradle build

build: compile
	gradle shadowJar

run: build
	echo Starting Service at:  http://localhost:9090
	java -cp build/libs/starbucks-all.jar api.StarbucksServer

docker-build: 
	docker build -t starbucks .
	docker images

docker-clean:
	docker stop starbucks
	docker rm starbucks
	docker rmi starbucks

docker-run:
	docker run --name starbucks -td starbucks
	docker ps

docker-run-host:
	docker run --name starbucks -td --net=host starbucks
	docker ps

docker-run-bridge:
	docker run --name starbucks -td -p 90:9090 starbucks
	docker ps

docker-network:
	docker network inspect host
	docker network inspect bridge

docker-stop:
	docker stop starbucks
	docker rm starbucks

docker-shell:
	docker exec -it starbucks bash 

install-curl:
	apt-get update; apt-get install curl
	yum install curl

ping:
	curl -X GET http://localhost:9090/

order:
	curl -X POST \
  http://localhost:9090/starbucks/order \
  -d '{ "location": "take-out", "items": [{"qty": 1, "name": "latte", "milk": "whole", "size": "large"}]}'

get:
	curl -X GET http://localhost:9090/starbucks/order/$(order_id)

pay:
	curl -X POST http://localhost:9090/starbucks/order/$(order_id)/pay



	

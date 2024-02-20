
build:
	docker build -t core-jenkins .

stop:
	docker-compose -f docker-compose.yaml down
	docker-compose -f docker-compose.yaml rm

run: stop
	docker-compose -f docker-compose.yaml up -d

exec:
	docker exec -it core-jenkins bash

logs:
	docker logs core-jenkins

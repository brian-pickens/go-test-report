build:
	docker build ./src/.
run:
	docker run --rm -it $$(docker build -q ./src/.)
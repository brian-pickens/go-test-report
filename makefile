build:
	docker build -t go-test-report ./src/.
run:
	docker build -t go-test-report -q ./src/.
	docker run --rm -it $$(docker build -q ./test/.)
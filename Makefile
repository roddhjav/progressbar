all:
	@echo "'progressbar' is a simple shell script, so there is nothing to do. Try \"make test\" instead."

install:
	@echo "'progressbar' is a simple shell script, so there is nothing to do. Try \"make test\" instead."

tests:
	make -C tests

lint:
	shellcheck -s bash progressbar.sh


.PHONY: all install tests lint

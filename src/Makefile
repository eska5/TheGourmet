SOURCES := inference_server meals_operator training_scripts
TEST_SOURCES := inference_server meals_operator
SEPERATOR := "------------------------------------------------------------------"
.SILENT: style_prerequisites style-check test_prerequisites test test-cov style-fix


style_prerequisites:
	pip install install black
	pip install install mypy
	pip install install pylint
	pip install --upgrade click==8.0.

test_prerequisites:
	sudo apt install python3-pip
	pip install --upgrade pip
	pip install -r meals_operator/requirements.txt
	pip install -r inference_server/requirements.txt
	pip install pytest pytest-mock pytest-cov


style-check: style_prerequisites
	echo $(SEPERATOR)
	echo "Running mypy type check inside: $(SOURCES)"
	# python3 -m mypy $(SOURCES) --ignore-missing-imports --show-error-codes
	echo "Successfully finished mypy type check inside: $(SOURCES)"
	echo $(SEPERATOR)
	echo "Running black format check inside: $(SOURCES)"
	python3 -m black $(SOURCES)
	echo "Successfully finished black format check inside: $(SOURCES)"
	echo $(SEPERATOR)
	echo "Running pylint code smells check inside: $(SOURCES)"
	python3 -m pylint $(SOURCES) --disable=E0401,C0114,C0115,C0116,W0603,C0411
	echo "Successfully finished pylint code smells check inside: $(SOURCES)"
	echo $(SEPERATOR)

style-fix: style_prerequisites
	echo "Running black formatting inside: $(SOURCES)"
	black $(SOURCES)
	echo "Successfully finished black formatting inside: $(SOURCES)"


test: test_prerequisites
	echo "Running unit test inside: $(TEST_SOURCES)"
	cd meals_operator; python3 -m pytest .
	cd inference_server; python3 -m pytest .
	echo "Unit tests successfully passed inside: $(TEST_SOURCES)"


test-cov: test_prerequisites
	echo "Running unit test coverage inside: $(TEST_SOURCES)"
	cd meals_operator; python3 -m pytest --cov-report term-missing --cov .
	cd inference_server; python3 -m pytest --cov-report term-missing --cov .
	echo "Unit tests coverage completed inside: $(TEST_SOURCES)"
SOURCES := inference_server
SEPERATOR := "------------------------------------------------------------------"
.SILENT: prerequisites style-check


prerequisites:
	sudo apt-get update -y
	sudo apt-get -y install black
	sudo apt-get -y install mypy
	sudo apt-get -y install pylint


style-check: prerequisites
	echo $(SEPERATOR)
	echo "Running mypy type check inside: $(SOURCES)"
	mypy $(SOURCES) --ignore-missing-imports
	echo "Successfully finished mypy type check inside: $(SOURCES)"
	echo $(SEPERATOR)
	echo "Running black format check inside: $(SOURCES)"
	black $(SOURCES)
	echo "Successfully finished black format check inside: $(SOURCES)"
	echo $(SEPERATOR)
	echo "Running pylint code smells check inside: $(SOURCES)"
	pylint $(SOURCES) --disable=E0401,C0114,C0115,C0116,W0603
	echo "Successfully finished pylint code smells check inside: $(SOURCES)"
	echo $(SEPERATOR)

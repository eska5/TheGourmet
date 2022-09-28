SOURCES := inference_server meals_operator
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
	#mypy $(SOURCES)
	echo "Successfully finished mypy type check inside: $(SOURCES)"
	echo $(SEPERATOR)
	echo "Running black format check inside: $(SOURCES)"
	black $(SOURCES)
	echo "Successfully finished black format check inside: $(SOURCES)"
	echo $(SEPERATOR)
	echo "Running pylint code smells check inside: $(SOURCES)"
	pylint $(SOURCES)
	echo "Successfully finished pylint code smells check inside: $(SOURCES)"
	echo $(SEPERATOR)

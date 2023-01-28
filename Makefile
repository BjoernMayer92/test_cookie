PROJECT_NAME = test_cookie
REPO_NAME = test_cookie
REMOTE_GIT = y

ifeq (,$(shell which conda))
HAS_CONDA=False
else
HAS_CONDA=True
endif


initialize_git:
	@echo "Initalizing git ... "
	git init
	git add .
	git commit -m "inital commit"
	
ifeq (y,$(REMOTE_GIT))
	#gh repo create $(REPO_NAME) --public 
	git_user_name=$(shell gh api user | jq -r ".login")
	@echo $(git_user_name)

endif	


activate:
	@echo "Activating virtual environment..."
	source activate 

create_environment:
ifeq (True,$(HAS_CONDA))
	conda env create -f requirements.yml
endif
@echo "New conda env created. Activate with: \nsource activate $(ROJECT_NAME)"

update_environment:
	conda env update --file environment.yml

delete_environment:
	conda env remove -n $(PROJECT_NAME)

lint:
	flake8 src

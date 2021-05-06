# start from an official image
FROM python:3.6

# arbitrary location choice: you can change the directory
RUN mkdir -p /opt/services/djangoapp/src
WORKDIR /opt/services/djangoapp/src

# install our dependencies
# we use --system flag because we don't need an extra virtualenv
COPY Pipfile Pipfile.lock /opt/services/djangoapp/src/
RUN pip install pipenv && pipenv install --system

# copy our project code
COPY . /opt/services/djangoapp/src

# expose the port 8080
EXPOSE 8080

# define the default command to run when starting the container
CMD ["gunicorn", "--chdir", "blog_project", "--bind", ":8080", "blog_project.wsgi:application", "--capture-output", "--access-logfile","-", "--reload"]
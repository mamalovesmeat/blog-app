FROM python:3.9-slim

# Install which command if necessary
RUN apt-get update && apt-get install -y which

# Set working directory
WORKDIR /app

# Copy Pipfile and Pipfile.lock
COPY Pipfile Pipfile.lock /app/

# Install pipenv and create virtual environment
RUN pip install pipenv
RUN pipenv --venvs

# Copy the rest of the application code
COPY . /app/

# Activate the virtual environment and install dependencies
RUN source $(pipenv --venvs)/bin/activate && pipenv install --deploy --ignore-pipfile

# Expose the port
EXPOSE 8000

# Run command to start the application
CMD ["source", "$(pipenv --venvs)/bin/activate", "&&", "python", "manage.py", "runserver", "0.0.0.0:8000"]

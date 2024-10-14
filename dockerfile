FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Copy Pipfile and Pipfile.lock
COPY Pipfile Pipfile.lock /app/

# Install pipenv and dependencies
RUN pip install pipenv
RUN pipenv --venvs
RUN source $(pipenv --venvs)/bin/activate && pipenv install --deploy --ignore-pipfile

# Copy the rest of the application code
COPY . /app/

# Expose the port
EXPOSE 8000

# Run command to start the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

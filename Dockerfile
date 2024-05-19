# Use the official Python image from the Docker Hub with a specific version
FROM python:3.8.10-slim-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libev-dev \
    gcc \
    pkg-config \
    libpq-dev \
    libhdf5-dev \
    python3-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    && apt-get clean

# Upgrade pip
RUN pip install --upgrade pip

# Install Cython first
RUN pip install Cython

RUN pip install requests

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Expose the port that Flask will run on
EXPOSE 5000

# Run the Flask app
CMD ["flask", "run"]

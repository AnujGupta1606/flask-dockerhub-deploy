# Simple Python setup
FROM python:3.9-slim

# Create app directory
WORKDIR /app

# Install Python packages
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy Flask app
COPY app/ .

# Port for Flask
EXPOSE 5000

# Run Flask app
CMD ["python", "app.py"]

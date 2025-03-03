# syntax=docker/dockerfile:1
#FROM python:3.10-bullseye
FROM l4t-pytorch:r36.4.3

# Expose the required port
EXPOSE 6969

# Set up working directory
WORKDIR /app

# Install system dependencies, clean up cache to keep image size small
RUN apt update && \
    apt install -y -qq ffmpeg && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Copy application files into the container
COPY requirements.txt .

# Create a virtual environment in the app directory and install dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir python-ffmpeg && \
    pip install --no-cache-dir -r requirements.txt

# Define volumes for persistent storage
# VOLUME ["/app/logs/"]

# Set environment variables if necessary
#ENV PATH="/app/.venv/bin:$PATH"

# Run the app
# ENTRYPOINT ["python3"]
# CMD ["app.py"]

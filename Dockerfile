# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install any necessary system dependencies
RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user for added security
RUN useradd -m scriptrunner

# Copy the scripts into the container
COPY unsafe_script.py /app/
COPY run_script.sh /app/

# Set appropriate permissions
RUN chmod +x /app/run_script.sh

# Switch to non-root user
USER scriptrunner

# Default command
CMD ["/app/run_script.sh"]

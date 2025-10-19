# Use the official Python image from the Python Docker Hub repository as the base image
FROM python:3.12-slim-bullseye

# Set the working directory to /app in the container
WORKDIR /app

# Copy requirements first to leverage Docker layer cache
COPY requirements.txt ./

# Create non-root user, install deps, and make writable dirs
RUN useradd -m myuser && pip install --no-cache-dir -r requirements.txt && \
    mkdir logs qr_codes && chown myuser:myuser logs qr_codes

# Copy the rest of the app with correct ownership
COPY --chown=myuser:myuser . .

# Drop privileges
USER myuser

# Default process (can be extended with extra args)
ENTRYPOINT ["python", "main.py"]
# Default argument (can be overridden by docker run / compose)
CMD ["--url","http://github.com/kaw393939"]

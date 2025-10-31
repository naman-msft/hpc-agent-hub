FROM mcr.microsoft.com/mirror/docker/library/python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ✅ AUTOMATIC CACHE BUSTER - Uses git commit SHA from GitHub Actions
ARG CACHEBUST=dev
RUN echo "Building from commit: $CACHEBUST"

# Copy application code
COPY . .

# Create non-root user for security
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 5000

# Start with gunicorn
CMD gunicorn --bind 0.0.0.0:5000 --workers 2 --timeout 120 --access-logfile - --error-logfile - --log-level info app:app
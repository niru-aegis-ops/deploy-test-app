# Multi-stage Dockerfile

# Stage 1: Builder
FROM python:3.9-slim-buster as builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Runner
FROM python:3.9-slim-buster

WORKDIR /app

# Copy only the installed packages from the builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

# Copy application code
COPY app.py .

EXPOSE 5000

# Run the application using Gunicorn for production
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

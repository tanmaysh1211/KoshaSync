
# Backend Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all backend Python modules
COPY main.py .
COPY data_loader.py .
COPY matcher.py .
COPY ml_matcher.py .
COPY policy.py .

# Copy datasets and trained ML model
COPY data/ ./data/
COPY models/ ./models/

# Create logs directory
RUN mkdir -p logs

# Backend port
EXPOSE 8000

# Default environment variables
ENV DATA_DIR=data
ENV RISK_TOLERANCE_INR=500.00
ENV CORS_ORIGINS=*

# Start FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

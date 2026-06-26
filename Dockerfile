# 1. Use the 'slim' image to drastically reduce the final image size
FROM python:3.12-slim

# 2. Use apt-get (stable for scripts), avoid installing unnecessary packages, and clean up the cache
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends awscli && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 3. Copy ONLY requirements.txt first to leverage Docker layer caching
COPY requirements.txt .

# 4. Install dependencies with --no-cache-dir to save space
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of the application code AFTER dependencies are installed
COPY . .

CMD ["python", "app.py"]
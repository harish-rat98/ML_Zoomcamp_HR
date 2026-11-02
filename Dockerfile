# 1. Start from a small image that already has Python 3.11 (matches your Pipfile)
FROM python:3.11-slim

# 2. Install pipenv inside the container
RUN pip install pipenv

# 3. Everything below happens in /app inside the container
WORKDIR /app

# 4. Copy ONLY the dependency files first (so Docker can cache this layer)
COPY ["Pipfile", "Pipfile.lock", "./"]

# 5. Install the exact versions from Pipfile.lock, straight into the system Python
#    --system  = no virtualenv needed (the container IS the isolation)
#    --deploy  = fail if Pipfile.lock is out of date
RUN pipenv install --system --deploy

# 6. Now copy the app code and the trained model
COPY ["predict.py", "model_C=1.0.bin", "./"]

# 7. Document which port the app listens on
EXPOSE 9696

# 8. Start the app with gunicorn (a production web server, not Flask's dev server)
ENTRYPOINT ["gunicorn", "--bind=0.0.0.0:9696", "predict:app"]

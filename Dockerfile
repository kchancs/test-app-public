FROM python:3.9-slim-buster

WORKDIR /
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy application code into the container
COPY . .

# expose the port
EXPOSE 8090

CMD ["python", "sample-app.py"]
# test-app-public

sample build:
```
docker build -t test-app-public:0.1 .
docker run -d -p 8090:8090 --name test-app-public test-app-public:0.1
```
FROM python:3.8-alpine
COPY server.py /server.py
WORKDIR /app
ENTRYPOINT ["python3","-u", "server.py"]

#syntax=docker/dockerfile:1

FROM python:3.12-slim AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/app/venv/bin:$PATH"

WORKDIR /app


COPY requirements.txt ./
RUN python -m venv /app/venv
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

FROM python:3.12-slim

WORKDIR /app

ENV PYTHONUNBUFFERED=1
ENV PATH="/app/venv/bin:$PATH"
EXPOSE 8000

COPY manage.py ./
COPY jonas_website/ ./jonas_website/
COPY main/ ./main/
COPY db.sqlite3 ./
COPY --from=builder /app/venv /app/venv


CMD ["gunicorn", "--bind", "0.0.0.0:8000", "jonas_website.wsgi:application"]
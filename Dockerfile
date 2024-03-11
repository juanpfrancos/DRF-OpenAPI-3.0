FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN pip install gunicorn

COPY . .

RUN python manage.py makemigrations && python manage.py migrate

#Create OpenApi 3.0 Schema

RUN python manage.py spectacular --file schema.yml

EXPOSE 8000

CMD ["gunicorn", "drf_api.wsgi:application", "--bind=0.0.0.0:8000"]

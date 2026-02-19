#lightweight python image
FROM python:3.12-slim
#set working directory inside container
WORKDIR /app
#copy the requirements
COPY requirements.txt .
#install dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
#copy rest of code
COPY . .
#expose the port the app runs on
EXPOSE 8000
#command to start the API
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
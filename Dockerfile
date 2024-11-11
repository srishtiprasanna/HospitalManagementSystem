# Use a Python image from Docker Hub
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy your application files into the container
COPY . /app

# Install the required dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that Streamlit will use
EXPOSE 8501

# Command to run your Streamlit app
CMD ["streamlit", "run", "app.py"]

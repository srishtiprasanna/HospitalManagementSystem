# Use an official Windows Server Core base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set the working directory in the container
WORKDIR /app

# Install Python 3.8 (as Windows Server Core image doesn't have Python by default)
RUN powershell -Command \
    Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.8.10/python-3.8.10-amd64.exe -OutFile python-installer.exe; \
    Start-Process python-installer.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1' -NoNewWindow -Wait; \
    Remove-Item -Force python-installer.exe

# Install dependencies from the requirements file
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose the port that Streamlit will run on
EXPOSE 8501

# Command to run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.enableCORS=false"]

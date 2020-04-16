FROM python:3.7-slim-stretch

RUN apt-get update && apt-get install -y git python3-dev gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR app 
# Install pytorch and fastai
# RUN pip install torch_nightly -f https://download.pytorch.org/whl/nightly/cpu/torch_nightly.html

ADD requirements.txt .
RUN pip install -r requirements.txt
#pip install --no-cache-dir -r
ADD models models
ADD src src

# Run it once to trigger resnet download
RUN python src/app.py prepare

#EXPOSE 5000

# Start the server
CMD ["python", "src/app.py", "serve"]
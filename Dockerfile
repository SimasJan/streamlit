FROM docker.io/python:3.8-slim

WORKDIR /usr/src/app

# OS Update
RUN apt-get update --allow-unauthenticated -y

COPY . ./

# RUN pip install --no-cache-dir -r Pipfile
RUN pip install -r requirements.txt

# streamlit-specific commands for config
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8echo 

RUN mkdir -p /.streamlit
RUN chmod 777 /.streamlit

RUN bash -c 'echo -e "\
[general]\n\
email = \"\"\n\
" > /.streamlit/credentials.toml'

RUN bash -c 'echo -e "\
[server]\n\
enableCORS = false\n\
enableXsrfProtection = false\n\
enableWebsocketCompression = false\n\
" > /.streamlit/config.toml'

EXPOSE 8080
CMD ["python", "-m", "streamlit", "run", "app.py", "--server.port=8080"]
EXPOSE 8080

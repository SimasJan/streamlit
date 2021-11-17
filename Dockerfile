FROM python:3.7

WORKDIR /app

COPY requirements.txt ./requirements.txt

RUN pip install -r requirements.txt
# exposing default port for streamlit
EXPOSE 8501

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

EXPOSE 8501

COPY . .

ENTRYPOINT ["streamlit", "run"]
CMD ["streamlit", "run", "iris_streamlit_demo.py"]
EXPOSE 8501

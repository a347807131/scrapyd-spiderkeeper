FROM vimagick/scrapyd:py3
MAINTAINER Gatsby,<a347807131@gmail.com>
ENV SK_USER=admin S_PASSWORD=admin SD_SERVER=localhost
ENV PIP_MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple/
WORKDIR /app
COPY requirements.txt ./
#解决安装mysqlclient的问题
RUN apt-get update && \
    apt-get install default-libmysqlclient-dev &&\
    apt-get install python3 python-dev python3-dev &&\
    apt-get install build-essential libssl-dev libffi-dev &&\
    apt-get install libxml2-dev libxslt1-dev zlib1g-dev

RUN pip install -i $PIP_MIRROR --upgrade --no-cache-dir setuptools==45.2.0
RUN pip install -i $PIP_MIRROR -r requirements.txt &&\
    pip install -i $PIP_MIRROR --no-cache-dir spiderkeeper

EXPOSE 5000 6800
CMD scrapyd --pidfile= &\
    spiderkeeper --server=$SD_SERVER --username=$SK_USERNAME --password=$SK_PASSWORD
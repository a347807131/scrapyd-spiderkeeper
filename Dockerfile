FROM vimagick/scrapyd:py3
MAINTAINER Gatsby,<a347807131@gmail.com>
ENV SK_USER=admin S_PASSWORD=admin SD_SERVER=localhost
ENV PIP_MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple/
WORKDIR /app
COPY requirements.txt ./
#解决安装mysqlclient的问题
RUN apt-get update && \
    apt-get install -y default-libmysqlclient-dev &&\
    apt-get install -y python3 python-dev python3-dev &&\
    apt-get install -y build-essential libssl-dev libffi-dev &&\
    apt-get install -y libxml2-dev libxslt1-dev zlib1g-dev

RUN pip install  --upgrade setuptools==45.2.0 &&\
RUN pip install  spiderkeeper &&\
    pip install  -r requirements.txt

EXPOSE 5000 6800
CMD scrapyd --pidfile= &\
    spiderkeeper --server=$SD_SERVER --username=$SK_USERNAME --password=$SK_PASSWORD
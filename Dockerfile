FROM openjdk:latest

RUN apt-get update \
	&& apt-get install -y --no-install-recommends iceweasel xvfb 

RUN mkdir /arpit
RUN mkdir /arpit/deployments
COPY deployments/* /arpit/deployments
COPY entrypoint.sh /arpit/

RUN wget -O geckodriver.tar.gz \
	$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/6664074 | grep  browser_download_url | grep linux64 | cut -d '"' -f 4)

RUN tar -xzvf geckodriver.tar.gz
RUN cp geckodriver /arpit/
RUN rm geckodriver.tar.gz

RUN chmod +x /arpit/entrypoint.sh
#CMD bash /arpit/entrypoint.sh
ENTRYPOINT ["/arpit/entrypoint.sh"]

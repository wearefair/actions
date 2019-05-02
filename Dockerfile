FROM python:3.6
RUN apt-get update && apt-get install -y --no-install-recommends ssh
ADD build-package.sh /
RUN chmod +x build-package.sh
ENTRYPOINT ["/build-package.sh"]

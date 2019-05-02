FROM python:3.6
RUN apt-get update && apt-get install -y --no-install-recommends ssh jq
ADD release-package.sh /
ADD github.json /
RUN chmod +x release-package.sh
ENTRYPOINT ["/release-package.sh"]

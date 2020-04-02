FROM alpine

ENV TERRAFORM_VERSION=0.12.23

RUN apk add --update git bash openssh curl unzip

RUN curl -s https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip && \
  unzip terraform.zip && \
  chmod +x terraform && \
  mv terraform /usr/bin/terraform && \
  rm terraform.zip && \
  terraform version

ENTRYPOINT ["/bin/sh"]
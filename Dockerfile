FROM ubuntu
RUN apt-get update -y
RUN apt-get install wget -y
RUN apt-get install git -y
RUN apt-get install tree -y
CMD ["ls"]

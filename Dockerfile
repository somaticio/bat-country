FROM somatic/cuda
RUN ls
RUN git clone https://xx993e65f591708d4a3ed33e675dd3c019d4e25f82@github.com/somaticio/bat-country /home/ubuntu/experiment
#ADD * /home/ubuntu/experiment/    <--- this should work,its a bug with docker https://github.com/docker/docker/issues/18396
RUN apt-get install -y \
      python-numpy python-scipy \
      build-essential python-dev python-setuptools \
      libatlas-dev libatlas3gf-base

RUN update-alternatives --set libblas.so.3 \
      /usr/lib/atlas-base/atlas/libblas.so.3; \
    update-alternatives --set liblapack.so.3 \
      /usr/lib/atlas-base/atlas/liblapack.so.3
RUN cd /home/ubuntu/somaticagent/ && git pull
RUN cd /home/ubuntu/experiment && pip install -r requirements.txt
ADD .docker-experimentconfig /home/ubuntu/experiment/.experimentconfig
RUN python /home/ubuntu/somaticagent/web.py -i

FROM somatic/cuda
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
#move install instructions to main cuda/docker

RUN cd /home/ubuntu/somaticagent/ && git pull
RUN cd /home/ubuntu/experiment && pip install -r requirements.txt
RUN cd /home/ubuntu/experiment && python setup.py install
ADD .docker-experimentconfig /home/ubuntu/experiment/.experimentconfig


#MOVE BACK
RUN cd /opt/caffe/python && pip install -r requirements.txt
RUN cd /opt/caffe && make pycaffe && make distribute
RUN /opt/caffe/scripts/download_model_binary.py /opt/caffe/models/bvlc_googlenet #MOVE THIS TO experimentfile
RUN python /home/ubuntu/somaticagent/web.py -i

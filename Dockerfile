FROM nvidia/cuda:10.0-base-ubuntu18.04

# Pick up some TF dependencies
RUN apt update && apt install -y \
        build-essential \
        cuda-command-line-tools-10-0 \
        cuda-cublas-10-0 \
        cuda-cufft-10-0 \
        cuda-curand-10-0 \
        cuda-cusolver-10-0 \
        cuda-cusparse-10-0 \
        libcudnn7=7.4.2.24-1+cuda10.0 \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libpng-dev \
        libzmq3-dev \
        pkg-config \
        software-properties-common \
        unzip \
        nvinfer-runtime-trt-repo-ubuntu1804-5.0.2-ga-cuda10.0 \
        libnvinfer5=5.1.2-1+cuda10.0

# For CUDA profiling, TensorFlow requires CUPTI.
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

# Start of Conda installation of tensorflow
COPY anaconda.yaml /tmp

RUN apt update && apt install -y build-essential libssl1.0.0 wget && apt clean
RUN cd /tmp && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && chmod a+x /tmp/Miniconda3-latest-Linux-x86_64.sh
RUN /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/anaconda
RUN /opt/anaconda/bin/conda-env update -f /tmp/anaconda.yaml

ENV PYTHONUNBUFFERED=1
ENV PATH=/opt/anaconda/bin:$PATH

ENTRYPOINT ["python"]

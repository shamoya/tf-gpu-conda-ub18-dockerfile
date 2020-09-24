# tf-gpu-conda-ub18-docker

This is a Dockerfile for my building and running tensorflow-gpu (1.13.1 version),
inside a miniconda with python 3.7.3, without installing the cuda toolkit from the conda enviorement.
Instead, cuda is being installed via nvidia docker images, just like "normal" tensorflow-gpu (non conda) docker image is built.

# Use the official Debian image as the base image
FROM debian:latest

# Set the working directory in the container
# WORKDIR /usr/src/app

######################################################################
########################## Ultra basics ##############################
######################################################################

RUN apt-get update && \
    apt-get install -y wget && \ 
    apt-get install -y git && \
    # needed to compile rusty_axe
    apt-get install binutils 

######################################################################
############################ MiniConda ###############################
######################################################################

RUN mkdir -p ~/miniconda3

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh

RUN bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

ENV PATH=~/miniconda3/bin:$PATH
RUN ~/miniconda3/bin/conda init bash

SHELL ["/bin/bash", "-c"]

######################################################################
####################### Jupyter + Scanpy #############################
######################################################################

RUN conda install -c conda-forge -y python=3.11 conda-libmamba-solver

RUN conda install -c conda-forge -y jupyter scanpy python-igraph leidenalg pandas pybind11 setuptools 

######################################################################
#################### PyCoGAPS#########################################
######################################################################

# RUN conda config --set solver classic
# RUN conda install -c conda-forge -y conda-forge::gcc conda-forge::gxx conda-forge::boost

# RUN git clone https://github.com/FertigLab/pycogaps.git --recursive

# WORKDIR /home/haxx/pycogaps

# RUN ~/miniconda3/bin/conda run -n base python /home/haxx/pycogaps/setup.py install

######################################################################
########################## R Install #################################
######################################################################

# RUN ~/miniconda3/bin/conda install -y r-recommended r-irkernel
# RUN R -e 'IRkernel::installspec()'


######################################################################
########################## Rusty Axe #################################
######################################################################

RUN conda install -c conda-forge -y rust
# RUN git clone https://github.com/bbrener1/ --recursive

RUN mkdir /home/haxx

WORKDIR /home/haxx/


######################################################################
########################## Initialization ############################
######################################################################


# Expose the port Jupyter will run on
EXPOSE 8888

# Run the start-up script when the container launches
# RUN ~/miniconda3/bin/jupyter notebook --ip 0.0.0.0 --no-browser --allow-root

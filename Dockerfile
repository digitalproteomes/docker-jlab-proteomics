FROM jupyter/datascience-notebook

LABEL maintainer="Patrick Pedrioli"
LABEL Description="A JupyterLab proteomics data analysis"

################################
## Add some jupyterlab extensions
RUN pip install --upgrade nbdime
RUN nbdime config-git --enable --global

RUN jupyter labextension install @jupyterlab/git
RUN pip install jupyterlab-git
RUN jupyter serverextension enable --py jupyterlab_git

RUN jupyter labextension install jupyterlab_tensorboard
RUN pip install jupyter-tensorboard

RUN pip install rpy2
RUN conda install r-styler

RUN jupyter labextension install @jupyterlab/toc

RUN jupyter labextension install jupyterlab-emacskeys

RUN jupyter lab build

#################
## Add TensorFlow
RUN pip install tensorflow

###############################################################
# Install any additional R package specified in r-requirements.R
COPY r-requirements.R /tmp/
RUN Rscript /tmp/r-requirements.R


##########################################################################
## Install any additional python package specified in the requirements.txt
## We use pip rather than conda, to avoid neverending solve times.
COPY requirements.txt /tmp/

RUN while read requirement; do pip install $requirement; done < /tmp/requirements.txt

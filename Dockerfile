FROM jupyter/datascience-notebook:2023-02-20

LABEL maintainer="Patrick Pedrioli"
LABEL Description="A JupyterLab for proteomics data analysis"


#################
## Add TensorFlow
RUN pip3 install --upgrade tensorflow
RUN pip3 install --upgrade tensorboard


################################
## Add some jupyterlab extensions
# Diffing and merging notebooks
RUN pip3 install --upgrade nbdime
#RUN nbdime config-git --enable --global

#RUN jupyter labextension install @jupyterlab/git
RUN pip3 install --upgrade jupyterlab jupyterlab-git
#RUN jupyter serverextension enable --py jupyterlab_git

#RUN jupyter labextension install jupyterlab_tensorboard
#RUN pip install git+https://github.com/cliffwoolley/jupyter_tensorboard.git
#RUN pip3 install jupyter-tensorboard
RUN pip3 install --upgrade jupyterlab-tensorboard-pro


#RUN pip3 install rpy2
RUN conda install r-styler

#RUN jupyter labextension install @jupyterlab/toc


#RUN jupyter lab build


###############################################################
# Install any additional R package specified in r-requirements.R
COPY r-requirements.R /tmp/
RUN Rscript /tmp/r-requirements.R


##########################################################################
## Install any additional python package specified in the requirements.txt
## We use pip rather than conda, to avoid neverending solve times.
COPY requirements.txt /tmp/

RUN while read requirement; do pip install $requirement; done < /tmp/requirements.txt


# This breaks Ctrl-V paste shortcut
# But you can use Ctrl-shift-v instead
#RUN jupyter labextension install jupyterlab-emacskeys

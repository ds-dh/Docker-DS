FROM jupyter/base-notebook

LABEL maintainer = "Data Science <datascience@digitalhouse.com>"


ENV NB_USER=DS-DH-2018\
	NB_UID=1001

ENV HOME=/home/$NB_USER

USER root

RUN useradd -ms /bin/bash -N -u $NB_UID $NB_USER  && \
    mkdir -p $CONDA_DIR && \
    chown -R $NB_USER:$NB_GID $CONDA_DIR && \
    fix-permissions $HOME && \
	fix-permissions $CONDA_DIR && \
	echo "$NB_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/notebook &&\
	mkdir /home/$NB_USER/notebooks && \
	fix-permissions /home/$NB_USER && \
	usermod -aG sudo $NB_USER

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	python-pip \
	git && \
	apt-get -y install gcc \
	&& rm -rf /var/lib/apt/lists/* 


RUN conda_libs='numpy \
scipy \
statsmodels \
matplotlib \
seaborn \
nltk \
setuptools \
sqlite \
bokeh \
pandas \
plotly \
scrapy \
beautifulsoup4 \
dill' && \
conda install --yes $conda_libs

RUN pip_libs='ez_setup \
multiprocess \
datetime \
sqlparse \
ipython-sql \
sqlalchemy \
scikit-learn \
selenium \
joblib \
scikit-image \
unidecode \
geopandas \
imblearn \
graphviz' \
&& pip install --upgrade $pip_libs \
&& pip install --quiet 'git+https://github.com/esafak/mca' 


USER $NB_USER
WORKDIR $HOME

CMD ["start-notebook.sh", "--NotebookApp.token=''", "--allow-root"]
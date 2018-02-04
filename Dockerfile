FROM jupyter/base-notebook

LABEL maintainer = "Data Science <datascience@digitalhouse.com>"

CMD ["/bin/bash", "useradd", "--disabled-password", "--create-home", "DS-DH-2018"]

#RUN conda install --yes 'numpy' 
# 'scipy'\
# 'statsmodels'\
# 'sklearn'

#RUN conda install --yes 'matplotlib' 'seaborn'

USER DS-DH-2018
WORKDIR /home/DS-DH-2018
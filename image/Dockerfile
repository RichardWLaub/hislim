FROM continuumio/anaconda3:2018.12
RUN mkdir /opt/notebooks 
COPY hi-slim.ipynb /opt/notebooks
COPY jupyter_notebook_config.py /root/.jupyter/
COPY jupyter_notebook_config.json /root/.jupyter/
CMD ["/opt/conda/bin/jupyter", "notebook", "--notebook-dir=/opt/notebooks", "--ip=0.0.0.0", "--port=80", "--no-browser", "--allow-root"]

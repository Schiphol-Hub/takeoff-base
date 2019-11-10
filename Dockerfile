FROM hseeberger/scala-sbt:8u212_1.2.8_2.13.0

ARG MINICONDA_VERSION=3
ARG MINICONDA_RELEASE=4.7.12
ARG PYTHON_VERSION=3.8

ENV PATH="/opt/miniconda${MINICONDA_VERSION}/bin:${PATH}"

RUN set -x && \
    apt-get update && \
    apt-get install -y curl bzip2 build-essential && \
    curl -s --url "https://repo.continuum.io/miniconda/Miniconda${MINICONDA_VERSION}-${MINICONDA_RELEASE}-Linux-x86_64.sh" --output /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -f -p "/opt/miniconda${MINICONDA_VERSION}" && \
    rm /tmp/miniconda.sh && \
    apt-get purge -y bzip2 && \
    apt-get clean && \
    conda config --set auto_update_conda true && \
    conda install python=$PYTHON_VERSION -y --force;\
    conda clean -tipsy && \
    find /opt/miniconda${MINICONDA_VERSION} -depth \( \( -type d -a \( -name test -o -name tests \) \) -o \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \) | xargs rm -rf && \
    echo "PATH=/opt/miniconda${MINICONDA_VERSION}/bin:\${PATH}" > /etc/profile.d/miniconda.sh && \
    echo "source /etc/profile.d/miniconda.sh" >> ~/.bashrc

RUN apt-get update && apt-get install -y --no-install-recommends lsb-release apt-transport-https \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian  $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce

# Install kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN touch /etc/apt/sources.list.d/kubernetes.list
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y --no-install-recommends kubectl=1.16.0-00 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

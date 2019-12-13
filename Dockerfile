FROM python:3.6-alpine

RUN apk update && \
	apk add --no-cache \
    # bash \
    libstdc++ \
    libgomp \
	lapack \
    libpng && \
    apk add --no-cache --virtual .build-deps \
	git \
	build-base \
    cmake \
    gfortran \
    lapack-dev \
    musl-dev \
    python3-dev \
    jpeg-dev \
    freetype-dev \
    libffi-dev \
    openssl-dev \
    g++ && \
	ln -s locale.h /usr/include/xlocale.h && \
	pip install --no-cache-dir \
	Cython && \
    pip install --no-cache-dir \
    numpy==1.17.0 && \
	pip install --no-cache-dir \
    scipy \
    scikit-learn==0.21.2 \
    pandas==0.25.0 \
    matplotlib \
    boto3 \
    py-multibase==0.1.2 \
    wheel \
    psutil \
	nltk \
	joblib && \
	git clone https://github.com/google/sentencepiece.git  && \
	cd /sentencepiece && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	(make install || true)  && \
	(ldconfig -v || true ) && \
	cd ../python && \
	python setup.py build && \
	python setup.py install && \
	cd / && \
	rm -rf /sentencepiece && \
	pip install --no-cache-dir \
	bpemb && \
	find /usr/local/lib/python3.*/ -name 'tests' -exec rm -r '{}' + && \
	apk del .build-deps

COPY . .

ENTRYPOINT [ "python", "cloud.py" ]

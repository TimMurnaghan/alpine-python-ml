# alpine-python-ml
Docker Image for a smaller python machine learning and language processing image with a smaller attack surface

Alpine is a popular choice of base image because it's smaller - but the choice of libc means that
python modules are less easy to load as the pre-built binaries don't work.
Pip will fall back to compiling in that case - but then you have to bloat the image with all of the compilers.

This image install the compilers temporarily while it installs some libraries and then removes them.

The main libraries included (along with their dependencies) are:
- numpy
- scipy
- scikit-learn
- pandas
- nltk
- bpemb (Note that bpemb brings in sentencepiece which pip can't build - so we have to manage that as its own step)

Removing the compilers isn't ideal - at some point you will probably want to install some binary modules that aren't yet included.
In that case you either add the new ones to this dockerfile or change it to stop removing the compilers and pay the price of the extra size.

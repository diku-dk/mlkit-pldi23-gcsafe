# Artifact for the paper *Garbage-Collection Safety for Region-Based Type-Polymorphic Programs* submitted to PLDI 2023

## Getting Started

The artifact comprises a Docker image `mlkit-pldi23-gcsafe.tar.gz`.
Depending on your system, `docker` commands might or might not need to
be prefixed with `sudo`.  In the following we will leave off `sudo`,
but you may have to add it yourself.

You can load the Docker image into Docker with:

```
$ docker load -i mlkit-pldi23-gcsafe.tar.gz
```

You can then run the image with:

```
$ docker run -it mlkit-pldi23-gcsafe:latest
```

This will put you into a shell inside a directory containing the
experimental infrastructure.  Run `make` to begin benchmarking.  If it
stays running for a few minutes, then everything likely works.

## Step by Step Instructions

This artifact reproduces the content of Figure 9 of the paper.

The results shown in Figure 9 of the paper were computed on a MacBook
Pro (15-inch, 2016) with a 2.7GHz Intel Core i7 processor and 16GB of
memory, running macOS 12.4.

Simply running `make` should compile and run all benchmarks and
produce a file `benchmarks/static.txt`, with benchmark results for the
first four columns of Figure 9 of the paper, and a file
`benchmarks/dynamic.txt` with benchmark results for the remaining
columns of Figure 9. It takes about 20min to run all the benchmarks
(and produce the two files), depending on your hardware.

The precise results contained in the file `static.txt` should match
closely the results of the submitted paper, as the compilation results
are indifferent to the hardware and operating system on (or for) which
the benchmarks are compiled. On the other hand, the precise results
contained in the file `dynamic.txt` are likely to be somewhat
different from those in the paper unless you use similar
hardware. Hopefully, however, the general trends will remain stable.

## System Requirements

The artifact assumes that `mlkit`, and `mlton` are immediately
runnable from the command line and that necessary environment
variables have been set for them to work.  The provided Docker
container has all this set up already.

Constructing the image from `Dockerfile` requires access to the
Internet, but running `make` does not.

### Building MLKit from Source

The Docker image contains source code for MLKit v4.7.3, which is
located in the folder `mlkit-4.7.3`. As an **optional first
step** (before running the benchmarks), it is possible to compile and
install the MLKit from source, using the following steps (ignore the
possible error by `autobuild`):

```
$ cd mlkit-4.7.3
$ ./autobuild
$ ./configure --with-compiler=mlkit --prefix=/home/bench/mlkit
$ make mlkit && make mlkit_basislibs
$ make install
$ cd ..
```

These steps will overwrite the binary MLKit installation with a
bootstrapped version of the MLKit.

## Docker Image

For space reasons, the Docker image is very sparse and does not have
e.g. text editors installed.  The user account has passwordless `sudo`
so you can install more things if you want.  Otherwise you can use
commands such as `docker cp` to move data out of the image for
inspection on the host system.  Consult your favourite search engine
for information on how to use Docker if you are unfamiliar.

## Manifest

This section describes every top-level directory and nontrivial file
and its purpose.

* `benchmarks/`: The benchmark programs and a Makefile containing
  targets for compiling and executing the benchmarks with MLton and
  different configurations of the MLKit. The Makefile target `all`
  runs the target `static`, which produces a file `static.txt`
  corresponding to the first four columns of Figure 9 of the paper,
  and a target `dynamic`, which produces a file `dynamic.txt`
  corresponding to the remaining columns of Figure 9.

* `tools/`: Various SML programs that constitute the experimental
  tooling.  You should not need to look at these.

* `Dockerfile`: The file used to build the Docker image.  You should
  use the prebuilt image if possible, but if necessary you can build
  it yourself with `make mlkit-pldi23-gcsafe.tar.gz` (uses `sudo`).

  Notice that the Dockerfile is *not* reproducible, so it may or may
  not result in a working image if you try this in the distant future.

* `Makefile`: The commands executed when running `make`.  You can
  extract the commands if you need to run them out of order.

* `mlkit-4.7.3`: Source directory for MLKit v4.7.3, which is the
  source for the binary version of the MLKit, installed in the Docker
  image.

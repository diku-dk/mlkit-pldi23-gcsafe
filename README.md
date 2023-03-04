# Artifact for the paper *Garbage-Collection Safety for Region-Based Type-Polymorphic Programs* submitted to PLDI 2023

This artifact reproduces the content of Figure 9 of the paper.

The results shown in Figure 9 of the paper were computed on a MacBook
Pro (15-inch, 2016) with a 2.7GHz Intel Core i7 processor and 16GB of
memory, running macOS 12.4.

Simply running `make` should compile and run all benchmarks and
produce a file `static.txt`, with benchmark results for the first four
columns of Figure 9 of the paper, and a file `dynamic.txt` with
benchmark results for the remaining columns of Figure 9.

The precise results contained in the file `static.txt` should match
closely the results of the submitted paper, as the compilation results
are indifferent to the hardware and operating system on (or for) which
the benchmarks are compiled. On the other hand, the precise results
contained in the file `dynamic.txt` are likely to be somewhat
different from those in the paper unless you use similar
hardware. Hopefully, however, the general trends will remain stable.

Caveat: The versions of MLKit and MLton have changed for this artifact
compared to the submitted version of the paper). The final version of
the paper will report on the versions used for this artifact (MLKit
4.7.3 and MLton 20210117). Except for a few instances, the reported
numbers in the submitted paper are similar to those that can be
produced with this artifact. The main difference is that, for the
`zebra` benchmark, we now see a difference in the number of garbage
collections for the different configurations `rg` and `rg-`. This
difference will be discussed in the paper.

## System Requirements

The artifact assumes that `mlkit`, and `mlton` are immediately
runnable from the command line and that necessary environment
variables have been set for them to work.  The provided Docker
container has all this set up already.

Constructing the image from `Dockerfile` requires access to the
Internet, but running `make` does not.

## Manifest

This section describes every top-level directory and nontrivial file
and its purpose.

* `benchmarks/`: The benchmark programs and a Makefile containing
  targets for compiling and executing the benchmarks with MLton and
  different configurations of the MLKit. The Makefile taget `all` runs
  the target `static`, which produces a file `static.txt`
  corresponding to the first four columns of Figure 9 of the paper, and
  a target `dynamic`, which produces a file `dynamic.txt`
  corresponding to the remaining columns of Figure 9.

* `tools/`: Various SML programs that constitute the experimental
  tooling.  You should not need to look at these.

* `Dockerfile`: The file used to build the Docker image.  You should
  use the prebuilt image if possible, but if necessary you can build
  it yourself with the following command:

  ```
  $ docker build . -t mlkit-pldi23-gcsafe
  ```

  (You might need `sudo`, depending on your system.)

  The `-t mlkit-pldi23-gcsafe` assigns a tag to the image in your
  local Docker registry.  You can run the built image with:

  ```
  $ docker run -it mlkit-pldi23-gcsafe:latest
  ```

  (Again, might need `sudo`.)

  Notice that the Dockerfile is *not* reproducible, so it may or may
  not result in a working image if you try this in the distant future.

  The image can be saved to a file with:

  ```
  $ docker save mlkit-pldi23-gcsafe | gzip > mlkit-pldi23-gcsafe.gz
  ```

  On another machine, the image can then be loaded from the file:

  ```
  $ docker load -i mlkit-pldi23-gcsafe.tar.gz
  ```

  This file is what we distribute as the "reproducible" artifact.

* `Makefile`: The commands executed when running `make`.  You can
  extract the commands if you need to run them out of order.

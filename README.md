# ChapelForPythonProgrammersMay2023

Chapel code examples using for March 18th tutorial at the 
Rocky Mountain Advanced Computing Consortium Symposium.

See https://rmacc2023.sched.com/event/903d49614e671146f037d53bbfe9cb90
for the abstract for the tutorial.

## Participating in the tutorial

* Poll Everywhere link: https://pollev.com/michellestrout402

* Attempt this Online website for running Chapel code
  * https://ato.pxeger.com/run?1=m70sOSOxIDVnwYKlpSVpuhZoFJQGAA

* Using a container on your laptop
  * First, install docker for your machine and then start them up.
    podman requires some extra steps so the container can mount your 
    local directly with the example code.
```
    NOTE: podman was having issues at the time of this tutorial.
    Thus these instructions are only for docker.
```
  * Then, use the below commands to compile and then run the various
    chapel code examples on your laptop.
```
 docker pull docker.io/chapel/chapel     // takes about 5 minutes
 git clone git@github.com:mstrout/ChapelForPythonProgrammersMay2023.git
 cd ChapelForPythonProgrammersMay2023
 docker run --rm -v "$PWD":/myapp -w /myapp chapel/chapel chpl hello.chpl
 docker run --rm -v "$PWD":/myapp -w /myapp chapel/chapel ./hello
```

## Code Examples in this repository

For these code examples to compile and run as described in the "usage" message 
at the top of each source file, make sure you have installed, initialized, 
and started docker as described below in Prerequisites.

* `hello.chpl`, serial version of hello world

* `hello6-taskpar-dist.chpl`, distributed and thread parallel version

* `kmer.chpl`, serial kmer counting program, `kmer_large_input_file.txt` is example input

* `diffusion.chpl`, a parallel implementation of heat diffusion

* Many other examples in the `ExamplesInSlides/` and `ExamplesInPollEV/`
  directories.

## Chapel Tutorial for Python Programmers: Productivity and Performance in One Language

Many users of HPC systems are also Python programmers. Python is a great programming language for prototyping data analyses and simulations, but things become more challenging when trying to leverage cross-node and within-node parallelism. In this tutorial, we present the general-purpose Chapel programming language for productive, parallel programming. Participants can experiment with Chapel code examples from applications such as k-mer counting, solving a diffusion PDE, sorting, and image processing. For hands-on activities, we provide a container for quick setup and instructions on how to use Chapel on the UArizona HPC systems. Active learning exercises such as online multiple choice about converting common Python patterns into Chapel code enable participants to check what they have learned. Throughout the tutorial, existing large applications written in Chapel are highlighted with quotes from their developers and example code snippets showing Chapel usage in production.  We also give a brief introduction to Chapel’s newfound support for GPU programming. Come join us for a fun couple of hours exploring how to write parallel programs in a productive and performant way!

## Prerequisites
```
NOTE: unfortunately, podman was not working as expected for this tutorial
```

Please install podman (https://podman.io/) on your laptop beforehand or bring
along a friend who has it installed on their laptop and is willing to share.
Here is how you could install and start it on a mac:

    brew install podman                  # ignore the llvm15 dep error
    podman machine init
    podman machine start
    podman machine stop                  # what you can use to stop it

Here are the commands you can use to do an initial test of chapel ahead of time
if you would like:

    podman pull docker.io/chapel/chapel     # takes about 3 minutes
    mkdir ChapelSandbox             # optional: create a directory for storing chapel files
    cd ChapelSandbox
    echo 'writeln("Hello, world!");' > hello.chpl
    podman run --rm -v "$PWD":/myapp -w /myapp chapel/chapel chpl hello.chpl
    podman run --rm -v "$PWD":/myapp -w /myapp chapel/chapel ./hello

The '-v "$PWD":/myapp -w /myapp' options to podman (and docker) will map your current
directory ($PWD) to the directory /myapp in the container and then set /myapp to the
working directory in the container.  Therefore, these one off commands are running
the chpl compiler in the container on the files in your current subdirectory on your
laptop.  The executable files are also put into your current directory.

## Running multi-locale/node runs

On your laptop, you need to use docker for the container that emulates 
multinode executions. 
The current docker container doesn't work with podman just yet.  Here are the instructions:

    docker pull docker.io/chapel/chapel-gasnet     # takes about 5 minutes
    echo 'writeln("Hello, world!");' > hello.chpl
    docker run --rm -v "$PWD":/myapp -w /myapp chapel/chapel-gasnet chpl hello.chpl
    docker run --rm -v "$PWD":/myapp -w /myapp chapel/chapel-gasnet ./hello -nl 2

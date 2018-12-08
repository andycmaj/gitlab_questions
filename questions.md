# Gitlab assignment for Andrew Cunningham (cloud native engineer position)

## What is the difference between pod and deployment in Kubernetes?

Kubernetes resources are designed as building blocks and often, resources will use other resources as blocks to build a more complex and powerful component. For example, a `pod` is a way to tell kubernetes how to run a `container`. In the same way, a `deployment` is a specification that tells kubernetes how to provison and manage a `pod` or group of `pods`.

To get more specific, a `pod` is a specification for running a docker image as a `container`. As such, a `pod` spec contains generic docker-runtime parameters, such as `image`, `ports`, environment variables, volume mounts, etc., as well as kubernetes-specific parameters, such as `probe`s, `imagePullSecrets`, etc.

A `deployment` creates and manages a set of `pod`s. I say a **set** of `pods` because a `deployment` allows you to specify a number of `replicas` that should be maintained for the `pod` you define in the `deployment`'s `sepc`. Under the hood, kubernetes will create a `replicaset` to ensure that the desired number of `replicas` are created and maintained at all times on your available `node`s.

You would normally use a `deployment` as the unit of application deployment, because it allows for operations like rolling updates in a way that takes into account kubernetes concepts like `node`s, `resources`, `eviction`, `services`, etc.

## A user on a RHEL based machine runs `rpm -i packagename.rpm`. Describe what happens during the lifecycle of this command.

as i understand, RPM is pretty similar to most package managers in how it installs new packages. The interesting parts, to me, are the hooks.

* pre-install hook

* Parse manifest and look for dependencies. Recursively install all packages in the dependency tree in a depth-first fashion (in effect, recursively running `rpm -i dep.rpm` on each one).

* Copy all packaged files to the desired destination. I believe you can configure output path and desired permission on the installed files.

* post-install hook

* if upgrading (previous version already exists), clean up old version's files

## In your view, describe 1 challenge and 1 advantage of both monolithic and microservice architectures.

### Monolith

(I took "monolith" here to mean a single repository, shared between all developers, that contains all of the components of your system)

#### Challenge

custom tooling needed to ensure builds and tests happen quickly and efficiently (usually incremental/comprehend git diffs to select which components build) and that you can deploy multiple components from a single repository

#### Advantage

reduced development overhead in comprehension, testing, making changes. Testing, for example is much easier when all components can be run locally as a unit and the effects of changes made to one are of the system are immediately evident in other dependent areas

### Microservices

#### Challenge

debuggability and performance can both be difficult without forethought, but a much larger and more difficult problem is matching your architecture to your org structure in a way that de-couples teams and services from each other (or vice-versa if you're in a position to make org structures)

#### Advantage

Agility. Safer, easier, and faster to test and deploy changes to a small service with well understood contracts and boundaries. Also easier to debug given good monitoring

## Can you write a small Ruby based script/app that will get HTTP response times over 5 minutes from your location to https://gitlab.com?

see `healthcheck.rb`.

## Additional questions

### QQ1: Do you have remote working experience?

Not full time, however i did work remotely a few days a week at my previous job, and i have experience managing and working with remote co-workers in india, ukraine, and other timezones in the US.

### QQ2: Are there any other languages you have significant experience in?

yes. C#, Javascript are my 2 best languages. Also very interested in Scala, Rust, and Go.

### QQ3: Can you describe your Chef and packaging experience?

litte experience in Chef. Used it a while back (before i learned docker) to provision and configure a Splunk installation. This is a fairly complex application, but it has been a while.

As far as other packaging, i am very familiar with Helm, Docker, NuGet/NPM, and other application and library packaging systems.

### QQ4: Do you have an open source project that you own or contributed to that you feel particularly proud about?

I'm currently working on a set of application block libraries for C#/aspnetcore and an application for discovering new musicians and albums that i'm excited to develop further.

https://github.com/andycmaj/SerilogEventLogger

https://github.com/andycmaj/musigraph (can play with it at https://musigraph.app/)

I'm also quite proud of (from what i have found) building the first/only Splunk-on-kubernetes deployment: https://github.com/andycmaj/kubernetes-splunk

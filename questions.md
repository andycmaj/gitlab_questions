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
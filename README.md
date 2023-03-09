# Inception

This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.

# Table of content:

This is a complete guide of inception project where we are going to explain all the needed concepts (Docker, containers, VM, the command lines...etc)

- [docker engine](#docker-engine)

## Docker Engine

### What is docker?

- Docker is an open-source platform that allows developers to create, deploy, and run applications in containers. Containers are a lightweight and portable way to package and distribute software, along with all it's dependencies, in a self-contained environment.
- Docker enables developers to build applications that can run on any platform that support Docker, making it easier to develop an deploy applications across different environments. Docker also provides tools for managing and orchestrating containers at scale, allowing developers to automate many aspects of the software development and deploment process.
- Docker also makes it easy to share and distribute applications, as container can be easily packaged and deployed to any Docker-enabled host. This makes it popular choice for deploying microservices architectures and building cloud-native applications.

### What are containers?
A container is a lightweight, standalone executable package that includes all the necessary components to run an application, such as code, libraries, system tools and settings. containers are designed to be portable, meaning that they can be run on any machine that has a container runtime installed, regardless of the underlying operating system or infrastructure.

### What is containerization?
- Containerization is the process of creating and managing containers. It involves packaging an application and it's dependencies into a container image, which can be easily distributed and deployed. Containerization isolates an application and it's dependencies from the host system, providing a consistent and reproducible environment that can be easily moved between different machines or cloud platforms.
- Containerization provides several benefits over traditional virtualization technologies such as faster startup times, lower resource consumption, and greater scalability. Because containers are isolated from the host system, they can also provide increased security and reliabilitym as any changes made to the container do not affect the underlying host system.
- Docker is one of the most popular containerization platforms, and it's the one we will use in this project, but there are also other containerization technologies available, such as Kubernetes, LXC, and OpenVZ.

## What problems that Docker solves and why we use it?

### Porblem 1: Application Dependencies

- One of the biggest challenges developers face when building applications is managing application dependencies. Each application has a specific of dependencies that must be installed and configured to work properly. These dependencies can include libraries, framerowks, runtime, and other software components.
- In the past, developers had to manually install and configure these dependencies on every machine that the application would run on. This process was time-consuming, error-prone, and often resulted in different versions of the dependencies being installed on different machines. This created problems with compatibility and stability, which made it difficult to ensure that the application would work consistently across different environments.
- Docker solves this problem by allowing developers to package the application and it's dependencies into a single container. This container can then be deployed to any machine with Docker installed, and the application will run exactly the same way on every machine. This ensures that the application's dependencies are always consistent and up-to-date, which reduces the risk of compatibility issues and improves overall stability.

### Problem 2: DevOps Workflow

- Another problem that Docker solves is the DevOps workflow. In traditional development workflows, developers write code on their local machines, test it, and then deploy it to production servers. This process can be time-consuming, error-prone, and difficult to manage, especially when dealing with multiple applications and environments.

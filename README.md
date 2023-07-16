# Inception

This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.

# Table of content:

This is a complete guide of inception project where we are going to explain all the needed concepts (Docker, containers, VM, the command lines...etc)

- [docker engine](#docker-engine)
- [PID 1 && the dumb init solution](#pid-1-&&-the-dumb-init-solution)
- [Docker Volumes](#docker-volumes)

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

Docker solved this problem by enabling developers to build, test, and deploy their applications in a consistent and repeatable manner. With Docker, developers can define the environment that their application will run in, including the operating system, language, and other dependencies. This allows developers to create a standardized environment that can be used across all stages of the development process, from development to production.
- By using Docker, developers can also streamline the deployment process by using containers to package and deploy their applications. Containers are lightweight and portable, which makes them easy to move between different environments and servers. This allows developers to quickly and easily deploy their applications to production servers, reducing the time and effort required to manage the DevOps workflow.

### Problem 3: Resource Management

- Another challenge that developers face is resource management. Applications often require different amounts of CPU, memory, and storage resources, and these requirements can change over time. Manually managing these resources can be difficult and time-consuming, especially in large-scale production environments.

- Docker solves this problem by providing a lightweight and efficient virtualization layer that isolates applications from each other and the underlying hardware. Each Docker container runs in its own isolated environment, with its own set of resources, including CPU, memory, and storage. This allows multiple applications to run on the same server without interfering with each other, and it ensures that each application has the resources it needs to operate smoothly.

- Docker also makes it easy to scale applications up or down as needed. Developers can use Docker Swarm or Kubernetes to manage large clusters of Docker hosts, automatically scaling containers up or down based on resource usage.

### Problem 4: Portability

- Finally, portability is a major concern for many developers. Applications need to be able to run on different operating systems and hardware architectures, and they need to be able to move between different environments, such as development, testing, and production.

- Docker solves this problem by providing a portable runtime environment. Docker containers can run on any operating system that supports Docker, including Linux, Windows, and macOS. This allows developers to build and test their applications on their local machines, and then deploy them to any server or cloud platform that supports Docker.

- Docker also makes it easy to move applications between different environments. Developers can use Docker images to package their applications and all their dependencies into a single container, which can then be deployed to any Docker-enabled server or cloud platform.

### Virtualization vs containerization

### What is a Docker image?
- A Docker image is a self-contained package that includes everything needed to run an application. It is essentially a snapshot of a container, containing all the necessary files, configurations, and dependencies needed to run the application.
- Docker images are designed to be portable and can be run on any machine that supports Docker, regardless of the underlying operating system or hardware architecture. This makes Docker images an ideal way to package and distribute applications, as they can run consistently in any environment.
  > **Note**
  > Docker images are created from a Dockerfile, but what is a dockerfile again??

### Dockerfile:
- Dockerfile is a text file that contains a set of instructions for building the image, The Dockerfile specifies the base image to use, the software components to install, and the configuration settings to apply.
- Once the Dockerfile is written, it can be used to build the Docker image. The Docker build command reads the Dockerfile and creates a new image based on its instructions. The resulting image can then be stored in a container registry, such as Docker Hub or a private registry, or it can be distributed to other developers to run on their local machines or deploy to other servers.

### What is a registry?
- In Docker, a registry is a storage and distribution system for Docker images, it is a server-side application that stores and manages Docker images, which can be thought of as a packaged and portable version of an application or service.
- Docker registries allows users to share and distribute Docker images, making it easier to deploy applications on different systems and environments. Docker registries can be public, where anyone can access and download images, or private, where access is restricted to authorized users.

### Docker compose

- Docker compose is a tool that allows users to define and run multi-container Docker applications. It is a command-line tool that uses a YAML file to configure the services, networks and volumes required by an application.
- With Docker compose, users can define a set of services that make up an application, specify how those services should be configured, and launch and manage them as a single unit. For example, a typical web application may require a web server, a database, and a catching service. With Docker compose, users can define each of these services in a YAML file, along with their required configuration, and launch them all together with a single command.
- Docker Compose simplifies the process of deploying complex applications by allowing users to manage multiple containers as a single unit. It also provides a way to manage environment variables, volumes, and networks, making it easier to costomize and configure applications to different environments.


## PID 1 && the dumb-init solution

### Zombie process:
- In an operating system, when a process (a running program) finishes it's execution, it doesn't immediately disappear from the system. Instead, it becomes a "zombie process".
- A zombie process is a term used to describe a process that has completed it's execution but still has an entry in the process table. It's essentially a process that is dead but hasn't been completely removed from the system.
- In summary, a zombie process is a completed process that still has an entry in the process table. It occurs when the parent process fails to handle the termination of it's child process properly. While zombie processes themselves are not harmful, an excessive accumulation of zombie processes can lead to issues, such as resource exhaustion. Therefore, it's crucial for parent processes to handle the termination signals and clean up zombie processes to ensure the efficient functioning of the system.

### PID 1 && The dumb-init solution
- When running a Docker container, the first process inside the container is assigned the PID 1. This process is responsible for starting and stopping other processes within the container, and it is crucial for the proper functioning of the container.
- One issue that can occur with PID 1 in Docker is known as the "PID 1 zombie reaping problem". This occurs when a zombie process is not properly reaped by PID 1. This can cause problems with resource management and lead to other issues.
- To address this problem, the dumb-init solution can be used. Dumb-init is a simple process supervisor that can be used as the init process in a container. It ensures that all processes are properly reaped and that signals are correctly propagated to child processes.
- To use dumb-init in your Docker container, you can add the following line to your Dockerfile:
```
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
```
This will ensure that dumb-init is used as the PID 1 process in the container, which will help prevent the PID 1 zombie reaping problem and ensure that your container runs smoothly.

## Docker Volumes
- In Docker, a volume is a persistent storage location that is used to store data from a container. Volumes are used to persist data from a container even after the container is deleted, and they can be shared between container.
- `bind mounts` and `named volumes` are mechanisms for persisting data and sharing it between containers and the host machine. However, they differ in their implementation and use cases. Let's explore each other:

### Bind Mounts:
- A bind mount is a direct reference to a directory on the host machine. It allows you to mount a specific directory or file from the host into a container.
- With bind mounts, the file or directory is shared between the host and the container, and any changes made in either the host or the container are immediately reflected in both.
- Bind mounts provide flexibility and allow you to use th host's file system directly within the countainer. They are typically specified using absolute paths on the host machine.
- Bind mounts can be useful during development or debugging processes when you want to quickly modify or examine files within a container.

### Named volumes:
- A named volume is a Docker-managed volume that provides an abstraction layer on top of the host's file system. It is a directory within the Docker host's file system that is managed by Docker itself.
- Named volumes are created and managed by Docker, ensuring their availability and durability even if the containers are removed or recreated.
- When you create a named volume, Docker handles the underlying storage and manages the volume's lifecyle, including backups and restores.
- Unlike bind mounts, named volumes are independent of the host's file system, which means they can be more portable and can be used across different hosts and environments.
- Named volumes are often used in production scenarios where data persistence and sharing between containers are crucial.

### When to use bind mounts/Named Volumes:
#### We use bind mounts when
  - You want to directly acess files or directories on the host machine.
  - You need immediate changes made in the host or container to reflect in both.
  - You are working in a development or debugging environment.
#### We use named volumes when
  * You require data persistence that is managed by Docker itself.
  * You need data to be available and independent of the container lifecyle.
  * You want to share data between multiple containers.
  * You are working in a production environment.

> Now you might be wondering why we need persisting of data between the container and the host machine?
- Persisting data between the container and the host machine can be necessary for several reasons:

  * Data Backup and Recovery: By persisting data on the host machine, you ensure that important data is not lost if the container is removed, upgraded, or experciences any issues. Storing data on the host machine allows you to create backups and easily recover the data if needed.
  * Data Sharing and collaboration: Persisting data on the host machine enables sharing and collaboration between containers and other applications running on the host.
  * Data Persistence Across Container lifecycles: Containers are designed to be ephemeral, meaning they can be created, destroyed, and recreated as needed. However, some data needs to persist across container lifecycles, such as configuration files, databases, or uploaded user files. By persisting this data on the host machine, you ensure it's availability and consistency even when containers are terminated or restarted.
  * Develop,emt and Debugging: During the development and debugging phases of an application, it is often useful to have quick and direct access to files and directories from the host machine within the container. Bind mounts allow you to make changes to code, configurations, or other resources on the host, and instantly see the effects within the container without the need for rebuilding or restarting the container.
 
  Overall, persisting data between the container and the host machine offers flexibility, data integrity, and compatibility with existing systems. It ensures that critical data is accessible, durable, and can be shared among different components or processes running on the host machine.

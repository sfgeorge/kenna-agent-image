## How to build on CentOS 8

1. Git-clone this repository  
   `git@github.com:sfgeorge/kenna-agent-image.git`
2. Save the [kenna-agent rpm installation package](https://software.cisco.com/download/home/286329714/type/286329700/) to the `centos8/` directory,
   and rename the rpm package to `kenna-agent.rpm`.
3. `cd centos8/` if you are not already in the centos8/ directory.
4. Build this image  
   `docker build -t kenna-agent:latest .`
5. Launch the container, while specifying your [Kenna API Key](https://apidocs.kennasecurity.com/reference/authentication) as an Environment variable:
```
   export KENNA_API_KEY=XXXX-XXXX
   docker run --name kenna-agent --env KENNA_API_KEY --init --rm -it kenna-agent:latest
```
6. If the output from the previous step indicates a successful launch, you can stop it and run it again in a more stable way.  For example,

    **Detached mode (`-d`)**

   `docker run --name kenna-agent --env KENNA_API_KEY --init --rm -d kenna-agent:latest`

   **Restart the container if it exits up to 5 times**

   `docker run --name kenna-agent --env KENNA_API_KEY --init -d --restart on-failure:5 kenna-agent:latest`

## Troubleshooting / FAQ

1. What is kenna-agent?

   kenna-agent allows your organization to send encrypted security vulnerability date to the Kenna Security platform.  For more information, visit
   https://help.kennasecurity.com/hc/en-us/articles/360029047771-Setting-Up-the-Kenna-Agent

2. I've edited centos8/kenna-agent.toml.template but don't see the changes reflected in the container.

   Re-run the build with layer caching disabled...

   `docker build --no-cache -t kenna-agent:latest .`

3. I can't kill the container with Ctrl-C

   `docker kill kenna-agent`

## Container Inspection

To launch the container without automatically running kenna-agent, such as for troubleshooting purposes, run the following...

    docker build -t kenna-agent:latest .
    docker run --name kenna-agent --env KENNA_API_KEY --init --rm -it kenna-agent:latest /bin/bash
    kenna-agent check

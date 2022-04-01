## How to build on CentOS 8

1. Git-clone this repository
   `git@github.com:sfgeorge/kenna-agent-image.git`
2. Save the [kenna-agent rpm installation package](https://software.cisco.com/download/home/286329714/type/286329700/) to the `centos8/` directory,
   and rename the rpm package to `kenna-agent.rpm`.
3. `cd centos8/` if you are not already in the centos8/ directory.
4. Build the image, while specifying your [Kenna API Key](https://apidocs.kennasecurity.com/reference/authentication) as a Build Argument:
   `export KENNA_API_KEY=XXXX-XXXX`
   `docker build --build-arg KENNA_API_KEY -t kenna-agent:latest .`
5. Launch the container:
   `docker run --name kenna-agent --privileged --rm -it kenna-agent:latest`
6. If the output from the previous step indicates a successful launch, run it again in detached mode (`-d`)
   `docker run --name kenna-agent --privileged --rm -d kenna-agent:latest`

## Troubleshooting / FAQ

1. I've edited centos8/kenna-agent.toml.template but don't see the changes reflected in the container.

   Re-run the build with layer caching disabled...

   `docker build --build-arg KENNA_API_KEY --no-cache -t kenna-agent:latest .`

2. I can't kill the container with Ctrl-C

   `docker kill kenna-agent`

## Container Inspection

To launch the container without automatically running kenna-agent, such as for troubleshooting purposes, run the following...

    docker build --build-arg KENNA_API_KEY -t kenna-agent:latest .
    docker run --name kenna-agent --privileged --rm -it kenna-agent:latest /bin/bash

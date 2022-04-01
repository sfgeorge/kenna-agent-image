## How to build on CentOS 8

1. Git-clone this repository
   `git@github.com:sfgeorge/kenna-agent-image.git`
2. Save the [kenna-agent rpm installation package](https://software.cisco.com/download/home/286329714/type/286329700/) to the `centos8/` directory,
   and rename the rpm package to `kenna-agent.rpm`.
3. `cd centos8/` if you are not already in the centos8/ directory.
4. Build this image
   `docker build --build-arg KENNA_API_KEY=XXXX-XXXX -t kenna-agent:latest .`
5. Launch the container:
   `docker run -it --rm kenna-agent:latest /bin/bash`

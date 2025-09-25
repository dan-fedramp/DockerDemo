# Setup colima as a docker replacement on GSA issued macbook

## TLDR: 
`git clone https://github.com/dan-fedramp/DockerDemo.git` \
`cd DockerDemo` \
`./install_colima.sh`

For a fully free, “just works” drop-in replacement that keeps your existing docker commands and compose syntax, use Colima (with the Docker runtime).

Why Colima
- Free and open-source
- Uses the standard docker CLI and docker compose
- Fast and reliable on Intel and Apple Silicon
- Minimal setup; no vendor lock-in

## Setup (Homebrew)
- Install: 


    `brew install colima docker docker-compose docker-buildx`

- Start Colima with Docker runtime:


    `colima start --runtime docker`

## Getting it to work with zscaler

1) Export Zscaler certs from macOS


  `security find-certificate -a -c "Zscaler" -p > ~/zscaler.pem`

2) Ensure CA tools are present and install the cert: \
HINT: You can find your mac username by running `whoami` 

    
    `colima ssh -- sudo apt-get update -y && sudo apt-get install -y ca-certificates` \
    `colima ssh -- sudo install -m 0644 /Users/<your-mac-username>/zscaler.pem /usr/local/share/ca-certificates/zscaler.crt` \
     `colima ssh -- sudo update-ca-certificates`


3) Restart Docker inside the VM


    `colima ssh 'sudo systemctl restart docker'`

4) Test


    `docker run hello-world`

### Notes
- Zscaler sometimes installs multiple roots/intermediates; include them all in zscaler.pem.
- This change persists across VM restarts. If you delete the Colima VM (colima delete), reapply the steps.
- Avoid “insecure registries” or disabling TLS verification; trusting the Zscaler CA is the correct fix.


### Daily usage
- Use docker and docker compose exactly as before:
  - docker compose up -d
  - docker ps
  - docker images
- Stop/start VM:
  - colima stop
  - colima start
- Remove the VM (if you ever want a clean slate):
  - colima delete

### Apple Silicon tips (M1/M2/M3)
- Prefer multi-arch images for best performance.
- If you must run x86/amd64 images:
  - colima start --runtime docker --arch x86_64

### Optional
- Kubernetes: 

    `colima start --runtime docker --kubernetes`

- Customize resources (example):

    `colima start --runtime docker --cpu 4 --memory 8 --disk 60`



# Docker Script Isolation Demo

## Purpose
This demo shows how to safely execute a potentially harmful Python script inside a Docker container with multiple layers of protection.

## Safety Mechanisms
1. **Container Isolation**: Docker provides process and filesystem isolation
2. **Non-Root User**: Script runs as a non-privileged user
3. **Resource Limits**: 
   - Memory limited via `ulimit`
   - Execution time limited via `timeout`
4. **Controlled Environment**: Predictable, sandboxed execution

## Prerequisites
- Docker installed
- Basic understanding of Docker commands

## Usage
1. Build the Docker image: `docker build -t script-isolation-demo .`
2. Run the container: `docker run --rm script-isolation-demo`


## What to Expect
The demo script will:
- Attempt potentially risky operations
- Demonstrate how these operations are safely contained
- Show the power of containerization for script execution

## Key Security Considerations
1. The script is intentionally restricted
2. Container provides multiple layers of isolation
3. Non-root user prevents system-wide modifications
4. Resource limits prevent potential DoS attempts

## More complex use cases
### Run multiple scripts from the current directory
`docker run -it --rm -v $(pwd):/workspace -w /workspace python:3.9-slim bash`

- `-it`: Interactive terminal
- `--rm`: Remove container after exit
- `-v $(pwd):/workspace`: Mount current directory to `/workspace` in container
- `-w /workspace`: Set working directory inside container

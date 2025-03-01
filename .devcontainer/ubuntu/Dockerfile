FROM ubuntu:latest

# Create and set the working directory
WORKDIR /workspace

# Copy all project files
COPY . .

# Install default targets
RUN make

# Install Shell
RUN make ubuntu-zsh

# Start shell
CMD ["zsh"]

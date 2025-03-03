FROM ubuntu:latest

ENV USER_NAME=tomy0000000
ENV USER_ID=2000
ENV GROUP_ID=2000

# Install necessary packages
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    make \
    sudo

# Create a group and a user with specific IDs
RUN groupadd -g $GROUP_ID $USER_NAME \
    && useradd -m -u $USER_ID -g $USER_NAME -s /bin/bash $USER_NAME \
    && echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the custom user
USER $USER_NAME

# Set the working directory
WORKDIR /home/$USER_NAME/.dotfiles

# Copy all dotfiles
COPY --chown=$USER_NAME:$USER_NAME . .

# Install default targets
RUN make all

# Install Shell
RUN make ubuntu-zsh

# Start shell
CMD ["zsh"]

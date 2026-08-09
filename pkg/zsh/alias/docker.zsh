#!/bin/zsh

# Playground
alias 'dk-python'="docker run --name some-python --volume \${PWD}:/host -it --rm python:latest python"
alias 'dk-arch'="docker run --name some-archlinux --volume \${PWD}:/host -it --rm archlinux:latest bash"
alias 'dk-alpine'="docker run --name some-alpine --volume \${PWD}:/host -it --rm alpine:latest sh"
alias 'dk-cent'="docker run --name some-centos --volume \${PWD}:/host -it --rm centos:latest bash"
alias 'dk-debian'="docker run --name some-debian --volume \${PWD}:/host -it --rm debian:latest bash"
alias 'dk-fedora'="docker run --name some-fedora --volume \${PWD}:/host -it --rm fedora:latest bash"
alias 'dk-ubuntu'="docker run --name some-ubuntu --volume \${PWD}:/host -it --rm ubuntu:latest bash"

# Main
alias 'dk-i'="docker image"
alias 'dk-v'="docker volume"

# Compose
alias 'dk-c'="docker-compose"
alias 'dk-c-b'="docker-compose build"
alias 'dk-c-l'="docker-compose logs --follow"
alias 'dk-c-r'="docker-compose run"
alias 'dk-c-up'="docker-compose up"
alias 'dk-c-up-b'="docker-compose up --build"
alias 'dk-c-up-d'="docker-compose up --detach"
alias 'dk-c-up-f'="docker-compose up --build --detach"

# Handy functions
dk-i-rm-all() {
	docker images --filter="reference=${1}" --format='{{.Repository}}:{{.Tag}}' | xargs docker rmi
}
dk-v-ls-items() {
	docker run -it --rm -v "${1}:/volume" busybox ls -lh /volume
}

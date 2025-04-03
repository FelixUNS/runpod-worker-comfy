variable "DOCKERHUB_REPO" {
  default = "fdeman"
}

variable "DOCKERHUB_IMG" {
  default = "comfy-dockers"
}

variable "RELEASE_VERSION" {
  default = "test"
}

variable "HUGGINGFACE_ACCESS_TOKEN" {
  default = ""
}

group "default" {
  targets = ["final"]
}

target "base" {
  context = "."
  dockerfile = "Dockerfile"
  target = "base"
  platforms = ["linux/amd64"]
}

target "snapshot" {
  context = "."
  dockerfile = "Dockerfile"
  target = "snapshot"
  inherits = ["base"]
}

target "final" {
  context = "."
  dockerfile = "Dockerfile"
  target = "final"
  inherits = ["snapshot"]
  tags = ["${DOCKERHUB_REPO}/${DOCKERHUB_IMG}:${RELEASE_VERSION}"]
}


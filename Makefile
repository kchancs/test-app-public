# Makefile for sample app deployed on sudo k3s
# Define variables
PROJECT_NAME := webapp
IMAGE_NAME := webapp
IMAGE_VERSION := 0.1
IMAGE_REF := $(IMAGE_NAME):$(IMAGE_VERSION)
IMAGE_TAR := $(IMAGE_NAME)-$(IMAGE_VERSION).tar

.PHONY: build push clean deploy-dev deploy-prod

# Target to build the Docker image
build:
	@echo "--- Building Docker image $(IMAGE_REF) ---"
	sudo docker build -t $(IMAGE_REF) .

# Target to push the Docker image to a remote registry
push:
	@echo "--- Pushing Docker image $(IMAGE_REF) to sudo k3s registry ---"
	sudo docker save $(IMAGE_REF) -o $(IMAGE_TAR)
	sudo k3s ctr images import $(IMAGE_TAR)

# Target to deploy the service to a cluster
deploy-dev:
	@echo "--- Deploying $(IMAGE_REF) to sudo k3s DEV ---"
	sed -i "s/image: $(IMAGE_NAME):clean/image: $(IMAGE_REF)/g" ../k8s/deployment.yaml
	sudo k3s kubectl apply -f ../k8s/ -n dev

deploy-prod:
	@echo "--- Deploying $(IMAGE_REF) to sudo k3s PROD ---"
	sed -i "s/image: $(IMAGE_NAME):clean/image: $(IMAGE_REF)/g" ../k8s/deployment.yaml
	sudo k3s kubectl apply -f ../k8s/ -n prod

# Target to revert changes made to k8s manifests
clean:
	sed -i "s/image: $(IMAGE_REF)/image: $(IMAGE_NAME):clean/g" ../k8s/deployment.yaml
PROG = racknet
IMAGE = rgbkrk/$(PROG)

default: image $(PROG)

image: $(PROG) Dockerfile
	docker build -t $(IMAGE) .

upload: image
	docker push $(IMAGE)

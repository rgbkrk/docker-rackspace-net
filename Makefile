PROG = racknet
IMAGE = rgbkrk/$(PROG)

default: image $(PROG)

$(PROG): $(PROG).go
	CGO_ENABLED=0 GOOS=linux go build -o $(PROG) -a -tags netgo -ldflags '-w' . 

image: $(PROG) Dockerfile
	docker build -t $(IMAGE) .

upload: image
	docker push $(IMAGE)

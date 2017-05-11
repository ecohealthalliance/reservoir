all: latest devel 3.4.0

latest:
	docker build -t reservoir .
devel: .PHONY
	docker build -t reservoir:devel devel
3.4.0: .PHONY
		docker build -t reservoir:3.4.0 3.4.0

.PHONY:
	echo "building image..."

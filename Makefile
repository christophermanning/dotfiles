Dockerfile.build: Dockerfile ./*/install.sh
	docker build -t dotfiles .
	touch $@

clean:
	rm Dockerfile.build

# login as ubuntu to ensure setup works as non-root user
# setting RCRC is only needed for the first run before ~/.rcrc is saved
test: Dockerfile.build
	@docker run --user ubuntu --rm \
		--volume="$(PWD):/home/ubuntu/dotfiles" \
		-it dotfiles \
		/bin/bash -c ' \
		RCRC=~/dotfiles/rcm/rcrc rcup -v; \
		ls -lah ~; \
		/bin/bash; \
		'

SHA := $(shell shasum install.sh | cut -f1 -d' ')

all: shasum

shasum:
	@- sed -i '' -E "s/([a-z0-9]{40})/${SHA}/" README.md

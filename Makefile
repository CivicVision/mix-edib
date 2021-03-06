all:
	@echo Use publish, archive or gitio

publish:
	@mix hex.publish

push:
	@git push && git push --tags

archive:
	@mix compile && mix archive.build

gitio:
	@[ -n "$(VERSION)" ] && \
	curl -i https://git.io \
		-F "url=https://github.com/edib-tool/mix-edib/releases/download/v$(VERSION)/edib-$(VERSION).ez" \
		-F "code=edib-$(VERSION).ez" || \
	echo "No version set. (VERSION=x.y.z)"

### README / DOCS

readme:
	@mix readme

docs: readme
	MIX_ENV=docs mix docs

doc: docs

### TEST

spec:
	@MIX_ENV=test mix espec --order --cover
.PHONY: spec

test: spec
.PHONY: test

### LINT

lint: lint-credo
.PHONY: lint

lint-credo:
	-MIX_ENV=lint mix credo --strict
.PHONY: lint-credo

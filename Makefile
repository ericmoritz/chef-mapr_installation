.PHONY: test integration-test

test:
	rubocop
	chef exec rspec

test-integration:
	kitchen destroy
	kitchen converge
	kitchen verify

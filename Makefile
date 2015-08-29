.PHONY: test integration-test rubocop rspec

test: rubocop rspec

rubocop:
	rubocop

rspec:
	chef exec rspec

test-integration:
	kitchen destroy
	kitchen converge
	kitchen verify

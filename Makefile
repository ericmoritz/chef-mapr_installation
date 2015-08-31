.PHONY: test integration-test rubocop rspec

test: foodcritic rubocop rspec

foodcritic:
	foodcritic .

rubocop:
	rubocop

rspec:
	chef exec rspec

test-integration:
	kitchen destroy
	kitchen converge
	kitchen verify

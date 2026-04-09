.PHONY: test test-file format help

test:
	nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests/unit/ {minimal_init = 'tests/minimal_init.lua'}"

test-file:
	nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedFile $(FILE)"

format:
	stylua .

help:
	@echo "Available targets:"
	@echo "  test        - Run all tests"
	@echo "  test-file   - Run specific test file (usage: make test-file FILE=tests/unit/pr_number_spec.lua)"
	@echo "  format      - Format code with stylua"
	@echo "  help        - Show this help"

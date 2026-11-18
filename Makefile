# Find all .typ files in content/ that don't start with an underscore in their path
TYP_FILES := $(shell find content -name '*.typ' -not -path '*/_*')

# Map each source file to its output, keeping clean URLs:
#   content/index.typ          -> _site/index.html
#   content/foo/index.typ      -> _site/foo/index.html
#   content/foo.typ            -> _site/foo/index.html
INDEX_FILES := $(filter %index.typ,$(TYP_FILES))
PAGE_FILES  := $(filter-out %index.typ,$(TYP_FILES))
HTML_FILES  := $(patsubst content/%.typ,_site/%.html,$(INDEX_FILES)) \
               $(patsubst content/%.typ,_site/%/index.html,$(PAGE_FILES))

# Lean sources for code snippets (see `snippet` in config.typ)
LEAN_FILES := $(shell find code/Lectures -name '*.lean')

# Every page depends on the config, all content (parents are imported)
# and the Lean sources its snippets are read from
DEPS := config.typ $(TYP_FILES) $(LEAN_FILES)

# The main target 'html' depends on all generated HTML files and assets
html: $(HTML_FILES) assets

# content/foo.typ -> _site/foo/index.html
_site/%/index.html: content/%.typ $(DEPS)
	@mkdir -p $(@D)
	typst compile --root . --features html --format html $< $@

# content/foo/index.typ -> _site/foo/index.html
_site/%.html: content/%.typ $(DEPS)
	@mkdir -p $(@D)
	typst compile --root . --features html --format html $< $@

assets:
	@mkdir -p _site/assets
	@cp -r assets/* _site/assets/

# A clean rule to remove generated files
clean:
	rm -rf _site/*

# Check that all lecture code compiles (tests, expected errors, hidden answers)
check:
	cd code && lake build

.PHONY: html clean assets check server

server:
	cd _site && python3 -m http.server 8000
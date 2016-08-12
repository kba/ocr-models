PATH := ./node_modules/.bin:$(PATH)

AJV = ajv validate --all-errors

METADATA_SCHEMA = schema/description.schema.json

.PHONY: schema
schema: $(METADATA_SCHEMA)

schema/%.json: schema/%.yml
	traf "$<" "$@"

validate: schema
	@echo ">>>"
	@echo ">>> Validating metadata"
	@echo ">>>"
	@find . -name 'DESCRIPTION' -exec \
		$(AJV) -s "$(METADATA_SCHEMA)" -d "{}" \;

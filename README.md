# ocr-models
A registry of models for OCR engines

## Deployment

Unless you intend to deploy your own version of the model registry,
you won't need to actually clone this repo.

### Initialize the submodules

Unless you did a recursive clone (`git clone --recursive
https://github.com/kba/ocr-models`):

```
git submodule init
git submodule update
```

### Validate the metadata

```
make validate
```

This will apply the [JSON schema for the
metadata](./schema/description.schema.yml) to the `DESCRIPTION`
JSON file of all models.

### Build the ZIP archives

```
make zip
```

### Build the database

```
make db
```

### Start the server

```
npm start
```

# ocr-models
A registry of models for OCR engines

## Setup

Unless you intend to develop your own version of the model registry,
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

## Development server

Install node modules:

```
npm install
```

To get a development server up, run `npm start-dev`.

Server will be available on [http://localhost:3002](http://localhost:3002).

## Production server

### Run the docker image

```
docker run --rm -it -p 3002:3002 kbai/ocr-models
```

### Proxy through Apache

Enable the `proxy_http` apache module. In Debian:

```
a2enmod http_proxy
```

Add a location directive to an enabled site, such as `/etc/apache2/sites-enabled/000-default.conf`:

```apache2
<Location /ocr-models/>
    ProxyPass http://localhost:3002/ retry=0
    ProxyPassReverse http://localhost:3002/
</Location>

```

Restart apache

```
service apache2 restart
# or, if using systemd
systemctl restart apache2.service
```


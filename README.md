# Writefreely

[![Pipeline](https://gitlab.com/ankit-containers/writefreely/badges/main/pipeline.svg)](https://gitlab.com/ankit-containers/writefreely/-/pipelines)


WriteFreely is the Golang based open-source version of the amazingly minimalist
and privacy-focused blogging platform, Write.as. It can run in Single-mode for a
single blog or Community mode. WriteFreely also supports federation into the
Fediverse.

The Write.as platform is the primary managed instance of WriteFreely with more
features. Write.as also integrates with image hosting service Snap.as. The
platform uses a subscription-based model and offers a free account as well. The
team also provides managed private instances of WriteFreely.

The WriteFreely project ships a tarball that includes a statically compiled
binary, static web assets (JS, CSS), and templates for the pages. It is possible
to deploy it directly to the public web or behind a reverse proxy. WriteFreely
supports multiple databases, including SQLite3, MySQL, and PostgreSQL.

This repository packages WriteFreely in a Docker image to run it in the
container.

## Usage

WriteFreely uses a single `config.ini` file for its configuration. Check the
[configuration documentation](https://writefreely.org/docs/latest/admin/config)
for all possible configuration fields. Create the file on the local machine. We
will then mount this file as a volume in the container. In case of SQLite3
Database, you need to mount an additional volume to persist the data. Remember
to modify the configurations to match the path to the mounted volume.


```bash
docker run -d \
  --name "writefreely" \
  -v /path/to/config-dir:/config \
  -v /path/to/sqlite-data:/data \  # Optional
  -p 8080:8080 \                   # Change according to the port in configuration
  registry.gitlab.com/ankit-containers/writefreely/writefreely:latest
  /writefreely/writefreely -c /config/config.ini
```

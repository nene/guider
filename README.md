# Guider

JSDuck-compatible guides generator for Sencha docs.

It's still in very early stages of development. You have been warned.

## Install

Grab it from rubygems:

    gem install guider

## Usage

Just point guider at your guides directory:

    guider /path/to/guides

This will by default output the docs to `out/` directory. Use the
`--output` option to specify a different path.

All files inside the guides directory will get copied over to the
output directory.  All Markdown files (`*.md`) will be converted to
HTML files with the same name (excepth the `README.md` which is turned
into `index.html` for backwards compatibility with JSDuck).

To generate guides index page from the `guides.json` file use the
`--index` option:

    guider /path/to/guides --index=/path/to/guides.json

See `--help` for all other command line options.

## License

Guider is free software, licensed under GNU General Public License
version 3.

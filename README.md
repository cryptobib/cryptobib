# CryptoBib Main Repository for Developers

**WARNING**: This is probably not the repository your are interested in. This repository is only for *cryptobib* developers. The repositories containing the public *bib* files are [cryptobib/export](https://github.com/cryptobib/export) and  [cryptobib/export_crossref](https://github.com/cryptobib/export_crossref).

## Getting started

### Requirements

#### General

- MyRepos [mr](https://raw.githubusercontent.com/joeyh/myrepos/master/mr) in your path
- python 2.7 with the following packages (which can be installed using `pip`):
  - pybtex 0.16 (WARNING: not another version, because with use internal structure of pybtex 0.16)
  - unidecode

#### Tests (db_test)

- compile bibtex8:

		cd db_test/bibtex8
		make -f unix.mak linux-gcc

- scons (can be installed via `pip install --egg scons`)
- compile pplatex

		cd db_test/pplatex
		scons

### Checkout the project

Just run in some folder:

    mr bootstrap https://raw.githubusercontent.com/cryptobib/cryptobib/master/mrconfig/mrconfig_https

or

    mr bootstrap https://raw.githubusercontent.com/cryptobib/cryptobib/master/mrconfig/mrconfig_ssh

depending whether you want to access github using *https* or *ssl*.

### Import a new conference

1. go to `db_import`
2. run `python2 import.py confYYYY` with *conf* the conf key and *YYYY* the year
3. correct the bibtex file `confYYYY.bib`
4. go back in `..`
5. update `db/abbrev.bibyml` and run `python2 db_tools/gen_abbrev.py`
6. update `db/crypto_conf_list.bib`
7. add this bibtex file to `db/crypto_db.bib` by running `python2 db_tools/add.py import/confYYYY.bib`
8. update `db/changes.txt`
9. generate all the files: `make`
10. check all was done correctly: `make test`

### Publish

First, do not forget to run `make` (and, even better, `make test`) before any commit.
Do not forget either to update `db/changes.txt` if changes are related to the database content.
Then run

    mr record -m "message... generally the same as in changes.txt"
    mr push

## Organization of the project

The project is composed of multiple repositories:

- `cryptobib`: this repository containing this documentation, the main `Makefile` and the `mrconfig` files (to get all the repositories using `mr`)
- `db`: the database containing all the bibtex entries and the list of all conferences
- `db_import`: tools to import bibtex entries from DBLP, ePrint, ...
- `db_test`: tools to check the database is valid and can successfully be used by bibtex
- `db_tools`: tools to merge bibtex entrie imported by `db_import` tools into the main database, to generate the website database, ...
- `export`: the `bib` files to be used in latex documents, generated from `db`. This repository can be added as a submodule of a latex project for example.
- `export_crossref`: same as above, but using crossref (lighter files)
- `lib`: some internal libraries used by the various tools and the website
- `webapp`: the web2py application corresponding to the website

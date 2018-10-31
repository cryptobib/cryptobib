# CryptoBib Main Repository for Developers

**WARNING**: This is probably not the repository your are interested in. This repository is only for *cryptobib* developers. The repositories containing the public *bib* files are [cryptobib/export](https://github.com/cryptobib/export) and  [cryptobib/export_crossref](https://github.com/cryptobib/export_crossref).

For any **correction** or **issue** with the database content, you can either contact Michel Abdalla and Fabrice Benhamouda (firstname.lastname@ens.fr), or submit a pull request or report an issue for [cryptobib/db](https://github.com/cryptobib/db).

## Getting started

### Requirements

- MyRepos [mr](https://raw.githubusercontent.com/joeyh/myrepos/master/mr) in your path (on MacOS X with HomeBrew: `brew install mr`)
- python 2.7 with the following packages (which can be installed using `pip` - on MacOS X with HomeBrew, `pip` can be installed with `brew install python`):
  - pybtex 0.16-0.20.1 
    WARNING: we use the internal structure of pybtex. 
    CryptoBib has only been tested with pybtex 0.16-0.20.1.
    There might be bugs with other versions but they should be easy to spot
    (like an abnormal exception).
    If you do not want or cannot install an outdated version of pybtex globally, please read the section about virtual_env below
  - unidecode
- on MacOS X, XCode Command Line Tools is required: `xcode-select --install`. We also recommend to use HomeBrew.
  
#### Using virtualenv

If you want to separate the Python installation for CryptoBib from your global installation, you can use virtualenv.

Run (somewhere not necessarily in the cryptobib folder):

    pip install virtualenv
    virtualenv venv
    . venv/bin/activate
    pip install pybtex==0.20.1 unidecode
    
Each time you need to run any CryptoBib script, you need to first activate the virtualenv `. venv/bin/activate`. This will replace the global Python installation by the local one in `venv`. You can go back to the global one using `deactivate`.

### Checkout the project

Just run in some folder:

    mr bootstrap https://raw.githubusercontent.com/cryptobib/cryptobib/master/mrconfig/mrconfig_https

or

    mr bootstrap https://raw.githubusercontent.com/cryptobib/cryptobib/master/mrconfig/mrconfig_ssh

depending whether you want to access github using *https* or *ssl*.

### Set up `make test`

If you want to be able to run `make test` (highly recommended before any push), you first need to read `db_test/README.md`.

### Import a new conference

1. go to `db_import`
2. run `python2 import.py confYYYY` with *conf* the conf key and *YYYY* the year
3. correct the bibtex file `confYYYY.bib`
4. go back in `..`
5. update `db/abbrev.bibyml` and run `python2 db_tools/gen_abbrev.py`
6. update `db/crypto_conf_list.bib`
7. add this bibtex file to `db/crypto_db.bib` by running `python2 db_tools/add.py db_import/confYYYY.bib`
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

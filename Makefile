PYTHON=python2
ABBREV_BIB=db/abbrev0.bib db/abbrev1.bib db/abbrev2.bib db/abbrev3.bib
EXPORT_DIRS=export export_crossref

.PHONY: all test web clean FORCE_MAKE

all: ${ABBREV_BIB} db/crypto.bib db/crypto_crossref.bib db/changes.txt export/crypto.bib export_crossref/crypto_crossref.bib FORCE_MAKE
	for d in ${EXPORT_DIRS}; do cp ${ABBREV_BIB} "$$d"; done
	for d in ${EXPORT_DIRS}; do cp db/changes.txt "$$d"; done


export/crypto.bib: db/crypto.bib
	cp db/crypto.bib export

export_crossref/crypto.bib: db/crypto_crossref.bib
	cp db/crypto_crossref.bib export_crossref

test: all
	cd db_test && $(MAKE)

db/abbrev%.bib: db/abbrev.bibyml db_tools/gen_abbrev.py
	$(PYTHON) db_tools/gen_abbrev.py

db/crypto.bib db/crypto_crossref.bib: db/abbrev0.bib db/crypto_db.bib db/crypto_misc.bib db/crypto_conf_list.bib db_tools/gen.py
	$(PYTHON) db_tools/gen.py

clean: 
	rm -f $(ABBREV_BIB)
	rm -f db/crypto.bib db/crypto_crossref.bib 

web: all
	$(PYTHON) db_tools/update_webapp_db.py

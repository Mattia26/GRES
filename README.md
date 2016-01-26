# GRES (GoodReads Expert System)

GRES is an expert system designed in CLIPS with the aim of helping the user in finding a good book to read. It bases its decisions on the preferences of the user discovered with a series of questions. 

Project for the course of Expert Systems (Ingegneria della Conoscenza e Sistemi Esperti) at the University of Bari "Aldo Moro".

Per avviare il progetto servirà avere a disposizione la libreria libCLIPSJNI, il comando da utilizzare per avviare su sistemi linux  è:

-java -Djava.library.path=. -jar GRES.jar (eseguito all'interno di questa cartella)

Per altri sistemi si rimanda alla documentazione ufficiale clips: http://clipsrules.sourceforge.net/documentation/v630/bpg.pdf

Per avviare il progetto senza l'opzione di login direttamente su console clips bisognerà aprire la console su questa cartella e dare i seguenti comandi:

>(clear)
>(load GRES.clp)
>(run)

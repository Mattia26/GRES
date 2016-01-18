;GRES - GoodReads Expert System
;Mattia Menna Mat. 601515


; MESSAGGIO DI BENVENUTO


(defrule benvenuto
(not (presentazione))
=>
(printout t "'It  is  a long tail, certainly said Alice, looking down" crlf)
(printout t "with wonder at the Mouse's tail; 'but why do you call it" crlf)
(printout t "sad?'  And  she  kept  on  puzzling  about  it while the" crlf)
(printout t "Mouse was speaking, so that her idea  of  the  tale  was" crlf)
(printout t "something like this:- 'Fury said to a" crlf)
(printout t "                  mouse, That" crlf)
(printout t "                    he met in the" crlf)
(printout t "                         house, 'Let" crlf) 
(printout t "                              us both go" crlf)
(printout t "                                to law: I" crlf)
(printout t "                                 will prosec-" crlf)
(printout t "                                  cute you --" crlf)
(printout t "                                Come, I'll" crlf)
(printout t "                             take no de-" crlf)
(printout t "                         nial:  We" crlf)
(printout t "                     must  have" crlf)
(printout t "                 the trial;" crlf)
(printout t "               For really" crlf)
(printout t "             this morn-" crlf)
(printout t "           ing I've" crlf)
(printout t "          nothing" crlf)
(printout t "         to do.'" crlf)
(printout t "          Said the" crlf)
(printout t "           mouse to" crlf)
(printout t "            the cur," crlf)
(printout t "             'Such   a" crlf)
(printout t "               trial, dear" crlf)
(printout t "                   sir, With" crlf)
(printout t "                      no  jury" crlf)
(printout t "                        or judge," crlf)
(printout t "                            would" crlf)
(printout t "                         be wast-" crlf)
(printout t "                      ing our" crlf)
(printout t "                   breath.'" crlf)
(printout t "                 'I'll be" crlf)
(printout t "               judge," crlf)
(printout t "            I'll be" crlf)
(printout t "          jury,'" crlf)
(printout t "         said" crlf)
(printout t "        cun-" crlf)
(printout t "        ning" crlf)
(printout t "          old" crlf)
(printout t "           Fury;" crlf)
(printout t "             'I'll" crlf)
(printout t "              try" crlf)
(printout t "                 the" crlf)
(printout t "                  whole" crlf)
(printout t "                   cause," crlf)
(printout t "                    and" crlf)
(printout t "                  con-" crlf)
(printout t "                demn" crlf)
(printout t "              you to" crlf)
(printout t "           death'" crlf)
(printout t" -------------------------------------------------------"crlf)
(printout t"|                                                       |"crlf)
(printout t"|                                                       |"crlf)
(printout t"|    Benvenuto in GRES(GoodReads Expert System)         |"crlf)
(printout t"|                                                       |"crlf)
(printout t"|                                                       |"crlf)
(printout t" -------------------------------------------------------"crlf)
(printout t crlf)
(printout t "Ti guiderò nella scelta di un buon romanzo da leggere" crlf)
(printout t  crlf)
(printout t  crlf)
(assert (presentazione))
)

;FUNZIONI AUSILIARIE

(deffunction Domanda (?testo $?valori_ammessi)
	(format t ?testo)
	(format t "? ")
	(bind ?risposta (read))
	( if (lexemep ?risposta) ; Se si e' inserita una stringa
	then (bind ?risposta (lowcase ?risposta)) )
	(while (not (member$ ?risposta ?valori_ammessi)) do
	(format t "Valore non valido, riprovare!")
	(bind ?risposta (read))
	( if (lexemep ?risposta)
	then (bind ?risposta (lowcase ?risposta)) )
	)
	?risposta ; Valore restituito dalla funzione Domanda
)

(deffunction DomandaB (?testo)
	(format t ?testo)
	(format t "")
	(bind ?risposta (read))
	(if(lexemep ?risposta) 			; Se si e' inserita una stringa o symbol
		then (bind ?risposta (lowcase ?risposta)))
	
	?risposta ; Valore restituito dalla funzione Domanda2
)

;TEMPLATE CHE DEFINISCE UN LIBRO

(deftemplate libro
	(slot nome
		(type STRING))
	(slot punteggio
		(type FLOAT))
	(slot autore
		(type STRING))
	(slot serie
		(type STRING)
		(default ?DERIVE)))


;REGOLE PER LA CLASSIFICAZIONE DELL'UTENTE

(defrule età
(presentazione)
=>
(bind ?eta (DomandaB "Età del lettore? (Inserire un valore numerico)"))
(if (< ?eta 16)  then (assert (esplicito no)))
(if (< ?eta 12) then (assert (violento no)))
(assert (età))
)


(defrule lettore-accanito
(presentazione)
=>
(printout t "Quante ore dedichi alla lettura settimanalmente?" crlf)
(printout t "1)0" crlf)
(printout t "2)Tra 1 e 10" crlf)
(printout t "3)Più di 10" crlf)
(bind ?accanito (Domanda "" 1 2 3))
(switch ?accanito
	(case 1 then 
		     (assert (lungo no))
		     (assert (autore no)))

	(case 2 then  
		     (assert (lungo indifferente))
		     (assert (autore no)))

	(case 3 then 
		     (assert (autore si)))
))


;REGOLE PER LETTORE ACCANITO

(defrule domanda-autori
(declare (salience 10000))
(autore si)
(età)
(not (esplicito ?))
(not (violento ?))
=>
(printout t "Secondo te, quale di questi autori rappresenta meglio un romanzo che potrebbe piacerti?" crlf)
(printout t "1) J.K. Rowling" crlf)
(printout t "2) J.R.R. Tolkien" crlf)
(printout t "3) Charles Dickens" crlf)
(printout t "4) Sir Arthur Conan Doyle" crlf)
(printout t "5) Isaac Asimov" crlf)
(printout t "6) George Orwell" crlf)
(printout t "7) Ken Follet" crlf)
(printout t "8) Stephen King" crlf)
(printout t "9) Nessuno di questi" crlf)
(bind ?scelta (Domanda " " 1 2 3 4 5 6 7 8 9))
(switch ?scelta
	(case 1 then 
		(assert (imprevedibile si))
		(assert (violento no))
		(assert (leggero si))
		(assert (serie si)))
	(case 2 then
		(assert (lungo si))
		(assert (divertente no))
		(assert (esplicito no))
		(assert (leggero si)))
	(case 3 then
		(assert (lungo si))
		(assert (divertente no))
		(assert (esplicito si))
		(assert (leggero si)))
	(case 4 then
		(assert (divertente si))
		(assert (lungo no))
		(assert (imprevedibile si))
		(assert (leggero si)))
	(case 5 then
		(assert (lungo no))
		(assert (serie si))
		(assert (imprevedibile si))
		(assert (leggero si)))
	(case 6 then
		(assert (lungo no))
		(assert (divertente no))
		(assert (leggero no))
		(assert (serie no)))
	(case 7 then
		(assert (lungo si))
		(assert (esplicito si))
		(assert (violento si))
		(assert (serie si)))
	(case 8 then
		(assert (violento si))
		(assert (esplicito si))
		(assert (leggero si))
		(assert (serie si)))
))

;REGOLE PER DOMANDE GENERALI

(defrule lungo
(autore ?)
(not (lungo ?))
=>
(printout t "Vorresti leggere un libro con molte pagine?" crlf)
(printout t "1)Si" crlf)
(printout t "2)No" crlf)
(printout t "3)Indifferente" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta
	(case 1 then
		(assert (lungo si)))
	(case 2 then
		(assert (lungo no)))
	(case 3 then
		(assert (lungo indifferente)))
))	

(defrule divertente-serio
(autore ?)
(not (divertente ?))
=>
(printout t "Scegli un aggettivo che pensi un buon romanzo debba avere" crlf)
(printout t "1)Divertente" crlf)
(printout t "2)Serio" crlf)
(printout t "3)Indifferente" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta 
	(case 1 then
		(assert (divertente si)))
	(case 2 then
		(assert (divertente no)))
	(case 3 then
		(assert (divertente indifferente))))
)

(defrule esplicito
(autore ?)
(not (esplicito ?))
=>
(printout t "Saresti infastidito da contenuto esplicito?" crlf)
(printout t "1)Si" crlf)
(printout t "2)No" crlf)
(bind ?scelta (Domanda " " 1 2))
(if (= ?scelta 1) then (assert (esplicito no)) else (assert (esplicito si)))
)

(defrule imprevedibile
(autore ?)
(not (imprevedibile ?))
=>
(printout t "Scegli un aggettivo che pensi un buon romanzo debba avere" crlf)
(printout t "1)Imprevedibile" crlf)
(printout t "2)Tranquillo" crlf)
(printout t "3)Indifferente" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta 
	(case 1 then
		(assert (imprevedibile si)))
	(case 2 then
		(assert (imprevedibile no)))
	(case 3 then
		(assert (imprevedibile indifferente))))
)

(defrule violenza
(autore ?)
(not (violento ?))
=>
(printout t "Saresti infastidito da contenuto violento?" crlf)
(printout t "1)Si" crlf)
(printout t "2)No" crlf)
(bind ?scelta (Domanda " " 1 2))
(if (= ?scelta 1) then (assert (violento no)) else (assert (violento si)))
)

(defrule leggero
(autore ?)
(not (leggero ?))
=>
(printout t "Scegli un aggettivo che pensi un buon romanzo debba avere" crlf)
(printout t "1)Impegnativo" crlf)
(printout t "2)Leggero" crlf)
(printout t "3)Indifferente" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta 
	(case 1 then
		(assert (leggero no)))
	(case 2 then
		(assert (leggero si)))
	(case 3 then
		(assert (leggero indifferente))))
)

(defrule serie
(autore ?)
(not (serie ?))
=>
(printout t "Ti piacerebbe leggere un romanzo che fa parte di una serie? (Trilogie, Cicli...)" crlf)
(printout t "1)Si" crlf)
(printout t "2)No" crlf)
(printout t "3)Indifferente" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta 
	(case 1 then
		(assert (serie si)))
	(case 2 then
		(assert (serie no)))
	(case 3 then
		(assert (serie indifferente))))
)


;REGOLE DI FINE ESECUZIONE

(defrule fallimento
(declare (salience -10000))
(not (trovato))
(not (ritratta))
=>
(printout t "Mi dispiace, non sono riuscito a trovare nessun libro" crlf)
(printout t "con le caratteristiche richieste, ora puoi procedere nei seguenti modi:" crlf)
(printout t "1)Provare a cercare un altro libro" crlf)
(printout t "2)Modificare qualche risposta" crlf)
(printout t "3)Uscire" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta 
	(case 1 then
		(reset)
		(assert (presentazione))
		(run))
	(case 2 then
		(assert (ritratta))))
)

(defrule successo
(declare (salience -1000))
(trovato)
=>
(printout t crlf "I seguenti libri probabilmente fanno per te: " crlf)
)

(defrule menu-finale
(declare (salience -5000))
?x <- (trovato)
=>
(printout t crlf "Li hai già letti o non credi possano piacerti questi titoli?" crlf)
(printout t "1)Riprova" crlf)
(printout t "2)Modifica qualche risposta" crlf)
(printout t "3)Esci" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta
	(case 1 then 
		(reset)
		(assert (presentazione))
		(run))
	(case 2 then
		(assert (ritratta))
		(retract ?x)))
)


;REGOLA PER RITRATTARE FATTI

(defrule ritratta

?rit <- (ritratta)
?imp <- (imprevedibile ?attr1)
?viol <- (violento ?attr2)
?legg <- (leggero ?attr3)
?ser <- (serie ?attr4)
?espl <- (esplicito ?attr5)
?lun <- (lungo ?attr6)
?div <- (divertente ?attr7)
=>
(printout t "Si sono scelte le seguenti caratteristiche per il libro da trovare: " crlf)
(switch ?attr1
	(case si then
		(printout t "1)Imprevedibile" crlf))
	(case no then
		(printout t "1)Tranquillo" crlf))
	(case indifferente then
		(printout t "1)Imprevedibile/Tranquillo" crlf)))

(if (eq ?attr2 si) then (printout t "2)Anche con contenuto violento" crlf) else (printout t "2)Senza contenuto violento" crlf))

(switch ?attr3 
	(case si then
		(printout t "3)Leggero" crlf))
	(case no then
		(printout t "3)Impegnativo" crlf))
	(case indifferente then
		(printout t "3)Leggero/Impegnativo" crlf)))

(switch ?attr4 
	(case si then
		(printout t "4)Facente parte di una serie" crlf))
	(case no then
		(printout t "4)Autoconclusivo" crlf))
	(case indifferente then
		(printout t "4)Anche facente parte di una serie" crlf)))

(if (eq ?attr5 si) then (printout t "5)Anche con contenuto esplicito" crlf) else (printout t "5)Senza contenuto esplicito" crlf))

(switch ?attr6 
	(case si then
		(printout t "6)Voluminoso" crlf))
	(case no then
		(printout t "6)Non molto lungo" crlf))
	(case indifferente then
		(printout t "6)Lungo/Breve" crlf)))
(switch ?attr7 
	(case si then
		(printout t "7)Divertente" crlf))
	(case no then
		(printout t "7)Serio" crlf))
	(case indifferente then
		(printout t "7)Divertente/Serio" crlf)))
(printout t "8)Riprova" crlf)

(printout t "Scegliere la caratteristica da ritrattare: ")
(bind ?scelta (Domanda " " 1 2 3 4 5 6 7 8 ))
(switch ?scelta 
	(case 1 then (retract ?imp))
	(case 2 then (retract ?viol))
	(case 3 then (retract ?legg))
	(case 4 then (retract ?ser))
	(case 5 then (retract ?espl))
	(case 6 then (retract ?lun))
	(case 7 then (retract ?div))
	(case 8 then (retract ?rit)))
)

 
;REGOLE PER LA SCELTA DEI LIBRI

(defrule the-casual-vacancy
(imprevedibile si|indifferente)
(violento si)
(leggero no|indifferente)
(serie no|indifferente)
(esplicito no)
(lungo no|indifferente)
(divertente no|indifferente)
=>
(assert (libro (nome "The Casual Vacancy") (punteggio 3.26) (autore "J.K.Rowling") (serie "-")))
(assert (trovato))
)

;STAMPA RISULTATO

(defrule print
(declare (salience -1001))
(trovato)
(libro (nome ?nome) (punteggio ?punteggio) (autore ?autore) (serie ?serie))
=>
(printout t "-  Titolo: " ?nome "  Rating: " ?punteggio "  Autore: " ?autore "  Serie: " ?serie crlf)
)






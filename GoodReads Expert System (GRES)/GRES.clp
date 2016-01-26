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
(assert (genere nil))
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
	(printout t crlf)
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
		(type STRING))
	(slot autore
		(type STRING))
	(slot serie
		(type STRING)
		(default "-")))


;REGOLE PER LA CLASSIFICAZIONE DELL'UTENTE

(defrule età
(presentazione)
(not (login))
=>
(bind ?eta (DomandaB "Età del lettore? (Inserire un valore numerico)"))
(if (< ?eta 16)  then (assert (esplicito no)))
(if (< ?eta 12) then (assert (violento no)))
(assert (età))
)


(defrule lettore-accanito
(presentazione)
(not (login))
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
		     (assert (lungo indifferente))
		     (assert (autore si)))
))


;REGOLE PER LETTORE ACCANITO

(defrule domanda-autori
(declare (salience 10000))
?x <- (autore si)
(età)
(not (login))
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
(printout t "10)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4 5 6 7 8 9 10))
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
	(case 10 then
		(assert (aiuto autore))
		(retract ?x))
))

;REGOLE PER DOMANDE GENERALI

(defrule lungo
(autore ?)
(not (lungo ?))
=>
(printout t "Vorresti leggere un libro con molte pagine?" crlf)
(printout t "1)Sì" crlf)
(printout t "2)No" crlf)
(printout t "3)Non so" crlf)
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
(printout t "Secondo te un buon romanzo è:" crlf)
(printout t "1)Divertente" crlf)
(printout t "2)Serio" crlf)
(printout t "3)Non so" crlf)
(printout t "4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (divertente si)))
	(case 2 then
		(assert (divertente no)))
	(case 3 then
		(assert (divertente indifferente)))
	(case 4 then 
		(assert (aiuto divertente))))
)

(defrule esplicito
(autore ?)
(not (esplicito ?))
=>
(printout t "Saresti infastidito da contenuto esplicito?" crlf)
(printout t "1)Sì" crlf)
(printout t "2)No" crlf)
(bind ?scelta (Domanda " " 1 2))
(if (= ?scelta 1) then (assert (esplicito no)) else (assert (esplicito si)))
)

(defrule imprevedibile
(autore ?)
(not (imprevedibile ?))
=>
(printout t "Secondo te un buon romanzo è:" crlf)
(printout t "1)Imprevedibile" crlf)
(printout t "2)Tranquillo" crlf)
(printout t "3)Non so" crlf)
(printout t "4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (imprevedibile si)))
	(case 2 then
		(assert (imprevedibile no)))
	(case 3 then
		(assert (imprevedibile indifferente)))
	(case 4 then
		(assert (aiuto imprevedibile))))
)

(defrule violenza
(autore ?)
(not (violento ?))
=>
(printout t "Saresti infastidito da contenuto violento?" crlf)
(printout t "1)Sì" crlf)
(printout t "2)No" crlf)
(bind ?scelta (Domanda " " 1 2))
(if (= ?scelta 1) then (assert (violento no)) else (assert (violento si)))
)

(defrule leggero
(autore ?)
(not (leggero ?))
=>
(printout t "Secondo te un buon romanzo è:" crlf)
(printout t "1)Impegnativo" crlf)
(printout t "2)Leggero" crlf)
(printout t "3)Non so" crlf)
(printout t "4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (leggero no)))
	(case 2 then
		(assert (leggero si)))
	(case 3 then
		(assert (leggero indifferente)))
	(case 4 then
		(assert (aiuto leggero))))
)

(defrule intenso
(autore ?)
(not (intenso ?))
=>
(printout t "Secondo te un buon romanzo è:" crlf)
(printout t "1)Intenso" crlf)
(printout t "2)Riflessivo" crlf)
(printout t "3)Non so" crlf)
(printout t "4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (intenso si)))
	(case 2 then
		(assert (intenso no)))
	(case 3 then
		(assert (intenso indifferente)))
	(case 4 then
		(assert (aiuto intenso))))
)

(defrule serie
(autore ?)
(not (serie ?))
=>
(printout t "Cerchi un romanzo che faccia parte di una serie? (Trilogie, Cicli...)" crlf)
(printout t "1)Sì" crlf)
(printout t "2)No" crlf)
(printout t "3)Non so" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta 
	(case 1 then
		(assert (serie si)))
	(case 2 then
		(assert (serie no)))
	(case 3 then
		(assert (serie indifferente))))


)

(defrule kindle 
(autore ?)
(not (kindle ?))
=>
(printout t "Possiedi un kindle?" crlf)
(printout t "1)Sì" crlf)
(printout t "2)No" crlf)
(printout t "3)Cos'è?" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta
	(case 1 then
		(assert (kindle si)))
	(case 2 then 
		(assert (kindle no))
		(assert (ebook nil)))
	(case 3 then 
		(assert (aiuto kindle))))
)

(defrule ebook
(autore ?)
(not (ebook ?))
(kindle si)
=>
(printout t "Vuoi cercare un romanzo disponibile come free-ebook nel progetto Gutemberg?" crlf)
(printout t "1)Sì" crlf)
(printout t "2)No" crlf)
(printout t "3)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta 
	(case 1 then 
		(assert (ebook si)))
	(case 2 then
		(assert (ebook no)))
	(case 3 then
		(assert (aiuto ebook))))
)

;REGOLE PER GENERE 

(defrule avventura
(imprevedibile si|indifferente)
(intenso si|indifferente)
(not (ritratta genere))
(not (genere avventura))
=>
(printout t crlf "Stai per caso cercando un romanzo d'avventura? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta
	(case 1 then 
		(assert (genere avventura)))
	(case 4 then
		(assert (aiuto avventura))))
)

(defrule storico
(intenso no|indifferente)
(leggero no|indifferente)
(not (ritratta genere))
(not (genere storico))
=>
(printout t crlf "Stai per caso cercando un romanzo storico? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere storico)))
	(case 4 then
		(assert (aiuto storico))))
)

(defrule sociale
(intenso no|indifferente)
(leggero no|indifferente)
(not (ritratta genere))
(not (genere sociale))
=>
(printout t crlf "Stai per caso cercando un romanzo sociale? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere sociale)))
	(case 4 then
		(assert (aiuto sociale))))
)

(defrule psicologico
(intenso no|indifferente)
(leggero no|indifferente)
(imprevedibile no|indifferente)
(not (ritratta genere))
(not (genere psicologico))
=>
(printout t crlf "Stai per caso cercando un romanzo psicologico? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere psicologico)))
	(case 4 then
		(assert (aiuto psicologico))))
)

(defrule fantastico
(leggero si|indifferente)
(imprevedibile si|indifferente)
(intenso si|indifferente)
(not (ritratta genere))
(not (genere fantastico))
=>
(printout t crlf "Stai per caso cercando un romanzo fantastico? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere fantastico)))
	(case 4 then
		(assert (aiuto fantastico))))
)

(defrule giallo
(imprevedibile si|indifferente)
(intenso no|indifferente)
(not (ritratta genere))
(not (genere giallo))
=>
(printout t crlf "Stai per caso cercando un romanzo giallo? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere giallo)))
	(case 4 then
		(assert (aiuto giallo))))
)

(defrule nero
(violento si)
(intenso si|indifferente)
(not (ritratta genere))
(not (genere nero))
=>
(printout t crlf "Stai per caso cercando un romanzo gotico? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere nero)))
	(case 4 then
		(assert (aiuto nero))))
)

(defrule rosa
(esplicito si)
(intenso si|indifferente)
(not (ritratta genere))
(not (genere rosa))
=>
(printout t crlf "Stai per caso cercando un romanzo rosa? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere rosa)))
	(case 4 then
		(assert (aiuto rosa))))
)

(defrule fantascienza
(leggero si|indifferente)
(imprevedibile si|indifferente)
(intenso si|indifferente)
(not (ritratta genere))
(not (genere fantascienza))
=>
(printout t crlf "Stai per caso cercando un romanzo fantascientifico? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere fantascienza)))
	(case 4 then
		(assert (aiuto fantascienza))))
)

;REGOLE DI AIUTO

(defrule aiuto-fantascienza
?x <- (aiuto fantascienza)
=>
(printout t crlf "La fantascienza ha come tema fondamentale l'impatto di una scienza e/o una tecnologia – reale o immaginaria – sulla società e sull'individuo. I personaggi, oltre che esseri umani, possono essere alieni, robot, cyborg, mostri o mutanti; la storia può essere ambientata nel passato, nel presente o, più frequentemente, nel futuro. Premere INVIO per continuare." crlf)
(get-char)
(retract ?x)
(printout t crlf "Stai per caso cercando un romanzo fantascientifico? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere fantascienza)))
	(case 4 then
		(assert (aiuto fantascienza))))
)

(defrule aiuto-rosa
?x <- (aiuto rosa)
=>
(printout t crlf "Il romanzo rosa (detto anche romance) è un genere letterario che narra di storie d'amore e del loro intreccio che si dipanano in genere in avventure e intrighi e terminano sempre con un lieto fine. Premere INVIO per continuare." crlf)
(get-char)
(retract ?x)
(printout t crlf "Stai per caso cercando un romanzo rosa? (Ricorda che puoi scegliere più di un genere)" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere rosa)))
	(case 4 then
		(assert (aiuto rosa))))
)

(defrule aiuto-nero
?x <- (aiuto nero)
=>
(printout t crlf "Il romanzo gotico è un genere narrativo sviluppatosi dalla seconda metà del Settecento e caratterizzato dall'unione di elementi romantici e dell'orrore. L'espressione 'letteratura gotica', riferita alla tendenza culturale sviluppatasi dalla metà del XVIII secolo, è entrata nell'uso comune a partire soprattutto dai paesi anglosassoni e individua solitamente storie ambientate nel Medioevo in castelli diroccati, sotterranei e altri ambienti cupi e tenebrosi. Premere INVIO Per continuare." crlf)
(get-char)
(retract ?x)
(printout t crlf "Stai per caso cercando un romanzo gotico?" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere nero)))
	(case 4 then
		(assert (aiuto nero))))
)

(defrule aiuto-giallo
?x <- (aiuto giallo)
=>
(printout t crlf "L'oggetto principale della letteratura gialla è la descrizione di un crimine e dei personaggi coinvolti, siano essi criminali o vittime. Si parla in modo più specifico di poliziesco quando, assieme a questi elementi, ha un ruolo centrale la narrazione delle indagini che portano alla luce tutti gli elementi della vicenda criminale. Premere INVIO per continuare" crlf)
(get-char)
(retract ?x)
(printout t crlf "Stai per caso cercando un romanzo giallo?" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere giallo)))
	(case 4 then
		(assert (aiuto giallo))))
)

(defrule aiuto-fantastico
?x <- (aiuto fantastico)
=>
(printout t crlf "Il fantastico è un genere di narrazione basato sulla rappresentazione di elementi e situazioni immaginarie che esulano dall'esperienza quotidiana, straordinarie, che si ritiene non si verifichino (molto probabilmente) nella realtà comunemente sperimentata. Elementi che possono definire una situazione fantastica sono l'intervento del soprannaturale o del meraviglioso, come la magia o una invenzione tecnologica futuribile. Premere INVIO per continuare" crlf)
(get-char)
(retract ?x)
(printout t crlf "Stai per caso cercando un romanzo fantastico?" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere fantastico)))
	(case 4 then
		(assert (aiuto fantastico))))
)

(defrule aiuto-psicologico
?x <- (aiuto psicologico)
=>
(printout t crlf "l romanzo psicologico è un tipo di romanzo nato tra l'Ottocento il Novecento, nel clima di crisi e di tensione che caratterizzò gli anni letteratura: da una parte, una chiusura nella propria interiorità, dall'altra una forte esigenza di realismo. Davanti ai drammi della guerra, letteratura era vista come mezzo di autoanalisi e riflessione profonda su di sé. In questo tipo di narrazione la fabula è debole, quasi inesistente e focalizza tutta l'attenzione sui meccanismi mentali dei personaggi. Premere INVIO per continuare" crlf)
(get-char)
(retract ?x)
(printout t crlf "Stai per caso cercando un romanzo psicologico?" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere psicologico)))
	(case 4 then
		(assert (aiuto psicologico))))
)


(defrule aiuto-sociale
?x <- (aiuto sociale)
=>
(printout t crlf "Il romanzo a sfondo sociale (altrimenti detto semplicemente romanzo sociale) si sviluppa nella prima metà dell'Ottocento ed è un genere di romanzo che tratteggia la vita dei ceti sociali economicamente svantaggiati e denuncia situazioni di sopruso e pregiudizio. Premere INVIO per continuare" crlf)
(get-char)
(retract ?x)
(printout t crlf "Stai per caso cercando un romanzo sociale?" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere sociale)))
	(case 4 then
		(assert (aiuto sociale))))
)

(defrule aiuto-autore
?x <- (aiuto autore)
=>
(printout t crlf "Cerca di selezionare l'autore i cui romanzi rispecchiano" crlf
	    "in modo più efficace i tuoi gusti personali, se sei in dubbio" crlf
	    "non preoccuparti e seleziona semplicemente l'opzione 'Nessuno di questi'" crlf
	    "il processo di ricerca non sarà influenzato in maniera negativa." crlf
	    "Premere INVIO per continuare" crlf)
(get-char)
(retract ?x)
(assert (autore si))
)

(defrule aiuto-divertente
?x <- (aiuto divertente)
=>
(printout t crlf "Un romanzo divertente contiene situazioni esilaranti e generalmente" crlf
	       "ha un tono goliardico e leggero, un romanzo serio invece ha una trama" crlf
	       "creata con lo scopo di raccontare avvenimenti più reali che suscitano" crlf
	       "più che un sorriso, una riflessione. Premere INVIO per continuare" crlf)
(get-char)
(retract ?x)
(printout t "Secondo te un buon romanzo è:" crlf)
(printout t "1)Divertente" crlf)
(printout t "2)Serio" crlf)
(printout t "3)Entrambi" crlf)
(printout t "4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (divertente si)))
	(case 2 then
		(assert (divertente no)))
	(case 3 then
		(assert (divertente indifferente)))
	(case 4 then 
		(assert (aiuto divertente))))
)


(defrule aiuto-imprevedibile
?x <- (aiuto imprevedibile)
=>
(printout t crlf "Un romanzo imprevedibile ha una trama ricca di colpi di scena, i personaggi" crlf
		"evolvono in maniera più brusca e veloce rispetto a un romanzo con una trama più" crlf
		"piatta che si concentra più sull'aspetto caratteriale dei personaggi e sulla psicologia delle" crlf
		"situazioni raccontate.Premere INVIO per continuare" crlf)
(get-char)
(retract ?x)
(printout t "Secondo te un buon romanzo è:" crlf)
(printout t "1)Imprevedibile" crlf)
(printout t "2)Tranquillo" crlf)
(printout t "3)Entrambi" crlf)
(printout t "4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (imprevedibile si)))
	(case 2 then
		(assert (imprevedibile no)))
	(case 3 then
		(assert (imprevedibile indifferente)))
	(case 4 then
		(assert (aiuto imprevedibile))))
)

(defrule aiuto-leggero
?x <- (aiuto leggero)
=>
(printout t crlf "Un romanzo leggero è più facile da leggere, il linguaggio è più semplice e la trama " crlf
		 "non troppo complicata, un romanzo impegnativo al contrario necessita una discreta quantità " crlf 
		"di concentrazione per essere letto e apprezzato.Premere INVIO per continuare" crlf)
(get-char)
(retract ?x)
(printout t "Secondo te un buon romanzo è:" crlf)
(printout t "1)Impegnativo" crlf)
(printout t "2)Leggero" crlf)
(printout t "3)Entrambi" crlf)
(printout t "4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (leggero no)))
	(case 2 then
		(assert (leggero si)))
	(case 3 then
		(assert (leggero indifferente)))
	(case 4 then
		(assert (aiuto leggero))))
)

(defrule aiuto-intenso
?x <- (aiuto intenso)
=>
(printout t crlf "Un libro intenso si concentra principalmente sulla trama e cattura il lettore in un " crlf
		"vortice di eventi di solito senza o con pochissimi momenti di respiro; un romanzo riflessivo " crlf
		"invece, si sofferma spesso su eventi per analizzare i pensieri e le emozioni dei personaggi, " crlf
		"si tratta di un tipo di scrittura più descrittiva e lenta che porta appunto a riflettere. " crlf
		"Premere INVIO per continuare" crlf)
(get-char)
(retract ?x)
(printout t "Secondo te un buon romanzo è:" crlf)
(printout t "1)Intenso" crlf)
(printout t "2)Riflessivo" crlf)
(printout t "3)Entrambi" crlf)
(printout t "4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (intenso si)))
	(case 2 then
		(assert (intenso no)))
	(case 3 then
		(assert (intenso indifferente)))
	(case 4 then
		(assert (aiuto intenso))))
)

(defrule aiuto-kindle
?x <- (aiuto kindle)
=>
(printout t crlf "Kindle è un lettore di ebook o libri elettronici, gli ebook non sono altro che libri normalissimi ma digitalizzati: invece di" crlf 		 "essere stampati su carta sono file. Un ebook reader è dotato di una tecnologia definita e-ink, ovvero inchiostro elettronico o" crlf 		 "carta elettronica, vale a dire una tecnologia progettata per imitare l’aspetto dell’inchiostro su un normale foglio. A differenza" crlf 		 "di un normale schermo, che usa una luce posteriore al display per illuminare i pixel, l’e-paper riflette la luce ambientale come" crlf 		 "un foglio di carta. Premere INVIO per continuare." crlf)
(get-char)
(retract ?x)
(printout t "Possiedi un kindle?" crlf)
(printout t "1)Sì" crlf)
(printout t "2)No" crlf)
(printout t "3)Cos'è?" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta
	(case 1 then
		(assert (kindle si)))
	(case 2 then 
		(assert (kindle no))
		(assert (ebook nil)))
	(case 3 then 
		(assert (aiuto kindle))))
)

(defrule aiuto-ebook
?x <- (aiuto ebook)
=>
(printout t crlf "Il Progetto Gutenberg (Project Gutenberg, noto anche con l'acronimo PG) è un'iniziativa avviata dall'informatico Michael Hart nel" crlf 	       "1971 con l'obiettivo di costituire una biblioteca di versioni elettroniche liberamente riproducibili di libri stampati, oggi" 
crlf 	       "chiamati eBook. Il progetto Gutenberg è la più antica iniziativa del settore. I testi disponibili in questa biblioteca libera sono" crlf 	       "per la maggior parte di pubblico dominio, o in quanto mai coperti da diritto d'autore o da copyright, o in quanto decaduti questi" crlf	       "vincoli.Sono disponibili anche alcuni testi coperti da copyright ma che hanno ottenuto dagli autori il permesso alla nuova forma di" crlf           "pubblicazione.(Selezionando l'opzione sì, si sceglie di cercare libri esclusivamente appartenenti al progetto Premere INVIO per continuare." crlf)
(get-char)
(retract ?x)
(printout t "Vuoi cercare un romanzo disponibile come free-ebook nel progetto Gutemberg?" crlf)
(printout t "1)Sì" crlf)
(printout t "2)No" crlf)
(printout t "3)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta 
	(case 1 then 
		(assert (ebook si)))
	(case 2 then
		(assert (ebook no)))
	(case 3 then
		(assert (aiuto ebook))))
)


(defrule aiuto-avventura
?x <- (aiuto avventura)
=>
(printout t crlf "Il romanzo di avventura è un genere letterario che nasce nel XVIII secolo e che narra di viaggi in terre lontane e quindi celebra il coraggio e l'ingegno umano. L'incontro fra diverse culture offre uno spunto per riflettere e criticare la società in cui l'autore vive, ma anche per esaltarne i valori. Premere INVIO per continuare." crlf)
(get-char)
(retract ?x)
(printout t crlf "Stai per caso cercando un romanzo d'avventura?" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta
	(case 1 then 
		(assert (genere avventura)))
	(case 4 then
		(assert (aiuto avventura))))
)

(defrule aiuto-storico
?x <- (aiuto storico)
=>
(printout t crlf "Il romanzo storico è un'opera narrativa ambientata in un'epoca passata, della quale ricostruisce le atmosfere, gli usi, i costumi, la mentalità e la vita in genere, così da farli rivivere al lettore. Secondo l'Enciclopedia Britannica, un romanzo si definisce storico quando 'è ambientato in un'epoca storica e intende trasmetterne lo spirito, i comportamenti e le condizioni sociali attraverso dettagli realistici e con un'aderenza (in molti casi solo apparente) ai fatti documentati.' Premere INVIO per continuare." crlf)
(get-char)
(retract ?x)
(printout t crlf "Stai per caso cercando un romanzo storico?" crlf
		"1)Si" crlf
		"2)No" crlf
		"3)Non so" crlf
		"4)Aiuto" crlf)
(bind ?scelta (Domanda " " 1 2 3 4))
(switch ?scelta 
	(case 1 then
		(assert (genere storico)))
	(case 4 then
		(assert (aiuto storico))))
)



;REGOLE DI FINE ESECUZIONE

(defrule fallimento
(declare (salience -10000))
(not (trovato))
(not (ritratta))
(not (interfaccia))
=>
(printout t crlf "Mi dispiace, non sono riuscito a trovare nessun libro" crlf)
(printout t "con le caratteristiche richieste, ora puoi procedere nei seguenti modi:" crlf crlf)
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
(not (interfaccia))
=>
(printout t crlf "I seguenti libri probabilmente fanno per te: " crlf)
)

(defrule menu-finale
(declare (salience -5000))
?x <- (trovato)
(not (interfaccia))
=>
(printout t crlf "RATING FORNITI DAGLI UTENTI DI www.goodreads.com!" crlf)
(printout t crlf "Li hai già letti o non credi possano piacerti questi titoli?" crlf)
(printout t "1)Riprova" crlf)
(printout t "2)Modifica qualche risposta" crlf)
(printout t "3)Esci" crlf)
(bind ?scelta (Domanda " " 1 2 3))
(switch ?scelta
	(case 1 then 
		(reset)
		(assert (presentazione))
		(assert (genere nil))
		(run))
	(case 2 then
		(assert (ritratta))
		(retract ?x)))
)

(defrule rimuovi-genere
(genere ~nil)
?x <- (genere nil)
=>
(retract ?x)
)

(defrule genere-nil
(declare (salience -100))
(not (genere ?))
=>
(assert (genere nil))
)


;REGOLA PER RITRATTARE FATTI

(defrule ritratta
(declare (salience -1))
?rit <- (ritratta)
?imp <- (imprevedibile ?attr1)
?viol <- (violento ?attr2)
?legg <- (leggero ?attr3)
?ser <- (serie ?attr4)
?espl <- (esplicito ?attr5)
?lun <- (lungo ?attr6)
?div <- (divertente ?attr7)
?int <- (intenso ?attr8)
?gut <- (ebook  ?attr9)
?gen <- (genere ?attr10)
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
(switch ?attr8
	(case si then
		(printout t "8)Intenso" crlf))
	(case no then
		(printout t "8)Riflessivo" crlf))
	(case indifferente then
		(printout t "8)Intenso/Riflessivo" crlf)))
(switch ?attr9
	(case si then
		(printout t "9)Facente parte del progetto Gutemberg" crlf))
	(case  no  then
		(printout t "9)Anche facente parte del progetto Gutemberg" crlf))
	(case  nil  then
		(printout t "9)Anche facente parte del progetto Gutemberg" crlf)))

(if (eq ?attr10 nil) then (printout t "10)Nessun genere in particolare" crlf)
	else (printout t "10)Generi:" crlf)
	     (do-for-all-facts ((?p genere)) TRUE (printout t "            " (str-cat (nth$ 1 (fact-slot-value ?p implied))) crlf)))

(printout t "11)Riprova" crlf)

(printout t "Scegliere la caratteristica da ritrattare: ")
(bind ?scelta (Domanda " " 1 2 3 4 5 6 7 8 9 10 11))
(switch ?scelta 
	(case 1 then (retract ?imp) (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 2 then (retract ?viol) (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 3 then (retract ?legg) (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 4 then (retract ?ser) (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 5 then (retract ?espl) (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 6 then (retract ?lun) (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 7 then (retract ?div) (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 8 then (retract ?int) (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 9 then (retract ?gut) (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 10 then (do-for-all-facts ((?g genere)) TRUE (retract ?g)) 
		      (retract (assert (ritratta genere)))
		      (do-for-all-facts ((?p libro)) TRUE (retract ?p)))
	(case 11 then (retract ?rit)
			))
)

 
;REGOLE PER LA SCELTA DEI LIBRI

(defrule the-casual-vacancy
(genere giallo|psicologico|nil)
(imprevedibile si|indifferente)
(violento si)
(leggero no|indifferente)
(serie no|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente no|indifferente)
(intenso si|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "The Casual Vacancy") (punteggio "3.26") (autore "J.K.Rowling")))
(assert (trovato))
)

(defrule lo-hobbit
(genere fantastico|avventura|nil)
(imprevedibile si|indifferente)
(violento si)
(leggero no|indifferente)
(serie no|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente no|indifferente)
(intenso si|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "Lo Hobbit") (punteggio "4.22") (autore "J.R.R. Tolkien")))
(assert (trovato))
)

(defrule il-signore-degli-anelli
(genere fantastico|avventura|nil)
(imprevedibile si|indifferente)
(violento si)
(leggero no|indifferente)
(serie si|indifferente)
(esplicito no|si)
(lungo si|indifferente)
(divertente no|indifferente)
(intenso si|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "Il Signore degli Anelli") (punteggio "4.40") (autore "J.R.R Tolkien") (serie "Il Signore degli Anelli")))
(assert (trovato))
)

(defrule il-silmarillion
(genere fantastico|nil)
(imprevedibile no|indifferente)
(violento si)
(leggero no|indifferente)
(serie no|indifferente)
(esplicito no|si)
(lungo si|indifferente)
(divertente no|indifferente)
(intenso no|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "Il Silmarillion") (punteggio "3.84") (autore "J.R.R Tolkien")))
(assert (trovato))
)

(defrule racconto-di-due-città
(genere storico|sociale|nil)
(imprevedibile no|indifferente)
(violento si)
(leggero no|indifferente)
(serie no|indifferente)
(esplicito si)
(lungo si|indifferente)
(divertente no|indifferente)
(intenso si|indifferente)
(ebook si|nil)
=>
(assert (libro (nome "Racconto di Due Città") (punteggio "3.78") (autore "Charles Dickens")))
(assert (trovato))
)

(defrule oliver-twist
(genere sociale|psicologico|avventura|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero si|indifferente)
(serie no|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente no|indifferente)
(intenso si|indifferente)
(ebook si|no|nil)
=>
(assert (libro (nome "Oliver Twist") (punteggio "3.83") (autore "Charles Dickens")))
(assert (trovato))
)

(defrule david-copperfield
(genere psicologico|storico|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero no|indifferente)
(serie no|indifferente)
(esplicito no|si)
(lungo si|indifferente)
(divertente no|indifferente)
(intenso no|indifferente)
(ebook si|no|nil)
=>
(assert (libro (nome "David Copperfield") (punteggio "3.94") (autore "Charles Dickens")))
(assert (trovato))
)

(defrule uno-studio-in-rosso
(genere giallo|avventura|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero si|indifferente)
(serie no|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente si|indifferente)
(intenso si|indifferente)
(ebook si|no|nil)
=>
(assert (libro (nome "Uno Studio in Rosso") (punteggio "4.13") (autore "Sir Arthur Conan Doyle")))
(assert (trovato))
)

(defrule il-mastino-dei-baskerville
(genere giallo|avventura|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero si|indifferente)
(serie no|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente si|indifferente)
(intenso si|indifferente)
(ebook si|no|nil)
=>
(assert (libro (nome "Il Mastino dei Baskerville") (punteggio "4.06") (autore "Sir Arthur Conan Doyle")))
(assert (trovato))
)

(defrule la-valle-della-paura
(genere giallo|avventura|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero si|indifferente)
(serie no|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente si|indifferente)
(intenso si|indifferente)
(ebook si|no|nil)
=>
(assert (libro (nome "La Valle della Paura") (punteggio "4.20") (autore "Sir Arthur Conan Doyle")))
(assert (trovato))
)

(defrule io-robot
(genere giallo|fantascienza|avventura|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero si|indifferente)
(serie si|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente no|indifferente)
(intenso si|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "Io,Robot") (punteggio "4.14") (autore "Isaac Asimov") (serie "Ciclo dei Robot")))
(assert (trovato))
)

(defrule abissi-acciaio
(genere giallo|fantascienza|avventura|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero si|indifferente)
(serie si|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente no|indifferente)
(intenso si|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "Abissi d'Acciaio") (punteggio "4.12") (autore "Isaac Asimov") (serie "Ciclo dei Robot")))
(assert (trovato))
)

(defrule il-sole-nudo
(genere giallo|fantascienza|avventura|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero si|indifferente)
(serie si|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente no|indifferente)
(intenso si|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "Il Sole Nudo") (punteggio "4.09") (autore "Isaac Asimov") (serie "Ciclo dei Robot")))
(assert (trovato))
)

(defrule millenovecentoottantaquattro
(genere sociale|psicologico|nil)
(imprevedibile si|indifferente)
(violento si)
(leggero no|indifferente)
(serie no|indifferente)
(esplicito si)
(lungo no|indifferente)
(divertente no|indifferente)
(intenso no|indifferente)
(ebook si|no|nil)
=>
(assert (libro (nome "1984") (punteggio "4.80") (autore "George Orwell")))
(assert (trovato))
)

(defrule la-fattoria-degli-animali
(genere psicologico|nil)
(imprevedibile no|indifferente)
(violento no|si)
(leggero no|indifferente)
(serie no|indifferente)
(esplicito no|si)
(lungo no|indifferente)
(divertente no|indifferente)
(intenso no|indifferente)
(ebook si|no|nil)
=>
(assert (libro (nome "La Fattoria degli Animali") (punteggio "3.83") (autore "George Orwell")))
(assert (trovato))
)

(defrule la-caduta-dei-giganti
(genere storico|sociale|rosa|avventura|nil)
(imprevedibile no|indifferente)
(violento si)
(leggero si|indifferente)
(serie si|indifferente)
(esplicito si)
(lungo si|indifferente)
(divertente no|indifferente)
(intenso si|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "La Caduta dei Giganti") (punteggio "4.22") (autore "Ken Follett") (serie "Trilogia del Secolo")))
(assert (trovato))
)

(defrule l-ombra-dello-scorpione
(genere avventura|nero|fantastico|nil)
(imprevedibile si|indifferente)
(violento si)
(leggero si|indifferente)
(serie no|indifferente)
(esplicito no|si)
(divertente no|indifferente)
(lungo si|indifferente)
(intenso no|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "L'Ombra dello Scorpione") (punteggio "4.32") (autore "Stephen King")))
(assert (trovato))
)

(defrule l-ultimo-cavaliere
(genere avventura|fantastico|nil)
(imprevedibile si|indifferente)
(violento si)
(leggero no|indifferente)
(serie si|indifferente)
(esplicito si)
(divertente no|indifferente)
(lungo no|indifferente)
(intenso si|indifferente)
(ebook no|nil)
=>
(assert (libro (nome "L'Ultimo Cavaliere") (punteggio "4.00") (autore "Stephen King") (serie "Saga della Torre Nera")))
(assert (trovato))
)

(defrule le-avventure-di-huckleberry-finn
(genere sociale|avventura|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero si|indifferente)
(serie no|indifferente)
(esplicito no|si)
(divertente si|indifferente)
(lungo no|indifferente)
(intenso no|indifferente)
(ebook si|no|nil)
=>
(assert (libro (nome "Le Avventure di Huckleberry Finn") (punteggio "3.66") (autore "Mark Twain")))
(assert (trovato))
)

(defrule lo-strano-caso-del-dr
(genere fantastico|giallo|nil)
(imprevedibile si|indifferente)
(violento no|si)
(leggero si|indifferente)
(serie no|indifferente)
(esplicito no|si)
(divertente no|indifferente)
(lungo no|indifferente)
(intenso no|indifferente)
(ebook si|no|nil)
=>
(assert (libro (nome "Lo Strano Caso del Dr. Jeckill e Mr. Hyde") (punteggio "3.70") (autore "Fernando Marìas")))
(assert (trovato))
)


;STAMPA RISULTATO

(defrule print
(declare (salience -1001))
(trovato)
(libro (nome ?nome) (punteggio ?punteggio) (autore ?autore) (serie ?serie))
(not (interfaccia))
=>
(printout t "-  TITOLO: " ?nome "  RATING: " ?punteggio "/5" "  AUTORE: " ?autore "  SERIE: " ?serie crlf)
)






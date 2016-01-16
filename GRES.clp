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
(assert (presentazione)))


;REGOLE PER LA CLASSIFICAZIONE DELL'UTENTE

(defrule età
(presentazione)
=>
(bind ?eta (DomandaB "Età del lettore? (Inserire un valore numerico)"))
(if (< ?eta 16)  then (assert (esplicito no)))
(if (< ?eta 12) then (assert (violento no)))
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
	(case 1 then (assert (accanito no))
		     (assert (lungo no))
		     (assert (autore no)))

	(case 2 then (assert (accanito medio)) 
		     (assert (lungo indifferente))
		     (assert (autore no)))

	(case 3 then (assert (accanito si))
		     (assert (lungo indifferente))
		     (assert (autore si)))
))




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


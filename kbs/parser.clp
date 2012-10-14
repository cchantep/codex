(deftemplate phrase
  (slot id (type INTEGER) (default ?NONE))
  (multislot contenu (type SYMBOL)))

(deftemplate lexem-list
  (slot id-phrase (type INTEGER) (default ?NONE))
  (multislot contenu (type SYMBOL)))

(deffacts lexems
  (lexem verbe mange)
  (lexem verbe cherche)
  (lexem nom chat m s)
  (lexem nom souris f s)
  (lexem nom chien m s)
  (lexem adj bleu m s)
  (lexem adj vert m s)
  (lexem adj verte f s)
  (lexem det le m s)
  (lexem det les m p)
  (lexem det la f s)
  ; groupe
  (lexem nominal gn-ms m s)
  (lexem nominal gn-mp m p)
  (lexem nominal gn-fs f s)
  (lexem nominal gn-fp f p)
  (lexem verbal gv)
  (lexem wrong nominal verbal)
  (lexem wrong verbe nominal))

(deffacts phrases 
  (phrase (id 1) (contenu le chat mange la souris verte))
  (phrase (id 2) (contenu mange le chien))
  (phrase (id 3) (contenu la chien))
  (phrase (id 4) (contenu les chat)))

(defrule init-lexem-list
  (phrase (id ?id) (contenu $?contenu))
  (not (lexem-list (id-phrase ?id)))
  =>
  (assert (lexem-list (id-phrase ?id)
		      (contenu ?contenu))))

(defrule gn-1
  ?f <- (lexem-list (id-phrase ?id) (contenu $?begin ?det ?nom $?end))
  (lexem det ?det ?genre ?nb)
  (lexem nom ?nom ?genre ?nb)
  (lexem nominal ?lexem ?genre ?nb)
  =>
  (retract ?f)
  (assert (lexem-list (id-phrase ?id)
		      (contenu ?begin ?lexem ?end))))

(defrule gn-2
  ?f <- (lexem-list (id-phrase ?id) (contenu $?begin ?gn ?adj $?end))
  (lexem nominal ?gn ?genre ?nb)
  (lexem adj ?adj ?genre ?nb)
  =>
  (retract ?f)
  (assert (lexem-list (id-phrase ?id)
		      (contenu ?begin ?gn ?end))))

(defrule gv-1
  ?f <- (lexem-list (id-phrase ?id) (contenu $?begin ?gn ?verbe $?end))
  (lexem nominal ?gn ? ?)
  (lexem verbe ?verbe)
  (lexem verbal ?gv)
  =>
  (retract ?f)
  (assert (lexem-list (id-phrase ?id) 
		      (contenu ?begin ?gv ?end))))

(defrule phrase-1
  ?f <- (lexem-list (id-phrase ?id) (contenu ?gv ?gn))
  (lexem verbal ?gv)
  (lexem nominal ?gn ? ?)
  =>
  (retract ?f)
  (assert (phrase-correcte ?id)))

(defrule wrong-gram-1
  ?f <- (lexem-list (id-phrase ?id) (contenu $?begin ?lexem1 ?lexem2 $?end))
  (lexem ?lexem-type1 ?lexem1 $?)
  (lexem ?lexem-type2 ?lexem2 $?)
  (phrase (id ?id) (contenu $?phrase))
  (lexem wrong ?lexem-type1 ?lexem-type2)
  =>
  (retract ?f)
  (assert (phrase-fausse ?id)))

(defrule wrong-accord-1
  ?f <- (lexem-list (id-phrase ?id) (contenu $?begin ?lexem1 ?lexem2 $?end))
  (lexem ? ?lexem1 ?genre1 ?nb1)
  (or (lexem ? ?lexem2&~?lexem1 ?genre2&~?genre1 ?)
      (lexem ? ?lexem2&~?lexem1 ? ?nb2&~?nb1))
  =>
  (retract ?f)
  (assert (faute-accord ?id)))

(defrule display-correct-1
  (phrase-correcte ?id)
  ?f <- (phrase (id ?id) (contenu $?contenu))
  =>
  (retract ?f)
  (printout t "\"" (implode$ ?contenu) 
	    "\" est une phrase correcte." crlf))

(defrule display-wrong-1
  (phrase-fausse ?id)
  ?f <- (phrase (id ?id) (contenu $?contenu))
  =>
  (retract ?f)
  (printout t "\"" (implode$ ?contenu)
	    "\" est une phrase fausse." crlf))

(defrule display-wrong-2
  (faute-accord ?id)
  ?f <- (phrase (id ?id) (contenu $?contenu))
  =>
  (retract ?f)
  (printout t "\"" (implode$ ?contenu)
	    "\" contient une faute d'accord." crlf))

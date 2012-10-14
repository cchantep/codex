;;;;;
;; Probleme des cruches
;; Remarque : Situation (noeud du graphe) represente en fait ordonne
;;   et pas slot, precalcul de la description a afficher pour l'explication.
;;;;;

(deffacts initial
  (cruche cruche-1 3) ; cruche-1 de capacite 3
  (cruche cruche-2 4) ; cruche-2 de capacite 4
  (situation "Situation initiale ( 0 0 )" ; description situation initiale
	     nil nil ; situation initiale, pas de predecesseur, pas d'operateur
	     cruche-1 0 cruche-2 0)) ; 0/3 dans cruche-1
					; 0/3 dans cruche-2

(deffunction display-path$ (?situation)
  (if (neq (nth$ 2 (fact-slot-value (fact-index ?situation) 
				       implied)) nil)
      then (display-path$ (nth$ 2 (fact-slot-value (fact-index ?situation) 
					      implied))))

  (printout t (nth$ 1 (fact-slot-value (fact-index ?situation) implied)) crlf))


(defrule op-remplir
  "Operateur remplir"

  (not (situation ? ? ? $? 2 $?)) ; Il n'existe pas de situation
				; satisfaisante.

  ?s <- (situation ? ? ? $?avant ?cruche ?contenu $?apres) ; Considere une
					; situation quelconque.
  (cruche ?cruche ?capacite) ; capacite de la cruche consideree

  (not (situation ? ? ? ; La situation avec la cruche remplie 
		  $?avant ; n'a pas deja ete obtenue
		  ?cruche ?capacite 
		  $?apres)) 
  
  (test (< ?contenu ?capacite)) ; La cruche n'est pas encore remplie.
  =>
  (assert (situation ; description precalculee
	   (str-cat "Remplir la cruche de " ?capacite " litres ("
		    (implode$ $?avant) " " ?cruche " " ?capacite " " 
		    (implode$ $?apres) " )")
	   ?s remplir ; nouvelle situation obtenue par ?s en remplissant
	   ?avant ; cruches avant non remplies
	   ?cruche ?capacite ; cruche remplie
	   ?apres))) ; cruches apres non remplies


(defrule op-vider
  "Operateur vider"
  
  (not (situation ? ? ? $? 2 $?)) ; Il n'existe pas de situation
				; satisfaisante.
  
  ?s <- (situation ? ? ? $?avant ?cruche ?contenu $?apres) ; Considere une
					; situation quelconque.
  (cruche ?cruche ?capacite) ; la cruche consideree

  (not (situation ? ? ? ; La situation avec la la cruche videe
		  $?avant ; n'a pas deja ete obtenue.
		  ?cruche 0
		  $?apres))

  (test (> ?contenu 0)) ; La cruche n'est pas deja vide.
  =>
  (assert (situation ; description precalculee
	   (str-cat "Vider la cruche de " ?capacite " litres ("
		    (implode$ $?avant) " " ?cruche " " 0 " " 
		    (implode$ $?apres) " )")
	   ?s vider ; nouvelle situation obtenue par ?s en vidant
	   ?avant ; cruches avant non videes
	   ?cruche 0 ; cruche videe
	   ?apres))) ; cruches apres non videes


					
(defrule op-transvaser-1 ; Transvase de cruche1 vers cruche2
  "Operateur transvaser 1->2 (droite-gauche)"

  (not (situation ? ? ? $? 2 $?)) ; Il n'existe pas de situation
				; satisfaisante.

  ?s <- (situation ? ? ? ; Considere une situation quelconque.
		   $?avant 
		   ?cruche1 ?contenu1
		   ?cruche2 ?contenu2
		   $?apres) 
				
  (cruche ?cruche1 ?capacite1) ; capacite de la cruche1
  (cruche ?cruche2 ?capacite2) ; capacite de la cruche2

  (test (> ?capacite2 ?capacite1)) ; test si le transvasement est possible
  (test (> ?contenu1 0))
  (test (< ?contenu2 ?capacite2))

  =>
  (assert (situation 
	   (str-cat "Transvaser la cruche de " ?capacite1 ; description precalculee
		    " litres dans la cruche de " ?capacite2
		    " litres ("
		    (implode$ $?avant) " " 
		    ?cruche1 " " (+ ?contenu1 
				    (- ?contenu2 
				       (min ?capacite2 (+ ?contenu1 
							  ?contenu2)))) 
		    " " ?cruche2 " " (min ?capacite2 (+ ?contenu1 ?contenu2)) " "
		    (implode$ $?apres) " )")

	   ?s transvaser ; nouvelle situation basee sur ?s
					; par transvasement
	   $?avant ; cruches non modifiees
	   
	   ?cruche1 ; cruche1 apres transvasement
	   (+ ?contenu1 ; contenu de cruche1
	      (- ?contenu2 
		 (min ?capacite2 (+ ?contenu1 
				    ?contenu2))))
	   
	   ?cruche2 ; cruche2 apres transvasement
	   (min ?capacite2 (+ ?contenu1 ?contenu2)) ; contenu de cruche2
	   
	   $?apres))) ; cruches non modifiees


(defrule op-transvaser-2 ; Transvase de cruche2 vers cruche1
  "Operateur transvaser 2->1 (gauche-droite)"

  (not (situation ? ? ? $? 2 $?)) ; Il n'existe pas de situation
				; satisfaisante.

  ?s <- (situation ? ? ? ; Considere une situation quelconque.
		   $?avant 
		   ?cruche1 ?contenu1
		   ?cruche2 ?contenu2
		   $?apres) 
				
  (cruche ?cruche1 ?capacite1) ; capacite de la cruche1
  (cruche ?cruche2 ?capacite2) ; capacite de la cruche2

  (test (> ?capacite1 ?capacite2)) ; test si le transvasement est possible
  (test (> ?contenu2 0))
  (test (< ?contenu1 ?capacite1))

  =>
  (assert (situation 
	   (str-cat "Transvaser la cruche de " ?capacite2
		    " litres dans la cruche de " ?capacite1
		    " litres ("
		    (implode$ $?avant) " " 
		    ?cruche2 " " (+ ?contenu2 ; 
		     (- ?contenu1 
			(min ?capacite1 (+ ?contenu2 
					   ?contenu1)))) 
		    " " ?cruche1 " " (min ?capacite1 (+ ?contenu2 ?contenu1)) " " 
		    (implode$ $?apres) " )")
	   ?s transvaser ; nouvelle situation basee sur ?s
				   ; par transvasement
		  $?avant ; cruches non modifiees

		  ?cruche2 ; cruche2 apres transvasement
		  (+ ?contenu2 ; contenu de cruche2
		     (- ?contenu1 
			(min ?capacite1 (+ ?contenu2 
					   ?contenu1))))

		  ?cruche1 ; cruche1 apres transvasement
		  (min ?capacite1 (+ ?contenu2 ?contenu1)) ; contenu de cruche1

		  $?apres))) ; cruches non modifiees


(defrule success-1
  "Declenche la fonction recursive d'affiche"
  ?situation <- (situation ? ? ? $? 2 $?)
  =>
  (printout t "<< Solution trouvée >>" crlf)
  (display-path$ ?situation))

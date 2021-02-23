# Sisteme de gestiune a bazelor de date
## _Proiectarea și Interogarea unei baze de date pt DSP_ 
Proiect care cuprinde:
- proiectarea unei baze de date pentru DSP, 
- implementarea unor subprograme utile în vederea gestionarii pacientilor infectați, spitalizați și carantinați din cauza virusului covid 19 cât și a personalului DSP,
- un pachet care conține tipuri de date complexe și obiecte necesare unor actiuni integrate pentru gestionarea persoanelor infectate.
- triggeri LMD și LDD

## Diagrama entintate-relație

Baza de date se împarte în 3 cateorii:
1. Sistemul central de organizare. Acesta cuprinde angajații care pot fi de 3 feluri: 
   - programatorii care lucrează pe proiecte (de exemplu site-uri, aplicații web, robot telefonic) cu un anumit limbaj de programare.
   - agenții teritoriali care investighează o anumită zonă( verifică dacă restaurantele, hotelurile și magazinele respectă normele de         distanțare socială)
	 - agenții sau operatorii call-center care răspund persoanelor la apeluri telefonice. Aceștia se află într-un centru dintr-o anumită        locație.
2.	Persoanele fizice. Acestea au un medic de familie, un pachet de servicii(ce conține o lista de servicii), se află într-o locatie și anunță că au simptome sau au intrat în contact cu o persoană infectată. Li se poate lua un test covid, rezultatul acestuia este trecut în tabela lor în campul test_covid care are tipul Bool, adică în Oracle, Number(1) : 0 pt pacientii negativi, 1 pt pacientii pozitivi. Data testului este trecută în câmpul de tip date, data_testare.

![Diagrama ER1](https://github.com/iuga-paula/Sisteme-de-gestiune-a-bazelor-de-date/blob/Screenshots-%26%26-Demos/DER1.png)

## Diagrama conceptuală


## Fișiere
- [Codul proiectului](https://github.com/iuga-paula/Sisteme-de-gestiune-a-bazelor-de-date/blob/main/Proiect_DSP.sql)
- [Documentația proiectului](https://github.com/iuga-paula/Sisteme-de-gestiune-a-bazelor-de-date/blob/main/Documentatie_proiect_DSP.pdf)




## _Optimizarea codului PL\SQL_ ###_-referat_
Pl/SQL, SQL, SQL*PLUS, ORACLE

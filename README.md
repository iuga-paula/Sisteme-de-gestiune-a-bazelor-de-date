# Sisteme de gestiune a bazelor de date
# _Proiectarea și Interogarea unei baze de date pt DSP_ 
Proiect care cuprinde:
- proiectarea unei baze de date pentru DSP, 
- implementarea unor subprograme utile în vederea gestionarii pacientilor infectați, spitalizați și carantinați din cauza virusului covid 19 cât și a personalului DSP,
- un pachet care conține tipuri de date complexe și obiecte necesare unor actiuni integrate pentru gestionarea persoanelor infectate.
- triggeri LMD și LDD


## Tehnologii folosite:
Proiectul a fost creat în **Sql Developer** folosind o baza de data locala creata cu ajutorul **Oracle Database 11gR2 Express Edition**.
* Pl/SQL,
* SQL, 
* SQL*PLUS


## Diagrama entintate-relație
Baza de date se împarte în 3 cateorii:
1. Sistemul central de organizare. Acesta cuprinde angajații care pot fi de 3 feluri: 
	 - programatorii care lucrează pe proiecte (de exemplu site-uri, aplicații web, robot telefonic) cu un anumit limbaj de programare.
   - agenții teritoriali care investighează o anumită zonă( verifică dacă restaurantele, hotelurile și magazinele respectă normele de distanțare socială)
   - agenții sau operatorii call-center care răspund persoanelor la apeluri telefonice. Aceștia se află într-un centru dintr-o anumită locație.
2. Persoanele fizice. Acestea au un medic de familie, un pachet de servicii(ce conține o lista de servicii), se află într-o locatie și anunță că au simptome sau au intrat în          contact cu o persoană infectată. Li se poate lua un test covid, rezultatul acestuia este trecut în tabela lor în campul test_covid care are tipul Bool, adică în Oracle,            Number(1) : 0 pt pacientii negativi, 1 pt pacientii pozitivi. Data testului este trecută în câmpul de tip date, data_testare.
3. Sistemul medical. Acesta cuprinde spitalele. In spitale lucreaza medici de familie iar unele spitale sunt suport covid adică aici se internează persoanele grav afectate de      virus. 

![Diagrama entitate-relatie1](https://github.com/iuga-paula/Sisteme-de-gestiune-a-bazelor-de-date/blob/Screenshots-%26%26-Demos/DER1.png)
![Diagrama entitate-relatie2](https://github.com/iuga-paula/Sisteme-de-gestiune-a-bazelor-de-date/blob/Screenshots-%26%26-Demos/DER2.png)

## Diagrama conceptuală
![Diagrama conceptuala1](https://github.com/iuga-paula/Sisteme-de-gestiune-a-bazelor-de-date/blob/Screenshots-%26%26-Demos/DC1.png)
![Diagrama conceptuala2](https://github.com/iuga-paula/Sisteme-de-gestiune-a-bazelor-de-date/blob/Screenshots-%26%26-Demos/DC2.png)

## Fișiere
- [Codul proiectului](https://github.com/iuga-paula/Sisteme-de-gestiune-a-bazelor-de-date/blob/main/Proiect_DSP.sql)
- [Documentația proiectului](https://github.com/iuga-paula/Sisteme-de-gestiune-a-bazelor-de-date/blob/main/Documentatie_proiect_DSP.pdf)






# _Optimizarea codului PL\SQL_ 
Referatul raspunde la urmatoarele întrebări:
* Ce greseli sunt de evitat atunci cand vrem să scriem un cod optim?
* Cum putem eficientiza codul PL/SQL?

## Cuprins
- Subroprogram inlining
- Proprietăți PL\SQL care îmbunătațesc timpul de execuție pt. comenzile SQL
  - FORALL în loc de FOR pentru structuri repetitve de INSERT, DELETE, UPDATE
  - Bulk collect în loc de select into repetitiv
- Warninguri
- Funcții de sistem pentru prelucrarea stringurilor


## Tehnologii folosite
Exemplele din referat au fost scrise în **Sql Developer** folosind:
* Pl/SQL,
* SQL, 
* SQL*PLUS


## Fișiere
[Referatul]() 

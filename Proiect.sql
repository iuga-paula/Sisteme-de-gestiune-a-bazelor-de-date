--4
CREATE OR REPLACE
TYPE TIP_SERVICII IS VARRAY(10) OF VARCHAR(20);
/

CREATE TABLE Pachet_servicii
(
Id_pachet INTEGER NOT NULL PRIMARY KEY,
Descriere VARCHAR2(200),
Titlu VARCHAR(25)
);

ALTER TABLE Pachet_servicii ADD Servicii TIP_SERVICII;

CREATE TABLE PERSOANE
(
Id_persoana INTEGER NOT NULL PRIMARY KEY,
Nume VARCHAR(25) NOT NULL,
Prenume VARCHAR(25) NOT NULL,
Telefon VARCHAR(10),
DATA_NASTERII DATE,
Test_covid  Number(1),---Boolean, se pare ca sql nu are bool asa ca voi folosi number(1)
Id_medic INTEGER NOT NULL,
Id_locatie INTEGER NOT NULL,
Id_pachet INTEGER
);

ALTER TABLE PERSOANE 
ADD Data_testare DATE;

CREATE TABLE medici_familie
(
id_medic INTEGER NOT NULL PRIMARY KEY,
nume VARCHAR(25),
prenume VARCHAR(25),
Id_spital INTEGER
);

CREATE TABLE Spitale
(
Id_spital INTEGER NOT NULL PRIMARY KEY,
Nume VARCHAR(25),
Id_locatie INTEGER
);

CREATE TABLE Spitale_suport
(
Id_spital INTEGER NOT NULL PRIMARY KEY,
Capacitate_paturi NUMERIC(10,0),
Paturi_ocupate NUMERIC(10,0)
);

CREATE TABLE  Internari
(
Id_persoana INTEGER NOT NULL,
Id_spital INTEGER NOT NULL,
Data_inceput DATE not null,
Data_iesire DATE,
PRIMARY KEY (Id_persoana, Id_spital, Data_inceput) -- un pacient se poate interna la date diferite in acelasi spital
);


CREATE TABLE Locatii
(
Id_locatie INTEGER NOT NULL PRIMARY KEY,
Oras VARCHAR(40),
Sector VARCHAR(25),
Judet VARCHAR(25),
Strada VARCHAR(25),
Numar NUMERIC(3,0),
Cod_postal NUMERIC(6,0)
);

CREATE TABLE Apeleaza
(
Id_persoana INTEGER NOT NULL,
Id_angajat INTEGER NOT NULL,
Data_apel DATE NOT NULL,
DURATA NUMERIC(3,2),
PRIMARY KEY (Id_persoana, Id_angajat),
CONSTRAINT A_chk_durata CHECK (DURATA <120) 
);

CREATE TABLE Centre
(
Id_centru INTEGER NOT NULL PRIMARY KEY,
Nume VARCHAR(25),
Capacitate_birouri NUMERIC(5,0),
Nr_fax NUMERIC(12,0),
Id_locatie INTEGER,
Id_sef INTEGER
);

CREATE TABLE ANGAJATI
(
Id_angajat INTEGER NOT NULL PRIMARY KEY,
Nume VARCHAR(25) NOT NULL,
Prenume VARCHAR(25) NOT NULL,
Telefon VARCHAR(10),
Email VARCHAR(25),
Data_nasterii DATE,
Salariu NUMERIC(10,3)
);

CREATE TABLE Agent_call_center
(
Id_angajat INTEGER NOT NULL PRIMARY KEY,
Lucreaza_partime NUMBER(1),
Id_centru INTEGER
);

CREATE TABLE Agent_teritorial
(
Id_angajat INTEGER NOT NULL PRIMARY KEY,
Sporuri_risc NUMERIC(5,3),
Id_locatie INTEGER
);

CREATE TABLE Programatori
(
Id_angajat INTEGER NOT NULL PRIMARY KEY,
Specializare_limbaj VARCHAR(45)
);

CREATE TABLE Lucreaza_la
(
Id_angajat INTEGER NOT NULL,
Id_proiect INTEGER NOT NULL,
Data_sfarsit DATE,
PRIMARY KEY (Id_proiect, Id_angajat)
);

CREATE TABLE Proiect
(
Id_proiect INTEGER NOT NULL PRIMARY KEY,
Start_date DATE,
Limbaj_programare VARCHAR(25),
Deadline DATE
);


ALTER TABLE Persoane
ADD CONSTRAINT P_FK FOREIGN KEY(Id_medic) REFERENCES  Medici_Familie(Id_medic);

ALTER TABLE Persoane
ADD CONSTRAINT P_FK2 FOREIGN KEY(Id_pachet) REFERENCES  Pachet_Servicii(Id_pachet);

ALTER TABLE Persoane
ADD CONSTRAINT p_FK3 FOREIGN KEY(Id_locatie) REFERENCES Locatii(Id_locatie);

ALTER TABLE Medici_Familie 
ADD CONSTRAINT MF_FK FOREIGN KEY(Id_spital) REFERENCES Spitale(Id_spital);

ALTER TABLE Spitale
ADD CONSTRAINT S_FK FOREIGN KEY(Id_locatie) REFERENCES Locatii(Id_locatie);

ALTER TABLE Spitale_Suport
ADD CONSTRAINT SS_FK FOREIGN KEY(Id_spital) REFERENCES Spitale(Id_spital);

ALTER TABLE Internari
ADD CONSTRAINT I_FK FOREIGN KEY(Id_persoana) REFERENCES Persoane(Id_persoana);

ALTER TABLE Internari
ADD CONSTRAINT I_FK2 FOREIGN KEY(Id_spital) REFERENCES Spitale(Id_spital);

ALTER TABLE Apeleaza
ADD CONSTRAINT A_FK FOREIGN KEY(Id_persoana) REFERENCES Persoane(Id_persoana);

ALTER TABLE Apeleaza
ADD CONSTRAINT A_FK2 FOREIGN KEY(Id_angajat) REFERENCES Agent_call_center(Id_angajat);

ALTER TABLE Centre
ADD CONSTRAINT C_FK FOREIGN KEY(Id_locatie) REFERENCES Locatii(Id_locatie);

ALTER TABLE Centre
ADD CONSTRAINT C_FK2 FOREIGN KEY(Id_sef) REFERENCES Angajati(Id_angajat);

ALTER TABLE Agent_call_center
ADD CONSTRAINT Ag_FK FOREIGN KEY(Id_angajat) REFERENCES Angajati(Id_angajat);

ALTER TABLE Agent_call_center
ADD CONSTRAINT Ag_FK2 FOREIGN KEY(Id_centru) REFERENCES Centre(Id_centru);

ALTER TABLE Agent_teritorial
ADD CONSTRAINT Agt_FK FOREIGN KEY(Id_angajat) REFERENCES Angajati(Id_angajat);

ALTER TABLE Agent_teritorial
ADD CONSTRAINT Agt_FK2 FOREIGN KEY(Id_locatie) REFERENCES Locatii(Id_locatie);

ALTER  TABLE Programatori
ADD CONSTRAINT PR_FK FOREIGN KEY(Id_angajat) REFERENCES Angajati(Id_angajat);


ALTER  TABLE Lucreaza_la
ADD CONSTRAINT L_FK FOREIGN KEY(Id_angajat) REFERENCES Programatori(Id_angajat);

ALTER  TABLE Lucreaza_la
ADD CONSTRAINT L_FK2 FOREIGN KEY(Id_proiect) REFERENCES Proiect(Id_proiect);


--5
INSERT INTO LOCATII
VALUES(1,'Brasov', NULL, 'Brasov', 'Muresenilor', 24, 505600);

INSERT INTO LOCATII
VALUES(2,'Zarnesti', NULL, 'Brasov', 'Zorilor', null, 505800);

INSERT INTO LOCATII
VALUES(3, 'Codlea', NULL, 'Brasov', 'Apolodor', 10, 505900);

INSERT INTO LOCATII
VALUES(4, 'Harman', NULL, 'Brasov', 'Hiercher', 8, 505700);

INSERT INTO LOCATII
VALUES(5,'Brasov', NULL, 'Brasov', 'Florilor', 13, 505600);

INSERT INTO LOCATII
VALUES(6,'Bucuresti', '3', 'Bucuresti', 'Gura Calitei', 24 ,100590);

INSERT INTO LOCATII
VALUES(7,'Bucuresti', '4', 'Bucuresti', 'Marioara', 10 ,101590);

INSERT INTO LOCATII
VALUES(8,'Bucuresti', '1', 'Bucuresti', 'Academiei', null ,100690);

INSERT INTO LOCATII
VALUES(9,'Bucuresti', '1', 'Bucuresti', 'Aerodromului', 9 ,100690);


INSERT INTO PROIECT
VALUES(1, SYSDATE, 'Python',  TO_DATE('11-12-2021', 'MM-DD-YYYY'));

INSERT INTO PROIECT
VALUES(2, TO_DATE('11-12-2020', 'MM-DD-YYYY'), 'C++',  TO_DATE('11-04-2021', 'MM-DD-YYYY'));

INSERT INTO PROIECT
VALUES(3, TO_DATE('08-12-2020', 'MM-DD-YYYY'), 'C++',  TO_DATE('01-01-2021', 'MM-DD-YYYY'));

INSERT INTO PROIECT
VALUES(4, sysdate, 'PHP',  TO_DATE('09-01-2021', 'MM-DD-YYYY'));


INSERT INTO PACHET_SERVICII
VALUES(1, 'Pachet complet analize si spitalizare', 'Pachet_Golden', tip_servicii('Analize sange', 'Ecografii', 'Internari', 'Tratament compensat'));

INSERT INTO PACHET_SERVICII
VALUES(2, 'Pachet doar pt analize medicale', 'Pachet_Silver', tip_servicii('Analize sange', 'Ecografii'));

INSERT INTO PACHET_SERVICII
VALUES(3, 'Pachet pt medicamente  si tratamente', 'Pachet_White', tip_servicii('Pastile compensate','Analize sange', 'Tratamente fizio'));


INSERT INTO ANGAJATI
VALUES (1, 'Popa', 'Andrei',  '0772298777', 'andreip@mail.com', TO_DATE('09-01-1970', 'MM-DD-YYYY'),3500);

INSERT INTO ANGAJATI
VALUES (2, 'Popa', 'Diana Sandra',  '0770178777', 'popasandrad@mail.com', TO_DATE('08-14-1975', 'MM-DD-YYYY'),3500);

INSERT INTO ANGAJATI
VALUES (3, 'Anton', 'Ileana',  '0770178112', 'antonile@mail.com', TO_DATE('10-30-1975', 'MM-DD-YYYY'), 4500);

INSERT INTO ANGAJATI
VALUES (4, 'Antonescu', 'Marcel',  '0720938112', 'antonescu.marcel@mail.com', TO_DATE('10-31-1976', 'MM-DD-YYYY'), 4500);

INSERT INTO ANGAJATI
VALUES (5, 'Petru', 'Rares',  '0720938132', 'petcu_raresica@mail.com', TO_DATE('04-11-1988', 'MM-DD-YYYY'), 4500);

INSERT INTO ANGAJATI
VALUES (6, 'Mircea', 'David',  '0720008132', 'mircea_dav@mail.com', TO_DATE('04-11-1991', 'MM-DD-YYYY'), 4500);

INSERT INTO ANGAJATI
VALUES (7, 'Popescu', 'Denisa Antonia',  '0751208132', 'popescu_antoniaD@mail.com', TO_DATE('06-12-1991', 'MM-DD-YYYY'), 4500);

INSERT INTO ANGAJATI
VALUES (8, 'Arens', 'Patricia',  '0721248149', 'arensPatty@mail.com', TO_DATE('02-16-1993', 'MM-DD-YYYY'), 5000);

INSERT INTO ANGAJATI
VALUES (9, 'Wentzel', 'Sandra',  '0720009992', 'wentzelSandra@mail.com', TO_DATE('04-17-1991', 'MM-DD-YYYY'), 5000);

INSERT INTO ANGAJATI
VALUES (10, 'Marginean', 'Laurentiu',  '0721234132', 'margineanL@mail.com', TO_DATE('05-25-1990', 'MM-DD-YYYY'), 5000);

INSERT INTO ANGAJATI
VALUES (11, 'Serban', 'Ionela',  '0722489136', 'SerbanIonela@mail.com', TO_DATE('06-15-1990', 'MM-DD-YYYY'), 5000);

INSERT INTO ANGAJATI
VALUES (12, 'Serban', 'Ioan',  '0722489137', 'SerbanIoan@mail.com', TO_DATE('06-15-1991', 'MM-DD-YYYY'), 5000);

INSERT INTO ANGAJATI
VALUES (13, 'Costin', 'Daniel',  '0722455166', 'CostiD@mail.com', TO_DATE('08-21-1990', 'MM-DD-YYYY'), 3000);

INSERT INTO ANGAJATI
VALUES (15, 'Alexe', 'Stefania',  '0722489117', 'AlexeStefi@mail.com', TO_DATE('06-29-1990', 'MM-DD-YYYY'), 5000);


ALTER TABLE Agent_teritorial
MODIFY (SPORURI_RISC NUMERIC(7,3) DEFAULT 1000);

INSERT INTO Agent_teritorial
values (5, null, 1);

INSERT INTO Agent_teritorial (Id_angajat, Id_locatie)
values(6, 4);

INSERT INTO Agent_teritorial (Id_angajat, Id_locatie)
values(4, 6);


INSERT INTO Programatori
VALUES (1, 'C++');

INSERT INTO Programatori
VALUES (2, 'C++');

INSERT INTO Programatori
VALUES (3, 'PHP');

INSERT INTO Programatori
VALUES (7, 'PYTHON');

INSERT INTO Programatori
VALUES (8, 'PYTHON');

SELECT * FROM Proiect;

INSERT INTO Lucreaza_la
VALUES(1, 2, null);

INSERT INTO Lucreaza_la
VALUES(2, 2, null);

INSERT INTO Lucreaza_la
VALUES(7, 1, null);

INSERT INTO Lucreaza_la
VALUES(8, 1, null);

INSERT INTO Lucreaza_la
VALUES(3, 4, null);

INSERT INTO Lucreaza_la
Values(7, 4, null);


INSERT INTO Centre
VALUES (1, 'Centru DSP Bv1', 500, 123456789000, 1, 11);

INSERT INTO Centre
VALUES (2, 'Centru DSP Buc1', 1000, 123456232000, 8, 10);

INSERT INTO Centre
VALUES (3, 'Centru DSP Buc2', 2000, 122956232000, 7, 9);


INSERT INTO Agent_call_center
VALUES(9, 0, 3);

INSERT INTO Agent_call_center
VALUES(11, 0, 1);

INSERT INTO Agent_call_center
VALUES(12, 1, 1);

INSERT INTO Agent_call_center
VALUES(13, 1, 1);

INSERT INTO Agent_call_center
VALUES(8, 0, 2);

INSERT INTO Agent_call_center
VALUES(1, 0, 2);

INSERT INTO Agent_call_center
VALUES(3, 0, 2);



INSERT INTO Spitale
VALUES (1, 'Regina Maria', 1);

INSERT INTO Spitale
VALUES (2, 'Caius Sparchez', 2);

INSERT INTO Spitale
VALUES (3, 'Sf Anton', 3);

INSERT INTO Spitale
VALUES (4, 'Infectioase', 5);

INSERT INTO Spitale
VALUES (5, 'Matei Bals', 8);

INSERT INTO Spitale
VALUES (6, 'Matei Basarab', 9);


INSERT INTO Spitale_Suport
VALUES (4, 2000, 100);

INSERT INTO Spitale_Suport
VALUES (2, 40, 10);

INSERT INTO Spitale_Suport
VALUES (5, 4000, 500);


INSERT INTO Medici_familie
VALUES(1, 'Pleasa', 'Mirela', 1);

INSERT INTO Medici_familie
VALUES(3, 'Matasa', 'Ciprian', 1);

INSERT INTO Medici_familie
VALUES(4, 'Iustin', 'Alin', 1);

INSERT INTO Medici_familie
VALUES(2, 'Petrica', 'Radu', 2);

INSERT INTO Medici_familie
VALUES(5, 'Amariei', 'Natalia', 2);



INSERT INTO Persoane
VALUES (1, 'Popei', 'Stefan', '0773398405', TO_DATE('06-15-1960', 'MM-DD-YYYY'), 1, 1, 2, 1, TO_DATE('12-28-2021', 'MM-DD-YYYY'));

INSERT INTO Persoane
VALUES (2, 'Anghel', 'Marius', '0733349405', TO_DATE('06-15-1959', 'MM-DD-YYYY'), 0, 3, 1, 1, sysdate);

INSERT INTO Persoane
VALUES (3, 'Jidau', 'Marian', '0733249400', TO_DATE('06-20-1965', 'MM-DD-YYYY'), 0, 4, 2, 2, sysdate);

INSERT INTO Persoane
VALUES (8, 'Iulius', 'Andrei', '0733249400', TO_DATE('06-20-1965', 'MM-DD-YYYY'), 0, 1, 3, 2, SYSDATE);

INSERT INTO Persoane
VALUES (4, 'Stefanos', 'Anton', '0733249400', TO_DATE('06-20-1965', 'MM-DD-YYYY'), 1, 4, 2, 2,  TO_DATE('12-02-2020', 'MM-DD-YYYY'));

INSERT INTO Persoane
VALUES (5, 'Jerau', 'Cosmin', '0733249225', TO_DATE('06-20-1999', 'MM-DD-YYYY'), 1, 2, 3, 3,  TO_DATE('12-10-2020', 'MM-DD-YYYY'));

INSERT INTO Persoane
VALUES (6, 'Jerau', 'Antonia', '0733249225', TO_DATE('06-20-1999', 'MM-DD-YYYY'), 1, 2, 3, 3,  TO_DATE('12-11-2020', 'MM-DD-YYYY'));

INSERT INTO Persoane
VALUES (7, 'Jerau', 'Antonia', '0733249225', TO_DATE('07-05-1999', 'MM-DD-YYYY'), 1, 2, 4, 1,  TO_DATE('12-06-2020', 'MM-DD-YYYY'));

INSERT INTO Persoane
VALUES (9, 'Moisecu', 'Marin', '0733249420', TO_DATE('06-20-1965', 'MM-DD-YYYY'), 1, 4, 2, 3, sysdate);


INSERT INTO Internari
VALUES(4,1,sysdate, sysdate + 14);

INSERT INTO Internari
VALUES(4,2,TO_DATE('12-02-2020', 'MM-DD-YYYY'), TO_DATE('12-02-2020', 'MM-DD-YYYY') + 14);

INSERT INTO Internari
VALUES(6,1,sysdate, sysdate + 14);

INSERT INTO Internari
VALUES(6,1,TO_DATE('06-20-1999', 'MM-DD-YYYY'), TO_DATE('06-20-1999', 'MM-DD-YYYY') + 14);

INSERT INTO Internari
VALUES(7,5, TO_DATE('12-06-2020','MM-DD-YYYY'),  TO_DATE('12-06-2020', 'MM-DD-YYYY') + 14);


select * from agent_call_center;

ALTER TABLE APELEAZA
MODIFY (Durata NUMERIC(4,0)); 

INSERT INTO Apeleaza
values(2, 9, sysdate, 5);

INSERT INTO Apeleaza
values(4, 11, sysdate, 10);

INSERT INTO Apeleaza
VALUES(4, 8, SYSDATE, 100);

INSERT INTO Apeleaza
VALUES(5, 13, SYSDATE, 15);

INSERT INTO Apeleaza
VALUES(5, 1, TO_DATE('12-06-2020', 'MM-DD-YYYY'), 15);

SELECT * FROM Persoane;
SELECT * FROM Internari;

--6
SET SERVEROUTPUT ON;

CREATE OR REPLACE TYPE pers_pachet IS OBJECT (cod_pesoana INTEGER, data_test DATE, pachet_servicii tip_servicii);
/


CREATE OR REPLACE PROCEDURE plata_spitalizare(nr_pers_pachet OUT NUMBER, nr_pers_fara_pachet OUT  NUMBER) 
IS
TYPE tablou_imbricat IS TABLE OF pers_pachet;
t tablou_imbricat := tablou_imbricat(); 
v_id_pers persoane.Id_persoana%TYPE;
v_id_pachet persoane.Id_pachet%TYPE;
v_data persoane.Data_testare%TYPE;
v_pachet tip_servicii;
contor NUMBER;
contor2 NUMBER;
v_ok NUMBER;
v_ok2 NUMBER;
v_nr NUMBER;

BEGIN

    nr_pers_pachet := 0;
    nr_pers_fara_pachet := 0;
    contor := 1;
    
    FOR i in (SELECT Id_persoana, Id_pachet, Data_testare
              FROM Persoane
              WHERE test_covid = 1
              ORDER BY Id_persoana)
         
          
      LOOP
      SELECT servicii INTO v_pachet
      FROM pachet_servicii
      WHERE Id_pachet = i.Id_pachet;
      
      t.EXTEND;
      t(contor) := pers_pachet(i.Id_persoana, i.Data_testare, v_pachet);
      contor := contor + 1;
      END LOOP;
      
      FOR j IN t.FIRST..t.LAST
      LOOP
      DBMS_OUTPUT.PUT('Persoana cu id-ul ' || t(j).cod_pesoana || ' are test pozitiv si pachetul << ');
      
      v_ok := 0;
      v_nr := 0;
      FOR k IN t(j).pachet_servicii.FIRST..t(j).pachet_servicii.LAST
      LOOP
       DBMS_OUTPUT.PUT(t(j).pachet_servicii(k) || ' ');
       IF 'Internari' = t(j).pachet_servicii(k) AND v_ok = 0 THEN
         
         v_ok := 1;
         nr_pers_pachet := nr_pers_pachet + 1;
         
       END IF; 
       END LOOP;
       DBMS_OUTPUT.PUT('>> ');
       IF v_ok = 0 THEN --nu are pachet care sa contina internari deci trebuie sa le plateasca
         DBMS_OUTPUT.PUT(' trebuie sa plateasca internarile ');
         v_ok2 := 0;
         SELECT count(*) INTO v_nr
         FROM spitale S JOIN internari i ON (S.id_spital = i.id_spital)
                   WHERE i.id_persoana = t(j).cod_pesoana;
                   
          IF v_nr = 0 THEN
          DBMS_OUTPUT.PUT( 'viitoare si nu s-a internat pana acum');
          END IF;
          
         FOR l IN (SELECT nume
                   FROM spitale S JOIN internari i ON (S.id_spital = i.id_spital)
                   WHERE i.id_persoana = t(j).cod_pesoana)
        LOOP
        IF v_ok2 = 0 THEN
            DBMS_OUTPUT.PUT('la ');
             DBMS_OUTPUT.PUT('*'||l.nume || '* ');
            v_ok2 := 1;
        ELSE
          DBMS_OUTPUT.PUT('*'||l.nume || '* ');
        END IF;
        END LOOP;
        ELSE
          DBMS_OUTPUT.PUT(' nu trebuie sa plateasca internarile');
        END IF;
        DBMS_OUTPUT.NEW_LINE();
      END LOOP;
      
    
      SELECT count(*) INTO nr_pers_fara_pachet
      FROM Persoane
      where Test_covid = 1;
      
      nr_pers_fara_pachet := nr_pers_fara_pachet - nr_pers_pachet;
      
    
END plata_spitalizare;
/

DECLARE
v_nr1 NUMBER;
v_nr2 NUMBER;
BEGIN
plata_spitalizare(v_nr1, v_nr2);
DBMS_OUTPUT.PUT_LINE('Numarul de persoane care au achizitionat un pachet CU internari este: ' || v_nr1);
DBMS_OUTPUT.PUT_LINE('Numarul de Persoane care au achizitionat un pachet FARA internari este: ' || v_nr2);
END;
/

--7
SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION numar_pachete_internare RETURN NUMBER
IS
TYPE refcursor IS REF CURSOR;
CURSOR c1 IS
  SELECT Id_pachet, Titlu,
        CURSOR(SELECT S.*
               FROM pachet_servicii P2, TABLE (P2.servicii) S
               WHERE P2.Id_Pachet = P.Id_Pachet)
  FROM Pachet_servicii P;

cursor_aux refcursor;
v_id Pachet_servicii.Id_pachet%TYPE;
v_titlu Pachet_servicii.Titlu%TYPE;
v_nr NUMBER;
serviciu varchar(20);

BEGIN
  v_nr := 0;
  OPEN c1;
  LOOP
    FETCH c1 INTO v_id, v_titlu, cursor_aux;
    EXIT WHEN c1%NOTFOUND;
    LOOP
        FETCH cursor_aux INTO serviciu;
        EXIT WHEN cursor_aux%NOTFOUND;
        IF 'Internari' = Initcap(serviciu) THEN
          v_nr := v_nr + 1;
          DBMS_OUTPUT.PUT_LINE('PACHETUL ' || v_id || ' CU NUMELE ' || v_titlu || ' contine internari');
        END IF;
    END LOOP;
  END LOOP;
  CLOSE c1;
  
  RETURN v_nr;
  IF v_nr = 0 THEN
  RAISE_APPLICATION_ERROR(-20001,'Nu exista pachet cu internare!');
  RETURN -1;
  END IF;
END numar_pachete_internare;
/

VARIABLE nr NUMBER
EXECUTE :nr := numar_pachete_internare;
PRINT nr

--8
SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION date_programator(param_nume Angajati.Nume%TYPE) RETURN FLOAT
IS
v_id Angajati.Id_angajat%TYPE;
date_proiect Proiect%ROWTYPE;
procent_salariu FLOAT := 0.00;
specialitate Programatori.Specializare_limbaj%TYPE;
nr_proiecte NUMBER;
contor NUMBER := 0;
sal_total Angajati.Salariu%TYPE;
sal Angajati.Salariu%TYPE;

CURSOR c(param Angajati.Id_angajat%TYPE) IS
    SELECT Id_Proiect 
    FROM Lucreaza_la
    where Id_angajat = param;

BEGIN
BEGIN
SELECT Id_angajat INTO v_id
FROM Programatori JOIN Angajati  USING (Id_Angajat)
WHERE Nume = param_nume;
EXCEPTION 
  WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20000, 'Nu exista programator cu numele dat!');
      RETURN -1.00;
  WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi programatori cu numele dat!');
      RETURN -2.00;
  WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'S-a generat alta eroare!');
      RETURN -3.00;
END;
     
BEGIN 
    SELECT Specializare_limbaj INTO specialitate
    FROM Programatori
    WHERE Id_Angajat = v_id;
    IF specialitate is null THEN
          RAISE_APPLICATION_ERROR(-20003, 'Progamatorului cu numele ' || param_nume || ' nu i s-a atribuit o specialziare!');
          RETURN -4.00;   
    END IF;

END;


BEGIN
SELECT COUNT(*) INTO nr_proiecte
FROM Lucreaza_la
WHERE Id_angajat = v_id
GROUP BY Id_angajat;
 EXCEPTION 
      WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20005, 'Progamatorului cu numele ' || param_nume || ' nu are proiecte!');
          RETURN -5.00; 
END;

DBMS_OUTPUT.PUT_LINE('Progamatorul cu numele ' || param_nume || ' lucreaza in prezent pe ' || nr_proiecte || ' proiecte si are specializarea ' || specialitate);

IF nr_proiecte <> 0 THEN --daca lcureaza pe mai mult de 0 proiecte vedem care sunt
  FOR i IN c(v_id) LOOP
      SELECT * INTO date_proiect
      FROM PROIECT
      WHERE Id_proiect = i.Id_proiect;
      DBMS_OUTPUT.PUT_LINE('Proiectul cu nr de ordine ' || contor || ' are startdate ' || date_proiect.Start_date || ' deadline ' || date_proiect.Deadline || ' si este lucrat in limbajul ' || date_proiect.Limbaj_programare);
      contor := contor + 1;
  END LOOP; 
END IF;
  
SELECT SUM(NVL(Salariu,0)) INTO sal_total
FROM ANGAJATI;

BEGIN 
SELECT Salariu INTO sal
FROM ANGAJATI
WHERE Id_angajat = v_id;
IF sal is null THEN
      RAISE_APPLICATION_ERROR(-20004, 'Programatorului ' || param_nume || ' nu i s-a alocat salariu!');
      RETURN -4.00;
END IF;


END;

procent_salariu := sal*100/sal_total;
RETURN procent_salariu;

END date_programator;
/

SELECT Id_angajat,nume
FROM Angajati JOIN Programatori USING (Id_angajat);

SELECT * FROM Lucreaza_la;


VARIABLE procent_salariu NUMBER
EXECUTE :procent_salariu :=date_programator('Arens');
PRINT procent_salariu

VARIABLE procent_salariu NUMBER
EXECUTE :procent_salariu :=date_programator('Popescu');
PRINT procent_salariu

VARIABLE procent_salariu NUMBER
EXECUTE :procent_salariu :=date_programator('Popa');
PRINT procent_salariu

VARIABLE procent_salariu NUMBER
EXECUTE :procent_salariu :=date_programator('Amariei');
PRINT procent_salariu

--inseram un programator fara proiecte se observa ca exceptia de proiecte era prinsa inaintea celei de salariu null
INSERT INTO ANGAJATI
VALUES (16, 'Matei', 'Aelxandru',  '0720938672', 'mateiAlex@mail.com', TO_DATE('04-11-1988', 'MM-DD-YYYY'), NULL);

INSERT INTO PROGRAMATORI
VALUES (16,'Java');

VARIABLE procent_salariu NUMBER
EXECUTE :procent_salariu :=date_programator('Matei');
PRINT procent_salariu


--inseram un programator cu salariul null dar cu  proiecte
INSERT INTO ANGAJATI
VALUES (17, 'Constantinescu', 'David',  '0720932372', 'ConstDavid@mail.com', TO_DATE('04-11-1988', 'MM-DD-YYYY'), NULL);

INSERT INTO PROGRAMATORI
VALUES (17,'Java');

INSERT INTO Lucreaza_la
VALUES (17,2,null);


VARIABLE procent_salariu NUMBER
EXECUTE :procent_salariu :=date_programator('Constantinescu');
PRINT procent_salariu

--inseram un programator cu fara specialitate
INSERT INTO ANGAJATI
VALUES (18, 'Constantin', 'Ilie',  '0720932372', 'IlieC@mail.com', TO_DATE('04-11-1988', 'MM-DD-YYYY'), 300);

INSERT INTO PROGRAMATORI
VALUES (18,null);

VARIABLE procent_salariu NUMBER
EXECUTE :procent_salariu :=date_programator('Constantin');
PRINT procent_salariu


--9
ALTER TABLE Angajati
ADD CONSTRAINT Ang_sal_max
CHECK (salariu < 10000);

CREATE OR REPLACE PROCEDURE mareste_salariu(nume_spital IN Spitale.Nume%TYPE, nr_apeluri OUT NUMBER) 
IS
id_sp Spitale.Id_spital%TYPE;
max_apeluri NUMBER := 0;
v_nr NUMBER := 0;
v_id Angajati.Id_angajat%TYPE;
v_id_max Angajati.Id_angajat%TYPE;
v_sal Angajati.Salariu%TYPE;
                    
CHECK_CONSTRAINT_VIOLATED EXCEPTION;
PRAGMA EXCEPTION_INIT(CHECK_CONSTRAINT_VIOLATED, -2290);

BEGIN
  BEGIN
  SELECT Id_Spital INTO id_sp
  FROM Spitale
  WHERE Nume = nume_spital;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista spital cu numele dat!');
  END;
  
 BEGIN
  FOR i IN (SELECT COUNT(*) nr , Id_angajat id
          FROM Apeleaza
          WHERE Id_persoana in (SELECT Id_persoana
                                FROM Persoane P JOIN Medici_familie M ON (P.Id_medic = M.Id_medic) 
                                 JOIN Spitale S ON (M.Id_spital = S.Id_spital)
                                 WHERE S.Id_spital = id_sp)
          GROUP BY Id_angajat)
    LOOP
      IF (i.nr > max_apeluri) THEN
           max_apeluri := i.nr;
           v_id_max := i.id;
       END IF;
      
      END LOOP;

   
   nr_apeluri := max_apeluri;
   SELECT salariu INTO v_sal
   FROM angajati 
   WHERE id_angajat = v_id_max;
   
   DBMS_OUTPUT.PUT_LINE('Agentul call center cu id-ul ' || v_id_max || ' a avut cele mai multe apeluri ' || nr_apeluri || ' si are salariul initial de ' || v_sal);



  UPDATE Angajati
  SET salariu =  salariu * 10/100 + salariu
  WHERE id_angajat = v_id_max;
  
   
  EXCEPTION
  WHEN CHECK_CONSTRAINT_VIOLATED THEN  
   DBMS_OUTPUT.PUT_LINE('Salariul depaseste limita de 10000!');
 
END;

END mareste_salariu;
/

SELECT salariu
FROM angajati
where id_angajat = 1;
      
DECLARE
v_nr NUMBER;
BEGIN
mareste_salariu('Regina Maria',v_nr);
DBMS_OUTPUT.PUT_LINE('Numarul maxim de apeluri pt. spitalul introdus este: ' || v_nr);
END;
/

DECLARE
v_nr NUMBER;
BEGIN
mareste_salariu('Caius Sparez',v_nr);
DBMS_OUTPUT.PUT_LINE('Numarul maxim de apeluri pt. spitalul introdus este: ' || v_nr);
END;
/



DECLARE
v_nr NUMBER;
BEGIN
mareste_salariu('Caius Sparchez',v_nr);
DBMS_OUTPUT.PUT_LINE('Numarul maxim de apeluri pt. spitalul introdus este: ' || v_nr);
END;
/

SELECT * FROM angajati;
SELECT * FROM spitale;
SELECT * FROM apeleaza;

SELECT id_medic
FROM medici_familie
where id_spital = 1;

select id_persoana
FROM persoane
WHERE id_medic IN (1,4,3); --9 1 2 3 8 4

SELECT id_angajat
from agent_call_center; --- 3 8 9

INSERT 
INTO APELEAZA
values(9,9,sysdate,5);

INSERT 
INTO APELEAZA
values(1,9,sysdate,5);

UPDATE angajati
SET salariu = 9999
where Id_angajat = 1;
rollback;

--10
CREATE SEQUENCE id_info START WITH 1;

CREATE TABLE INFO_ANG
(  ID  INTEGER  NOT NULL PRIMARY KEY,
  user_name VARCHAR2(50),
  data_modif date,
  DESCRIERE VARCHAR2(100)
);

CREATE OR REPLACE TRIGGER info_angajati
AFTER INSERT OR UPDATE OR DELETE ON angajati
BEGIN
IF DELETING THEN
  INSERT INTO info_ang (user_name, data_modif, descriere)
  VALUES(SYS.LOGIN_USER, SYSDATE, ' s-a sters un anagajat');
  
ELSIF UPDATING THEN
      INSERT INTO info_ang (user_name, data_modif, descriere)
     VALUES(SYS.LOGIN_USER, SYSDATE, ' s-a modificat un anagajat');
  
ELSE 
     INSERT INTO info_ang (user_name, data_modif, descriere)
     VALUES(SYS.LOGIN_USER, SYSDATE, ' s-a inserat un anagajat');
END IF;
END info_angajati;
/

CREATE OR REPLACE TRIGGER pune_id 
BEFORE INSERT ON info_ang
FOR EACH ROW
BEGIN
  SELECT id_info.NEXTVAL
  INTO   :new.ID
  FROM   dual;
END;
/

DELETE FROM angajati
WHERE Id_Angajat = 15;

select * from info_ang;

UPDATE Angajati 
SET salariu = 4000
WHERE Id_angajat = 1;

SELECT * FROM info_ang;


--11
CREATE OR REPLACE TRIGGER verifica_loc_liber
FOR INSERT ON spitale_suport
compound TRIGGER

TYPE tablou_indexat IS TABLE OF Spitale_suport.Capacitate_paturi%TYPE
INDEX BY BINARY_INTEGER;
t tablou_indexat;
v_ok NUMBER;

BEFORE statement IS
BEGIN
SELECT count(*) 
BULK COLLECT INTO t
FROM Spitale_Suport SS JOIN Spitale S ON(SS.Id_spital = S.Id_spital)
GROUP BY S.Id_locatie;


END BEFORE statement;

AFTER EACH ROW IS
BEGIN
v_ok := 1;
FOR i IN 1..t.LAST
LOOP
IF t(i) + 1 > 2 THEN
  v_ok := 0;
  RAISE_APPLICATION_ERROR(-20005, 'Nu pot fi 2 spitale suport in aceeasi locatie!');
end if;
END LOOP;

IF v_ok <> 0 THEN
DBMS_OUTPUT.PUT_LINE('Inserare corecta');
END IF;
END AFTER EACH ROW;

END verifica_loc_liber;
/

SELECT Id_locatie FROM  --2 5 8
spitale_suport JOIN spitale USING (id_spital);

INSERT INTO Spitale
VALUES (7, 'Mircea cel batran', 2);


INSERT INTO Spitale_suport
values (7, 1000, 0); --inserare corecta

INSERT INTO Spitale
VALUES (8, 'Sf. Stefan ', 2);

INSERT INTO Spitale_suport
values (8, 1000, 0); 

SELECT * FROM spitale;
SELECT * FROM spitale_suport; --4 2 5

--12

CREATE TABLE info
(
user_name VARCHAR2(30),
eveniment VARCHAR2(20),
DATA DATE,
nume_obiect VARCHAR2(30)
);

CREATE OR REPLACE PROCEDURE insereaza(ev IN info.eveniment%TYPE, ob IN info.nume_obiect%TYPE)
IS
BEGIN
IF ob = 'INFO' THEN
 RAISE_APPLICATION_ERROR(-20005, 'Nu se poate modifica acest tabel');
END IF;
INSERT INTO info
VALUES(SYS.LOGIN_USER, ev, SYSDATE, ob);
END insereaza;
/


CREATE OR REPLACE TRIGGER ldd_trigger
BEFORE CREATE OR DROP OR ALTER ON SCHEMA
BEGIN

   insereaza(SYS.SYSEVENT,SYS.DICTIONARY_OBJ_NAME);

END;
/



DROP TABLE info_ang;
SELECT * FROM info;

DROP TABLE INFO;
select * from info;


--13
CREATE OR REPLACE PACKAGE pachet_complet AS


PROCEDURE insereaza(ev IN info.eveniment%TYPE, ob IN info.nume_obiect%TYPE);
PROCEDURE mareste_salariu(nume_spital IN Spitale.Nume%TYPE, nr_apeluri OUT NUMBER);
FUNCTION date_programator(param_nume Angajati.Nume%TYPE) RETURN FLOAT;
FUNCTION numar_pachete_internare RETURN NUMBER;
PROCEDURE plata_spitalizare(nr_pers_pachet OUT NUMBER, nr_pers_fara_pachet OUT  NUMBER);

END pachet_complet;
/



CREATE OR REPLACE PACKAGE BODY pachet_complet AS


PROCEDURE insereaza(ev IN info.eveniment%TYPE, ob IN info.nume_obiect%TYPE)
IS
BEGIN
IF ob = 'INFO' THEN
 RAISE_APPLICATION_ERROR(-20005, 'Nu se poate modifica acest tabel');
END IF;
INSERT INTO info
VALUES(SYS.LOGIN_USER, ev, SYSDATE, ob);
END insereaza;


PROCEDURE mareste_salariu(nume_spital IN Spitale.Nume%TYPE, nr_apeluri OUT NUMBER) 
IS
id_sp Spitale.Id_spital%TYPE;
max_apeluri NUMBER := 0;
v_nr NUMBER := 0;
v_id Angajati.Id_angajat%TYPE;
v_id_max Angajati.Id_angajat%TYPE;
v_sal Angajati.Salariu%TYPE;
                    
CHECK_CONSTRAINT_VIOLATED EXCEPTION;
PRAGMA EXCEPTION_INIT(CHECK_CONSTRAINT_VIOLATED, -2290);

BEGIN
  BEGIN
  SELECT Id_Spital INTO id_sp
  FROM Spitale
  WHERE Nume = nume_spital;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista spital cu numele dat!');
  END;
  
 BEGIN
  FOR i IN (SELECT COUNT(*) nr , Id_angajat id
          FROM Apeleaza
          WHERE Id_persoana in (SELECT Id_persoana
                                FROM Persoane P JOIN Medici_familie M ON (P.Id_medic = M.Id_medic) 
                                 JOIN Spitale S ON (M.Id_spital = S.Id_spital)
                                 WHERE S.Id_spital = id_sp)
          GROUP BY Id_angajat)
    LOOP
      IF (i.nr > max_apeluri) THEN
           max_apeluri := i.nr;
           v_id_max := i.id;
       END IF;
      
      END LOOP;

   
   nr_apeluri := max_apeluri;
   SELECT salariu INTO v_sal
   FROM angajati 
   WHERE id_angajat = v_id_max;
   
   DBMS_OUTPUT.PUT_LINE('Agentul call center cu id-ul ' || v_id_max || ' a avut cele mai multe apeluri ' || nr_apeluri || ' si are salariul initial de ' || v_sal);



  UPDATE Angajati
  SET salariu =  salariu * 10/100 + salariu
  WHERE id_angajat = v_id_max;
  
   
  EXCEPTION
  WHEN CHECK_CONSTRAINT_VIOLATED THEN  
   DBMS_OUTPUT.PUT_LINE('Salariul depaseste limita de 10000!');
 
END;
END mareste_salariu;


FUNCTION date_programator(param_nume Angajati.Nume%TYPE) RETURN FLOAT
IS
v_id Angajati.Id_angajat%TYPE;
date_proiect Proiect%ROWTYPE;
procent_salariu FLOAT := 0.00;
specialitate Programatori.Specializare_limbaj%TYPE;
nr_proiecte NUMBER;
contor NUMBER := 0;
sal_total Angajati.Salariu%TYPE;
sal Angajati.Salariu%TYPE;

CURSOR c(param Angajati.Id_angajat%TYPE) IS
    SELECT Id_Proiect 
    FROM Lucreaza_la
    where Id_angajat = param;

BEGIN
BEGIN
SELECT Id_angajat INTO v_id
FROM Programatori JOIN Angajati  USING (Id_Angajat)
WHERE Nume = param_nume;
EXCEPTION 
  WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20000, 'Nu exista programator cu numele dat!');
      RETURN -1.00;
  WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi programatori cu numele dat!');
      RETURN -2.00;
  WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'S-a generat alta eroare!');
      RETURN -3.00;
END;
     
BEGIN 
    SELECT Specializare_limbaj INTO specialitate
    FROM Programatori
    WHERE Id_Angajat = v_id;
    IF specialitate is null THEN
          RAISE_APPLICATION_ERROR(-20003, 'Progamatorului cu numele ' || param_nume || ' nu i s-a atribuit o specialziare!');
          RETURN -4.00;   
    END IF;

END;


BEGIN
SELECT COUNT(*) INTO nr_proiecte
FROM Lucreaza_la
WHERE Id_angajat = v_id
GROUP BY Id_angajat;
 EXCEPTION 
      WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20005, 'Progamatorului cu numele ' || param_nume || ' nu are proiecte!');
          RETURN -5.00; 
END;

DBMS_OUTPUT.PUT_LINE('Progamatorul cu numele ' || param_nume || ' lucreaza in prezent pe ' || nr_proiecte || ' proiecte si are specializarea ' || specialitate);

IF nr_proiecte <> 0 THEN --daca lcureaza pe mai mult de 0 proiecte vedem care sunt
  FOR i IN c(v_id) LOOP
      SELECT * INTO date_proiect
      FROM PROIECT
      WHERE Id_proiect = i.Id_proiect;
      DBMS_OUTPUT.PUT_LINE('Proiectul cu nr de ordine ' || contor || ' are startdate ' || date_proiect.Start_date || ' deadline ' || date_proiect.Deadline || ' si este lucrat in limbajul ' || date_proiect.Limbaj_programare);
      contor := contor + 1;
  END LOOP; 
END IF;
  
SELECT SUM(NVL(Salariu,0)) INTO sal_total
FROM ANGAJATI;

BEGIN 
SELECT Salariu INTO sal
FROM ANGAJATI
WHERE Id_angajat = v_id;
IF sal is null THEN
      RAISE_APPLICATION_ERROR(-20004, 'Programatorului ' || param_nume || ' nu i s-a alocat salariu!');
      RETURN -4.00;
END IF;


END;

procent_salariu := sal*100/sal_total;
RETURN procent_salariu;

END date_programator;

FUNCTION numar_pachete_internare RETURN NUMBER
IS
TYPE refcursor IS REF CURSOR;
CURSOR c1 IS
  SELECT Id_pachet, Titlu,
        CURSOR(SELECT S.*
               FROM pachet_servicii P2, TABLE (P2.servicii) S
               WHERE P2.Id_Pachet = P.Id_Pachet)
  FROM Pachet_servicii P;

cursor_aux refcursor;
v_id Pachet_servicii.Id_pachet%TYPE;
v_titlu Pachet_servicii.Titlu%TYPE;
v_nr NUMBER;
serviciu varchar(20);

BEGIN
  v_nr := 0;
  OPEN c1;
  LOOP
    FETCH c1 INTO v_id, v_titlu, cursor_aux;
    EXIT WHEN c1%NOTFOUND;
    LOOP
        FETCH cursor_aux INTO serviciu;
        EXIT WHEN cursor_aux%NOTFOUND;
        IF 'Internari' = Initcap(serviciu) THEN
          v_nr := v_nr + 1;
          DBMS_OUTPUT.PUT_LINE('PACHETUL ' || v_id || ' CU NUMELE ' || v_titlu || ' contine internari');
        END IF;
    END LOOP;
  END LOOP;
  CLOSE c1;
  
  RETURN v_nr;
  IF v_nr = 0 THEN
  RAISE_APPLICATION_ERROR(-20001,'Nu exista pachet cu internare!');
  RETURN -1;
  END IF;
END numar_pachete_internare;

PROCEDURE plata_spitalizare(nr_pers_pachet OUT NUMBER, nr_pers_fara_pachet OUT  NUMBER) 
IS
TYPE tablou_imbricat IS TABLE OF pers_pachet;
t tablou_imbricat := tablou_imbricat(); 
v_id_pers persoane.Id_persoana%TYPE;
v_id_pachet persoane.Id_pachet%TYPE;
v_data persoane.Data_testare%TYPE;
v_pachet tip_servicii;
contor NUMBER;
contor2 NUMBER;
v_ok NUMBER;
v_ok2 NUMBER;
v_nr NUMBER;

BEGIN

    nr_pers_pachet := 0;
    nr_pers_fara_pachet := 0;
    contor := 1;
    
    FOR i in (SELECT Id_persoana, Id_pachet, Data_testare
              FROM Persoane
              WHERE test_covid = 1
              ORDER BY Id_persoana)
         
          
      LOOP
      SELECT servicii INTO v_pachet
      FROM pachet_servicii
      WHERE Id_pachet = i.Id_pachet;
      
      t.EXTEND;
      t(contor) := pers_pachet(i.Id_persoana, i.Data_testare, v_pachet);
      contor := contor + 1;
      END LOOP;
      
      FOR j IN t.FIRST..t.LAST
      LOOP
      DBMS_OUTPUT.PUT('Persoana cu id-ul ' || t(j).cod_pesoana || ' are test pozitiv si pachetul << ');
      
      v_ok := 0;
      v_nr := 0;
      FOR k IN t(j).pachet_servicii.FIRST..t(j).pachet_servicii.LAST
      LOOP
       DBMS_OUTPUT.PUT(t(j).pachet_servicii(k) || ' ');
       IF 'Internari' = t(j).pachet_servicii(k) AND v_ok = 0 THEN
         
         v_ok := 1;
         nr_pers_pachet := nr_pers_pachet + 1;
         
       END IF; 
       END LOOP;
       DBMS_OUTPUT.PUT('>> ');
       IF v_ok = 0 THEN --nu are pachet care sa contina internari deci trebuie sa le plateasca
         DBMS_OUTPUT.PUT(' trebuie sa plateasca internarile ');
         v_ok2 := 0;
         SELECT count(*) INTO v_nr
         FROM spitale S JOIN internari i ON (S.id_spital = i.id_spital)
                   WHERE i.id_persoana = t(j).cod_pesoana;
                   
          IF v_nr = 0 THEN
          DBMS_OUTPUT.PUT( 'viitoare si nu s-a internat pana acum');
          END IF;
          
         FOR l IN (SELECT nume
                   FROM spitale S JOIN internari i ON (S.id_spital = i.id_spital)
                   WHERE i.id_persoana = t(j).cod_pesoana)
        LOOP
        IF v_ok2 = 0 THEN
            DBMS_OUTPUT.PUT('la ');
             DBMS_OUTPUT.PUT('*'||l.nume || '* ');
            v_ok2 := 1;
        ELSE
          DBMS_OUTPUT.PUT('*'||l.nume || '* ');
        END IF;
        END LOOP;
        ELSE
          DBMS_OUTPUT.PUT(' nu trebuie sa plateasca internarile');
        END IF;
        DBMS_OUTPUT.NEW_LINE();
      END LOOP;
      
    
      SELECT count(*) INTO nr_pers_fara_pachet
      FROM Persoane
      where Test_covid = 1;
      
      nr_pers_fara_pachet := nr_pers_fara_pachet - nr_pers_pachet;
      
    
END plata_spitalizare;

END pachet_complet;
/


DECLARE
nr_pachete NUMBER;
nr_pers_pachet NUMBER;
nr_pers_fara_pachet  NUMBER;

BEGIN
nr_pachete := pachet_complet.numar_pachete_internare;
DBMS_OUTPUT.PUT_LINE('Nr de pachete care contin serviciul internare este: ' || nr_pachete);
DBMS_OUTPUT.PUT_LINE('-------------------------');
plata_spitalizare(nr_pers_pachet, nr_pers_fara_pachet);
DBMS_OUTPUT.PUT_LINE('Nr de persoane care au pachete cu internare este: ' || nr_pers_pachet || ' iar nr de persoane fara pachete este: ' || nr_pers_fara_pachet);
END;
/

--triggerul ldd sa foloseasca procedura insereaza din pachet:
CREATE OR REPLACE 
TRIGGER ldd_trigger2
BEFORE CREATE OR DROP OR ALTER ON SCHEMA
BEGIN

   pachet_complet.insereaza(SYS.SYSEVENT,SYS.DICTIONARY_OBJ_NAME);

END;
/


--14

CREATE OR REPLACE PACKAGE management_persoane AS
CURSOR c1 RETURN Persoane%ROWTYPE; -- pt persoanele pozitive
TYPE sp_tip IS REF CURSOR RETURN Spitale_Suport%ROWTYPE; -- tip pt cusor dinamic pt spitalele suport care mai au locuri libere
TYPE pers_carantinate IS RECORD (cod_pesoana INTEGER, data_test DATE, iesire_izolare DATE);
TYPE tabel_carantinate IS TABLE OF pers_carantinate
      INDEX BY BINARY_INTEGER;
FUNCTION creeaza_tabel RETURN NUMBER; -- RETURNEAZA 1 DACA EXISTA tabel CU PERSOANELE CARANTINATE SI 0 IN CAZ CONTRAR
FUNCTION alege_spital RETURN INTEGER;
FUNCTION verifica_daca_e_internata(param PERSOANE.Id_persoana%TYPE) RETURN NUMBER; --daca persoana cu id ul dat e internata returneaza 1 altfel 0
PROCEDURE interneaza_persoana; -- daca se citeste de la tastatura pt fiecare persoana din cursorul c1 se interneaza, daca nu se insereaza in t1
PROCEDURE scoate_din_carantina;
t1 tabel_carantinate; --colectie tip tablou indexat pt. persoanele carantinate
END management_persoane;
/


CREATE OR REPLACE PACKAGE BODY management_persoane AS

CURSOR c1 RETURN Persoane%ROWTYPE IS
SELECT * FROM PERSOANE
WHERE Test_covid = 1;

FUNCTION creeaza_tabel RETURN NUMBER IS
v_nr NUMBER;
BEGIN 
SELECT COUNT(*) into v_nr
FROM USER_TABLES
WHERE TABLE_NAME = 'PERSOANE_CARANTINATE';
IF v_nr <> 0 THEN
DBMS_OUTPUT.PUT_LINE('TABELUL PERSOANE_CARANTINATE EXISTA DEJA');
RETURN 1;
ELSE
DBMS_OUTPUT.PUT_LINE('TABELUL  PERSOANE_CARANTINATE NU EXISTA');
RETURN 0;
END IF;
END creeaza_tabel;



FUNCTION alege_spital RETURN INTEGER IS
c2 sp_tip;
v_id INTEGER;
v_nr_max NUMBER;
v_spital Spitale_suport%ROWTYPE;
BEGIN
OPEN c2 FOR
          SELECT * FROM spitale_suport
          WHERE capacitate_paturi - paturi_ocupate >= 1;
          
v_nr_max := 0;
LOOP
    FETCH c2 INTO v_spital;
    EXIT WHEN c2%NOTFOUND;
    IF (v_spital.capacitate_paturi - v_spital.paturi_ocupate) > v_nr_max THEN
        v_nr_max := v_spital.capacitate_paturi - v_spital.paturi_ocupate;
        v_id := v_spital.Id_spital;
    END IF;
END LOOP;

RETURN v_id;

EXCEPTION 
  WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('NU MAI SUNT SPITALE SUPORT CU LOCURI LIBERE!');
  
END alege_spital;

FUNCTION verifica_daca_e_internata(param PERSOANE.Id_persoana%TYPE) RETURN NUMBER IS
v_nr NUMBER;
BEGIN
SELECT COUNT(*) INTO v_nr
FROM Internari
WHERE id_persoana = param;

IF v_nr <> 0 THEN --e internata
  RETURN 1;
ELSE
  RETURN 0;
END IF;
END verifica_daca_e_internata;

PROCEDURE interneaza_persoana IS
v_id_spital INTEGER;
v_pers Persoane%ROWTYPE;
raspuns VARCHAR(20);
ran FLOAT;
p pers_carantinate;
contor NUMBER;
verifica NUMBER;

BEGIN
v_id_spital := alege_spital;
contor := 1;

OPEN c1;
LOOP
  FETCH c1 INTO v_pers;
  EXIT WHEN c1%NOTFOUND;
  
  SELECT dbms_random.VALUE(1,20) INTO ran FROM dual;
  
  verifica := management_persoane.verifica_daca_e_internata(v_pers.Id_persoana);
  
  IF ran <= 10 AND verifica = 0 THEN
  raspuns := 'DA';
  ELSE
   raspuns := 'NU';
  END IF;
  
  IF upper(raspuns) = 'DA' THEN
      INSERT INTO INTERNARI
      VALUES(v_pers.Id_persoana, v_id_spital,SYSDATE,null);
      UPDATE Spitale_suport
      SET paturi_ocupate = paturi_ocupate + 1
      where Id_spital = v_id_spital;
      v_id_spital := alege_spital;
  
  ELSE
    p.cod_pesoana := v_pers.Id_persoana;
    p.data_test := SYSDATE;
    p.iesire_izolare  := SYSDATE+14;
    t1(contor) := p;
    contor := contor + 1;
    --t1(t1.LAST+1) := p; 
      
  END IF;
  
  
END LOOP;

CLOSE c1;

DBMS_OUTPUT.PUT_LINE('PERSOANELE CARANTINATE SUNT:');
FOR  i IN 1..t1.LAST
LOOP
DBMS_OUTPUT.PUT_LINE(t1(i).cod_pesoana || ' data intrare in carantina ' ||  t1(i).data_test || ' data iesire din carantina ' || t1(i).iesire_izolare);
END LOOP;
END interneaza_persoana;



PROCEDURE scoate_din_carantina IS
TYPE vector IS VARRAY(20) OF NUMBER;
t vector:= vector();
contor NUMBER;
BEGIN
contor := 1;
FOR  i IN 1..t1.LAST
LOOP
IF t1(i).iesire_izolare >=SYSDATE THEN
t.EXTEND;
t(contor) := i;
--t1.delete(i);
END IF;
END LOOP;

FOR  i IN 1..t.LAST
LOOP
t1.DELETE(t(i));
END LOOP;

IF contor -1 <> 0 THEN
DBMS_OUTPUT.PUT_LINE('Au iesit ' || contor -1 || ' persoane din carantina ');
ELSE 
DBMS_OUTPUT.PUT_LINE('NU au iesit persoane din carantina ');
END IF;
END scoate_din_carantina;


END management_persoane;
/




DECLARE
exista_tabel NUMBER;
id_spital INTEGER;
verifica_inter INTEGER;
BEGIN

exista_tabel := management_persoane.creeaza_tabel;
DBMS_OUTPUT.PUT_LINE(exista_tabel);
id_spital := management_persoane.alege_spital;
DBMS_OUTPUT.PUT_LINE('SPITALUL SUPORT cu cele mai multe locuri libere are id-ul : ' || id_spital);
verifica_inter := management_persoane.verifica_daca_e_internata(10);
IF verifica_inter = 0 THEN
DBMS_OUTPUT.PUT_LINE('Persoana nu e internata!');
ELSE
DBMS_OUTPUT.PUT_LINE('Persoana  e internata!');
END IF;

 management_persoane.interneaza_persoana;
 management_persoane.scoate_din_carantina;
END;
/

select dbms_random.value(1,9)  from dual;
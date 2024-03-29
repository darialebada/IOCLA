### Lebada Daria-Cristiana 313CA

## Tema 2 - ACS Cat Invasion
### ~ IOCLA / PCLP2 ~

### Task 1: Simple Cipher
Luam fiecare caracter pe rand si il prelucram, adaugand la codul sau ascii numarul
dat. Ne asiguram ca acest caracter rezultat este mai mic decat 91, iar in sens
contrar scadem 26 din valoarea sa (cream un ciclu in literele mari ale alfabetului).
Algoritmul se opreste cand nu mai avem caractere de citit in cuvant.

### Task 2: Points
a. Points distance:
Deoarece punctele se afla pe aceeasi dreapta, pentru a calcula distanta este suficient
sa facem diferenta in modul dintre cele 2 coordonate diferite.
Luam coordonatele x ale celor doua puncte (le consideram x1 si x2) si avem 3 cazuri:
    - x1 > x2 => se realizeaza diferenta x1 - x2;
    - x1 < x2 => se realizeaza diferenta x2 - x1;
    - x1 == x2 se realizeaza una dintre operatiile de mai sus pe coordonatele y.

b. Road:
Vom realiza operatiile implementate la subpunctul anterior pe cate 2 puncte consecutive
din vectorul de puncte.

c. Is square:
Vom lua fiecare distanta din vector si o vom gasi un patrat perfect mai mare sau egal cu
acesta.

### 3. Beaufort Encryption:
Folosim 2 contori - pentru cheie, respectiv string. Pentru a parcurge cheia, vom crea un
ciclu in aceasta (de fiecare data cand contorul ajunge egal cu lungimea cheii, contorul
va fi reinitializat cu 0). Pentru fiecare litera aplicam formula |ascii_cheie - ascii_string| + 65.

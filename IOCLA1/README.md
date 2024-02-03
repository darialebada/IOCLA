#### Lebada Daria-Cristiana 313CA

# Tema 1 - Momente disperate
### ~ IOCLA / PCLP2 ~

### Implementare
Pentru stocarea datelor am folosit vectorul generic void *arr, in care fiecare 
element este definit de un header ce descrie continutul, urmat de datele efective.
La fiecare pas se citeste o linie (care reprezinta o comanda) si se realizeaza una
dintre operatiile cerute. Pentru parcurgerea vectorului arr vom folosi o variabila
offset in care vom retine pozitia curenta din vector.

### add_last:
Se va parsa comanda cu strtok si se vor extrage datele care trebuie adaugate in vector.
Acestea se vor copia apoi intr-o structura de tipul data_structure. Valorile bancnotelor 
sunt declarate generic, deoarece inca nu se stie exact tipul acestora. In functie de 
header->type se va aloca memorie pentru valoarea fiecarei bancnote, apoi vor fi copiate.
La final, se parcurge complet vectorul arr, se aloca memoria necesara noilor date (sau
realoca dupa caz) si se adauga la final acestea.

### add_at:
Principiul este asemenator celui de la functia add_last. Aici se va parcurge vectorul arr
doar pana la elementul de pe pozitia index, apoi se vor muta la dreapta datele aflate
dupa acest index in vector.

### find:
Se parcurge vectorul arr pana la elementul de pe pozitia index si se afiseaza datele acestuia.

### delete_at:
Se parcurge vectorul arr pana la elementul de pe pozitia index + 1 si se permuta la stanga 
(pe pozitia index) toate datele care se gasesc in arr incepand cu pozitia index + 1;

### print:
Se parcurge vectorul arr si se afiseaza fiecare element dupa formatul cerut. La fiecare pas
se obtin datele din fiecare element, astfel: tipul se gaseste in header, numele il cautam in
functie de aparitia terminatorului de sir, iar valorile bancnotelor le aflam in functie de
tip (vor fi declarate void*).

### exit:
Memoria stocata in arr este eliberata si programul se opreste.


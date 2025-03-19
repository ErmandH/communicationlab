.data
msg1: .asciiz "Buyuk sayi: "
msg2: .asciiz "iki sayi esit"
.text
.globl main
main:
## Kullanıcıdan ilk sayıyı al, $t0’ a yaz
addi $v0, $zero, 5 # syscall ile $v0’a sayıyı al
syscall # syscall
add $t0, $v0, $zero # okunan sayıyı $t0’a geçir
## Kullanıcıdan ikinci sayıyı al, $t1’ e yaz
addi $v0, $zero, 5 # syscall ile $v0’a sayıyı al
syscall # syscall
add $t1, $v0, $zero 

slt $t2, $t0, $t1 # t0 < t1 mü
beq $t2, $zero buyukise
la $a0, msg1 # msg1’nin başlangıç adresini $a0’a yükle
addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
syscall # syscall

# t1 büyük olduğu için
add $a0, $t1, $zero # 
addi $v0, $zero, 1 # tamsayı yazma için $v0’a syscall yükle
syscall # syscall
addi $v0, $zero, 10 # çıkış için syscall kodu 10’dur
syscall # syscall


# t0 >= t1 ise
buyukise:
beq $t0, $t1 esitise
# esit degil ise
# t0 büyük olduğu için
la $a0, msg1 
addi $v0, $zero, 4 
syscall 

add $a0, $t0, $zero # 
addi $v0, $zero, 1
syscall 
addi $v0, $zero, 10
syscall
esitise:
la $a0, msg2 
addi $v0, $zero, 4 
syscall # syscall
addi $v0, $zero, 10 
syscall 

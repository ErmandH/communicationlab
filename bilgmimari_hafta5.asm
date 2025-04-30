.data

msg1: .asciiz "Dizinin uzunlugu: "
array: .space 256
maxlength: .word 256
.text
.globl main
main:
## Kullanıcıdan ilk sayıyı al, $t0’ a yaz
lw $a1,maxlength
la $a0,array # a0 dizinin adresi
addi $v0,$zero, 8
syscall

la $s0, array # baslangic adresi

strlen:
addi $s1,$zero, 1 # s1 = count = 0
while:
addi $s0, $s0, 1
lbu $t1, 0($s0) # t1 = array[i]
beq $t1, $zero, endwhile
#while içi
beq $t1, 10, continue
addi $s1, $s1, 1 # count++
continue:
j while
endwhile:
# while end
la $a0, msg1 # msg1’nin başlangıç adresini $a0’a yükle
addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
syscall

add $a0, $s1, $zero # dizi uzunlgunu yazdır
addi $v0, $zero, 1
syscall
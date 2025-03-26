
.data
msg1: .asciiz "\nSekil seçiniz 1-Küp, 2-Küre, 3-Silindir:"
kupMsg1: .asciiz "Kupun kenarini giriniz: "
kupMsg2: .asciiz "Kupun alani: "

kureMsg1: .asciiz "Kurenin yaricapini giriniz: "
kureMsg2: .asciiz "Kurenin alani: "

silindirMsg1: .asciiz "Silindirin yaricapini giriniz: "
silindirMsg2: .asciiz "Silindirin uzunluğunu giriniz: "
silindirMsg3: .asciiz "Silindirin alani: "
.align 2
shapes: .space 40


.text
.globl main
main:
# t0 = counter
add $t0, $zero, $zero
#t8 = sekillerin base adresi

la $t8, shapes
la $t9, shapes

loop:
	# t0 < 3 ise t1 = 1 else t1 = 0
	slti $t1, $t0, 3
	beq $t1, $zero, exit
	# while (i < 3)
	la $a0, msg1
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	
	# kullanıcıdan şekil numarasını iste
	addi $v0, $zero, 5
	syscall # syscall
	# t2 = sekil no
	add $t2, $v0, $zero
	
	# if sekil no == 1, kup hesapla
	beq $t2, 1, kupHesapla
	
	# if sekil no == 2, kure hesapla
	beq $t2, 2, kureHesapla
	
	# if sekil no == 3, kure hesapla
	beq $t2, 3, silindirHesapla
	addi $t0, $t0, 1
	j loop
	
kupHesapla:
	# kupun alanını gir mesaji
	la $a0, kupMsg1
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	
	# kenar inputunu t5 e al
	addi $v0, $zero, 5
	syscall
	add $t5, $v0, $zero 
	
	# a = t5
	mul $t5, $t5, $t5
	mul $t5, $t5, 6
	# t5 = alan
	la $a0, kupMsg2
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	add $a0, $t5, $zero 
	addi $v0, $zero, 1 # t5 i yazdir
	syscall 
	
	#adresi doldur
	sw $t5, 0($t9)
	# bir sonraki eleman için 4 ekle
	addi $t9, $t9, 4

	addi $t0, $t0, 1
	j loop
kureHesapla:
	# kurenin alanını gir mesaji
	la $a0, kureMsg1
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	
	# yaricap inputunu t5 e al
	addi $v0, $zero, 5
	syscall
	add $t5, $v0, $zero 
	
	# r = t5
	mul $t5, $t5, $t5
	mul $t5, $t5, 4
	mul $t5, $t5, 314
	div $t5, $t5, 100
	# t5 = alan
	la $a0, kureMsg2
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	add $a0, $t5, $zero 
	addi $v0, $zero, 1 # t5 i yazdir
	syscall 
	
	#adresi doldur
	sw $t5, 0($t9)
	# bir sonraki eleman için 4 ekle
	addi $t9, $t9, 4

	addi $t0, $t0, 1
	j loop
silindirHesapla:
	# silindirin yaricapini gir mesaji
	la $a0, silindirMsg1
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	
	# yaricap inputunu t5 e al
	addi $v0, $zero, 5
	syscall
	add $t5, $v0, $zero 
	
	# silindirin uzunlugunu gir mesaji
	la $a0, silindirMsg2
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	
	# uzunluk inputunu t6 e al
	addi $v0, $zero, 5
	syscall
	add $t6, $v0, $zero
	
	# r = t5, h = t6 
	mul $s0, $t5, $t6
	# s0 = r * h
	mul $s0, $s0, 2
	mul $s0, $s0, 314
	div $s0, $s0, 100
	# s0 = 2 * pi  * r * h
	
	mul $t5, $t5, $t5 # r^2
	mul $s1,$t5, 2
	mul $s1, $s1, 314
	div $s1, $s1, 100
	
	#sonuc = s0 + s1
	add $s0, $s0, $s1
	#alan = s0
	la $a0, silindirMsg3
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	add $a0, $s0, $zero 
	addi $v0, $zero, 1 # s0 i yazdir
	syscall 
	
	#adresi doldur
	sw $t5, 0($t9)
	# bir sonraki eleman için 4 ekle
	addi $t9, $t9, 4

	addi $t0, $t0, 1
	j loop

# while dongu cikisi
exit:
   addi $v0, $zero, 10 # çıkış için syscall kodu 10’dur
   syscall # syscall


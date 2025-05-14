
.data

msg1: .asciiz "\nDizinin elemanini girin:"
msg2: .asciiz "\nIlk indexi girin:"
msg3: .asciiz "\nIkinci indexi girin:"
toplam: .asciiz "\nToplam:"
.align 2
array: .space 100


.text
.globl main
main:

jal getInputsFromUser
jal askUserForIndexes

addi $v0, $zero, 10 # çıkış için syscall kodu 10’dur
syscall # syscall

getInputsFromUser: #a0 = base address
	# t0 = counter
	add $t0, $zero, $zero
	la $t6, array # t6 = base address
	loop:
	# t0 < 8 ise t1 = 1 else t1 = 0
	slti $t1, $t0, 8
	beq $t1, $zero, exitloop1
	# while (i < 8)
	la $a0, msg1
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	
	# kullanıcıdan dizi elemanını iste
	addi $v0, $zero, 5
	syscall # syscall
	# t2 = dizi elemanı
	add $t2, $v0, $zero
	
	sll $t3, $t0, 2 # t3 = i * 4
	add $t7, $t6, $t3 # s1= array + i
	sw $t2, 0($t7) # array[i] = t2
	addi $t0, $t0, 1
	j loop
	# while dongu cikisi
	exitloop1:
   	jr $ra
   	
askUserForIndexes:
    	la $t6, array # t6 = base address
    	#ilk indexi al
    	la $a0, msg2
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	# kullanıcıdan dizi elemanını iste
	addi $v0, $zero, 5
	syscall # syscall
	add $t0, $v0, $zero # t0 = index1;
    	
    	#2. indexi al
    	la $a0, msg3
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	# kullanıcıdan dizi elemanını iste
	addi $v0, $zero, 5
	syscall # syscall
	add $t1, $v0, $zero # t1 = index2;
	
	add $s0,$zero, $zero
	loop2:
	# t1 < t0 ise t2 = 1 else t2 = 0
	slt $t2, $t1, $t0
	bne $t2, $zero, exitloop2
	# while (t0 < t1)
	sll $t3, $t0, 2 # t3 = i * 4
	add $t4, $t6, $t3 # t4 = array + 1
	lw $t5, 0($t4) # t5 = array[i}
	add $s0, $s0, $t5 # sum += t5
	addi $t0, $t0, 1
	j loop2
	# while dongu cikisi
	exitloop2:
	# toplam yi yazdır
	la $a0, toplam
	addi $v0, $zero, 4 # karakter dizisi yazma için syscall 4
	syscall
	
	add $a0, $s0, $zero 
	addi $v0, $zero, 1 # s0 i yazdir
	syscall 
   	jr $ra
	



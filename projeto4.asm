
# 	Trabalho: calcular a raíz cúbica de um número x   (0 < x < 1)

# ======== declarações ========
.data
	msg1:	.asciiz	"digite um valor entre 0 e 1 (flutuante): "
	msg2:	.asciiz	"voce digitou: "
	p: .float 1.0
	a1: .float 3.0
	x: .float 0.0
	erro: .float 0.001

# ======== codigo ========
.text

le_float:
	li $v0, 4	# parâmentro para printar string
	la $a0, msg1	# $a0 recebe a mensagem a ser mostrada
	syscall

	li $v0, 6	# para ler o valor de m e guardar em $f0
	syscall

	lwc1 $f1, p	# $f1 recebe o valor de p = 1
	lwc1 $f2, a1	# $f2 recebe o valor 3
	lwc1 $f3, x	# $f2 recebe o valor de x
	lwc1 $f6, erro	# $f6 recebe o valor do erro
	mul.s $f2, $f2, $f1 	# $f2 recebe 3*p = 3*p²
	sub.s $f1, $f1, $f0	# calcula p³-m 

loop_raiz: 
	mov.s $f4, $f3		# $f4 recebe o valor de x inicial e x anterior
	mul.s $f4, $f4, $f4	# eleva x ao quadrado
	mul.s $f5 , $f2, $f4	# calcula 3p*x²
	mul.s $f4, $f4, $f4	# eleva x ao quadrado
	add.s $f3, $f1, $f5	# calcula a p³-m+3px² 	
	sub.s $f5 , $f5, $f4	# calcula 3px²-x³
	div.s $f3, $f3, $f2	# calcula valor definitivo de x =  (p³-m+3px²-x³)/3p²
	sub.s $f7, $f3, $f4	# calcula o erro atual
	mov.s $f12, $f7 
	c.lt.s $f6, $f7		# campara se erro é menor que o erro atual
	mov.s $f12, $f3
	bc1t loop_raiz	# se x é diferente de x anterior continua o loop
	#bc1f imprime_saida	# se x é igual a x anterior calcula a raiz de m

calc_raiz:
	lwc1 $f1, p	# $f1 recebe o valor de p = 1
	sub.s $f12, $f1, $f3	# calcula a raiz de m	
	#j imprime_saida

imprime_saida:
	
	li $v0, 2	# parâmentro para printar float
	syscall

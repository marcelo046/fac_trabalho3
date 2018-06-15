
# 	Trabalho: calcular a raíz cúbica de um número x   (0 < x < 1)

# ======== declarações ========
.data
	msg1:	.asciiz	"digite um valor entre 0 e 1 (flutuante): "
	msg2:	.asciiz	"voce digitou: "
	a1: .float 3.0
	x: .float 0.1
	erro: .float 0.000001

# ======== codigo ========
.text

le_float:
	li $v0, 4	# parâmentro para printar string
	la $a0, msg1	# $a0 recebe a mensagem a ser mostrada
	syscall

	li $v0, 6	# para ler o valor de m e guardar em $f0
	syscall

	lwc1 $f1, x	# $f1 recebe o valor de x
	lwc1 $f2, a1	# $f2 recebe o valor 3
	lwc1 $f5, erro	# $f5 recebe o valor do erro
	j expoente_x1	# desvio para expoente_x1	
	
	calc_x1:
		sub.s $f4, $f4, $f0	# calcula x³-m
		mul.s $f3, $f3, $f2	# calcula 3*x²
		div.s $f6, $f4, $f3	# calcula (x³-m)/3*x²
		abs.s $f6, $f6		# módulo do novo x
		add.s $f6, $f1, $f6	# calcula x-[(x³-m)/3*x²]

loop_raiz: 
	mov.s $f1, $f6		# atualiza valor de x
	j expoente	# desvio para expoente	
	
	calc_x:
		sub.s $f4, $f4, $f0	# calcula x³-m
		mul.s $f3, $f3, $f2	# calcula 3*x²
		div.s $f6, $f4, $f3	# calcula (x³-m)/3*x²
		sub.s $f6, $f1, $f6	# calcula x-[(x³-m)/3*x²]
		sub.s $f7, $f1, $f6	# calcula diferença entre x e x anterior
		abs.s $f7, $f7		# módulo da diferença entre x e x anterior
		c.lt.s $f7, $f5		# verifica se $f7 é menor que erro
		bc1f loop_raiz		#continua loop
		bc1t imprime_saida	#desvio para imprime_saida

expoente_x1:
	mul.s $f3, $f1, $f1	# calcula x²
	mul.s $f4, $f3, $f1	# calcula x³
	j calc_x1
	
expoente:
	mul.s $f3, $f1, $f1	# calcula x²
	mul.s $f4, $f3, $f1	# calcula x³
	j calc_x

imprime_saida:
	mov.s $f12, $f6		# $f2 recebe raiz cúbica de m
	li $v0, 2	# parâmentro para printar float
	syscall

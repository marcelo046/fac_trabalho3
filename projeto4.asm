
# 	Trabalho: calcular a raíz cúbica de um número x   (0 < x < 1)

# ======== declarações ========
	.data
msg1:	.asciiz	"digite um valor entre 0 e 1 (flutuante): "
msg2:	.asciiz	"voce digitou: "


# ======== codigo ========
	.text
main:

la $a0, msg1	# para printar mensagem
li $v0, 4
syscall

li $v0, 7	# para ler um double e guardar em $v0
syscall

l.d $f12, ($v0) # salvar valor lido em 

la $a0, msg2	# para printar mensagem
li $v0, 4
syscall

li $v0, 3 # imprime double
syscall

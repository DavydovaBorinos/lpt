.model small
.stack 100h
.data
	errormes db 0ah,0dh,'Oshibka!!!',0ah,0dh,'$'
	
	printbusy db 'Printer zanyat',0ah,0dh,'$'
	printfree db 'Printer svoboden',0ah,0dh,'$'

	printready db 'Printer gotov',0ah,0dh,'$'
	printnotready db 'Printer ne gotov',0ah,0dh,'$'

	paperyes db 'Bumaga est',0ah,0dh,'$'
	paperno db 'Bumagi net',0ah,0dh,'$'


	selectno db 'Printer ne vibran',0ah,0dh,'$'
	selectyes db 'Printer vibran',0ah,0dh,'$'


	erroryes db 'Oshibka',0ah,0dh,'$'
	errorno db 'Net oshibki',0ah,0dh,'$'


	signalyes db 'Signala podtverjdenia prinyat',0ah,0dh,'$'
	signalno db 'Signala podtverjdenia ne prinyat',0ah,0dh,'$'
.code
start:

	mov	ax,@data
	mov	ds,ax

	call	Init_LPT

lpt1:	call	Test_LPT
 
	cmp	al,0d8h
	je	lpt2

	lea	dx,errormes
	mov	ah,09h
	int	21h

	jmp	exit

lpt2:	mov	ah,01h
	int	21h

	cmp	al,27
	je	exit

	call 	Byte_LPT
	jmp	lpt2

exit:	mov	ah,4ch
	mov	al,00h
	int	21h


Init_LPT	proc
.486
	push	ax
	push	dx
	mov	al,00001100b
	mov	dx,037Ah
	out	dx,al
	pop	dx
	pop	ax
	ret
Init_LPT	endp




Byte_LPT	proc
.486
	push	ax
	push	dx
	mov	dx,0378h
	out	dx,al
	mov	al,00001101b
	mov	dx,037Ah
	out	dx,al
	mov	al,00001100b
	mov	dx,037Ah
	out	dx,al
	pop	dx
	pop	ax
	ret
Byte_LPT	endp







Test_LPT proc
.486
	push	dx
	mov	dx,0379h
	in	al,dx

	push	ax
	test	al,10000000b
	jz	test1
	lea	dx,printfree
	jmp	test2
test1:	lea	dx,printbusy
test2:	mov	ah,09h
	int	21h
	pop	ax

	push	ax
	test	al,01000000b
	jz	test3
	lea	dx,printready
	jmp	test4
test3:	lea	dx,printnotready
test4:	mov	ah,09h
	int	21h
	pop	ax

	push	ax
	test	al,00100000b
	jz	test5
	lea	dx,paperno
	jmp	test6
test5:	lea	dx,paperyes
test6:	mov	ah,09h
	int	21h
	pop	ax

	push	ax
	test	al,00010000b
	jz	test7
	lea	dx,selectyes
	jmp	test8
test7:	lea	dx,selectno
test8:	mov	ah,09h
	int	21h
	pop	ax

	push	ax
	test	al,00001000b
	jz	test9
	lea	dx,errorno
	jmp	test10
test9:	lea	dx,erroryes
test10:	mov	ah,09h
	int	21h
	pop	ax

	push	ax
	test	al,00000100b
	jz	test11
	lea	dx,signalno
	jmp	test12
test11:	lea	dx,signalyes
test12:	mov	ah,09h
	int	21h
	pop	ax
	POP	dx

	ret
Test_LPT endp
	
end start
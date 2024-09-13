	.text
	.org 0x0000

	add x0,x0,x1
        and x1,x1,x2
        orr x2,x2,x23
	sub x3,x3,x3
	cbz x3,end
	
end:
	mrs x4,
	br x7

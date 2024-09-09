	.text
	.org 0x0000
	
	ADD x2,xzr,xzr
	ADD x0,xzr,xzr
	ADD x29,xzr,x16
multloop:
        ADD x2,x2,x17
        SUB x29,x29,x1
        CBZ x29,endloop
        CBZ xzr,multloop
endloop:
	STUR x2,[x0,#0]
infloop:
	CBZ xzr,infloop

	.text
	.org 0x0000
	
	// x0 --> Posicion de memoria a llenar
	// x1 --> Incrementar 1
	// x2 --> Guardar indice
	// x3 --> Resultado de resta
	// x30 --> Hasta donde ciclar
	ADD x2,xzr,xzr
	STUR x30, [x0, #240]	
startloop:
	STUR x2,[x0,#0]
	ADD x0,x0,x8
	ADD x2,x2,x1
	sUB x3,x2,x30
	CBZ x3, end
	CBZ XZR,startloop
end:	
	CBZ XZR, end

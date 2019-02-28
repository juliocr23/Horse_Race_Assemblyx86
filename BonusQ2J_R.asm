INCLUDE Irvine32.inc

.data
array byte 3 DUP(0)
output1 byte "The WINNER is horse #",0
output2 byte "It is a draw",0
location byte 3 DUP(0)
.code
main PROC
	
	call createStage

	.while( array[0] <=10  && array[1] <= 10 && array[2] <= 10)
		

		;Horse # 1
			call getRandom		;Get random digit.
			add array[0],AL

			MOV DH,5			;Go to location
			.if(location[0] == 0)
				MOV DL,2
			.else
				MOV DL,location[0]
			.endif

			call gotoXY
			call goRacing		;Go racing.
			MOV location[0],DL

		;Horse #2
			call getRandom		;Get random digit.
			add array[1],AL

			MOV DH,7            ;Go to Location
			.if(location[1] == 0)
				MOV DL,2
			.else
				MOV DL,location[1]
			.endif

			call gotoXY
			call goRacing
			MOV location[1],DL

		;Horse #3
			call getRandom		;Get random digit.
			add array[2],AL

			MOV DH,9			;Go to location.
			.if(location[2] == 0)
				MOV DL,2
			.else
				MOV DL,location[2]
			.endif

			call gotoXY
			call goRacing
			MOV location[2],DL

	.endw

	call crlf
	call crlf

	call determineWinner
	call crlf
	call crlf
exit
main ENDP

;The createStage procedure
;setup the stage for the race.

createStage  PROC

;Set the location of race.
MOV DL,0		
MOV DH,5
call gotoXY
MOV EDX,0

MOV EAX,WHITE
call setTextColor

MOV ECX,5
MOV EAX,0
MOV ESI,1
L1:
	push ECX		;Store Inner LOOP
	MOV ECX,10		;Outer LOOP

	.if(EDX == 0)		;Write horse number in screen.
		MOV EAX,ESI
		call writedec
		INC ESI
	.else
		MOV AL," "
		call writechar
     .endif

	MOV AL,"|"		
	call writechar
	L2:
		MOV AL,"_"
		call writechar
	LOOP L2

	.if(EDX == 0)
		MOV EDX,1
	.else
		MOV EDX,0
	.endif

	call crlf
	POP ECX	;Restore Iteration

LOOP L1

ret
createStage ENDP

getRandom PROC

call Randomize
MOV ECX,10

MOV EAX,3
call randomRange
add EAX,1

ret
getRandom ENDP

goRacing PROC
	MOV ECX,EAX	
	MOV EAX,100
	L1:
		call delay
		MOV AL,"*"
		call writechar
		ADD DL,1
	LOOP L1

	MOV EAX,0
ret
goRacing ENDP

determineWinner PROC

	MOV AL,array[0]
	MOV AH,array[1]
	.if(AL > array[1] && AL > array[2])
		MOV EDX,offset output1
		call writestring

		MOV AL,"1"
		call writechar

	.elseif(AH > array[0] && AH > array[2])
		MOV EDX,offset output1
		call writestring

		MOV AL,"2"
		call writechar

	.elseif(array[2] > AL && array[2] > AH)
		MOV EDX,offset output1
		call writestring

		MOV AL,"3"
		call writechar
	.else
		MOV EDX,offset output2
		call writestring
	.endif

ret
determineWinner ENDP
end main
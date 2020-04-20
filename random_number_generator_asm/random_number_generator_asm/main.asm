includelib libcmt.lib
includelib legacy_stdio_definitions.lib
.model flat
.686
extern _ExitProcess@4 : PROC
extern __read : PROC 
extern _printf : PROC
public _main
public _random_number_linear_generator
public _random_number_shift_register

.data
;constans for main program and some variables for outputting uint32 numbers and waiting for enter pressed
get_enter_buffer db 1
uint32_printf_output db "%u", 10, 0
press_enter_msg db "press enter to continue", 10, 0
ITERATION_COUNTER_END EQU 100000


;constans and variables for linear generator
A_CONST EQU 69069
C_CONST EQU 1
actual_generated_number dd 7

;constans and variables for shift register
P_CONST EQU 7
Q_CONST EQU 3
INIT_VECTOR_LENGTH_CONST EQU 7
NUMBER_BIT_LENGTH_CONST EQU 32
actual_starting_vector dd 00000045h
.code

_random_number_linear_generator PROC
	push ebp
	mov ebp,esp
	push ebx

	;calculating formula   Xn = ( Xn-1 * a + c ) % M 
	;where M is 2^32 - 1 because of that and size of register we don't need to do it manualy
	mov eax,actual_generated_number
	mov ebx,A_CONST
	mul ebx
	add eax,C_CONST
	mov actual_generated_number,eax

	pop ebx
	pop ebp
	ret
_random_number_linear_generator ENDP

_random_number_shift_register PROC
	push ebp
	mov ebp,esp
	push ebx
	push ecx

	;calculating formula bi = bi-p  XOR  bi-q	where b is bit in number
	mov eax,actual_starting_vector
	;we set 2 bits in register which will be operands for XOR first
	mov ebx,00000001h
	shl ebx, INIT_VECTOR_LENGTH_CONST - P_CONST
	mov edx,00000001h
	shl edx,INIT_VECTOR_LENGTH_CONST - Q_CONST
	add ebx,edx

	mov ecx,INIT_VECTOR_LENGTH_CONST
	generate_number:
	cmp ecx,NUMBER_BIT_LENGTH_CONST
	je generate_numberend
		;instead of XOR operation of 2 bits we can do AND operation
		;with actual_vector and vector with bits to xor
		;if resault of operation is equal to 0 or equal to vector with bits to xor
		;it's mean XOR operation resault will be 0
		;else XOR operation resault will be 1
		mov edx,eax
		and edx,ebx
		cmp edx,0
		je setzero
		cmp edx,ebx
		je setzero
		bts eax,ecx
		jmp setnotzero
		setzero:
		btr eax,ecx
		setnotzero:
		shl ebx,1	;shift vector with bits to xor by one
	inc ecx
	jmp generate_number
	generate_numberend:
	mov actual_starting_vector,eax
	shr actual_starting_vector,NUMBER_BIT_LENGTH_CONST-INIT_VECTOR_LENGTH_CONST

	pop ecx
	pop ebx
	pop ebp
	ret
_random_number_shift_register ENDP

_main PROC

	;100000 iteration with writing into console of generating numbers with linear generator
	mov ecx,ITERATION_COUNTER_END
	loop1:
		call _random_number_linear_generator

		push ecx ;beacuse _printf change value
		push eax
		push OFFSET uint32_printf_output
		call _printf
		add esp,8
		pop ecx ;beacuse _printf change value
	loop loop1



	;waiting for pressing enter
	push OFFSET press_enter_msg
	call _printf
	add esp,4
	push dword ptr 1
	push dword ptr OFFSET get_enter_buffer
	push dword ptr 0
	call __read
	add esp,12



	;100000 iteration with writing into console of generating numbers with shift register generator
	mov ecx,ITERATION_COUNTER_END
	loop2:
		call _random_number_shift_register

		push ecx ;beacuse _printf change value
		push eax
		push OFFSET uint32_printf_output
		call _printf
		add esp,8
		pop ecx ;beacuse _printf change value
	loop loop2



	;waiting for pressing enter
	push OFFSET press_enter_msg
	call _printf
	add esp,4
	push dword ptr 1
	push dword ptr OFFSET get_enter_buffer
	push dword ptr 0
	call __read
	add esp,12

	push 0
	call _ExitProcess@4

_main ENDP

END
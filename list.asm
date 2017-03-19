;global and external names
;------------------------------------------------------------------------------
global main
extern printf
extern exit
extern malloc
extern free
;initalized data
;------------------------------------------------------------------------------
SECTION .data
NODE_SIZE equ 8
NODE_COUNT equ 3
PRINT_INT_STR db "Node data = %i",10,0
PRINT_PTR_STR db "Node address = %p",10,0
PRINT_PTR_NEXT_STR db "Next node address = %p",10,0
PRINT_STR_STR db "%s",10,0
EXIT_SUCCESS dd 0 
;uninitialized data
;------------------------------------------------------------------------------
SECTION .bss
head_ptr resd 1
node1_ptr resd 1
node2_ptr resd 1
;cod
;------------------------------------------------------------------------------
SECTION .text
main:
;create list head
;------------------------------------------------------------------------------
	push NODE_SIZE
	call malloc
	add esp, 4
	mov [eax], dword 1
	mov [eax + 4], dword 0
	mov [head_ptr], eax

;create node 1
;------------------------------------------------------------------------------	
	push NODE_SIZE
	call malloc
	add esp, 4
	mov [eax], dword 2
	mov [eax + 4], dword 0
	mov [node1_ptr], eax

;create node 2
;------------------------------------------------------------------------------	
	push NODE_SIZE
	call malloc
	add esp, 4
	mov [eax], dword 3
	mov [eax + 4], dword 0
	mov [node2_ptr], eax

;create link head->node1->node2->null
;------------------------------------------------------------------------------	
	mov eax, dword [head_ptr]
	mov ebx, [node1_ptr]
	mov dword [eax + 4], ebx	
	mov eax, dword [node1_ptr]
	mov ebx, [node2_ptr]
	mov dword [eax + 4], ebx

;traverse list
;------------------------------------------------------------------------------	
	mov ebx, [head_ptr]
traverse:
	cmp dword [ebx + 4], 0
	jz last_node
	push ebx
	push PRINT_PTR_STR
	call printf
	add esp, 8
	
	push dword [ebx]
	push PRINT_INT_STR
	call printf
	add esp, 8
	
	push dword [ebx + 4]
	push PRINT_PTR_NEXT_STR
	call printf
	add esp, 8

	
	mov ecx, [ebx + 4]
	mov ebx, ecx
	jmp traverse
last_node:
	push ebx
	push PRINT_PTR_STR
	call printf
	add esp, 8
	
	push dword [ebx]
	push PRINT_INT_STR
	call printf
	add esp, 8
	
	push dword [ebx + 4]
	push PRINT_PTR_NEXT_STR
	call printf
	add esp, 8
	

;destroy head
;------------------------------------------------------------------------------	
	push dword [head_ptr]
	call free
	add esp, 4

;destroy node 1
;------------------------------------------------------------------------------		
	push dword [node1_ptr]
	call free
	add esp, 4

;destroy node 2
;------------------------------------------------------------------------------	
	push dword [node2_ptr]
	call free
	add esp, 4
	
;exit to OS
;------------------------------------------------------------------------------	
	push dword [EXIT_SUCCESS]
	call exit

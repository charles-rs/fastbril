	.file	"main.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.weak	json_hexadecimal_digit
	.type	json_hexadecimal_digit, @function
json_hexadecimal_digit:
.LFB50:
	.cfi_startproc
	endbr64
	lea	eax, -48[rdi]
	cmp	al, 9
	jbe	.L7
	lea	eax, -97[rdi]
	cmp	al, 5
	jbe	.L8
	lea	edx, -65[rdi]
	lea	eax, -55[rdi]
	cmp	dl, 6
	movsx	eax, al
	mov	edx, -1
	cmovnb	eax, edx
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	sub	edi, 87
	movsx	eax, dil
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	movsx	eax, al
	ret
	.cfi_endproc
.LFE50:
	.size	json_hexadecimal_digit, .-json_hexadecimal_digit
	.p2align 4
	.weak	json_hexadecimal_value
	.type	json_hexadecimal_value, @function
json_hexadecimal_value:
.LFB51:
	.cfi_startproc
	endbr64
	cmp	rsi, 16
	ja	.L21
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	xor	eax, eax
	mov	r13, rdx
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	mov	r12, rdi
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	mov	rbx, rsi
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	mov	QWORD PTR [rdx], 0
	test	rsi, rsi
	jne	.L12
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L22:
	add	r12, 1
	cdqe
	or	rax, QWORD PTR 0[r13]
	mov	rdx, r12
	mov	QWORD PTR 0[r13], rax
	sub	rdx, rbp
	cmp	rbx, rdx
	jbe	.L14
.L12:
	sal	rax, 4
	mov	QWORD PTR 0[r13], rax
	movsx	edi, BYTE PTR [r12]
	call	json_hexadecimal_digit
	cmp	eax, 15
	jbe	.L22
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L14:
	.cfi_restore_state
	add	rsp, 8
	.cfi_def_cfa_offset 40
	mov	eax, 1
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L21:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	xor	eax, eax
	ret
	.cfi_endproc
.LFE51:
	.size	json_hexadecimal_value, .-json_hexadecimal_value
	.p2align 4
	.weak	json_skip_whitespace
	.type	json_skip_whitespace, @function
json_skip_whitespace:
.LFB52:
	.cfi_startproc
	endbr64
	mov	rax, QWORD PTR 16[rdi]
	mov	rcx, QWORD PTR [rdi]
	xor	r8d, r8d
	movzx	edx, BYTE PTR [rcx+rax]
	cmp	dl, 32
	ja	.L23
	movabs	rsi, 4294977024
	bt	rsi, rdx
	jc	.L45
.L23:
	mov	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L45:
	mov	rsi, QWORD PTR 8[rdi]
.L29:
	movzx	edx, BYTE PTR [rcx+rax]
	cmp	dl, 10
	je	.L25
	jle	.L46
	cmp	dl, 13
	je	.L27
	cmp	dl, 32
	jne	.L43
.L27:
	add	rax, 1
	cmp	rsi, rax
	ja	.L29
.L43:
	mov	QWORD PTR 16[rdi], rax
	mov	r8d, 1
.L47:
	mov	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L46:
	cmp	dl, 9
	je	.L27
	mov	QWORD PTR 16[rdi], rax
	mov	r8d, 1
	jmp	.L47
	.p2align 4,,10
	.p2align 3
.L25:
	mov	rdx, QWORD PTR 64[rdi]
	movq	xmm1, rax
	add	rdx, 1
	movq	xmm0, rdx
	punpcklqdq	xmm0, xmm1
	movups	XMMWORD PTR 64[rdi], xmm0
	jmp	.L27
	.cfi_endproc
.LFE52:
	.size	json_skip_whitespace, .-json_skip_whitespace
	.p2align 4
	.weak	json_skip_c_style_comments
	.type	json_skip_c_style_comments, @function
json_skip_c_style_comments:
.LFB53:
	.cfi_startproc
	endbr64
	mov	rcx, QWORD PTR [rdi]
	mov	rax, QWORD PTR 16[rdi]
	mov	rdx, rdi
	cmp	BYTE PTR [rcx+rax], 47
	je	.L49
.L55:
	xor	eax, eax
	ret
	.p2align 4,,10
	.p2align 3
.L49:
	lea	rsi, 1[rax]
	mov	QWORD PTR 16[rdi], rsi
	movzx	esi, BYTE PTR 1[rcx+rax]
	cmp	sil, 47
	je	.L63
	cmp	sil, 42
	jne	.L55
	mov	r8, QWORD PTR 8[rdi]
	lea	rsi, 2[rax]
	add	rax, 3
	mov	QWORD PTR 16[rdi], rsi
	cmp	r8, rax
	ja	.L58
	jmp	.L62
	.p2align 4,,10
	.p2align 3
.L56:
	cmp	sil, 10
	jne	.L57
	mov	rsi, QWORD PTR 64[rdx]
	movq	xmm1, rdi
	add	rsi, 1
	movq	xmm0, rsi
	punpcklqdq	xmm0, xmm1
	movups	XMMWORD PTR 64[rdx], xmm0
.L57:
	mov	QWORD PTR 16[rdx], rax
	add	rax, 1
	cmp	rax, r8
	jnb	.L62
.L58:
	movzx	esi, BYTE PTR -1[rcx+rax]
	lea	rdi, -1[rax]
	cmp	sil, 42
	jne	.L56
	cmp	BYTE PTR [rcx+rax], 47
	jne	.L57
	add	rax, 1
	mov	QWORD PTR 16[rdx], rax
.L62:
	mov	eax, 1
	ret
	.p2align 4,,10
	.p2align 3
.L63:
	add	rax, 2
	mov	QWORD PTR 16[rdi], rax
	mov	rdi, QWORD PTR 8[rdi]
	cmp	rax, rdi
	jb	.L52
	jmp	.L62
	.p2align 4,,10
	.p2align 3
.L64:
	cmp	rax, rdi
	jnb	.L62
.L52:
	movzx	esi, BYTE PTR [rcx+rax]
	add	rax, 1
	mov	QWORD PTR 16[rdx], rax
	cmp	sil, 10
	jne	.L64
	mov	rcx, QWORD PTR 64[rdx]
	movq	xmm2, rax
	mov	eax, 1
	add	rcx, 1
	movq	xmm0, rcx
	punpcklqdq	xmm0, xmm2
	movups	XMMWORD PTR 64[rdx], xmm0
	ret
	.cfi_endproc
.LFE53:
	.size	json_skip_c_style_comments, .-json_skip_c_style_comments
	.p2align 4
	.weak	json_skip_all_skippables
	.type	json_skip_all_skippables, @function
json_skip_all_skippables:
.LFB54:
	.cfi_startproc
	endbr64
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	mov	rbx, rdi
	mov	r12, QWORD PTR 8[rdi]
	test	BYTE PTR 24[rdi], 32
	je	.L66
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L67:
	mov	rdi, rbx
	call	json_skip_whitespace
	mov	ebp, eax
	cmp	QWORD PTR 16[rbx], r12
	je	.L69
	mov	rdi, rbx
	call	json_skip_c_style_comments
	or	eax, ebp
	je	.L71
.L70:
	cmp	QWORD PTR 16[rbx], r12
	jne	.L67
.L69:
	mov	QWORD PTR 80[rbx], 7
	mov	eax, 1
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L77:
	.cfi_restore_state
	mov	rdi, rbx
	call	json_skip_whitespace
	test	eax, eax
	je	.L71
.L66:
	cmp	QWORD PTR 16[rbx], r12
	jne	.L77
	jmp	.L69
	.p2align 4,,10
	.p2align 3
.L71:
	cmp	QWORD PTR 16[rbx], r12
	je	.L69
	pop	rbx
	.cfi_def_cfa_offset 24
	xor	eax, eax
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE54:
	.size	json_skip_all_skippables, .-json_skip_all_skippables
	.p2align 4
	.weak	json_get_string_size
	.type	json_get_string_size, @function
json_get_string_size:
.LFB55:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 72
	.cfi_def_cfa_offset 128
	mov	rbx, QWORD PTR 16[rdi]
	mov	r14, QWORD PTR [rdi]
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 56[rsp], rax
	xor	eax, eax
	mov	r9, QWORD PTR 24[rdi]
	mov	r8, QWORD PTR 8[rdi]
	lea	rdx, [r14+rbx]
	mov	rax, QWORD PTR 48[rdi]
	movzx	ecx, BYTE PTR [rdx]
	cmp	cl, 39
	sete	r12b
	lea	r12d, 34[r12+r12*4]
	test	r9b, r9b
	jns	.L80
	test	rsi, rsi
	jne	.L140
.L80:
	add	rax, 16
.L81:
	mov	QWORD PTR 48[rbp], rax
	cmp	BYTE PTR [rdx], 34
	je	.L82
	test	r9d, 256
	je	.L116
	cmp	cl, 39
	je	.L82
.L116:
	mov	QWORD PTR 80[rbp], 3
	mov	eax, 1
.L78:
	mov	rdx, QWORD PTR 56[rsp]
	sub	rdx, QWORD PTR fs:40
	jne	.L141
	add	rsp, 72
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L82:
	.cfi_restore_state
	add	rbx, 1
	cmp	r8, rbx
	jbe	.L113
	and	r9d, 8192
	xor	r13d, r13d
	mov	r11d, 1
	mov	QWORD PTR 8[rsp], 0
	jmp	.L86
	.p2align 4,,10
	.p2align 3
.L89:
	cmp	al, 13
	je	.L117
	cmp	al, 10
	je	.L117
.L105:
	add	rbx, 1
.L95:
	cmp	r8, rbx
	jbe	.L85
.L110:
	mov	r13, r15
.L86:
	movzx	eax, BYTE PTR [r14+rbx]
	cmp	al, r12b
	je	.L109
	lea	r15, 1[r13]
	test	al, al
	je	.L87
	cmp	al, 9
	je	.L87
	cmp	al, 92
	jne	.L89
	lea	r10, 1[rbx]
	cmp	r8, r10
	je	.L142
	movzx	eax, BYTE PTR 1[r14+rbx]
	cmp	al, 117
	jg	.L139
	cmp	al, 91
	jle	.L143
	lea	ecx, -92[rax]
	mov	rdx, r11
	sal	rdx, cl
	test	edx, 21234753
	jne	.L93
	cmp	al, 117
	je	.L94
.L139:
	mov	QWORD PTR 80[rbp], 4
	mov	eax, 1
	mov	QWORD PTR 16[rbp], r10
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L143:
	cmp	al, 34
	je	.L93
	cmp	al, 47
	jne	.L139
.L93:
	add	rbx, 2
	jmp	.L95
	.p2align 4,,10
	.p2align 3
.L117:
	test	r9, r9
	jne	.L105
	mov	QWORD PTR 80[rbp], 4
	mov	eax, 1
	mov	QWORD PTR 16[rbp], rbx
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L140:
	add	rax, 40
	jmp	.L81
	.p2align 4,,10
	.p2align 3
.L94:
	lea	rcx, 6[rbx]
	cmp	rcx, r8
	jnb	.L139
	lea	rdx, 48[rsp]
	lea	rdi, 2[r14+rbx]
	mov	esi, 4
	mov	QWORD PTR 40[rsp], r10
	mov	QWORD PTR 32[rsp], r8
	mov	QWORD PTR 24[rsp], r9
	mov	QWORD PTR 16[rsp], rcx
	mov	QWORD PTR 48[rsp], 0
	call	json_hexadecimal_value
	mov	rcx, QWORD PTR 16[rsp]
	mov	r9, QWORD PTR 24[rsp]
	mov	r11d, 1
	test	eax, eax
	mov	r8, QWORD PTR 32[rsp]
	mov	r10, QWORD PTR 40[rsp]
	je	.L139
	cmp	QWORD PTR 8[rsp], 0
	mov	rax, QWORD PTR 48[rsp]
	je	.L98
	sub	rax, 56320
	cmp	rax, 1023
	ja	.L139
	mov	QWORD PTR 8[rsp], 0
	lea	r15, 4[r13]
.L100:
	mov	rbx, rcx
	jmp	.L110
	.p2align 4,,10
	.p2align 3
.L98:
	cmp	rax, 127
	jbe	.L100
	cmp	rax, 2047
	jbe	.L144
	lea	rdx, -55296[rax]
	cmp	rdx, 1023
	ja	.L102
	lea	rdx, 12[rbx]
	cmp	rdx, r8
	ja	.L139
	cmp	BYTE PTR [r14+rcx], 92
	jne	.L139
	cmp	BYTE PTR 7[r14+rbx], 117
	jne	.L139
	mov	QWORD PTR 8[rsp], rax
	jmp	.L100
.L113:
	xor	r15d, r15d
	.p2align 4,,10
	.p2align 3
.L85:
	mov	r13, r15
	cmp	rbx, r8
	je	.L145
.L109:
	mov	rax, QWORD PTR 56[rbp]
	add	rbx, 1
	mov	QWORD PTR 16[rbp], rbx
	lea	rax, 1[r13+rax]
	mov	QWORD PTR 56[rbp], rax
	xor	eax, eax
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L87:
	mov	QWORD PTR 80[rbp], 8
	mov	eax, 1
	mov	QWORD PTR 16[rbp], rbx
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L144:
	lea	r15, 2[r13]
	jmp	.L100
.L145:
	sub	rbx, 1
	mov	QWORD PTR 80[rbp], 7
	mov	eax, 1
	mov	QWORD PTR 16[rbp], rbx
	jmp	.L78
.L142:
	mov	QWORD PTR 80[rbp], 7
	mov	eax, 1
	mov	QWORD PTR 16[rbp], r8
	jmp	.L78
.L102:
	cmp	rdx, 2047
	jbe	.L139
	lea	r15, 3[r13]
	jmp	.L100
.L141:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE55:
	.size	json_get_string_size, .-json_get_string_size
	.p2align 4
	.weak	is_valid_unquoted_key_char
	.type	is_valid_unquoted_key_char, @function
is_valid_unquoted_key_char:
.LFB56:
	.cfi_startproc
	endbr64
	lea	edx, -48[rdi]
	mov	eax, 1
	cmp	dl, 9
	jbe	.L146
	mov	eax, edi
	and	eax, -33
	sub	eax, 65
	cmp	al, 25
	setbe	al
	cmp	dil, 95
	sete	dl
	or	eax, edx
	movzx	eax, al
.L146:
	ret
	.cfi_endproc
.LFE56:
	.size	is_valid_unquoted_key_char, .-is_valid_unquoted_key_char
	.p2align 4
	.weak	json_get_key_size
	.type	json_get_key_size, @function
json_get_key_size:
.LFB57:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	mov	r15, QWORD PTR 24[rdi]
	test	r15b, 2
	je	.L150
	mov	rbx, QWORD PTR 16[rdi]
	mov	r14, QWORD PTR [rdi]
	movzx	eax, BYTE PTR [r14+rbx]
	cmp	al, 34
	je	.L150
	test	r15d, 256
	je	.L160
	cmp	al, 39
	je	.L150
.L160:
	mov	r13, QWORD PTR 8[r12]
	mov	rbp, QWORD PTR 56[r12]
	cmp	rbx, r13
	jnb	.L158
	add	r13, rbp
	sub	r13, rbx
	jmp	.L154
	.p2align 4,,10
	.p2align 3
.L155:
	add	rbx, 1
	cmp	r13, rbp
	je	.L159
.L154:
	movsx	edi, BYTE PTR [r14+rbx]
	call	is_valid_unquoted_key_char
	mov	r8d, eax
	mov	rax, rbp
	lea	rbp, 1[rbp]
	test	r8d, r8d
	jne	.L155
.L153:
	mov	rdx, QWORD PTR 48[r12]
	add	rax, 1
	mov	QWORD PTR 16[r12], rbx
	movq	xmm1, rax
	lea	rcx, 40[rdx]
	add	rdx, 16
	and	r15d, 128
	cmove	rcx, rdx
	xor	eax, eax
	movq	xmm0, rcx
	punpcklqdq	xmm0, xmm1
	movups	XMMWORD PTR 48[r12], xmm0
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L150:
	.cfi_restore_state
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rdi, r12
	mov	esi, 1
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	jmp	json_get_string_size
	.p2align 4,,10
	.p2align 3
.L159:
	.cfi_restore_state
	mov	rax, r13
	jmp	.L153
.L158:
	mov	rax, rbp
	jmp	.L153
	.cfi_endproc
.LFE57:
	.size	json_get_key_size, .-json_get_key_size
	.p2align 4
	.weak	json_get_number_size
	.type	json_get_number_size, @function
json_get_number_size:
.LFB60:
	.cfi_startproc
	endbr64
	mov	r11, QWORD PTR 24[rdi]
	mov	r8, rdi
	mov	r10, QWORD PTR 16[rdi]
	mov	rcx, QWORD PTR [r8]
	mov	rdi, QWORD PTR 8[rdi]
	add	QWORD PTR 48[r8], 16
	test	r11d, 512
	je	.L169
	lea	rax, 1[r10]
	cmp	rax, rdi
	jnb	.L169
	cmp	BYTE PTR [rcx+r10], 48
	je	.L246
	.p2align 4,,10
	.p2align 3
.L169:
	cmp	r10, rdi
	jnb	.L175
	movzx	eax, BYTE PTR [rcx+r10]
	cmp	al, 45
	je	.L176
	mov	rdx, r11
	and	edx, 4096
	test	r11d, 1024
	je	.L177
	cmp	al, 43
	je	.L176
.L177:
	mov	rax, r10
	xor	r9d, r9d
	test	rdx, rdx
	jne	.L178
.L180:
	cmp	rax, rdi
	jnb	.L172
.L183:
	movzx	edx, BYTE PTR [rcx+rax]
.L185:
	cmp	dl, 48
	je	.L247
.L207:
	xor	r9d, r9d
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L191:
	add	rax, 1
	cmp	rdi, rax
	jbe	.L172
	movzx	edx, BYTE PTR [rcx+rax]
	mov	r9d, 1
.L190:
	lea	esi, -48[rdx]
	cmp	sil, 9
	jbe	.L191
.L189:
	cmp	dl, 46
	je	.L248
.L205:
	mov	esi, edx
	and	esi, -33
	cmp	sil, 69
	jne	.L196
	lea	rdx, 1[rax]
	cmp	rdi, rdx
	jbe	.L197
	movzx	esi, BYTE PTR 1[rcx+rax]
	sub	esi, 43
	and	esi, 253
	jne	.L198
	lea	rdx, 2[rax]
	cmp	rdi, rdx
	jbe	.L197
.L198:
	movzx	eax, BYTE PTR [rcx+rdx]
	sub	eax, 48
	cmp	al, 9
	ja	.L249
.L197:
	mov	rax, rdx
	jmp	.L199
	.p2align 4,,10
	.p2align 3
.L250:
	movzx	esi, BYTE PTR [rcx+rax]
	lea	edx, -48[rsi]
	cmp	dl, 9
	ja	.L200
.L199:
	add	rax, 1
	cmp	rdi, rax
	ja	.L250
	.p2align 4,,10
	.p2align 3
.L172:
	mov	rdx, QWORD PTR 56[r8]
	mov	rcx, rax
	xor	r9d, r9d
	sub	rcx, r10
	lea	rdx, 1[rcx+rdx]
	mov	QWORD PTR 56[r8], rdx
.L188:
	mov	QWORD PTR 16[r8], rax
	mov	eax, r9d
	ret
	.p2align 4,,10
	.p2align 3
.L175:
	mov	rax, r10
	xor	r9d, r9d
	test	r11d, 4096
	je	.L172
.L178:
	lea	rdx, 8[rax]
	cmp	rdx, rdi
	jnb	.L181
	cmp	BYTE PTR [rcx+rax], 73
	jne	.L181
	cmp	BYTE PTR 1[rcx+rax], 110
	jne	.L181
	cmp	BYTE PTR 2[rcx+rax], 102
	jne	.L181
	cmp	BYTE PTR 3[rcx+rax], 105
	jne	.L181
	cmp	BYTE PTR 4[rcx+rax], 110
	jne	.L181
	cmp	BYTE PTR 5[rcx+rax], 105
	jne	.L181
	cmp	BYTE PTR 6[rcx+rax], 116
	jne	.L181
	cmp	BYTE PTR 7[rcx+rax], 121
	jne	.L181
	lea	rsi, 11[rax]
	cmp	rdi, rsi
	ja	.L182
	mov	rax, rdx
	jmp	.L183
	.p2align 4,,10
	.p2align 3
.L181:
	lea	rsi, 3[rax]
	cmp	rsi, rdi
	jnb	.L184
	cmp	BYTE PTR [rcx+rax], 78
	jne	.L184
	cmp	BYTE PTR 1[rcx+rax], 97
	jne	.L184
.L212:
	cmp	BYTE PTR 2[rcx+rax], 78
	jne	.L184
	mov	rax, rsi
	jmp	.L180
.L252:
	cmp	rdi, rax
	jbe	.L172
.L200:
	movzx	edx, BYTE PTR [rcx+rax]
.L196:
	cmp	dl, 61
	jg	.L201
	cmp	dl, 8
	jle	.L202
	movabs	rcx, 17596481021440
	bt	rcx, rdx
	jc	.L172
	cmp	dl, 61
	je	.L251
.L202:
	mov	r9d, 1
	mov	QWORD PTR 16[r8], rax
	mov	QWORD PTR 80[r8], 5
	mov	eax, r9d
	ret
	.p2align 4,,10
	.p2align 3
.L201:
	and	edx, -33
	cmp	dl, 93
	jne	.L202
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L176:
	lea	rax, 1[r10]
	test	r11d, 4096
	jne	.L213
.L179:
	cmp	rdi, rax
	jbe	.L172
	movzx	edx, BYTE PTR [rcx+rax]
	lea	esi, -48[rdx]
	cmp	sil, 9
	jbe	.L185
	test	r11d, 2048
	je	.L202
	cmp	dl, 46
	jne	.L202
	jmp	.L207
	.p2align 4,,10
	.p2align 3
.L184:
	test	r9d, r9d
	jne	.L179
	jmp	.L180
	.p2align 4,,10
	.p2align 3
.L213:
	mov	r9d, 1
	jmp	.L178
	.p2align 4,,10
	.p2align 3
.L246:
	movzx	eax, BYTE PTR 1[rcx+r10]
	and	eax, -33
	cmp	al, 88
	jne	.L170
	lea	rax, 2[r10]
	cmp	rdi, rax
	jbe	.L172
	.p2align 4,,10
	.p2align 3
.L171:
	movzx	edx, BYTE PTR [rcx+rax]
	lea	esi, -48[rdx]
	cmp	sil, 9
	jbe	.L173
	and	edx, -33
	sub	edx, 65
	cmp	dl, 5
	ja	.L252
.L173:
	add	rax, 1
	cmp	rdi, rax
	ja	.L171
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L247:
	add	rax, 1
	cmp	rdi, rax
	jbe	.L172
	movzx	edx, BYTE PTR [rcx+rax]
	mov	r9d, 1
	lea	esi, -48[rdx]
	cmp	sil, 9
	ja	.L189
	mov	QWORD PTR 80[r8], 5
	jmp	.L188
	.p2align 4,,10
	.p2align 3
.L248:
	add	rax, 1
	movzx	edx, BYTE PTR [rcx+rax]
	lea	esi, -48[rdx]
	cmp	sil, 9
	jbe	.L192
	test	r11d, 2048
	je	.L202
	test	r9d, r9d
	je	.L202
.L192:
	cmp	rdi, rax
	ja	.L194
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L195:
	add	rax, 1
	cmp	rdi, rax
	jbe	.L172
	movzx	edx, BYTE PTR [rcx+rax]
.L194:
	lea	esi, -48[rdx]
	cmp	sil, 9
	jbe	.L195
	cmp	rdi, rax
	ja	.L205
	jmp	.L172
	.p2align 4,,10
	.p2align 3
.L251:
	and	r11d, 8
	jne	.L172
	jmp	.L202
.L182:
	cmp	BYTE PTR [rcx+rdx], 78
	jne	.L211
	cmp	BYTE PTR 9[rcx+rax], 97
	jne	.L211
	mov	rax, rdx
	xor	r9d, r9d
	jmp	.L212
.L170:
	cmp	r10, rdi
	jnb	.L175
	mov	rdx, r11
	and	edx, 4096
	jmp	.L177
.L249:
	mov	QWORD PTR 80[r8], 5
	mov	rax, rdx
	mov	r9d, 1
	jmp	.L188
.L211:
	mov	rax, rdx
	jmp	.L180
	.cfi_endproc
.LFE60:
	.size	json_get_number_size, .-json_get_number_size
	.p2align 4
	.weak	json_get_value_size
	.type	json_get_value_size, @function
json_get_value_size:
.LFB61:
	.cfi_startproc
	endbr64
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	mov	rax, QWORD PTR 48[rdi]
	mov	r12, QWORD PTR 24[rdi]
	mov	r13, QWORD PTR [rdi]
	mov	rbx, QWORD PTR 8[rdi]
	lea	rdx, 40[rax]
	add	rax, 16
	test	r12b, -128
	cmovne	rax, rdx
	mov	QWORD PTR 48[rdi], rax
	test	esi, esi
	jne	.L321
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L322
	mov	rsi, QWORD PTR 16[rbp]
	movzx	ecx, BYTE PTR 0[r13+rsi]
	cmp	cl, 91
	jg	.L259
	cmp	cl, 33
	jle	.L260
	lea	edx, -34[rcx]
	cmp	dl, 57
	ja	.L261
	lea	rdi, .L263[rip]
	movzx	edx, dl
	movsx	rdx, DWORD PTR [rdi+rdx*4]
	add	rdx, rdi
	notrack jmp	rdx
	.section	.rodata
	.align 4
	.align 4
.L263:
	.long	.L320-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L267-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L266-.L263
	.long	.L261-.L263
	.long	.L273-.L263
	.long	.L265-.L263
	.long	.L261-.L263
	.long	.L273-.L263
	.long	.L273-.L263
	.long	.L273-.L263
	.long	.L273-.L263
	.long	.L273-.L263
	.long	.L273-.L263
	.long	.L273-.L263
	.long	.L273-.L263
	.long	.L273-.L263
	.long	.L273-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L261-.L263
	.long	.L262-.L263
	.text
	.p2align 4,,10
	.p2align 3
.L322:
	mov	QWORD PTR 80[rbp], 7
	mov	eax, 1
.L253:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L259:
	.cfi_restore_state
	cmp	cl, 123
	jne	.L323
	xor	esi, esi
.L319:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	rdi, rbp
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	jmp	json_get_object_size
	.p2align 4,,10
	.p2align 3
.L321:
	.cfi_restore_state
	mov	esi, 1
	jmp	.L319
.L266:
	test	r12d, 1024
	je	.L272
.L273:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	rdi, rbp
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	jmp	json_get_number_size
.L267:
	.cfi_restore_state
	test	r12d, 256
	je	.L271
.L320:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	rdi, rbp
	xor	esi, esi
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	jmp	json_get_string_size
.L265:
	.cfi_restore_state
	test	r12d, 2048
	jne	.L273
.L272:
	mov	QWORD PTR 80[rbp], 5
	mov	eax, 1
	jmp	.L253
.L325:
	cmp	BYTE PTR 1[r13+rsi], 97
	jne	.L271
	cmp	BYTE PTR 2[r13+rsi], 78
	je	.L273
	.p2align 4,,10
	.p2align 3
.L271:
	mov	QWORD PTR 80[rbp], 6
	mov	eax, 1
	jmp	.L253
.L262:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	rdi, rbp
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	jmp	json_get_array_size
.L261:
	.cfi_restore_state
	lea	rdx, 4[rsi]
	cmp	rbx, rdx
	setnb	dil
.L274:
	lea	r8, 5[rsi]
	cmp	cl, 102
	jne	.L276
	cmp	r8, rbx
	ja	.L276
	cmp	BYTE PTR 1[r13+rsi], 97
	je	.L324
	.p2align 4,,10
	.p2align 3
.L276:
	test	dil, dil
	jne	.L279
.L277:
	test	r12d, 4096
	je	.L271
	lea	rax, 3[rsi]
	cmp	rax, rbx
	ja	.L278
	cmp	cl, 78
	je	.L325
.L278:
	lea	rax, 8[rsi]
	cmp	rax, rbx
	ja	.L271
	cmp	cl, 73
	jne	.L271
	cmp	BYTE PTR 1[r13+rsi], 110
	jne	.L271
	cmp	BYTE PTR 2[r13+rsi], 102
	jne	.L271
	cmp	BYTE PTR 3[r13+rsi], 105
	jne	.L271
	cmp	BYTE PTR 0[r13+rdx], 110
	jne	.L271
	cmp	BYTE PTR 0[r13+r8], 105
	jne	.L271
	cmp	BYTE PTR 6[r13+rsi], 116
	jne	.L271
	cmp	BYTE PTR 7[r13+rsi], 121
	jne	.L271
	jmp	.L273
	.p2align 4,,10
	.p2align 3
.L260:
	lea	rdx, 4[rsi]
	lea	r8, 5[rsi]
	cmp	rbx, rdx
	setnb	dil
	jmp	.L276
	.p2align 4,,10
	.p2align 3
.L323:
	lea	rdx, 4[rsi]
	cmp	rdx, rbx
	setbe	r8b
	mov	edi, r8d
	cmp	cl, 116
	jne	.L274
	test	r8b, r8b
	je	.L274
	cmp	BYTE PTR 1[r13+rsi], 114
	je	.L326
.L275:
	lea	r8, 5[rsi]
.L279:
	mov	rdi, QWORD PTR 0[rbp]
	cmp	BYTE PTR [rdi+rsi], 110
	jne	.L277
	cmp	BYTE PTR 1[rdi+rsi], 117
	jne	.L277
	cmp	BYTE PTR 2[rdi+rsi], 108
	jne	.L277
	cmp	BYTE PTR 3[rdi+rsi], 108
	jne	.L277
.L318:
	mov	QWORD PTR 16[rbp], rdx
	jmp	.L253
.L324:
	cmp	BYTE PTR 2[r13+rsi], 108
	jne	.L276
	cmp	BYTE PTR 3[r13+rsi], 115
	jne	.L276
	cmp	BYTE PTR 0[r13+rdx], 101
	jne	.L276
	mov	QWORD PTR 16[rbp], r8
	jmp	.L253
	.p2align 4,,10
	.p2align 3
.L326:
	cmp	BYTE PTR 2[r13+rsi], 117
	jne	.L275
	cmp	BYTE PTR 3[r13+rsi], 101
	jne	.L275
	jmp	.L318
	.cfi_endproc
.LFE61:
	.size	json_get_value_size, .-json_get_value_size
	.p2align 4
	.weak	json_get_object_size
	.type	json_get_object_size, @function
json_get_object_size:
.LFB58:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	mov	r14, rdi
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 40
	.cfi_def_cfa_offset 96
	mov	rax, QWORD PTR 8[rdi]
	mov	r13, QWORD PTR 24[rdi]
	mov	rbx, QWORD PTR [rdi]
	mov	QWORD PTR 8[rsp], rax
	test	esi, esi
	jne	.L328
	mov	rax, QWORD PTR 16[rdi]
.L329:
	cmp	BYTE PTR [rbx+rax], 123
	je	.L331
	mov	QWORD PTR 80[r14], 11
	mov	r15d, 1
.L327:
	add	rsp, 40
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	eax, r15d
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L331:
	.cfi_restore_state
	add	rax, 1
	add	QWORD PTR 48[r14], 16
	xor	ebp, ebp
	mov	QWORD PTR 16[r14], rax
	cmp	rax, QWORD PTR 8[rsp]
	je	.L335
.L333:
	mov	rax, r13
	xor	r15d, r15d
	xor	r12d, r12d
	and	eax, 16
	mov	QWORD PTR 24[rsp], rax
	mov	rax, r13
	and	r13d, 8
	and	eax, 1
	mov	QWORD PTR 16[rsp], rax
	jmp	.L348
	.p2align 4,,10
	.p2align 3
.L367:
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L335
	mov	rax, QWORD PTR 16[r14]
	cmp	BYTE PTR [rbx+rax], 125
	je	.L336
.L340:
	test	r15d, r15d
	je	.L338
	mov	rax, QWORD PTR 16[r14]
	cmp	BYTE PTR [rbx+rax], 44
	je	.L363
	cmp	QWORD PTR 24[rsp], 0
	je	.L364
.L342:
	cmp	QWORD PTR 16[rsp], 0
	jne	.L350
	mov	rdi, r14
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L335
.L338:
	mov	rdi, r14
	call	json_get_key_size
	test	eax, eax
	jne	.L365
	mov	rdi, r14
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L335
	mov	rax, QWORD PTR 16[r14]
	movzx	ecx, BYTE PTR [rbx+rax]
	test	r13, r13
	je	.L345
	cmp	cl, 58
	je	.L346
	cmp	cl, 61
	jne	.L347
.L346:
	add	rax, 1
	mov	rdi, r14
	mov	QWORD PTR 16[r14], rax
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L335
	xor	esi, esi
	mov	rdi, r14
	call	json_get_value_size
	test	eax, eax
	jne	.L351
	mov	rax, QWORD PTR 16[r14]
	add	r12, 1
	mov	r15d, 1
.L343:
	cmp	QWORD PTR 8[rsp], rax
	jbe	.L366
.L348:
	mov	rdi, r14
	test	ebp, ebp
	je	.L367
	call	json_skip_all_skippables
	test	eax, eax
	je	.L340
.L339:
	lea	rax, [r12+r12*2]
	xor	r15d, r15d
	sal	rax, 3
	add	QWORD PTR 48[r14], rax
	jmp	.L327
	.p2align 4,,10
	.p2align 3
.L366:
	jne	.L339
	test	ebp, ebp
	jne	.L339
	.p2align 4,,10
	.p2align 3
.L335:
	mov	QWORD PTR 80[r14], 7
	mov	r15d, 1
	jmp	.L327
	.p2align 4,,10
	.p2align 3
.L350:
	xor	r15d, r15d
	jmp	.L343
	.p2align 4,,10
	.p2align 3
.L345:
	cmp	cl, 58
	je	.L346
.L347:
	mov	QWORD PTR 80[r14], 2
	mov	r15d, 1
	jmp	.L327
	.p2align 4,,10
	.p2align 3
.L363:
	add	rax, 1
	mov	QWORD PTR 16[r14], rax
	jmp	.L342
	.p2align 4,,10
	.p2align 3
.L328:
	mov	ebp, esi
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L330
	mov	rax, QWORD PTR 16[r14]
	mov	rcx, QWORD PTR [r14]
	cmp	BYTE PTR [rcx+rax], 123
	je	.L329
.L330:
	add	QWORD PTR 48[r14], 16
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L365:
	mov	QWORD PTR 80[r14], 8
	mov	r15d, 1
	jmp	.L327
	.p2align 4,,10
	.p2align 3
.L351:
	mov	r15d, 1
	jmp	.L327
.L336:
	add	rax, 1
	mov	QWORD PTR 16[r14], rax
	jmp	.L339
.L364:
	mov	QWORD PTR 80[r14], 1
	jmp	.L327
	.cfi_endproc
.LFE58:
	.size	json_get_object_size, .-json_get_object_size
	.p2align 4
	.weak	json_get_array_size
	.type	json_get_array_size, @function
json_get_array_size:
.LFB59:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	mov	r12, QWORD PTR [rdi]
	mov	rbx, rdi
	mov	rax, QWORD PTR 16[rdi]
	mov	rbp, QWORD PTR 24[rdi]
	mov	r13, QWORD PTR 8[rdi]
	cmp	BYTE PTR [r12+rax], 91
	je	.L369
	mov	QWORD PTR 80[rdi], 11
	mov	eax, 1
.L368:
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L369:
	.cfi_restore_state
	add	rax, 1
	add	QWORD PTR 48[rdi], 16
	mov	QWORD PTR 16[rdi], rax
	cmp	rax, r13
	jnb	.L372
	mov	r14, rbp
	and	r14d, 16
	and	ebp, 1
	jne	.L373
	test	r14, r14
	je	.L397
	xor	r14d, r14d
	jmp	.L381
	.p2align 4,,10
	.p2align 3
.L414:
	mov	rax, QWORD PTR 16[rbx]
	movzx	edx, BYTE PTR [r12+rax]
	cmp	dl, 93
	je	.L376
	test	r14d, r14d
	je	.L377
	cmp	dl, 44
	jne	.L378
	add	rax, 1
	mov	QWORD PTR 16[rbx], rax
.L378:
	mov	rdi, rbx
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L372
.L377:
	xor	esi, esi
	mov	rdi, rbx
	call	json_get_value_size
	test	eax, eax
	jne	.L380
	add	rbp, 1
	mov	r14d, 1
	cmp	r13, QWORD PTR 16[rbx]
	jbe	.L372
.L381:
	mov	rdi, rbx
	call	json_skip_all_skippables
	test	eax, eax
	je	.L414
.L372:
	mov	QWORD PTR 80[rbx], 7
	mov	eax, 1
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L373:
	.cfi_restore_state
	test	r14, r14
	je	.L399
	xor	r14d, r14d
	xor	ebp, ebp
	jmp	.L391
	.p2align 4,,10
	.p2align 3
.L387:
	cmp	dl, 44
	jne	.L390
	add	rax, 1
	mov	QWORD PTR 16[rbx], rax
.L390:
	xor	r14d, r14d
.L388:
	cmp	r13, rax
	jbe	.L372
.L391:
	mov	rdi, rbx
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L372
	mov	rax, QWORD PTR 16[rbx]
	movzx	edx, BYTE PTR [r12+rax]
	cmp	dl, 93
	je	.L376
	test	r14d, r14d
	jne	.L387
	xor	esi, esi
	mov	rdi, rbx
	call	json_get_value_size
	test	eax, eax
	jne	.L380
	mov	rax, QWORD PTR 16[rbx]
	add	rbp, 1
	mov	r14d, 1
	jmp	.L388
.L398:
	mov	rbp, r14
.L376:
	add	rax, 1
	sal	rbp, 4
	add	QWORD PTR 48[rbx], rbp
	mov	QWORD PTR 16[rbx], rax
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xor	eax, eax
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L380:
	.cfi_restore_state
	mov	eax, 1
	jmp	.L368
.L397:
	xor	ebp, ebp
.L374:
	mov	rdi, rbx
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L372
	mov	rax, QWORD PTR 16[rbx]
	movzx	edx, BYTE PTR [r12+rax]
	cmp	dl, 93
	je	.L398
	test	ebp, ebp
	je	.L385
	cmp	dl, 44
	je	.L415
.L384:
	mov	QWORD PTR 80[rbx], 1
	mov	eax, 1
	jmp	.L368
.L415:
	add	rax, 1
	mov	rdi, rbx
	mov	QWORD PTR 16[rbx], rax
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L372
.L385:
	xor	esi, esi
	mov	rdi, rbx
	call	json_get_value_size
	test	eax, eax
	jne	.L380
	add	r14, 1
	mov	ebp, 1
	cmp	r13, QWORD PTR 16[rbx]
	ja	.L374
	jmp	.L372
.L399:
	xor	ebp, ebp
	jmp	.L386
.L416:
	cmp	dl, 44
	jne	.L384
	add	rax, 1
	xor	ebp, ebp
	mov	QWORD PTR 16[rbx], rax
.L395:
	cmp	rax, r13
	jnb	.L372
.L386:
	mov	rdi, rbx
	call	json_skip_all_skippables
	test	eax, eax
	jne	.L372
	mov	rax, QWORD PTR 16[rbx]
	movzx	edx, BYTE PTR [r12+rax]
	cmp	dl, 93
	je	.L398
	test	ebp, ebp
	jne	.L416
	xor	esi, esi
	mov	rdi, rbx
	call	json_get_value_size
	test	eax, eax
	jne	.L380
	mov	rax, QWORD PTR 16[rbx]
	add	r14, 1
	mov	ebp, 1
	jmp	.L395
	.cfi_endproc
.LFE59:
	.size	json_get_array_size, .-json_get_array_size
	.p2align 4
	.weak	json_parse_string
	.type	json_parse_string, @function
json_parse_string:
.LFB62:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	mov	edx, 34
	mov	r15, rdi
	mov	r8, rsi
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	r12, QWORD PTR [rdi]
	mov	r14, QWORD PTR 32[rdi]
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	mov	rax, QWORD PTR 16[rdi]
	movzx	r13d, BYTE PTR [r12+rax]
	mov	QWORD PTR [rsi], r14
	lea	rbp, 1[rax]
	movzx	edi, BYTE PTR 1[r12+rax]
	cmp	r13b, 39
	cmovne	r13d, edx
	cmp	r13b, dil
	je	.L444
	xor	r11d, r11d
	mov	rax, r15
	lea	rcx, .L428[rip]
	xor	ebx, ebx
	mov	r15, r11
	lea	r10, 32[rsp]
	mov	r11, rax
	jmp	.L441
	.p2align 4,,10
	.p2align 3
.L420:
	mov	BYTE PTR [r14+rbx], dil
	movzx	edi, BYTE PTR [rsi]
	add	rbx, 1
	mov	rbp, rax
.L437:
	cmp	r13b, dil
	je	.L453
.L441:
	lea	rax, 1[rbp]
	lea	rsi, [r12+rax]
	cmp	dil, 92
	jne	.L420
	movzx	eax, BYTE PTR [rsi]
	lea	rdx, 2[rbp]
	cmp	al, 117
	jg	.L417
	cmp	al, 91
	jle	.L454
	sub	eax, 92
	cmp	al, 25
	ja	.L417
	movzx	eax, al
	movsx	rax, DWORD PTR [rcx+rax*4]
	add	rax, rcx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L428:
	.long	.L434-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L433-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L432-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L425-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L417-.L428
	.long	.L430-.L428
	.long	.L417-.L428
	.long	.L429-.L428
	.long	.L427-.L428
	.text
	.p2align 4,,10
	.p2align 3
.L453:
	mov	r15, r11
	add	r14, rbx
	lea	rax, 1[rbx]
.L419:
	mov	QWORD PTR 8[r8], rbx
	add	rbp, 1
	mov	BYTE PTR [r14], 0
	add	QWORD PTR 32[r15], rax
	mov	QWORD PTR 16[r15], rbp
	.p2align 4,,10
	.p2align 3
.L417:
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L455
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L425:
	.cfi_restore_state
	mov	BYTE PTR [r14+rbx], 10
	mov	rbp, rdx
	movzx	edi, BYTE PTR [r12+rdx]
	add	rbx, 1
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L454:
	cmp	al, 34
	je	.L423
	jle	.L456
	cmp	al, 47
	jne	.L417
	mov	BYTE PTR [r14+rbx], 47
	mov	rbp, rdx
	movzx	edi, BYTE PTR [r12+rdx]
	add	rbx, 1
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L456:
	cmp	al, 10
	je	.L425
	cmp	al, 13
	jne	.L417
	mov	BYTE PTR [r14+rbx], 13
	movzx	edi, BYTE PTR [r12+rdx]
	lea	rax, 1[rbx]
	cmp	dil, 10
	je	.L457
	mov	rbx, rax
	mov	rbp, rdx
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L427:
	lea	rdi, [r12+rdx]
	mov	esi, 4
	mov	rdx, r10
	mov	QWORD PTR 24[rsp], r8
	mov	QWORD PTR 16[rsp], r11
	mov	QWORD PTR 32[rsp], 0
	mov	QWORD PTR 8[rsp], r10
	call	json_hexadecimal_value
	test	eax, eax
	je	.L417
	mov	rax, QWORD PTR 32[rsp]
	add	rbp, 6
	mov	r10, QWORD PTR 8[rsp]
	lea	rcx, .L428[rip]
	mov	r11, QWORD PTR 16[rsp]
	mov	r8, QWORD PTR 24[rsp]
	lea	rdx, [r12+rbp]
	mov	r9d, 4238353408
	cmp	rax, 127
	ja	.L436
	mov	BYTE PTR [r14+rbx], al
	add	rbx, 1
	movzx	edi, BYTE PTR [rdx]
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L429:
	mov	BYTE PTR [r14+rbx], 9
	mov	rbp, rdx
	movzx	edi, BYTE PTR [r12+rdx]
	add	rbx, 1
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L432:
	mov	BYTE PTR [r14+rbx], 12
	mov	rbp, rdx
	movzx	edi, BYTE PTR [r12+rdx]
	add	rbx, 1
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L433:
	mov	BYTE PTR [r14+rbx], 8
	mov	rbp, rdx
	movzx	edi, BYTE PTR [r12+rdx]
	add	rbx, 1
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L434:
	mov	BYTE PTR [r14+rbx], 92
	mov	rbp, rdx
	movzx	edi, BYTE PTR [r12+rdx]
	add	rbx, 1
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L430:
	mov	BYTE PTR [r14+rbx], 13
	mov	rbp, rdx
	movzx	edi, BYTE PTR [r12+rdx]
	add	rbx, 1
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L423:
	mov	BYTE PTR [r14+rbx], 34
	mov	rbp, rdx
	movzx	edi, BYTE PTR [r12+rdx]
	add	rbx, 1
	jmp	.L437
	.p2align 4,,10
	.p2align 3
.L436:
	cmp	rax, 2047
	jbe	.L458
	lea	rsi, -55296[rax]
	cmp	rsi, 1023
	jbe	.L459
	lea	rsi, 1[r14+rbx]
	lea	rdi, 3[rbx]
	mov	QWORD PTR 16[rsp], rsi
	lea	rsi, 2[r14+rbx]
	mov	QWORD PTR 8[rsp], rdi
	lea	rdi, -56320[rax]
	mov	QWORD PTR 24[rsp], rsi
	lea	rsi, [r14+rbx]
	cmp	rdi, 1023
	ja	.L440
	add	rax, r9
	sal	r15, 10
	mov	rdi, QWORD PTR 8[rsp]
	add	r15, rax
	mov	QWORD PTR 32[rsp], r15
	shr	r15, 18
	or	r15d, -16
	mov	BYTE PTR [rsi], r15b
	mov	rax, QWORD PTR 32[rsp]
	lea	rsi, 1[r14+rbx]
	xor	r15d, r15d
	shr	rax, 12
	and	eax, 63
	or	eax, -128
	mov	BYTE PTR [rsi], al
	mov	rax, QWORD PTR 32[rsp]
	lea	rsi, 2[r14+rbx]
	add	rbx, 4
	shr	rax, 6
	and	eax, 63
	or	eax, -128
	mov	BYTE PTR [rsi], al
	movzx	eax, BYTE PTR 32[rsp]
	and	eax, 63
	or	eax, -128
	mov	BYTE PTR [r14+rdi], al
	movzx	edi, BYTE PTR [rdx]
	jmp	.L437
.L457:
	add	rbp, 3
	mov	BYTE PTR [r14+rax], 10
	add	rbx, 2
	movzx	edi, BYTE PTR [r12+rbp]
	jmp	.L437
.L458:
	shr	rax, 6
	lea	rsi, 1[rbx]
	or	eax, -64
	mov	BYTE PTR [r14+rbx], al
	movzx	eax, BYTE PTR 32[rsp]
	add	rbx, 2
	and	eax, 63
	or	eax, -128
	mov	BYTE PTR [r14+rsi], al
	movzx	edi, BYTE PTR [rdx]
	jmp	.L437
.L440:
	shr	rax, 12
	mov	rbx, QWORD PTR 8[rsp]
	or	eax, -32
	mov	BYTE PTR [rsi], al
	mov	rax, QWORD PTR 32[rsp]
	mov	rsi, QWORD PTR 16[rsp]
	shr	rax, 6
	and	eax, 63
	or	eax, -128
	mov	BYTE PTR [rsi], al
	movzx	eax, BYTE PTR 32[rsp]
	mov	rsi, QWORD PTR 24[rsp]
	and	eax, 63
	or	eax, -128
	mov	BYTE PTR [rsi], al
	movzx	edi, BYTE PTR [rdx]
	jmp	.L437
.L444:
	mov	eax, 1
	xor	ebx, ebx
	jmp	.L419
.L459:
	movzx	edi, BYTE PTR [rdx]
	mov	r15, rax
	jmp	.L437
.L455:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE62:
	.size	json_parse_string, .-json_parse_string
	.p2align 4
	.weak	json_parse_key
	.type	json_parse_key, @function
json_parse_key:
.LFB63:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	mov	r14, rsi
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rdi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	test	BYTE PTR 24[rdi], 2
	je	.L461
	mov	r12, QWORD PTR [rdi]
	mov	rbx, QWORD PTR 16[rdi]
	movzx	eax, BYTE PTR [r12+rbx]
	cmp	al, 34
	je	.L461
	cmp	al, 39
	je	.L461
	mov	rbp, QWORD PTR 32[rdi]
	xor	r15d, r15d
	mov	QWORD PTR [rsi], rbp
	jmp	.L464
	.p2align 4,,10
	.p2align 3
.L465:
	add	rbx, 1
	add	rbp, 1
	mov	r15, rax
	movzx	edx, BYTE PTR -1[r12+rbx]
	mov	BYTE PTR -1[rbp], dl
.L464:
	movsx	edi, BYTE PTR [r12+rbx]
	call	is_valid_unquoted_key_char
	mov	r8d, eax
	lea	rax, 1[r15]
	test	r8d, r8d
	jne	.L465
	mov	BYTE PTR 0[rbp], 0
	mov	QWORD PTR 8[r14], r15
	mov	QWORD PTR 16[r13], rbx
	add	QWORD PTR 32[r13], rax
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L461:
	.cfi_restore_state
	add	rsp, 8
	.cfi_def_cfa_offset 56
	mov	rsi, r14
	mov	rdi, r13
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	jmp	json_parse_string
	.cfi_endproc
.LFE63:
	.size	json_parse_key, .-json_parse_key
	.p2align 4
	.weak	json_parse_number
	.type	json_parse_number, @function
json_parse_number:
.LFB66:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rsi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	r13, QWORD PTR 24[rdi]
	mov	rbx, rdi
	mov	rdx, QWORD PTR 16[rdi]
	mov	r12, QWORD PTR 8[rdi]
	mov	r10, QWORD PTR [rdi]
	mov	rdi, QWORD PTR 32[rdi]
	mov	rax, r13
	mov	QWORD PTR [rsi], rdi
	and	eax, 512
	je	.L484
	lea	rsi, [r10+rdx]
	movzx	eax, BYTE PTR [rsi]
	cmp	al, 48
	je	.L472
.L485:
	mov	r9, rdi
	mov	ecx, 1
	xor	eax, eax
	jmp	.L471
	.p2align 4,,10
	.p2align 3
.L484:
	mov	r9, rdi
	mov	ecx, 1
.L471:
	cmp	r12, rdx
	jbe	.L499
	movabs	r14, 288230376218853357
	lea	r11, [r12+rax]
	sub	r11, rdx
	.p2align 4,,10
	.p2align 3
.L479:
	movzx	ecx, BYTE PTR [r10+rdx]
	lea	r9, [rdi+rax]
	mov	r8, rax
	add	rax, 1
	lea	esi, -43[rcx]
	cmp	sil, 58
	ja	.L474
	bt	r14, rsi
	jc	.L500
.L474:
	test	r13d, 4096
	je	.L480
	lea	rcx, 8[rdx]
	cmp	rcx, r12
	jnb	.L481
	lea	rsi, [r10+rdx]
	cmp	BYTE PTR [rsi], 73
	je	.L501
.L481:
	lea	rcx, 3[rdx]
	cmp	rcx, r12
	jnb	.L480
	cmp	BYTE PTR [r10+rdx], 78
	je	.L502
.L480:
	mov	QWORD PTR 8[rbp], r8
	mov	BYTE PTR [r9], 0
	mov	QWORD PTR 16[rbx], rdx
	add	QWORD PTR 32[rbx], rax
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L500:
	.cfi_restore_state
	mov	BYTE PTR -1[rdi+rax], cl
	add	rdx, 1
	cmp	rax, r11
	jne	.L479
	lea	rcx, 2[r8]
	lea	r9, [rdi+rax]
.L499:
	mov	r8, rax
	mov	rax, rcx
	jmp	.L474
	.p2align 4,,10
	.p2align 3
.L472:
	movzx	ecx, BYTE PTR 1[r10+rdx]
	lea	r14, 1[rdx]
	and	ecx, -33
	cmp	cl, 88
	jne	.L485
	cmp	rdx, r12
	jnb	.L486
	movabs	r15, 36028797027352639
	mov	r9, r12
	xor	ecx, ecx
	sub	r9, rdx
.L496:
	lea	r8, 1[rcx]
	lea	rdx, [r14+rcx]
	mov	BYTE PTR -1[rdi+r8], al
	cmp	r8, r9
	je	.L503
	movzx	eax, BYTE PTR 1[rsi+rcx]
	lea	r11d, -48[rax]
	cmp	r11b, 9
	jbe	.L488
	lea	r11d, -97[rax]
	cmp	r11b, 5
	jbe	.L488
	lea	r11d, -65[rax]
	cmp	r11b, 55
	ja	.L478
	bt	r15, r11
	jc	.L488
.L478:
	add	rcx, 2
	lea	r9, [rdi+r8]
	mov	rax, r8
	jmp	.L471
.L501:
	lea	rax, [rdi+r8]
	lea	r9, 1[r10+rdx]
	mov	r11, rax
	sub	r11, r9
	cmp	r11, 6
	jbe	.L482
	mov	rdx, QWORD PTR [rsi]
	mov	QWORD PTR [rax], rdx
.L483:
	lea	rdx, 8[r8]
	lea	rax, 9[r8]
	lea	r9, [rdi+rdx]
	mov	r8, rdx
	mov	rdx, rcx
	jmp	.L481
.L502:
	mov	BYTE PTR [rdi+r8], 78
	movzx	eax, BYTE PTR 1[r10+rdx]
	mov	BYTE PTR 1[rdi+r8], al
	movzx	eax, BYTE PTR 2[r10+rdx]
	lea	rdx, 3[r8]
	lea	r9, [rdi+rdx]
	mov	BYTE PTR 2[rdi+r8], al
	lea	rax, 4[r8]
	mov	r8, rdx
	mov	rdx, rcx
	jmp	.L480
	.p2align 4,,10
	.p2align 3
.L488:
	mov	rcx, r8
	jmp	.L496
.L503:
	lea	rax, 2[rcx]
	add	r9, rdi
	jmp	.L474
.L482:
	mov	BYTE PTR [rax], 73
	movzx	eax, BYTE PTR [r9]
	mov	BYTE PTR 1[rdi+r8], al
	movzx	eax, BYTE PTR 2[r10+rdx]
	mov	BYTE PTR 2[rdi+r8], al
	movzx	eax, BYTE PTR 3[r10+rdx]
	mov	BYTE PTR 3[rdi+r8], al
	movzx	eax, BYTE PTR 4[r10+rdx]
	mov	BYTE PTR 4[rdi+r8], al
	movzx	eax, BYTE PTR 5[r10+rdx]
	mov	BYTE PTR 5[rdi+r8], al
	movzx	eax, BYTE PTR 6[r10+rdx]
	mov	BYTE PTR 6[rdi+r8], al
	movzx	eax, BYTE PTR 7[r10+rdx]
	mov	BYTE PTR 7[rdi+r8], al
	jmp	.L483
.L486:
	mov	r9, rdi
	mov	eax, 1
	xor	r8d, r8d
	jmp	.L474
	.cfi_endproc
.LFE66:
	.size	json_parse_number, .-json_parse_number
	.p2align 4
	.weak	json_parse_value
	.type	json_parse_value, @function
json_parse_value:
.LFB67:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	mov	r15d, esi
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdx
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	mov	r14, QWORD PTR 24[rdi]
	mov	r12, QWORD PTR [rdi]
	mov	r13, QWORD PTR 8[rdi]
	call	json_skip_all_skippables
	mov	rdx, QWORD PTR 16[rbp]
	test	r15d, r15d
	jne	.L556
	movzx	ecx, BYTE PTR [r12+rdx]
	cmp	cl, 57
	jle	.L557
	cmp	cl, 91
	je	.L510
	cmp	cl, 123
	jne	.L558
	mov	rdx, QWORD PTR 40[rbp]
	mov	QWORD PTR 8[rbx], 2
	xor	esi, esi
	lea	rax, 16[rdx]
	mov	QWORD PTR [rbx], rdx
	mov	QWORD PTR 40[rbp], rax
.L555:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rdi, rbp
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	jmp	json_parse_object
	.p2align 4,,10
	.p2align 3
.L557:
	.cfi_restore_state
	cmp	cl, 33
	jle	.L507
	movabs	rsi, 288063250384289792
	mov	eax, 1
	sal	rax, cl
	test	rax, rsi
	je	.L559
.L519:
	mov	rsi, QWORD PTR 40[rbp]
	mov	QWORD PTR 8[rbx], 1
	mov	rdi, rbp
	lea	rax, 16[rsi]
	mov	QWORD PTR [rbx], rsi
	mov	QWORD PTR 40[rbp], rax
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	jmp	json_parse_number
	.p2align 4,,10
	.p2align 3
.L559:
	.cfi_restore_state
	movabs	rsi, 566935683072
	test	rax, rsi
	jne	.L560
.L507:
	lea	rax, 4[rdx]
	lea	rdi, 5[rdx]
	cmp	r13, rax
	setnb	sil
.L516:
	cmp	cl, 110
	jne	.L517
	test	sil, sil
	jne	.L561
.L517:
	test	r14d, 4096
	je	.L504
	lea	rsi, 3[rdx]
	cmp	cl, 78
	jne	.L518
	cmp	rsi, r13
	jbe	.L562
.L518:
	lea	rsi, 8[rdx]
	cmp	rsi, r13
	ja	.L504
	cmp	cl, 73
	jne	.L504
	cmp	BYTE PTR 1[r12+rdx], 110
	jne	.L504
	cmp	BYTE PTR 2[r12+rdx], 102
	jne	.L504
	cmp	BYTE PTR 3[r12+rdx], 105
	jne	.L504
	cmp	BYTE PTR [r12+rax], 110
	jne	.L504
	cmp	BYTE PTR [r12+rdi], 105
	jne	.L504
	cmp	BYTE PTR 6[r12+rdx], 116
	jne	.L504
	cmp	BYTE PTR 7[r12+rdx], 121
	je	.L519
.L504:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L556:
	.cfi_restore_state
	mov	rdx, QWORD PTR 40[rbp]
	mov	QWORD PTR 8[rbx], 2
	mov	esi, 1
	lea	rax, 16[rdx]
	mov	QWORD PTR [rbx], rdx
	mov	QWORD PTR 40[rbp], rax
	jmp	.L555
	.p2align 4,,10
	.p2align 3
.L510:
	mov	rsi, QWORD PTR 40[rbp]
	mov	QWORD PTR 8[rbx], 3
	mov	rdi, rbp
	lea	rax, 16[rsi]
	mov	QWORD PTR [rbx], rsi
	mov	QWORD PTR 40[rbp], rax
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	jmp	json_parse_array
	.p2align 4,,10
	.p2align 3
.L560:
	.cfi_restore_state
	mov	rsi, QWORD PTR 40[rbp]
	mov	QWORD PTR 8[rbx], 0
	mov	rdi, rbp
	lea	rax, 16[rsi]
	mov	QWORD PTR [rbx], rsi
	mov	QWORD PTR 40[rbp], rax
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	jmp	json_parse_string
	.p2align 4,,10
	.p2align 3
.L561:
	.cfi_restore_state
	cmp	BYTE PTR 1[r12+rdx], 117
	jne	.L504
	cmp	BYTE PTR 2[r12+rdx], 108
	jne	.L504
	cmp	BYTE PTR 3[r12+rdx], 108
	jne	.L504
	mov	QWORD PTR 8[rbx], 6
	mov	QWORD PTR [rbx], 0
	mov	QWORD PTR 16[rbp], rax
	jmp	.L504
	.p2align 4,,10
	.p2align 3
.L558:
	lea	rax, 4[rdx]
	cmp	rax, r13
	setbe	dil
	mov	esi, edi
	cmp	cl, 116
	jne	.L513
	test	dil, dil
	je	.L513
	cmp	BYTE PTR 1[r12+rdx], 114
	je	.L563
.L514:
	lea	rdi, 5[rdx]
	jmp	.L517
.L513:
	lea	rdi, 5[rdx]
	cmp	cl, 102
	jne	.L516
	cmp	rdi, r13
	ja	.L516
	cmp	BYTE PTR 1[r12+rdx], 97
	jne	.L504
	cmp	BYTE PTR 2[r12+rdx], 108
	jne	.L504
	cmp	BYTE PTR 3[r12+rdx], 115
	jne	.L504
	cmp	BYTE PTR 4[r12+rdx], 101
	jne	.L504
	mov	QWORD PTR 8[rbx], 5
	mov	QWORD PTR [rbx], 0
	mov	QWORD PTR 16[rbp], rdi
	jmp	.L504
	.p2align 4,,10
	.p2align 3
.L562:
	cmp	BYTE PTR 1[r12+rdx], 97
	jne	.L504
	cmp	BYTE PTR 2[r12+rdx], 78
	jne	.L504
	jmp	.L519
	.p2align 4,,10
	.p2align 3
.L563:
	cmp	BYTE PTR 2[r12+rdx], 117
	jne	.L514
	cmp	BYTE PTR 3[r12+rdx], 101
	jne	.L514
	mov	QWORD PTR 8[rbx], 4
	mov	QWORD PTR [rbx], 0
	mov	QWORD PTR 16[rbp], rax
	jmp	.L504
	.cfi_endproc
.LFE67:
	.size	json_parse_value, .-json_parse_value
	.p2align 4
	.weak	json_parse_object
	.type	json_parse_object, @function
json_parse_object:
.LFB64:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 40
	.cfi_def_cfa_offset 96
	mov	rax, QWORD PTR 8[rdi]
	mov	r14, QWORD PTR 24[rdi]
	mov	QWORD PTR 24[rsp], rdx
	mov	r13, QWORD PTR [rdi]
	mov	QWORD PTR 8[rsp], rax
	mov	rax, QWORD PTR 16[rdi]
	test	esi, esi
	je	.L565
	cmp	BYTE PTR 0[r13+rax], 123
	mov	ebp, esi
	je	.L565
.L566:
	mov	rdi, r12
	call	json_skip_all_skippables
	mov	rax, QWORD PTR 8[rsp]
	cmp	QWORD PTR 16[r12], rax
	jnb	.L567
	and	r14d, 128
	xor	r15d, r15d
	xor	ebx, ebx
	mov	QWORD PTR 16[rsp], r14
	xor	r14d, r14d
	jmp	.L579
	.p2align 4,,10
	.p2align 3
.L592:
	call	json_skip_all_skippables
	mov	rax, QWORD PTR 16[r12]
	cmp	BYTE PTR 0[r13+rax], 125
	je	.L569
.L573:
	test	r14d, r14d
	je	.L571
	mov	rax, QWORD PTR 16[r12]
	cmp	BYTE PTR 0[r13+rax], 44
	je	.L590
.L571:
	mov	r14, QWORD PTR 40[r12]
	lea	rsi, 24[r14]
	mov	QWORD PTR 40[r12], rsi
	test	r15, r15
	je	.L591
	mov	QWORD PTR 16[r15], r14
.L576:
	cmp	QWORD PTR 16[rsp], 0
	je	.L577
	movdqu	xmm0, XMMWORD PTR 16[r12]
	movdqu	xmm2, XMMWORD PTR 64[r12]
	lea	rax, 64[r14]
	mov	rdi, r12
	mov	QWORD PTR 40[r12], rax
	movdqa	xmm1, xmm0
	movq	rax, xmm0
	punpcklqdq	xmm1, xmm2
	movups	XMMWORD PTR 40[r14], xmm1
	sub	rax, QWORD PTR 72[r12]
	mov	QWORD PTR 56[r14], rax
	mov	QWORD PTR [r14], rsi
	call	json_parse_key
	mov	rdi, r12
	call	json_skip_all_skippables
	add	QWORD PTR 16[r12], 1
	mov	rdi, r12
	call	json_skip_all_skippables
	mov	rdx, QWORD PTR 40[r12]
	lea	rax, 40[rdx]
	mov	QWORD PTR 40[r12], rax
	mov	rax, QWORD PTR 16[r12]
	movq	xmm0, rax
	movhps	xmm0, QWORD PTR 64[r12]
	movups	XMMWORD PTR 16[rdx], xmm0
	sub	rax, QWORD PTR 72[r12]
	mov	QWORD PTR 32[rdx], rax
.L578:
	mov	QWORD PTR 8[r14], rdx
	xor	esi, esi
	mov	rdi, r12
	mov	r15, r14
	add	rbx, 1
	mov	r14d, 1
	call	json_parse_value
	mov	rax, QWORD PTR 16[r12]
.L574:
	cmp	rax, QWORD PTR 8[rsp]
	jnb	.L572
.L579:
	mov	rdi, r12
	test	ebp, ebp
	je	.L592
	call	json_skip_all_skippables
	test	eax, eax
	je	.L573
.L572:
	test	r15, r15
	je	.L580
	mov	QWORD PTR 16[r15], 0
.L580:
	test	rbx, rbx
	je	.L567
.L581:
	mov	rax, QWORD PTR 24[rsp]
	mov	QWORD PTR 8[rax], rbx
	add	rsp, 40
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L565:
	.cfi_restore_state
	add	rax, 1
	xor	ebp, ebp
	mov	QWORD PTR 16[r12], rax
	jmp	.L566
	.p2align 4,,10
	.p2align 3
.L577:
	lea	rax, 40[r14]
	mov	rdi, r12
	mov	QWORD PTR 40[r12], rax
	mov	QWORD PTR [r14], rsi
	call	json_parse_key
	mov	rdi, r12
	call	json_skip_all_skippables
	add	QWORD PTR 16[r12], 1
	mov	rdi, r12
	call	json_skip_all_skippables
	mov	rdx, QWORD PTR 40[r12]
	lea	rax, 16[rdx]
	mov	QWORD PTR 40[r12], rax
	jmp	.L578
	.p2align 4,,10
	.p2align 3
.L591:
	mov	rax, QWORD PTR 24[rsp]
	mov	QWORD PTR [rax], r14
	jmp	.L576
	.p2align 4,,10
	.p2align 3
.L590:
	add	rax, 1
	xor	r14d, r14d
	mov	QWORD PTR 16[r12], rax
	jmp	.L574
	.p2align 4,,10
	.p2align 3
.L567:
	mov	rax, QWORD PTR 24[rsp]
	xor	ebx, ebx
	mov	QWORD PTR [rax], 0
	jmp	.L581
	.p2align 4,,10
	.p2align 3
.L569:
	add	rax, 1
	mov	QWORD PTR 16[r12], rax
	jmp	.L572
	.cfi_endproc
.LFE64:
	.size	json_parse_object, .-json_parse_object
	.p2align 4
	.weak	json_parse_array
	.type	json_parse_array, @function
json_parse_array:
.LFB65:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xor	r15d, r15d
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	xor	r12d, r12d
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	xor	ebp, ebp
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdi
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	add	QWORD PTR 16[rdi], 1
	mov	r13, QWORD PTR [rdi]
	mov	QWORD PTR 8[rsp], rsi
	mov	r14, QWORD PTR 8[rdi]
	call	json_skip_all_skippables
	jmp	.L602
	.p2align 4,,10
	.p2align 3
.L619:
	movq	xmm0, rax
	lea	rcx, 56[r12]
	movhps	xmm0, QWORD PTR 64[rbx]
	mov	QWORD PTR 40[rbx], rcx
	movups	XMMWORD PTR 32[r12], xmm0
	sub	rax, QWORD PTR 72[rbx]
	mov	QWORD PTR 48[r12], rax
.L601:
	mov	QWORD PTR [r12], rdx
	xor	esi, esi
	mov	rdi, rbx
	mov	r15, r12
	add	rbp, 1
	mov	r12d, 1
	call	json_parse_value
	mov	rax, QWORD PTR 16[rbx]
.L597:
	cmp	r14, rax
	jbe	.L595
.L602:
	mov	rdi, rbx
	call	json_skip_all_skippables
	mov	rax, QWORD PTR 16[rbx]
	movzx	edx, BYTE PTR 0[r13+rax]
	cmp	dl, 93
	je	.L616
	cmp	dl, 44
	jne	.L596
	test	r12d, r12d
	jne	.L617
.L596:
	mov	r12, QWORD PTR 40[rbx]
	lea	rdx, 16[r12]
	mov	QWORD PTR 40[rbx], rdx
	test	r15, r15
	je	.L618
	mov	QWORD PTR 8[r15], r12
.L599:
	test	BYTE PTR 24[rbx], -128
	jne	.L619
	lea	rax, 32[r12]
	mov	QWORD PTR 40[rbx], rax
	jmp	.L601
	.p2align 4,,10
	.p2align 3
.L618:
	mov	rcx, QWORD PTR 8[rsp]
	mov	QWORD PTR [rcx], r12
	jmp	.L599
	.p2align 4,,10
	.p2align 3
.L616:
	add	rax, 1
	mov	QWORD PTR 16[rbx], rax
.L595:
	test	r15, r15
	je	.L603
	mov	QWORD PTR 8[r15], 0
.L603:
	test	rbp, rbp
	jne	.L604
	mov	rax, QWORD PTR 8[rsp]
	mov	QWORD PTR [rax], 0
.L604:
	mov	rax, QWORD PTR 8[rsp]
	mov	QWORD PTR 8[rax], rbp
	add	rsp, 24
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L617:
	.cfi_restore_state
	add	rax, 1
	xor	r12d, r12d
	mov	QWORD PTR 16[rbx], rax
	jmp	.L597
	.cfi_endproc
.LFE65:
	.size	json_parse_array, .-json_parse_array
	.p2align 4
	.weak	json_parse_ex
	.type	json_parse_ex, @function
json_parse_ex:
.LFB68:
	.cfi_startproc
	endbr64
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	mov	rax, rdi
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	mov	r12, rcx
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	mov	rbp, r8
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	mov	rbx, r9
	sub	rsp, 104
	.cfi_def_cfa_offset 144
	mov	rcx, QWORD PTR fs:40
	mov	QWORD PTR 88[rsp], rcx
	xor	ecx, ecx
	test	r9, r9
	je	.L621
	pxor	xmm0, xmm0
	movups	XMMWORD PTR [r9], xmm0
	movups	XMMWORD PTR 16[r9], xmm0
.L621:
	test	rax, rax
	je	.L645
	mov	QWORD PTR 8[rsp], rsi
	mov	r13, rsp
	mov	esi, edx
	pxor	xmm0, xmm0
	movdqa	xmm1, XMMWORD PTR .LC0[rip]
	and	esi, 4
	mov	rdi, r13
	mov	QWORD PTR [rsp], rax
	mov	QWORD PTR 16[rsp], 0
	mov	QWORD PTR 80[rsp], 0
	mov	QWORD PTR 24[rsp], rdx
	movaps	XMMWORD PTR 48[rsp], xmm0
	movaps	XMMWORD PTR 64[rsp], xmm1
	call	json_get_value_size
	test	eax, eax
	je	.L646
.L624:
	test	rbx, rbx
	je	.L645
	mov	rax, QWORD PTR 64[rsp]
	movq	xmm0, QWORD PTR 80[rsp]
	mov	QWORD PTR 16[rbx], rax
	mov	rax, QWORD PTR 16[rsp]
	movhps	xmm0, QWORD PTR 16[rsp]
	sub	rax, QWORD PTR 72[rsp]
	movups	XMMWORD PTR [rbx], xmm0
	mov	QWORD PTR 24[rbx], rax
.L645:
	xor	r12d, r12d
.L620:
	mov	rax, QWORD PTR 88[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L647
	add	rsp, 104
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L646:
	.cfi_restore_state
	mov	rdi, r13
	call	json_skip_all_skippables
	mov	rax, QWORD PTR 8[rsp]
	cmp	QWORD PTR 16[rsp], rax
	jne	.L648
	mov	rsi, QWORD PTR 56[rsp]
	add	rsi, QWORD PTR 48[rsp]
	test	r12, r12
	je	.L649
	mov	rdi, rbp
	call	r12
	mov	r12, rax
.L627:
	test	r12, r12
	je	.L650
	mov	rax, QWORD PTR 48[rsp]
	mov	rsi, QWORD PTR 24[rsp]
	mov	QWORD PTR 16[rsp], 0
	movdqa	xmm2, XMMWORD PTR .LC0[rip]
	add	rax, r12
	mov	QWORD PTR 32[rsp], rax
	movaps	XMMWORD PTR 64[rsp], xmm2
	test	sil, -128
	je	.L629
	lea	rax, 40[r12]
	movdqa	xmm0, XMMWORD PTR .LC2[rip]
	mov	QWORD PTR 40[rsp], rax
	mov	QWORD PTR 32[r12], 0
	movups	XMMWORD PTR 16[r12], xmm0
.L630:
	and	esi, 4
	mov	rdx, r12
	mov	rdi, r13
	call	json_parse_value
	jmp	.L620
	.p2align 4,,10
	.p2align 3
.L629:
	lea	rax, 16[r12]
	mov	QWORD PTR 40[rsp], rax
	jmp	.L630
	.p2align 4,,10
	.p2align 3
.L648:
	mov	QWORD PTR 80[rsp], 10
	jmp	.L624
	.p2align 4,,10
	.p2align 3
.L649:
	mov	rdi, rsi
	call	malloc@PLT
	mov	r12, rax
	jmp	.L627
	.p2align 4,,10
	.p2align 3
.L650:
	test	rbx, rbx
	je	.L645
	movdqa	xmm0, XMMWORD PTR .LC1[rip]
	movups	XMMWORD PTR [rbx], xmm0
	pxor	xmm0, xmm0
	movups	XMMWORD PTR 16[rbx], xmm0
	jmp	.L620
.L647:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE68:
	.size	json_parse_ex, .-json_parse_ex
	.p2align 4
	.weak	json_parse
	.type	json_parse, @function
json_parse:
.LFB69:
	.cfi_startproc
	endbr64
	xor	r9d, r9d
	xor	r8d, r8d
	xor	ecx, ecx
	xor	edx, edx
	jmp	json_parse_ex
	.cfi_endproc
.LFE69:
	.size	json_parse, .-json_parse
	.p2align 4
	.weak	json_extract_get_number_size
	.type	json_extract_get_number_size, @function
json_extract_get_number_size:
.LFB71:
	.cfi_startproc
	endbr64
	mov	rdx, QWORD PTR 8[rdi]
	mov	eax, 16
	ret
	.cfi_endproc
.LFE71:
	.size	json_extract_get_number_size, .-json_extract_get_number_size
	.p2align 4
	.weak	json_extract_get_string_size
	.type	json_extract_get_string_size, @function
json_extract_get_string_size:
.LFB72:
	.cfi_startproc
	endbr64
	mov	rdx, QWORD PTR 8[rdi]
	mov	eax, 16
	add	rdx, 1
	ret
	.cfi_endproc
.LFE72:
	.size	json_extract_get_string_size, .-json_extract_get_string_size
	.p2align 4
	.weak	json_extract_get_value_size
	.type	json_extract_get_value_size, @function
json_extract_get_value_size:
.LFB75:
	.cfi_startproc
	endbr64
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	rax, QWORD PTR 8[rdi]
	cmp	rax, 2
	je	.L655
	ja	.L656
	test	rax, rax
	je	.L663
	mov	rdi, QWORD PTR [rdi]
	call	json_extract_get_number_size
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	add	rax, 16
	ret
	.p2align 4,,10
	.p2align 3
.L656:
	.cfi_restore_state
	cmp	rax, 3
	jne	.L664
	mov	rdi, QWORD PTR [rdi]
	call	json_extract_get_array_size
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	add	rax, 16
	ret
	.p2align 4,,10
	.p2align 3
.L664:
	.cfi_restore_state
	mov	eax, 16
	xor	edx, edx
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L663:
	.cfi_restore_state
	mov	rdi, QWORD PTR [rdi]
	call	json_extract_get_string_size
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	add	rax, 16
	ret
	.p2align 4,,10
	.p2align 3
.L655:
	.cfi_restore_state
	mov	rdi, QWORD PTR [rdi]
	call	json_extract_get_object_size
	add	rsp, 8
	.cfi_def_cfa_offset 8
	add	rax, 16
	ret
	.cfi_endproc
.LFE75:
	.size	json_extract_get_value_size, .-json_extract_get_value_size
	.p2align 4
	.weak	json_extract_get_object_size
	.type	json_extract_get_object_size, @function
json_extract_get_object_size:
.LFB73:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	mov	r14, QWORD PTR 8[rdi]
	mov	r12, QWORD PTR [rdi]
	mov	QWORD PTR 8[rsp], rdi
	lea	rax, [r14+r14*2]
	lea	r13, 16[0+rax*8]
	test	r14, r14
	je	.L666
	xor	r14d, r14d
	xor	r15d, r15d
	.p2align 4,,10
	.p2align 3
.L667:
	mov	rdi, QWORD PTR [r12]
	add	r15, 1
	call	json_extract_get_string_size
	mov	rdi, QWORD PTR 8[r12]
	mov	rbp, rax
	mov	rbx, rdx
	call	json_extract_get_value_size
	mov	r12, QWORD PTR 16[r12]
	add	rbp, rax
	mov	rax, QWORD PTR 8[rsp]
	add	rbx, rdx
	add	r13, rbp
	add	r14, rbx
	cmp	QWORD PTR 8[rax], r15
	ja	.L667
.L666:
	add	rsp, 24
	.cfi_def_cfa_offset 56
	mov	rax, r13
	mov	rdx, r14
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE73:
	.size	json_extract_get_object_size, .-json_extract_get_object_size
	.p2align 4
	.weak	json_extract_get_array_size
	.type	json_extract_get_array_size, @function
json_extract_get_array_size:
.LFB74:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	mov	r12, QWORD PTR 8[rdi]
	mov	rbx, QWORD PTR [rdi]
	lea	r13, 1[r12]
	sal	r13, 4
	test	r12, r12
	je	.L674
	mov	r14, rdi
	xor	r12d, r12d
	xor	ebp, ebp
	.p2align 4,,10
	.p2align 3
.L675:
	mov	rdi, QWORD PTR [rbx]
	add	rbp, 1
	call	json_extract_get_value_size
	mov	rbx, QWORD PTR 8[rbx]
	add	r13, rax
	add	r12, rdx
	cmp	QWORD PTR 8[r14], rbp
	ja	.L675
.L674:
	pop	rbx
	.cfi_def_cfa_offset 40
	mov	rax, r13
	pop	rbp
	.cfi_def_cfa_offset 32
	mov	rdx, r12
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE74:
	.size	json_extract_get_array_size, .-json_extract_get_array_size
	.p2align 4
	.weak	json_extract_copy_value
	.type	json_extract_copy_value, @function
json_extract_copy_value:
.LFB76:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	mov	rax, QWORD PTR [rdi]
	mov	rbx, rdi
	movdqu	xmm0, XMMWORD PTR [rsi]
	movups	XMMWORD PTR [rax], xmm0
	mov	rax, QWORD PTR [rdi]
	lea	rdx, 16[rax]
	mov	QWORD PTR [rdi], rdx
	mov	QWORD PTR [rax], rdx
	mov	rdx, QWORD PTR 8[rsi]
	test	rdx, rdx
	je	.L694
	cmp	rdx, 1
	je	.L695
	cmp	rdx, 2
	je	.L696
	cmp	rdx, 3
	je	.L697
.L681:
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L694:
	.cfi_restore_state
	mov	rdx, QWORD PTR [rsi]
	movdqu	xmm3, XMMWORD PTR [rdx]
	movups	XMMWORD PTR 16[rax], xmm3
	mov	rbp, QWORD PTR [rdi]
	lea	rax, 16[rbp]
	mov	rsi, QWORD PTR 0[rbp]
	mov	QWORD PTR [rdi], rax
	mov	rax, QWORD PTR 8[rbp]
	mov	rdi, QWORD PTR 8[rdi]
	lea	rdx, 1[rax]
	call	memcpy@PLT
	mov	rax, QWORD PTR 8[rbx]
	mov	rdx, QWORD PTR 8[rbp]
	mov	QWORD PTR 0[rbp], rax
	lea	rax, 1[rax+rdx]
	mov	QWORD PTR 8[rbx], rax
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L696:
	.cfi_restore_state
	mov	rdx, QWORD PTR [rsi]
	movdqu	xmm6, XMMWORD PTR [rdx]
	movups	XMMWORD PTR 16[rax], xmm6
	mov	r14, QWORD PTR [rdi]
	lea	rax, 16[r14]
	cmp	QWORD PTR 8[r14], 0
	mov	rdx, QWORD PTR [r14]
	mov	QWORD PTR [rdi], rax
	mov	QWORD PTR [r14], rax
	je	.L681
	xor	r13d, r13d
.L689:
	movdqu	xmm1, XMMWORD PTR [rdx]
	movups	XMMWORD PTR [rax], xmm1
	mov	rdx, QWORD PTR 16[rdx]
	mov	QWORD PTR 16[rax], rdx
	mov	rbp, QWORD PTR [rbx]
	lea	rax, 24[rbp]
	mov	QWORD PTR [rbx], rax
	mov	rax, QWORD PTR 0[rbp]
	movdqu	xmm2, XMMWORD PTR [rax]
	movups	XMMWORD PTR 24[rbp], xmm2
	mov	r12, QWORD PTR [rbx]
	mov	rdi, QWORD PTR 8[rbx]
	lea	rax, 16[r12]
	mov	rsi, QWORD PTR [r12]
	mov	QWORD PTR [rbx], rax
	mov	rax, QWORD PTR 8[r12]
	mov	QWORD PTR 0[rbp], r12
	lea	rdx, 1[rax]
	call	memcpy@PLT
	mov	rax, QWORD PTR 8[rbx]
	mov	rsi, QWORD PTR 8[rbp]
	mov	rdi, rbx
	mov	rdx, QWORD PTR 8[r12]
	mov	QWORD PTR [r12], rax
	lea	rax, 1[rax+rdx]
	mov	QWORD PTR 8[rbx], rax
	mov	rax, QWORD PTR [rbx]
	mov	QWORD PTR 8[rbp], rax
	call	json_extract_copy_value.localalias
	mov	rdx, QWORD PTR 16[rbp]
	test	rdx, rdx
	je	.L687
	mov	rax, QWORD PTR [rbx]
	add	r13, 1
	mov	QWORD PTR 16[rbp], rax
	cmp	r13, QWORD PTR 8[r14]
	jb	.L689
	jmp	.L681
	.p2align 4,,10
	.p2align 3
.L695:
	mov	rdx, QWORD PTR [rsi]
	movdqu	xmm5, XMMWORD PTR [rdx]
	movups	XMMWORD PTR 16[rax], xmm5
	mov	rbp, QWORD PTR [rdi]
	lea	rax, 16[rbp]
	mov	rsi, QWORD PTR 0[rbp]
	mov	rdx, QWORD PTR 8[rbp]
	mov	QWORD PTR [rdi], rax
	mov	rdi, QWORD PTR 8[rdi]
	call	memcpy@PLT
	mov	rax, QWORD PTR 8[rbx]
	mov	QWORD PTR 0[rbp], rax
	add	rax, QWORD PTR 8[rbp]
	mov	QWORD PTR 8[rbx], rax
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L687:
	.cfi_restore_state
	add	r13, 1
	cmp	QWORD PTR 8[r14], r13
	jbe	.L681
	mov	rax, QWORD PTR [rbx]
	jmp	.L689
	.p2align 4,,10
	.p2align 3
.L697:
	mov	rdx, QWORD PTR [rsi]
	movdqu	xmm7, XMMWORD PTR [rdx]
	movups	XMMWORD PTR 16[rax], xmm7
	mov	r13, QWORD PTR [rdi]
	lea	rax, 16[r13]
	cmp	QWORD PTR 8[r13], 0
	mov	rdx, QWORD PTR 0[r13]
	mov	QWORD PTR [rdi], rax
	mov	QWORD PTR 0[r13], rax
	je	.L681
	xor	r12d, r12d
.L692:
	movdqu	xmm4, XMMWORD PTR [rdx]
	mov	rdi, rbx
	movups	XMMWORD PTR [rax], xmm4
	mov	rbp, QWORD PTR [rbx]
	lea	rax, 16[rbp]
	mov	rsi, QWORD PTR 0[rbp]
	mov	QWORD PTR [rbx], rax
	mov	QWORD PTR 0[rbp], rax
	call	json_extract_copy_value.localalias
	mov	rdx, QWORD PTR 8[rbp]
	test	rdx, rdx
	je	.L690
	mov	rax, QWORD PTR [rbx]
	add	r12, 1
	mov	QWORD PTR 8[rbp], rax
	cmp	r12, QWORD PTR 8[r13]
	jb	.L692
	jmp	.L681
	.p2align 4,,10
	.p2align 3
.L690:
	add	r12, 1
	cmp	QWORD PTR 8[r13], r12
	jbe	.L681
	mov	rax, QWORD PTR [rbx]
	jmp	.L692
	.cfi_endproc
.LFE76:
	.size	json_extract_copy_value, .-json_extract_copy_value
	.set	json_extract_copy_value.localalias,json_extract_copy_value
	.p2align 4
	.weak	json_extract_value_ex
	.type	json_extract_value_ex, @function
json_extract_value_ex:
.LFB77:
	.cfi_startproc
	endbr64
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 40
	.cfi_def_cfa_offset 80
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 24[rsp], rax
	xor	eax, eax
	test	rdi, rdi
	je	.L703
	mov	r12, rsi
	mov	rbp, rdi
	mov	r13, rdx
	call	json_extract_get_value_size
	mov	rbx, rax
	lea	rsi, [rax+rdx]
	test	r12, r12
	je	.L705
	mov	rdi, r13
	call	r12
	mov	r12, rax
.L701:
	add	rbx, r12
	movq	xmm0, r12
	mov	rdi, rsp
	mov	rsi, rbp
	movq	xmm1, rbx
	punpcklqdq	xmm0, xmm1
	movaps	XMMWORD PTR [rsp], xmm0
	call	json_extract_copy_value
.L699:
	mov	rax, QWORD PTR 24[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L706
	add	rsp, 40
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L703:
	.cfi_restore_state
	xor	r12d, r12d
	jmp	.L699
	.p2align 4,,10
	.p2align 3
.L705:
	mov	rdi, rsi
	call	malloc@PLT
	mov	r12, rax
	jmp	.L701
.L706:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE77:
	.size	json_extract_value_ex, .-json_extract_value_ex
	.p2align 4
	.weak	json_extract_value
	.type	json_extract_value, @function
json_extract_value:
.LFB70:
	.cfi_startproc
	endbr64
	xor	edx, edx
	xor	esi, esi
	jmp	json_extract_value_ex
	.cfi_endproc
.LFE70:
	.size	json_extract_value, .-json_extract_value
	.p2align 4
	.weak	json_value_as_string
	.type	json_value_as_string, @function
json_value_as_string:
.LFB78:
	.cfi_startproc
	endbr64
	cmp	QWORD PTR 8[rdi], 0
	jne	.L710
	mov	rax, QWORD PTR [rdi]
	ret
	.p2align 4,,10
	.p2align 3
.L710:
	xor	eax, eax
	ret
	.cfi_endproc
.LFE78:
	.size	json_value_as_string, .-json_value_as_string
	.p2align 4
	.weak	json_value_as_number
	.type	json_value_as_number, @function
json_value_as_number:
.LFB79:
	.cfi_startproc
	endbr64
	xor	eax, eax
	cmp	QWORD PTR 8[rdi], 1
	jne	.L711
	mov	rax, QWORD PTR [rdi]
.L711:
	ret
	.cfi_endproc
.LFE79:
	.size	json_value_as_number, .-json_value_as_number
	.p2align 4
	.weak	json_value_as_object
	.type	json_value_as_object, @function
json_value_as_object:
.LFB80:
	.cfi_startproc
	endbr64
	xor	eax, eax
	cmp	QWORD PTR 8[rdi], 2
	jne	.L714
	mov	rax, QWORD PTR [rdi]
.L714:
	ret
	.cfi_endproc
.LFE80:
	.size	json_value_as_object, .-json_value_as_object
	.p2align 4
	.weak	json_value_as_array
	.type	json_value_as_array, @function
json_value_as_array:
.LFB81:
	.cfi_startproc
	endbr64
	xor	eax, eax
	cmp	QWORD PTR 8[rdi], 3
	jne	.L717
	mov	rax, QWORD PTR [rdi]
.L717:
	ret
	.cfi_endproc
.LFE81:
	.size	json_value_as_array, .-json_value_as_array
	.p2align 4
	.weak	json_value_is_true
	.type	json_value_is_true, @function
json_value_is_true:
.LFB82:
	.cfi_startproc
	endbr64
	xor	eax, eax
	cmp	QWORD PTR 8[rdi], 4
	sete	al
	ret
	.cfi_endproc
.LFE82:
	.size	json_value_is_true, .-json_value_is_true
	.p2align 4
	.weak	json_value_is_false
	.type	json_value_is_false, @function
json_value_is_false:
.LFB83:
	.cfi_startproc
	endbr64
	xor	eax, eax
	cmp	QWORD PTR 8[rdi], 5
	sete	al
	ret
	.cfi_endproc
.LFE83:
	.size	json_value_is_false, .-json_value_is_false
	.p2align 4
	.weak	json_value_is_null
	.type	json_value_is_null, @function
json_value_is_null:
.LFB84:
	.cfi_startproc
	endbr64
	xor	eax, eax
	cmp	QWORD PTR 8[rdi], 6
	sete	al
	ret
	.cfi_endproc
.LFE84:
	.size	json_value_is_null, .-json_value_is_null
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"Infinity"
.LC4:
	.string	"NaN"
	.text
	.p2align 4
	.weak	json_write_get_number_size
	.type	json_write_get_number_size, @function
json_write_get_number_size:
.LFB85:
	.cfi_startproc
	endbr64
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	mov	r9, rdi
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	mov	r8, QWORD PTR 8[rdi]
	mov	rbx, rsi
	mov	rdi, QWORD PTR [rdi]
	cmp	r8, 1
	jbe	.L724
	movzx	eax, BYTE PTR 1[rdi]
	and	eax, -33
	cmp	al, 88
	je	.L767
	movzx	eax, BYTE PTR [rdi]
	sub	eax, 43
	test	al, -3
	jne	.L751
.L749:
	lea	rdx, 1[rdi]
	mov	eax, 1
	jmp	.L731
	.p2align 4,,10
	.p2align 3
.L751:
	mov	rdx, rdi
	xor	eax, eax
.L731:
	movzx	ecx, BYTE PTR [rdx]
	cmp	cl, 73
	je	.L768
	mov	rsi, QWORD PTR [rbx]
	mov	r12, rsi
	cmp	cl, 78
	je	.L769
	cmp	cl, 46
	je	.L766
.L743:
	cmp	r8, rax
	ja	.L745
	jmp	.L730
	.p2align 4,,10
	.p2align 3
.L771:
	cmp	r8, rax
	jbe	.L770
.L745:
	movzx	esi, BYTE PTR [rdi+rax]
	mov	rcx, rax
	lea	rax, 1[rax]
	lea	edx, -48[rsi]
	cmp	dl, 9
	jbe	.L771
.L746:
	lea	rax, 1[rcx]
	mov	rsi, r12
	cmp	r8, rax
	jne	.L730
	cmp	BYTE PTR [rdi+rcx], 46
	je	.L766
.L730:
	add	rsi, r8
	mov	QWORD PTR [rbx], rsi
	cmp	BYTE PTR [rdi], 43
	jne	.L757
	sub	rsi, 1
	mov	QWORD PTR [rbx], rsi
.L757:
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	xor	eax, eax
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L724:
	.cfi_restore_state
	test	r8, r8
	jne	.L729
.L732:
	mov	rsi, QWORD PTR [rbx]
	jmp	.L730
	.p2align 4,,10
	.p2align 3
.L766:
	add	rsi, 1
	mov	QWORD PTR [rbx], rsi
	mov	r8, QWORD PTR 8[r9]
	jmp	.L730
	.p2align 4,,10
	.p2align 3
.L769:
	lea	rbp, .LC4[rip]
	mov	rdx, rax
	mov	r10d, 97
	sub	rbp, rax
	jmp	.L739
	.p2align 4,,10
	.p2align 3
.L742:
	movzx	r11d, BYTE PTR 1[rbp+rdx]
	mov	ecx, r10d
	mov	r10d, r11d
	test	cl, cl
	je	.L741
.L739:
	cmp	BYTE PTR [rdi+rdx], cl
	jne	.L741
	add	rdx, 1
	cmp	r8, rdx
	ja	.L742
.L741:
	test	r10b, r10b
	jne	.L743
	add	r12, 1
	mov	QWORD PTR [rbx], r12
	jmp	.L757
.L767:
	xor	edx, edx
	xor	esi, esi
	call	strtoumax@PLT
	xor	esi, esi
	mov	rdx, rax
	test	rax, rax
	je	.L726
	movabs	rdi, -3689348814741910323
	.p2align 4,,10
	.p2align 3
.L727:
	mov	rax, rdx
	mov	rcx, rdx
	add	rsi, 1
	mul	rdi
	shr	rdx, 3
	cmp	rcx, 9
	ja	.L727
.L726:
	add	QWORD PTR [rbx], rsi
	xor	eax, eax
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L768:
	.cfi_restore_state
	lea	r9, .LC3[rip]
	mov	edx, 110
	sub	r9, rax
	jmp	.L733
	.p2align 4,,10
	.p2align 3
.L736:
	movzx	esi, BYTE PTR 1[r9+rax]
	mov	ecx, edx
	mov	edx, esi
	test	cl, cl
	je	.L735
.L733:
	cmp	BYTE PTR [rdi+rax], cl
	jne	.L735
	add	rax, 1
	cmp	r8, rax
	ja	.L736
.L735:
	test	dl, dl
	jne	.L757
	mov	rax, QWORD PTR [rbx]
	lea	rdx, 22[rax]
	mov	QWORD PTR [rbx], rdx
	cmp	BYTE PTR [rdi], 45
	jne	.L757
	add	rax, 23
	mov	QWORD PTR [rbx], rax
	jmp	.L757
.L770:
	mov	rcx, rax
	jmp	.L746
.L729:
	movzx	eax, BYTE PTR [rdi]
	sub	eax, 43
	test	al, -3
	jne	.L751
	cmp	r8, 1
	ja	.L749
	jmp	.L732
	.cfi_endproc
.LFE85:
	.size	json_write_get_number_size, .-json_write_get_number_size
	.p2align 4
	.weak	json_write_get_string_size
	.type	json_write_get_string_size, @function
json_write_get_string_size:
.LFB86:
	.cfi_startproc
	endbr64
	cmp	QWORD PTR 8[rdi], 0
	mov	rcx, QWORD PTR [rsi]
	je	.L773
	mov	r8, QWORD PTR [rdi]
	xor	edx, edx
	jmp	.L779
	.p2align 4,,10
	.p2align 3
.L784:
	cmp	al, 7
	jg	.L774
.L777:
	add	rcx, 1
	add	rdx, 1
	mov	QWORD PTR [rsi], rcx
	cmp	QWORD PTR 8[rdi], rdx
	jbe	.L773
.L779:
	movzx	eax, BYTE PTR [r8+rdx]
	cmp	al, 34
	je	.L774
	jg	.L775
	cmp	al, 10
	jle	.L784
	sub	eax, 12
	cmp	al, 1
	ja	.L777
.L774:
	add	rcx, 2
	add	rdx, 1
	mov	QWORD PTR [rsi], rcx
	cmp	QWORD PTR 8[rdi], rdx
	ja	.L779
.L773:
	add	rcx, 2
	xor	eax, eax
	mov	QWORD PTR [rsi], rcx
	ret
	.p2align 4,,10
	.p2align 3
.L775:
	cmp	al, 92
	jne	.L777
	jmp	.L774
	.cfi_endproc
.LFE86:
	.size	json_write_get_string_size, .-json_write_get_string_size
	.section	.text.unlikely,"ax",@progbits
.LCOLDB5:
	.text
.LHOTB5:
	.p2align 4
	.weak	json_write_minified_get_value_size
	.type	json_write_minified_get_value_size, @function
json_write_minified_get_value_size:
.LFB89:
	.cfi_startproc
	endbr64
	cmp	QWORD PTR 8[rdi], 6
	ja	.L794
	mov	rax, QWORD PTR 8[rdi]
	lea	rdx, .L788[rip]
	movsx	rax, DWORD PTR [rdx+rax*4]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L788:
	.long	.L793-.L788
	.long	.L792-.L788
	.long	.L791-.L788
	.long	.L790-.L788
	.long	.L787-.L788
	.long	.L789-.L788
	.long	.L787-.L788
	.text
	.p2align 4,,10
	.p2align 3
.L787:
	add	QWORD PTR [rsi], 4
	xor	eax, eax
	ret
	.p2align 4,,10
	.p2align 3
.L790:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_minified_get_array_size
	.p2align 4,,10
	.p2align 3
.L789:
	add	QWORD PTR [rsi], 5
	xor	eax, eax
	ret
	.p2align 4,,10
	.p2align 3
.L793:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_get_string_size
	.p2align 4,,10
	.p2align 3
.L792:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_get_number_size
	.p2align 4,,10
	.p2align 3
.L791:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_minified_get_object_size
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	json_write_minified_get_value_size.cold, @function
json_write_minified_get_value_size.cold:
.LFSB89:
.L794:
	mov	eax, 1
	ret
	.cfi_endproc
.LFE89:
	.text
	.size	json_write_minified_get_value_size, .-json_write_minified_get_value_size
	.section	.text.unlikely
	.size	json_write_minified_get_value_size.cold, .-json_write_minified_get_value_size.cold
.LCOLDE5:
	.text
.LHOTE5:
	.p2align 4
	.weak	json_write_minified_get_array_size
	.type	json_write_minified_get_array_size, @function
json_write_minified_get_array_size:
.LFB87:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 8
	.cfi_def_cfa_offset 32
	mov	rax, QWORD PTR [rsi]
	mov	rbx, QWORD PTR [rdi]
	add	rax, 2
	mov	QWORD PTR [rsi], rax
	mov	rcx, QWORD PTR 8[rdi]
	lea	rdx, -1[rax+rcx]
	cmp	rcx, 1
	cmova	rax, rdx
	mov	QWORD PTR [rsi], rax
	test	rbx, rbx
	je	.L797
	mov	rbp, rsi
	jmp	.L799
	.p2align 4,,10
	.p2align 3
.L806:
	mov	rbx, QWORD PTR 8[rbx]
	test	rbx, rbx
	je	.L797
.L799:
	mov	rdi, QWORD PTR [rbx]
	mov	rsi, rbp
	call	json_write_minified_get_value_size
	test	eax, eax
	je	.L806
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	mov	eax, 1
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L797:
	.cfi_restore_state
	add	rsp, 8
	.cfi_def_cfa_offset 24
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE87:
	.size	json_write_minified_get_array_size, .-json_write_minified_get_array_size
	.p2align 4
	.weak	json_write_minified_get_object_size
	.type	json_write_minified_get_object_size, @function
json_write_minified_get_object_size:
.LFB88:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 8
	.cfi_def_cfa_offset 32
	mov	rax, QWORD PTR [rsi]
	mov	rbx, QWORD PTR [rdi]
	add	rax, 2
	mov	QWORD PTR [rsi], rax
	add	rax, QWORD PTR 8[rdi]
	mov	QWORD PTR [rsi], rax
	mov	rcx, QWORD PTR 8[rdi]
	lea	rdx, -1[rax+rcx]
	cmp	rcx, 1
	cmova	rax, rdx
	mov	QWORD PTR [rsi], rax
	test	rbx, rbx
	je	.L809
	mov	rbp, rsi
	jmp	.L813
	.p2align 4,,10
	.p2align 3
.L810:
	mov	rdi, QWORD PTR 8[rbx]
	mov	rsi, rbp
	call	json_write_minified_get_value_size
	test	eax, eax
	jne	.L812
	mov	rbx, QWORD PTR 16[rbx]
	test	rbx, rbx
	je	.L809
.L813:
	mov	rdi, QWORD PTR [rbx]
	mov	rsi, rbp
	call	json_write_get_string_size
	test	eax, eax
	je	.L810
.L812:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	mov	eax, 1
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L809:
	.cfi_restore_state
	add	rsp, 8
	.cfi_def_cfa_offset 24
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE88:
	.size	json_write_minified_get_object_size, .-json_write_minified_get_object_size
	.section	.rodata.str1.1
.LC6:
	.string	"1.7976931348623158e308"
	.text
	.p2align 4
	.weak	json_write_number
	.type	json_write_number, @function
json_write_number:
.LFB90:
	.cfi_startproc
	endbr64
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	mov	r9, QWORD PTR 8[rdi]
	mov	rbx, rsi
	mov	r8, QWORD PTR [rdi]
	cmp	r9, 1
	jbe	.L820
	movzx	eax, BYTE PTR 1[r8]
	and	eax, -33
	cmp	al, 88
	je	.L875
	movzx	ebp, BYTE PTR [r8]
	cmp	bpl, 43
	lea	eax, -43[rbp]
	sete	dl
	test	al, -3
	je	.L851
.L853:
	mov	rax, r8
	xor	esi, esi
	movzx	eax, BYTE PTR [rax]
	cmp	al, 73
	je	.L876
.L871:
	cmp	al, 78
	je	.L877
	cmp	al, 46
	je	.L839
.L832:
	cmp	r9, rsi
	ja	.L840
	jmp	.L841
	.p2align 4,,10
	.p2align 3
.L879:
	cmp	r9, rsi
	jbe	.L878
.L840:
	movzx	eax, BYTE PTR [r8+rsi]
	mov	rcx, rsi
	lea	rsi, 1[rsi]
	sub	eax, 48
	cmp	al, 9
	jbe	.L879
.L844:
	lea	rax, 1[rcx]
	cmp	r9, rax
	jne	.L841
	cmp	BYTE PTR [r8+rcx], 46
	je	.L880
.L841:
	movzx	edx, dl
	cmp	r9, rdx
	jbe	.L874
	movzx	ecx, BYTE PTR [r8+rdx]
	lea	rax, 1[rbx]
	add	rdx, 1
	mov	BYTE PTR [rbx], cl
	cmp	QWORD PTR 8[rdi], rdx
	jbe	.L819
	.p2align 4,,10
	.p2align 3
.L849:
	mov	rcx, QWORD PTR [rdi]
	add	rax, 1
	movzx	ecx, BYTE PTR [rcx+rdx]
	add	rdx, 1
	mov	BYTE PTR -1[rax], cl
	cmp	QWORD PTR 8[rdi], rdx
	ja	.L849
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
.L882:
	.cfi_restore_state
	lea	eax, -43[rbp]
	test	al, -3
	jne	.L853
	cmp	r9, 1
	jbe	.L841
	.p2align 4,,10
	.p2align 3
.L851:
	lea	rax, 1[r8]
	mov	esi, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 73
	jne	.L871
.L876:
	lea	r12, .LC3[rip]
	mov	rcx, rsi
	mov	r10d, 110
	sub	r12, rsi
	jmp	.L828
	.p2align 4,,10
	.p2align 3
.L831:
	movzx	r11d, BYTE PTR 1[r12+rcx]
	mov	eax, r10d
	mov	r10d, r11d
	test	al, al
	je	.L830
.L828:
	cmp	BYTE PTR [r8+rcx], al
	jne	.L830
	add	rcx, 1
	cmp	r9, rcx
	ja	.L831
.L830:
	test	r10b, r10b
	jne	.L832
	cmp	bpl, 45
	je	.L881
.L833:
	mov	rax, rbx
	lea	rcx, .LC6[rip]
	mov	edx, 49
	.p2align 4,,10
	.p2align 3
.L834:
	add	rcx, 1
	mov	BYTE PTR [rax], dl
	add	rax, 1
	movzx	edx, BYTE PTR [rcx]
	test	dl, dl
	jne	.L834
	jmp	.L819
	.p2align 4,,10
	.p2align 3
.L820:
	movzx	ebp, BYTE PTR [r8]
	cmp	bpl, 43
	sete	dl
	test	r9, r9
	jne	.L882
.L874:
	mov	rax, rbx
.L819:
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L877:
	.cfi_restore_state
	lea	rbp, .LC4[rip]
	mov	rcx, rsi
	mov	r10d, 97
	sub	rbp, rsi
	jmp	.L835
	.p2align 4,,10
	.p2align 3
.L838:
	movzx	r11d, BYTE PTR 1[rbp+rcx]
	mov	eax, r10d
	mov	r10d, r11d
	test	al, al
	je	.L837
.L835:
	cmp	BYTE PTR [r8+rcx], al
	jne	.L837
	add	rcx, 1
	cmp	r9, rcx
	ja	.L838
.L837:
	test	r10b, r10b
	jne	.L832
.L848:
	mov	BYTE PTR [rbx], 48
	lea	rax, 1[rbx]
	jmp	.L819
.L875:
	mov	rdi, r8
	xor	edx, edx
	xor	esi, esi
	call	strtoumax@PLT
	mov	r8, rax
	test	rax, rax
	je	.L822
	movabs	r9, -3689348814741910323
	mov	rdx, rax
	xor	edi, edi
	.p2align 4,,10
	.p2align 3
.L823:
	mov	rax, rdx
	mov	rsi, rdx
	mov	rcx, rdi
	add	rdi, 1
	mul	r9
	shr	rdx, 3
	cmp	rsi, 9
	ja	.L823
	movabs	r9, -3689348814741910323
	add	rcx, rbx
	.p2align 4,,10
	.p2align 3
.L824:
	mov	rax, r8
	sub	rcx, 1
	mul	r9
	mov	rax, r8
	shr	rdx, 3
	lea	rsi, [rdx+rdx*4]
	add	rsi, rsi
	sub	rax, rsi
	add	eax, 48
	mov	BYTE PTR 1[rcx], al
	mov	rax, r8
	mov	r8, rdx
	cmp	rax, 9
	ja	.L824
	lea	rax, [rbx+rdi]
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L839:
	.cfi_restore_state
	movzx	edx, dl
	cmp	BYTE PTR [r8+rdx], 45
	jne	.L842
	mov	BYTE PTR [rbx], 45
	add	rdx, 1
	add	rbx, 1
.L842:
	mov	BYTE PTR [rbx], 48
	lea	rax, 1[rbx]
	cmp	rdx, QWORD PTR 8[rdi]
	jnb	.L819
	.p2align 4,,10
	.p2align 3
.L843:
	mov	rcx, QWORD PTR [rdi]
	add	rax, 1
	movzx	ecx, BYTE PTR [rcx+rdx]
	add	rdx, 1
	mov	BYTE PTR -1[rax], cl
	cmp	QWORD PTR 8[rdi], rdx
	ja	.L843
	jmp	.L819
.L881:
	mov	BYTE PTR [rbx], 45
	add	rbx, 1
	jmp	.L833
.L880:
	movzx	edx, dl
	cmp	BYTE PTR [r8+rdx], 45
	jne	.L846
	mov	BYTE PTR [rbx], 45
	mov	r9, QWORD PTR 8[rdi]
	add	rdx, 1
	add	rbx, 1
.L846:
	cmp	rdx, r9
	jnb	.L848
	.p2align 4,,10
	.p2align 3
.L847:
	mov	rax, QWORD PTR [rdi]
	add	rbx, 1
	movzx	eax, BYTE PTR [rax+rdx]
	add	rdx, 1
	mov	BYTE PTR -1[rbx], al
	cmp	QWORD PTR 8[rdi], rdx
	ja	.L847
	jmp	.L848
.L822:
	mov	BYTE PTR -1[rbx], 48
	jmp	.L874
.L878:
	mov	rcx, rsi
	jmp	.L844
	.cfi_endproc
.LFE90:
	.size	json_write_number, .-json_write_number
	.p2align 4
	.weak	json_write_string
	.type	json_write_string, @function
json_write_string:
.LFB91:
	.cfi_startproc
	endbr64
	mov	BYTE PTR [rsi], 34
	cmp	QWORD PTR 8[rdi], 0
	lea	rax, 1[rsi]
	je	.L884
	xor	ecx, ecx
	lea	r8, .L888[rip]
	.p2align 4,,10
	.p2align 3
.L896:
	mov	rdx, QWORD PTR [rdi]
	movzx	edx, BYTE PTR [rdx+rcx]
	cmp	dl, 34
	jg	.L885
	cmp	dl, 7
	jle	.L886
	lea	esi, -8[rdx]
	cmp	sil, 26
	ja	.L886
	movzx	esi, sil
	movsx	rsi, DWORD PTR [r8+rsi*4]
	add	rsi, r8
	notrack jmp	rsi
	.section	.rodata
	.align 4
	.align 4
.L888:
	.long	.L893-.L888
	.long	.L892-.L888
	.long	.L891-.L888
	.long	.L886-.L888
	.long	.L890-.L888
	.long	.L889-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L886-.L888
	.long	.L887-.L888
	.text
	.p2align 4,,10
	.p2align 3
.L886:
	mov	BYTE PTR [rax], dl
	add	rax, 1
	.p2align 4,,10
	.p2align 3
.L895:
	add	rcx, 1
	cmp	QWORD PTR 8[rdi], rcx
	ja	.L896
.L884:
	mov	BYTE PTR [rax], 34
	add	rax, 1
	ret
	.p2align 4,,10
	.p2align 3
.L887:
	mov	esi, 8796
	add	rax, 2
	mov	WORD PTR -2[rax], si
	jmp	.L895
	.p2align 4,,10
	.p2align 3
.L889:
	mov	esi, 29276
	add	rax, 2
	mov	WORD PTR -2[rax], si
	jmp	.L895
	.p2align 4,,10
	.p2align 3
.L890:
	mov	r10d, 26204
	add	rax, 2
	mov	WORD PTR -2[rax], r10w
	jmp	.L895
	.p2align 4,,10
	.p2align 3
.L891:
	mov	r9d, 28252
	add	rax, 2
	mov	WORD PTR -2[rax], r9w
	jmp	.L895
	.p2align 4,,10
	.p2align 3
.L892:
	mov	edx, 29788
	add	rax, 2
	mov	WORD PTR -2[rax], dx
	jmp	.L895
	.p2align 4,,10
	.p2align 3
.L893:
	mov	r11d, 25180
	add	rax, 2
	mov	WORD PTR -2[rax], r11w
	jmp	.L895
	.p2align 4,,10
	.p2align 3
.L885:
	cmp	dl, 92
	jne	.L886
	mov	edx, 23644
	add	rax, 2
	mov	WORD PTR -2[rax], dx
	jmp	.L895
	.cfi_endproc
.LFE91:
	.size	json_write_string, .-json_write_string
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.p2align 4
	.weak	json_write_minified_value
	.type	json_write_minified_value, @function
json_write_minified_value:
.LFB94:
	.cfi_startproc
	endbr64
	cmp	QWORD PTR 8[rdi], 6
	ja	.L908
	mov	rax, QWORD PTR 8[rdi]
	lea	rdx, .L901[rip]
	movsx	rax, DWORD PTR [rdx+rax*4]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L901:
	.long	.L907-.L901
	.long	.L906-.L901
	.long	.L905-.L901
	.long	.L904-.L901
	.long	.L903-.L901
	.long	.L902-.L901
	.long	.L900-.L901
	.text
	.p2align 4,,10
	.p2align 3
.L902:
	mov	DWORD PTR [rsi], 1936482662
	lea	rax, 5[rsi]
	mov	BYTE PTR 4[rsi], 101
	ret
	.p2align 4,,10
	.p2align 3
.L900:
	mov	DWORD PTR [rsi], 1819047278
	lea	rax, 4[rsi]
	ret
	.p2align 4,,10
	.p2align 3
.L907:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_string
	.p2align 4,,10
	.p2align 3
.L906:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_number
	.p2align 4,,10
	.p2align 3
.L905:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_minified_object
	.p2align 4,,10
	.p2align 3
.L904:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_minified_array
	.p2align 4,,10
	.p2align 3
.L903:
	mov	DWORD PTR [rsi], 1702195828
	lea	rax, 4[rsi]
	ret
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	json_write_minified_value.cold, @function
json_write_minified_value.cold:
.LFSB94:
.L908:
	xor	eax, eax
	ret
	.cfi_endproc
.LFE94:
	.text
	.size	json_write_minified_value, .-json_write_minified_value
	.section	.text.unlikely
	.size	json_write_minified_value.cold, .-json_write_minified_value.cold
.LCOLDE7:
	.text
.LHOTE7:
	.p2align 4
	.weak	json_write_minified_array
	.type	json_write_minified_array, @function
json_write_minified_array:
.LFB92:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rax, rsi
	add	rsi, 1
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 8
	.cfi_def_cfa_offset 32
	mov	BYTE PTR [rax], 91
	mov	rbx, QWORD PTR [rdi]
	mov	rax, rsi
	test	rbx, rbx
	je	.L911
.L910:
	mov	rdi, QWORD PTR [rbx]
	call	json_write_minified_value
	test	rax, rax
	je	.L909
.L921:
	mov	rbx, QWORD PTR 8[rbx]
	test	rbx, rbx
	je	.L911
	mov	rsi, rax
	cmp	QWORD PTR 0[rbp], rbx
	je	.L910
	mov	BYTE PTR [rax], 44
	mov	rdi, QWORD PTR [rbx]
	add	rsi, 1
	call	json_write_minified_value
	test	rax, rax
	jne	.L921
.L909:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L911:
	.cfi_restore_state
	mov	BYTE PTR [rax], 93
	add	rsp, 8
	.cfi_def_cfa_offset 24
	add	rax, 1
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE92:
	.size	json_write_minified_array, .-json_write_minified_array
	.p2align 4
	.weak	json_write_minified_object
	.type	json_write_minified_object, @function
json_write_minified_object:
.LFB93:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rax, rsi
	add	rsi, 1
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 8
	.cfi_def_cfa_offset 32
	mov	BYTE PTR [rax], 123
	mov	rbx, QWORD PTR [rdi]
	mov	rax, rsi
	test	rbx, rbx
	je	.L924
.L923:
	mov	rdi, QWORD PTR [rbx]
	call	json_write_string
	test	rax, rax
	je	.L928
.L926:
	mov	BYTE PTR [rax], 58
	mov	rdi, QWORD PTR 8[rbx]
	lea	rsi, 1[rax]
	call	json_write_minified_value
	test	rax, rax
	je	.L928
	mov	rbx, QWORD PTR 16[rbx]
	test	rbx, rbx
	je	.L924
	mov	rsi, rax
	cmp	QWORD PTR 0[rbp], rbx
	je	.L923
	mov	BYTE PTR [rax], 44
	mov	rdi, QWORD PTR [rbx]
	add	rsi, 1
	call	json_write_string
	test	rax, rax
	jne	.L926
.L928:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	xor	r8d, r8d
	mov	rax, r8
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L924:
	.cfi_restore_state
	mov	BYTE PTR [rax], 125
	lea	r8, 1[rax]
	add	rsp, 8
	.cfi_def_cfa_offset 24
	mov	rax, r8
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE93:
	.size	json_write_minified_object, .-json_write_minified_object
	.p2align 4
	.weak	json_write_minified
	.type	json_write_minified, @function
json_write_minified:
.LFB95:
	.cfi_startproc
	endbr64
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	sub	rsp, 16
	.cfi_def_cfa_offset 48
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 8[rsp], rax
	xor	eax, eax
	mov	QWORD PTR [rsp], 0
	test	rdi, rdi
	je	.L949
	mov	rbx, rsi
	mov	rsi, rsp
	mov	rbp, rdi
	call	json_write_minified_get_value_size
	test	eax, eax
	jne	.L949
	mov	rax, QWORD PTR [rsp]
	lea	rdi, 1[rax]
	mov	QWORD PTR [rsp], rdi
	call	malloc@PLT
	mov	r12, rax
	test	rax, rax
	je	.L949
	mov	rsi, rax
	mov	rdi, rbp
	call	json_write_minified_value
	test	rax, rax
	je	.L950
	mov	BYTE PTR [rax], 0
	test	rbx, rbx
	je	.L936
	mov	rax, QWORD PTR [rsp]
	mov	QWORD PTR [rbx], rax
.L936:
	mov	rax, QWORD PTR 8[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L951
	add	rsp, 16
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L950:
	.cfi_restore_state
	mov	rdi, r12
	call	free@PLT
	.p2align 4,,10
	.p2align 3
.L949:
	xor	r12d, r12d
	jmp	.L936
.L951:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE95:
	.size	json_write_minified, .-json_write_minified
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4
	.weak	json_write_pretty_get_value_size
	.type	json_write_pretty_get_value_size, @function
json_write_pretty_get_value_size:
.LFB98:
	.cfi_startproc
	endbr64
	cmp	QWORD PTR 8[rdi], 6
	mov	rax, rdi
	ja	.L961
	mov	rdi, QWORD PTR 8[rdi]
	lea	r9, .L955[rip]
	movsx	rdi, DWORD PTR [r9+rdi*4]
	add	rdi, r9
	notrack jmp	rdi
	.section	.rodata
	.align 4
	.align 4
.L955:
	.long	.L960-.L955
	.long	.L959-.L955
	.long	.L958-.L955
	.long	.L957-.L955
	.long	.L954-.L955
	.long	.L956-.L955
	.long	.L954-.L955
	.text
	.p2align 4,,10
	.p2align 3
.L954:
	add	QWORD PTR [r8], 4
	xor	eax, eax
	ret
	.p2align 4,,10
	.p2align 3
.L957:
	mov	rdi, QWORD PTR [rax]
	jmp	json_write_pretty_get_array_size
	.p2align 4,,10
	.p2align 3
.L956:
	add	QWORD PTR [r8], 5
	xor	eax, eax
	ret
	.p2align 4,,10
	.p2align 3
.L960:
	mov	rdi, QWORD PTR [rax]
	mov	rsi, r8
	jmp	json_write_get_string_size
	.p2align 4,,10
	.p2align 3
.L959:
	mov	rdi, QWORD PTR [rax]
	mov	rsi, r8
	jmp	json_write_get_number_size
	.p2align 4,,10
	.p2align 3
.L958:
	mov	rdi, QWORD PTR [rax]
	jmp	json_write_pretty_get_object_size
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	json_write_pretty_get_value_size.cold, @function
json_write_pretty_get_value_size.cold:
.LFSB98:
.L961:
	mov	eax, 1
	ret
	.cfi_endproc
.LFE98:
	.text
	.size	json_write_pretty_get_value_size, .-json_write_pretty_get_value_size
	.section	.text.unlikely
	.size	json_write_pretty_get_value_size.cold, .-json_write_pretty_get_value_size.cold
.LCOLDE8:
	.text
.LHOTE8:
	.p2align 4
	.weak	json_write_pretty_get_array_size
	.type	json_write_pretty_get_array_size, @function
json_write_pretty_get_array_size:
.LFB96:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, r8
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	mov	rax, QWORD PTR [r8]
	mov	QWORD PTR 8[rsp], rsi
	add	rax, 1
	mov	QWORD PTR [r8], rax
	cmp	QWORD PTR 8[rdi], 0
	je	.L963
	add	rax, rcx
	mov	r15, rdx
	mov	rbp, QWORD PTR [rdi]
	mov	r14, rcx
	mov	QWORD PTR [r8], rax
	mov	rdx, QWORD PTR 8[rdi]
	lea	rax, -1[rax+rdx]
	mov	QWORD PTR [r8], rax
	test	rbp, rbp
	je	.L964
	lea	r12, 1[rsi]
	mov	r13, r12
	imul	r13, r15
	jmp	.L966
	.p2align 4,,10
	.p2align 3
.L973:
	mov	rax, QWORD PTR [rbx]
	mov	rbp, QWORD PTR 8[rbp]
	add	rax, r14
	mov	QWORD PTR [rbx], rax
	test	rbp, rbp
	je	.L964
.L966:
	add	rax, r13
	mov	rdi, QWORD PTR 0[rbp]
	mov	r8, rbx
	mov	rcx, r14
	mov	QWORD PTR [rbx], rax
	mov	rdx, r15
	mov	rsi, r12
	call	json_write_pretty_get_value_size
	test	eax, eax
	je	.L973
	add	rsp, 24
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	eax, 1
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L964:
	.cfi_restore_state
	mov	rbp, QWORD PTR 8[rsp]
	imul	rbp, r15
	add	rax, rbp
.L963:
	add	rax, 1
	mov	QWORD PTR [rbx], rax
	add	rsp, 24
	.cfi_def_cfa_offset 56
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE96:
	.size	json_write_pretty_get_array_size, .-json_write_pretty_get_array_size
	.p2align 4
	.weak	json_write_pretty_get_object_size
	.type	json_write_pretty_get_object_size, @function
json_write_pretty_get_object_size:
.LFB97:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, r8
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	mov	rax, QWORD PTR [r8]
	mov	QWORD PTR 8[rsp], rsi
	add	rax, 1
	mov	QWORD PTR [r8], rax
	cmp	QWORD PTR 8[rdi], 0
	je	.L975
	add	rax, rcx
	mov	r12, rdx
	mov	r15, QWORD PTR [rdi]
	mov	rbp, rcx
	mov	QWORD PTR [r8], rax
	mov	rdx, QWORD PTR 8[rdi]
	lea	rax, -1[rax+rdx]
	mov	QWORD PTR [r8], rax
	test	r15, r15
	je	.L976
	lea	r14, 1[rsi]
	mov	r13, r14
	imul	r13, r12
	add	r13, rcx
	jmp	.L980
	.p2align 4,,10
	.p2align 3
.L977:
	add	QWORD PTR [rbx], 3
	mov	rdi, QWORD PTR 8[r15]
	mov	r8, rbx
	mov	rcx, rbp
	mov	rdx, r12
	mov	rsi, r14
	call	json_write_pretty_get_value_size
	test	eax, eax
	jne	.L979
	mov	r15, QWORD PTR 16[r15]
	mov	rax, QWORD PTR [rbx]
	test	r15, r15
	je	.L976
.L980:
	add	rax, r13
	mov	rdi, QWORD PTR [r15]
	mov	rsi, rbx
	mov	QWORD PTR [rbx], rax
	call	json_write_get_string_size
	test	eax, eax
	je	.L977
.L979:
	add	rsp, 24
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	eax, 1
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L976:
	.cfi_restore_state
	mov	r15, QWORD PTR 8[rsp]
	imul	r15, r12
	add	rax, r15
.L975:
	add	rax, 1
	mov	QWORD PTR [rbx], rax
	add	rsp, 24
	.cfi_def_cfa_offset 56
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE97:
	.size	json_write_pretty_get_object_size, .-json_write_pretty_get_object_size
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.p2align 4
	.weak	json_write_pretty_value
	.type	json_write_pretty_value, @function
json_write_pretty_value:
.LFB101:
	.cfi_startproc
	endbr64
	cmp	QWORD PTR 8[rdi], 6
	ja	.L996
	mov	rax, QWORD PTR 8[rdi]
	lea	r9, .L989[rip]
	movsx	rax, DWORD PTR [r9+rax*4]
	add	rax, r9
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L989:
	.long	.L995-.L989
	.long	.L994-.L989
	.long	.L993-.L989
	.long	.L992-.L989
	.long	.L991-.L989
	.long	.L990-.L989
	.long	.L988-.L989
	.text
	.p2align 4,,10
	.p2align 3
.L990:
	mov	DWORD PTR [r8], 1936482662
	lea	rax, 5[r8]
	mov	BYTE PTR 4[r8], 101
	ret
	.p2align 4,,10
	.p2align 3
.L988:
	mov	DWORD PTR [r8], 1819047278
	lea	rax, 4[r8]
	ret
	.p2align 4,,10
	.p2align 3
.L995:
	mov	rdi, QWORD PTR [rdi]
	mov	rsi, r8
	jmp	json_write_string
	.p2align 4,,10
	.p2align 3
.L994:
	mov	rdi, QWORD PTR [rdi]
	mov	rsi, r8
	jmp	json_write_number
	.p2align 4,,10
	.p2align 3
.L993:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_pretty_object
	.p2align 4,,10
	.p2align 3
.L992:
	mov	rdi, QWORD PTR [rdi]
	jmp	json_write_pretty_array
	.p2align 4,,10
	.p2align 3
.L991:
	mov	DWORD PTR [r8], 1702195828
	lea	rax, 4[r8]
	ret
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	json_write_pretty_value.cold, @function
json_write_pretty_value.cold:
.LFSB101:
.L996:
	xor	eax, eax
	ret
	.cfi_endproc
.LFE101:
	.text
	.size	json_write_pretty_value, .-json_write_pretty_value
	.section	.text.unlikely
	.size	json_write_pretty_value.cold, .-json_write_pretty_value.cold
.LCOLDE9:
	.text
.LHOTE9:
	.p2align 4
	.weak	json_write_pretty_array
	.type	json_write_pretty_array, @function
json_write_pretty_array:
.LFB99:
	.cfi_startproc
	endbr64
	mov	rax, r8
	add	r8, 1
	mov	BYTE PTR [rax], 91
	cmp	QWORD PTR 8[rdi], 0
	jne	.L1046
	mov	BYTE PTR [r8], 93
	lea	rax, 1[r8]
	ret
.L1046:
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	mov	r15, rcx
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdx
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdi
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	movzx	eax, BYTE PTR [rcx]
	test	al, al
	je	.L999
	lea	rdx, 1[rcx]
	.p2align 4,,10
	.p2align 3
.L1000:
	add	rdx, 1
	mov	BYTE PTR [r8], al
	add	r8, 1
	movzx	eax, BYTE PTR -1[rdx]
	test	al, al
	jne	.L1000
	mov	r14, QWORD PTR [rbx]
	test	r14, r14
	je	.L1001
.L1020:
	lea	rbp, 1[r13]
	.p2align 4,,10
	.p2align 3
.L1002:
	xor	ecx, ecx
	xor	esi, esi
	test	rbp, rbp
	je	.L1006
	movzx	eax, BYTE PTR [r12]
	test	al, al
	je	.L1010
.L1009:
	lea	rdx, 1[r12]
	.p2align 4,,10
	.p2align 3
.L1007:
	add	rdx, 1
	mov	BYTE PTR [r8], al
	add	r8, 1
	movzx	eax, BYTE PTR -1[rdx]
	test	al, al
	jne	.L1007
	lea	rax, 1[rcx]
	cmp	r13, rcx
	je	.L1010
	mov	rcx, rax
	movzx	eax, BYTE PTR [r12]
	test	al, al
	jne	.L1009
.L1010:
	mov	rsi, rbp
.L1006:
	mov	rdi, QWORD PTR [r14]
	mov	rcx, r15
	mov	rdx, r12
	call	json_write_pretty_value
	mov	r8, rax
	test	rax, rax
	je	.L1023
	mov	r14, QWORD PTR 8[r14]
	test	r14, r14
	je	.L1001
	cmp	QWORD PTR [rbx], r14
	je	.L1002
	mov	BYTE PTR [r8], 44
	movzx	eax, BYTE PTR [r15]
	lea	rcx, 1[r8]
	test	al, al
	je	.L1021
	lea	rdx, 1[r15]
	mov	r8, rcx
	.p2align 4,,10
	.p2align 3
.L1004:
	add	rdx, 1
	mov	BYTE PTR [r8], al
	add	r8, 1
	movzx	eax, BYTE PTR -1[rdx]
	test	al, al
	jne	.L1004
	jmp	.L1002
.L1001:
	movzx	eax, BYTE PTR [r15]
	test	al, al
	je	.L1013
	add	r15, 1
.L1014:
	add	r15, 1
	mov	BYTE PTR [r8], al
	add	r8, 1
	movzx	eax, BYTE PTR -1[r15]
	test	al, al
	jne	.L1014
.L1013:
	xor	ecx, ecx
	test	r13, r13
	je	.L998
.L1015:
	movzx	eax, BYTE PTR [r12]
	test	al, al
	je	.L998
	lea	rdx, 1[r12]
	.p2align 4,,10
	.p2align 3
.L1016:
	add	rdx, 1
	mov	BYTE PTR [r8], al
	add	r8, 1
	movzx	eax, BYTE PTR -1[rdx]
	test	al, al
	jne	.L1016
	add	rcx, 1
	cmp	r13, rcx
	jne	.L1015
.L998:
	mov	BYTE PTR [r8], 93
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	lea	rax, 1[r8]
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L1021:
	.cfi_restore_state
	mov	r8, rcx
	jmp	.L1002
.L1023:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L999:
	.cfi_restore_state
	mov	r14, QWORD PTR [rdi]
	test	r14, r14
	jne	.L1020
	jmp	.L1013
	.cfi_endproc
.LFE99:
	.size	json_write_pretty_array, .-json_write_pretty_array
	.p2align 4
	.weak	json_write_pretty_object
	.type	json_write_pretty_object, @function
json_write_pretty_object:
.LFB100:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	lea	rsi, 1[r8]
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	mov	BYTE PTR [r8], 123
	cmp	QWORD PTR 8[rdi], 0
	mov	QWORD PTR 8[rsp], rdi
	je	.L1048
	movzx	eax, BYTE PTR [rcx]
	mov	r15, rdx
	mov	rbx, rcx
	test	al, al
	je	.L1049
	lea	rdx, 1[rcx]
	.p2align 4,,10
	.p2align 3
.L1050:
	add	rdx, 1
	mov	BYTE PTR [rsi], al
	add	rsi, 1
	movzx	eax, BYTE PTR -1[rdx]
	test	al, al
	jne	.L1050
	mov	rax, QWORD PTR 8[rsp]
	mov	r14, QWORD PTR [rax]
	test	r14, r14
	je	.L1051
.L1072:
	lea	r12, 1[r13]
	.p2align 4,,10
	.p2align 3
.L1052:
	xor	ecx, ecx
	xor	ebp, ebp
	test	r12, r12
	je	.L1056
	movzx	eax, BYTE PTR [r15]
	test	al, al
	je	.L1060
.L1059:
	lea	rdx, 1[r15]
	.p2align 4,,10
	.p2align 3
.L1057:
	add	rdx, 1
	mov	BYTE PTR [rsi], al
	add	rsi, 1
	movzx	eax, BYTE PTR -1[rdx]
	test	al, al
	jne	.L1057
	lea	rax, 1[rcx]
	cmp	r13, rcx
	je	.L1060
	mov	rcx, rax
	movzx	eax, BYTE PTR [r15]
	test	al, al
	jne	.L1059
.L1060:
	mov	rbp, r12
.L1056:
	mov	rdi, QWORD PTR [r14]
	call	json_write_string
	test	rax, rax
	je	.L1063
	mov	edx, 14880
	mov	BYTE PTR 2[rax], 32
	mov	rsi, rbp
	lea	r8, 3[rax]
	mov	WORD PTR [rax], dx
	mov	rdi, QWORD PTR 8[r14]
	mov	rcx, rbx
	mov	rdx, r15
	call	json_write_pretty_value
	mov	rsi, rax
	test	rax, rax
	je	.L1063
	mov	r14, QWORD PTR 16[r14]
	test	r14, r14
	je	.L1051
	mov	rax, QWORD PTR 8[rsp]
	cmp	QWORD PTR [rax], r14
	je	.L1052
	mov	BYTE PTR [rsi], 44
	movzx	eax, BYTE PTR [rbx]
	lea	rcx, 1[rsi]
	test	al, al
	je	.L1073
	lea	rdx, 1[rbx]
	mov	rsi, rcx
	.p2align 4,,10
	.p2align 3
.L1054:
	add	rdx, 1
	mov	BYTE PTR [rsi], al
	add	rsi, 1
	movzx	eax, BYTE PTR -1[rdx]
	test	al, al
	jne	.L1054
	jmp	.L1052
.L1051:
	movzx	eax, BYTE PTR [rbx]
	test	al, al
	je	.L1065
	add	rbx, 1
.L1066:
	add	rbx, 1
	mov	BYTE PTR [rsi], al
	add	rsi, 1
	movzx	eax, BYTE PTR -1[rbx]
	test	al, al
	jne	.L1066
.L1065:
	xor	ecx, ecx
	test	r13, r13
	je	.L1048
.L1067:
	movzx	eax, BYTE PTR [r15]
	test	al, al
	je	.L1048
	lea	rdx, 1[r15]
	.p2align 4,,10
	.p2align 3
.L1068:
	add	rdx, 1
	mov	BYTE PTR [rsi], al
	add	rsi, 1
	movzx	eax, BYTE PTR -1[rdx]
	test	al, al
	jne	.L1068
	add	rcx, 1
	cmp	r13, rcx
	jne	.L1067
.L1048:
	mov	BYTE PTR [rsi], 125
	add	rsp, 24
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	lea	rax, 1[rsi]
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L1063:
	.cfi_restore_state
	add	rsp, 24
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L1073:
	.cfi_restore_state
	mov	rsi, rcx
	jmp	.L1052
.L1049:
	mov	r14, QWORD PTR [rdi]
	test	r14, r14
	jne	.L1072
	jmp	.L1065
	.cfi_endproc
.LFE100:
	.size	json_write_pretty_object, .-json_write_pretty_object
	.section	.rodata.str1.1
.LC10:
	.string	"\n"
.LC11:
	.string	"  "
	.text
	.p2align 4
	.weak	json_write_pretty
	.type	json_write_pretty, @function
json_write_pretty:
.LFB102:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	sub	rsp, 16
	.cfi_def_cfa_offset 64
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 8[rsp], rax
	xor	eax, eax
	mov	QWORD PTR [rsp], 0
	test	rdi, rdi
	je	.L1125
	mov	rbp, rdi
	mov	r12, rsi
	mov	r13, rdx
	mov	rbx, rcx
	test	rsi, rsi
	je	.L1126
	movzx	edx, BYTE PTR [rsi]
	test	r13, r13
	je	.L1127
	movzx	eax, BYTE PTR 0[r13]
	test	dl, dl
	je	.L1128
.L1101:
	xor	edx, edx
	.p2align 4,,10
	.p2align 3
.L1104:
	add	rdx, 1
	cmp	BYTE PTR [r12+rdx], 0
	jne	.L1104
.L1105:
	test	al, al
	je	.L1113
.L1110:
	xor	ecx, ecx
	.p2align 4,,10
	.p2align 3
.L1107:
	add	rcx, 1
	cmp	BYTE PTR 0[r13+rcx], 0
	jne	.L1107
.L1106:
	xor	esi, esi
	mov	r8, rsp
	mov	rdi, rbp
	call	json_write_pretty_get_value_size
	test	eax, eax
	jne	.L1125
	mov	rax, QWORD PTR [rsp]
	lea	rdi, 1[rax]
	mov	QWORD PTR [rsp], rdi
	call	malloc@PLT
	mov	r14, rax
	test	rax, rax
	je	.L1125
	xor	esi, esi
	mov	r8, rax
	mov	rcx, r13
	mov	rdx, r12
	mov	rdi, rbp
	call	json_write_pretty_value
	test	rax, rax
	je	.L1129
	mov	BYTE PTR [rax], 0
	test	rbx, rbx
	je	.L1097
	mov	rax, QWORD PTR [rsp]
	mov	QWORD PTR [rbx], rax
.L1097:
	mov	rax, QWORD PTR 8[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L1130
	add	rsp, 16
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	mov	rax, r14
	pop	rbx
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
.L1129:
	.cfi_restore_state
	mov	rdi, r14
	call	free@PLT
	.p2align 4,,10
	.p2align 3
.L1125:
	xor	r14d, r14d
	jmp	.L1097
	.p2align 4,,10
	.p2align 3
.L1126:
	test	rdx, rdx
	je	.L1112
	movzx	eax, BYTE PTR [rdx]
	lea	r12, .LC11[rip]
	jmp	.L1101
	.p2align 4,,10
	.p2align 3
.L1127:
	mov	eax, 10
	lea	r13, .LC10[rip]
	test	dl, dl
	jne	.L1101
	xor	edx, edx
	jmp	.L1110
	.p2align 4,,10
	.p2align 3
.L1113:
	xor	ecx, ecx
	jmp	.L1106
	.p2align 4,,10
	.p2align 3
.L1128:
	xor	edx, edx
	jmp	.L1105
.L1112:
	lea	r12, .LC11[rip]
	mov	eax, 10
	lea	r13, .LC10[rip]
	jmp	.L1101
.L1130:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE102:
	.size	json_write_pretty, .-json_write_pretty
	.section	.rodata.str1.1
.LC12:
	.string	"%d\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB103:
	.cfi_startproc
	endbr64
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	rdi, QWORD PTR stdin[rip]
	call	getc@PLT
	lea	rsi, .LC12[rip]
	mov	edi, 1
	movzx	edx, ax
	xor	eax, eax
	call	__printf_chk@PLT
	xor	eax, eax
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE103:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	1
	.quad	0
	.align 16
.LC1:
	.quad	9
	.quad	0
	.align 16
.LC2:
	.quad	0
	.quad	1
	.ident	"GCC: (Ubuntu 11.2.0-7ubuntu2) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

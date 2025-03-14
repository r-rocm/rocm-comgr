; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i686-unknown < %s | FileCheck %s --check-prefix=X32
; RUN: llc -mtriple=x86_64-unknown < %s | FileCheck %s --check-prefix=X64

@array = weak dso_local global [4 x i32] zeroinitializer

define dso_local i32 @test_lshr_and(i32 %x) {
; X32-LABEL: test_lshr_and:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    andl $12, %eax
; X32-NEXT:    movl array(%eax), %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_lshr_and:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    andl $12, %edi
; X64-NEXT:    movl array(%rdi), %eax
; X64-NEXT:    retq
  %tmp2 = lshr i32 %x, 2
  %tmp3 = and i32 %tmp2, 3
  %tmp4 = getelementptr [4 x i32], [4 x i32]* @array, i32 0, i32 %tmp3
  %tmp5 = load i32, i32* %tmp4, align 4
  ret i32 %tmp5
}

define dso_local i32* @test_exact1(i32 %a, i32 %b, i32* %x)  {
; X32-LABEL: test_exact1:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    sarl %eax
; X32-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_exact1:
; X64:       # %bb.0:
; X64-NEXT:    subl %edi, %esi
; X64-NEXT:    sarl $3, %esi
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    leaq (%rdx,%rax,4), %rax
; X64-NEXT:    retq
  %sub = sub i32 %b, %a
  %shr = ashr exact i32 %sub, 3
  %gep = getelementptr inbounds i32, i32* %x, i32 %shr
  ret i32* %gep
}

define dso_local i32* @test_exact2(i32 %a, i32 %b, i32* %x)  {
; X32-LABEL: test_exact2:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    sarl %eax
; X32-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_exact2:
; X64:       # %bb.0:
; X64-NEXT:    subl %edi, %esi
; X64-NEXT:    sarl $3, %esi
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    leaq (%rdx,%rax,4), %rax
; X64-NEXT:    retq
  %sub = sub i32 %b, %a
  %shr = ashr exact i32 %sub, 3
  %gep = getelementptr inbounds i32, i32* %x, i32 %shr
  ret i32* %gep
}

define dso_local i32* @test_exact3(i32 %a, i32 %b, i32* %x)  {
; X32-LABEL: test_exact3:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_exact3:
; X64:       # %bb.0:
; X64-NEXT:    subl %edi, %esi
; X64-NEXT:    sarl $2, %esi
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    leaq (%rdx,%rax,4), %rax
; X64-NEXT:    retq
  %sub = sub i32 %b, %a
  %shr = ashr exact i32 %sub, 2
  %gep = getelementptr inbounds i32, i32* %x, i32 %shr
  ret i32* %gep
}

define dso_local i32* @test_exact4(i32 %a, i32 %b, i32* %x)  {
; X32-LABEL: test_exact4:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shrl %eax
; X32-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_exact4:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    subl %edi, %esi
; X64-NEXT:    shrl %esi
; X64-NEXT:    leaq (%rsi,%rdx), %rax
; X64-NEXT:    retq
  %sub = sub i32 %b, %a
  %shr = lshr exact i32 %sub, 3
  %gep = getelementptr inbounds i32, i32* %x, i32 %shr
  ret i32* %gep
}

define dso_local i32* @test_exact5(i32 %a, i32 %b, i32* %x)  {
; X32-LABEL: test_exact5:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shrl %eax
; X32-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_exact5:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    subl %edi, %esi
; X64-NEXT:    shrl %esi
; X64-NEXT:    leaq (%rsi,%rdx), %rax
; X64-NEXT:    retq
  %sub = sub i32 %b, %a
  %shr = lshr exact i32 %sub, 3
  %gep = getelementptr inbounds i32, i32* %x, i32 %shr
  ret i32* %gep
}

define dso_local i32* @test_exact6(i32 %a, i32 %b, i32* %x)  {
; X32-LABEL: test_exact6:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_exact6:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    subl %edi, %esi
; X64-NEXT:    leaq (%rsi,%rdx), %rax
; X64-NEXT:    retq
  %sub = sub i32 %b, %a
  %shr = lshr exact i32 %sub, 2
  %gep = getelementptr inbounds i32, i32* %x, i32 %shr
  ret i32* %gep
}

; PR42644 - https://bugs.llvm.org/show_bug.cgi?id=42644

define i64 @ashr_add_shl_i32(i64 %r) nounwind {
; X32-LABEL: ashr_add_shl_i32:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    incl %eax
; X32-NEXT:    movl %eax, %edx
; X32-NEXT:    sarl $31, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_shl_i32:
; X64:       # %bb.0:
; X64-NEXT:    incl %edi
; X64-NEXT:    movslq %edi, %rax
; X64-NEXT:    retq
  %conv = shl i64 %r, 32
  %sext = add i64 %conv, 4294967296
  %conv1 = ashr i64 %sext, 32
  ret i64 %conv1
}

define i64 @ashr_add_shl_i8(i64 %r) nounwind {
; X32-LABEL: ashr_add_shl_i8:
; X32:       # %bb.0:
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    addb $2, %al
; X32-NEXT:    movsbl %al, %eax
; X32-NEXT:    movl %eax, %edx
; X32-NEXT:    sarl $31, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_shl_i8:
; X64:       # %bb.0:
; X64-NEXT:    addb $2, %dil
; X64-NEXT:    movsbq %dil, %rax
; X64-NEXT:    retq
  %conv = shl i64 %r, 56
  %sext = add i64 %conv, 144115188075855872
  %conv1 = ashr i64 %sext, 56
  ret i64 %conv1
}

define <4 x i32> @ashr_add_shl_v4i8(<4 x i32> %r) nounwind {
; X32-LABEL: ashr_add_shl_v4i8:
; X32:       # %bb.0:
; X32-NEXT:    pushl %edi
; X32-NEXT:    pushl %esi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movb {{[0-9]+}}(%esp), %ch
; X32-NEXT:    movb {{[0-9]+}}(%esp), %dh
; X32-NEXT:    incb %dh
; X32-NEXT:    movsbl %dh, %esi
; X32-NEXT:    incb %ch
; X32-NEXT:    movsbl %ch, %edi
; X32-NEXT:    incb %dl
; X32-NEXT:    movsbl %dl, %edx
; X32-NEXT:    incb %cl
; X32-NEXT:    movsbl %cl, %ecx
; X32-NEXT:    movl %ecx, 12(%eax)
; X32-NEXT:    movl %edx, 8(%eax)
; X32-NEXT:    movl %edi, 4(%eax)
; X32-NEXT:    movl %esi, (%eax)
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %edi
; X32-NEXT:    retl $4
;
; X64-LABEL: ashr_add_shl_v4i8:
; X64:       # %bb.0:
; X64-NEXT:    pslld $24, %xmm0
; X64-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; X64-NEXT:    psrad $24, %xmm0
; X64-NEXT:    retq
  %conv = shl <4 x i32> %r, <i32 24, i32 24, i32 24, i32 24>
  %sext = add <4 x i32> %conv, <i32 16777216, i32 16777216, i32 16777216, i32 16777216>
  %conv1 = ashr <4 x i32> %sext, <i32 24, i32 24, i32 24, i32 24>
  ret <4 x i32> %conv1
}

define i64 @ashr_add_shl_i36(i64 %r) nounwind {
; X32-LABEL: ashr_add_shl_i36:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    shll $4, %edx
; X32-NEXT:    movl %edx, %eax
; X32-NEXT:    sarl $4, %eax
; X32-NEXT:    sarl $31, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_shl_i36:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shlq $36, %rax
; X64-NEXT:    sarq $36, %rax
; X64-NEXT:    retq
  %conv = shl i64 %r, 36
  %sext = add i64 %conv, 4294967296
  %conv1 = ashr i64 %sext, 36
  ret i64 %conv1
}

define i64 @ashr_add_shl_mismatch_shifts1(i64 %r) nounwind {
; X32-LABEL: ashr_add_shl_mismatch_shifts1:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    incl %eax
; X32-NEXT:    movl %eax, %edx
; X32-NEXT:    sarl $31, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_shl_mismatch_shifts1:
; X64:       # %bb.0:
; X64-NEXT:    shlq $8, %rdi
; X64-NEXT:    movabsq $4294967296, %rax # imm = 0x100000000
; X64-NEXT:    addq %rdi, %rax
; X64-NEXT:    sarq $32, %rax
; X64-NEXT:    retq
  %conv = shl i64 %r, 8
  %sext = add i64 %conv, 4294967296
  %conv1 = ashr i64 %sext, 32
  ret i64 %conv1
}

define i64 @ashr_add_shl_mismatch_shifts2(i64 %r) nounwind {
; X32-LABEL: ashr_add_shl_mismatch_shifts2:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    shrl $8, %edx
; X32-NEXT:    incl %edx
; X32-NEXT:    shrdl $8, %edx, %eax
; X32-NEXT:    shrl $8, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_shl_mismatch_shifts2:
; X64:       # %bb.0:
; X64-NEXT:    shrq $8, %rdi
; X64-NEXT:    movabsq $4294967296, %rax # imm = 0x100000000
; X64-NEXT:    addq %rdi, %rax
; X64-NEXT:    shrq $8, %rax
; X64-NEXT:    retq
  %conv = lshr i64 %r, 8
  %sext = add i64 %conv, 4294967296
  %conv1 = ashr i64 %sext, 8
  ret i64 %conv1
}

define dso_local i32 @ashr_add_shl_i32_i8_extra_use1(i32 %r, i32* %p) nounwind {
; X32-LABEL: ashr_add_shl_i32_i8_extra_use1:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll $24, %eax
; X32-NEXT:    addl $33554432, %eax # imm = 0x2000000
; X32-NEXT:    movl %eax, (%ecx)
; X32-NEXT:    sarl $24, %eax
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_shl_i32_i8_extra_use1:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    shll $24, %edi
; X64-NEXT:    leal 33554432(%rdi), %eax
; X64-NEXT:    movl %eax, (%rsi)
; X64-NEXT:    sarl $24, %eax
; X64-NEXT:    retq
  %conv = shl i32 %r, 24
  %sext = add i32 %conv, 33554432
  store i32 %sext, i32* %p
  %conv1 = ashr i32 %sext, 24
  ret i32 %conv1
}

define dso_local i32 @ashr_add_shl_i32_i8_extra_use2(i32 %r, i32* %p) nounwind {
; X32-LABEL: ashr_add_shl_i32_i8_extra_use2:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll $24, %eax
; X32-NEXT:    movl %eax, (%ecx)
; X32-NEXT:    addl $33554432, %eax # imm = 0x2000000
; X32-NEXT:    sarl $24, %eax
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_shl_i32_i8_extra_use2:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    shll $24, %edi
; X64-NEXT:    movl %edi, (%rsi)
; X64-NEXT:    leal 33554432(%rdi), %eax
; X64-NEXT:    sarl $24, %eax
; X64-NEXT:    retq
  %conv = shl i32 %r, 24
  store i32 %conv, i32* %p
  %sext = add i32 %conv, 33554432
  %conv1 = ashr i32 %sext, 24
  ret i32 %conv1
}

define dso_local i32 @ashr_add_shl_i32_i8_extra_use3(i32 %r, i32* %p1, i32* %p2) nounwind {
; X32-LABEL: ashr_add_shl_i32_i8_extra_use3:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll $24, %eax
; X32-NEXT:    movl %eax, (%edx)
; X32-NEXT:    addl $33554432, %eax # imm = 0x2000000
; X32-NEXT:    movl %eax, (%ecx)
; X32-NEXT:    sarl $24, %eax
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_shl_i32_i8_extra_use3:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    shll $24, %edi
; X64-NEXT:    movl %edi, (%rsi)
; X64-NEXT:    leal 33554432(%rdi), %eax
; X64-NEXT:    movl %eax, (%rdx)
; X64-NEXT:    sarl $24, %eax
; X64-NEXT:    retq
  %conv = shl i32 %r, 24
  store i32 %conv, i32* %p1
  %sext = add i32 %conv, 33554432
  store i32 %sext, i32* %p2
  %conv1 = ashr i32 %sext, 24
  ret i32 %conv1
}

%"class.QPainterPath" = type { double, double, i32 }

define dso_local void @PR42880(i32 %t0) {
; X32-LABEL: PR42880:
; X32:       # %bb.0:
; X32-NEXT:    xorl %eax, %eax
; X32-NEXT:    testb %al, %al
; X32-NEXT:    je .LBB16_1
; X32-NEXT:  # %bb.2: # %if
; X32-NEXT:  .LBB16_1: # %then
;
; X64-LABEL: PR42880:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    testb %al, %al
; X64-NEXT:    je .LBB16_1
; X64-NEXT:  # %bb.2: # %if
; X64-NEXT:  .LBB16_1: # %then
  %sub = add nsw i32 %t0, -1
  %add.ptr.i94 = getelementptr inbounds %"class.QPainterPath", %"class.QPainterPath"* null, i32 %sub
  %x = ptrtoint %"class.QPainterPath"* %add.ptr.i94 to i32
  %sub2 = sub i32 %x, 0
  %div = sdiv exact i32 %sub2, 24
  br i1 undef, label %if, label %then

then:
  %t1 = xor i32 %div, -1
  unreachable

if:
  unreachable
}

; The mul here is the equivalent of (neg (shl X, 32)).
define i64 @ashr_add_neg_shl_i32(i64 %r) nounwind {
; X32-LABEL: ashr_add_neg_shl_i32:
; X32:       # %bb.0:
; X32-NEXT:    movl $1, %eax
; X32-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, %edx
; X32-NEXT:    sarl $31, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_neg_shl_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl $1, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    cltq
; X64-NEXT:    retq
  %conv = mul i64 %r, -4294967296
  %sext = add i64 %conv, 4294967296
  %conv1 = ashr i64 %sext, 32
  ret i64 %conv1
}

; The mul here is the equivalent of (neg (shl X, 56)).
define i64 @ashr_add_neg_shl_i8(i64 %r) nounwind {
; X32-LABEL: ashr_add_neg_shl_i8:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll $24, %eax
; X32-NEXT:    movl $33554432, %edx # imm = 0x2000000
; X32-NEXT:    subl %eax, %edx
; X32-NEXT:    movl %edx, %eax
; X32-NEXT:    sarl $24, %eax
; X32-NEXT:    sarl $31, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ashr_add_neg_shl_i8:
; X64:       # %bb.0:
; X64-NEXT:    movb $2, %al
; X64-NEXT:    subb %dil, %al
; X64-NEXT:    movsbq %al, %rax
; X64-NEXT:    retq
  %conv = mul i64 %r, -72057594037927936
  %sext = add i64 %conv, 144115188075855872
  %conv1 = ashr i64 %sext, 56
  ret i64 %conv1
}

; The mul here is the equivalent of (neg (shl X, 24)).
define <4 x i32> @ashr_add_neg_shl_v4i8(<4 x i32> %r) nounwind {
; X32-LABEL: ashr_add_neg_shl_v4i8:
; X32:       # %bb.0:
; X32-NEXT:    pushl %edi
; X32-NEXT:    pushl %esi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movb $1, %cl
; X32-NEXT:    movb $1, %dl
; X32-NEXT:    subb {{[0-9]+}}(%esp), %dl
; X32-NEXT:    movsbl %dl, %edx
; X32-NEXT:    movb $1, %ch
; X32-NEXT:    subb {{[0-9]+}}(%esp), %ch
; X32-NEXT:    movsbl %ch, %esi
; X32-NEXT:    movb $1, %ch
; X32-NEXT:    subb {{[0-9]+}}(%esp), %ch
; X32-NEXT:    movsbl %ch, %edi
; X32-NEXT:    subb {{[0-9]+}}(%esp), %cl
; X32-NEXT:    movsbl %cl, %ecx
; X32-NEXT:    movl %ecx, 12(%eax)
; X32-NEXT:    movl %edi, 8(%eax)
; X32-NEXT:    movl %esi, 4(%eax)
; X32-NEXT:    movl %edx, (%eax)
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %edi
; X32-NEXT:    retl $4
;
; X64-LABEL: ashr_add_neg_shl_v4i8:
; X64:       # %bb.0:
; X64-NEXT:    pslld $24, %xmm0
; X64-NEXT:    movdqa {{.*#+}} xmm1 = [16777216,16777216,16777216,16777216]
; X64-NEXT:    psubd %xmm0, %xmm1
; X64-NEXT:    psrad $24, %xmm1
; X64-NEXT:    movdqa %xmm1, %xmm0
; X64-NEXT:    retq
  %conv = mul <4 x i32> %r, <i32 -16777216, i32 -16777216, i32 -16777216, i32 -16777216>
  %sext = add <4 x i32> %conv, <i32 16777216, i32 16777216, i32 16777216, i32 16777216>
  %conv1 = ashr <4 x i32> %sext, <i32 24, i32 24, i32 24, i32 24>
  ret <4 x i32> %conv1
}

define i32 @or_tree_with_shifts_i32(i32 %a, i32 %b, i32 %c, i32 %d) {
; X32-LABEL: or_tree_with_shifts_i32:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll $16, %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: or_tree_with_shifts_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    orl %edx, %edi
; X64-NEXT:    shll $16, %edi
; X64-NEXT:    orl %ecx, %eax
; X64-NEXT:    orl %edi, %eax
; X64-NEXT:    retq
  %a.shifted = shl i32 %a, 16
  %c.shifted = shl i32 %c, 16
  %or.ab = or i32 %a.shifted, %b
  %or.cd = or i32 %c.shifted, %d
  %r = or i32 %or.ab, %or.cd
  ret i32 %r
}

define i32 @xor_tree_with_shifts_i32(i32 %a, i32 %b, i32 %c, i32 %d) {
; X32-LABEL: xor_tree_with_shifts_i32:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    xorl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shrl $16, %eax
; X32-NEXT:    xorl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    xorl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: xor_tree_with_shifts_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    xorl %edx, %edi
; X64-NEXT:    shrl $16, %edi
; X64-NEXT:    xorl %ecx, %eax
; X64-NEXT:    xorl %edi, %eax
; X64-NEXT:    retq
  %a.shifted = lshr i32 %a, 16
  %c.shifted = lshr i32 %c, 16
  %xor.ab = xor i32 %a.shifted, %b
  %xor.cd = xor i32 %d, %c.shifted
  %r = xor i32 %xor.ab, %xor.cd
  ret i32 %r
}

define i32 @and_tree_with_shifts_i32(i32 %a, i32 %b, i32 %c, i32 %d) {
; X32-LABEL: and_tree_with_shifts_i32:
; X32:       # %bb.0:
; X32-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movswl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    andl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    andl %ecx, %eax
; X32-NEXT:    retl
;
; X64-LABEL: and_tree_with_shifts_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    andl %edx, %edi
; X64-NEXT:    sarl $16, %edi
; X64-NEXT:    andl %ecx, %eax
; X64-NEXT:    andl %edi, %eax
; X64-NEXT:    retq
  %a.shifted = ashr i32 %a, 16
  %c.shifted = ashr i32 %c, 16
  %and.ab = and i32 %b, %a.shifted
  %and.cd = and i32 %c.shifted, %d
  %r = and i32 %and.ab, %and.cd
  ret i32 %r
}

define i32 @logic_tree_with_shifts_var_i32(i32 %a, i32 %b, i32 %c, i32 %d, i32 %s) {
; X32-LABEL: logic_tree_with_shifts_var_i32:
; X32:       # %bb.0:
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll %cl, %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: logic_tree_with_shifts_var_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    orl %edx, %edi
; X64-NEXT:    movl %r8d, %ecx
; X64-NEXT:    shll %cl, %edi
; X64-NEXT:    orl %esi, %eax
; X64-NEXT:    orl %edi, %eax
; X64-NEXT:    retq
  %a.shifted = shl i32 %a, %s
  %c.shifted = shl i32 %c, %s
  %or.ab = or i32 %b, %a.shifted
  %or.cd = or i32 %d, %c.shifted
  %r = or i32 %or.ab, %or.cd
  ret i32 %r
}

define i32 @logic_tree_with_mismatching_shifts_i32(i32 %a, i32 %b, i32 %c, i32 %d) {
; X32-LABEL: logic_tree_with_mismatching_shifts_i32:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    shll $15, %ecx
; X32-NEXT:    shll $16, %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl %ecx, %eax
; X32-NEXT:    retl
;
; X64-LABEL: logic_tree_with_mismatching_shifts_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %edx, %eax
; X64-NEXT:    shll $15, %edi
; X64-NEXT:    shll $16, %eax
; X64-NEXT:    orl %esi, %edi
; X64-NEXT:    orl %ecx, %eax
; X64-NEXT:    orl %edi, %eax
; X64-NEXT:    retq
  %a.shifted = shl i32 %a, 15
  %c.shifted = shl i32 %c, 16
  %or.ab = or i32 %a.shifted, %b
  %or.cd = or i32 %c.shifted, %d
  %r = or i32 %or.ab, %or.cd
  ret i32 %r
}

define i32 @logic_tree_with_mismatching_shifts2_i32(i32 %a, i32 %b, i32 %c, i32 %d) {
; X32-LABEL: logic_tree_with_mismatching_shifts2_i32:
; X32:       # %bb.0:
; X32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    shll $16, %ecx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl %ecx, %eax
; X32-NEXT:    retl
;
; X64-LABEL: logic_tree_with_mismatching_shifts2_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %edx, %eax
; X64-NEXT:    shll $16, %edi
; X64-NEXT:    shrl $16, %eax
; X64-NEXT:    orl %esi, %edi
; X64-NEXT:    orl %ecx, %eax
; X64-NEXT:    orl %edi, %eax
; X64-NEXT:    retq
  %a.shifted = shl i32 %a, 16
  %c.shifted = lshr i32 %c, 16
  %or.ab = or i32 %a.shifted, %b
  %or.cd = or i32 %c.shifted, %d
  %r = or i32 %or.ab, %or.cd
  ret i32 %r
}

define <4 x i32> @or_tree_with_shifts_vec_i32(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c, <4 x i32> %d) {
; X32-LABEL: or_tree_with_shifts_vec_i32:
; X32:       # %bb.0:
; X32-NEXT:    pushl %edi
; X32-NEXT:    .cfi_def_cfa_offset 8
; X32-NEXT:    pushl %esi
; X32-NEXT:    .cfi_def_cfa_offset 12
; X32-NEXT:    .cfi_offset %esi, -12
; X32-NEXT:    .cfi_offset %edi, -8
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    shll $16, %ecx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    shll $16, %edx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %esi
; X32-NEXT:    shll $16, %esi
; X32-NEXT:    orl {{[0-9]+}}(%esp), %esi
; X32-NEXT:    orl {{[0-9]+}}(%esp), %esi
; X32-NEXT:    orl {{[0-9]+}}(%esp), %edi
; X32-NEXT:    shll $16, %edi
; X32-NEXT:    orl {{[0-9]+}}(%esp), %edi
; X32-NEXT:    orl {{[0-9]+}}(%esp), %edi
; X32-NEXT:    movl %edi, 12(%eax)
; X32-NEXT:    movl %esi, 8(%eax)
; X32-NEXT:    movl %edx, 4(%eax)
; X32-NEXT:    movl %ecx, (%eax)
; X32-NEXT:    popl %esi
; X32-NEXT:    .cfi_def_cfa_offset 8
; X32-NEXT:    popl %edi
; X32-NEXT:    .cfi_def_cfa_offset 4
; X32-NEXT:    retl $4
;
; X64-LABEL: or_tree_with_shifts_vec_i32:
; X64:       # %bb.0:
; X64-NEXT:    por %xmm2, %xmm0
; X64-NEXT:    pslld $16, %xmm0
; X64-NEXT:    por %xmm3, %xmm1
; X64-NEXT:    por %xmm1, %xmm0
; X64-NEXT:    retq
  %a.shifted = shl <4 x i32> %a, <i32 16, i32 16, i32 16, i32 16>
  %c.shifted = shl <4 x i32> %c, <i32 16, i32 16, i32 16, i32 16>
  %or.ab = or <4 x i32> %a.shifted, %b
  %or.cd = or <4 x i32> %c.shifted, %d
  %r = or <4 x i32> %or.ab, %or.cd
  ret <4 x i32> %r
}

define <4 x i32> @or_tree_with_mismatching_shifts_vec_i32(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c, <4 x i32> %d) {
; X32-LABEL: or_tree_with_mismatching_shifts_vec_i32:
; X32:       # %bb.0:
; X32-NEXT:    pushl %edi
; X32-NEXT:    .cfi_def_cfa_offset 8
; X32-NEXT:    pushl %esi
; X32-NEXT:    .cfi_def_cfa_offset 12
; X32-NEXT:    .cfi_offset %esi, -12
; X32-NEXT:    .cfi_offset %edi, -8
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll $16, %eax
; X32-NEXT:    shll $17, %ecx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    orl %eax, %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll $16, %eax
; X32-NEXT:    shll $17, %edx
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    orl %eax, %edx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll $16, %eax
; X32-NEXT:    shll $17, %esi
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %esi
; X32-NEXT:    orl %eax, %esi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll $16, %eax
; X32-NEXT:    shll $17, %edi
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl {{[0-9]+}}(%esp), %edi
; X32-NEXT:    orl %eax, %edi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %ecx, 12(%eax)
; X32-NEXT:    movl %edx, 8(%eax)
; X32-NEXT:    movl %esi, 4(%eax)
; X32-NEXT:    movl %edi, (%eax)
; X32-NEXT:    popl %esi
; X32-NEXT:    .cfi_def_cfa_offset 8
; X32-NEXT:    popl %edi
; X32-NEXT:    .cfi_def_cfa_offset 4
; X32-NEXT:    retl $4
;
; X64-LABEL: or_tree_with_mismatching_shifts_vec_i32:
; X64:       # %bb.0:
; X64-NEXT:    pslld $16, %xmm0
; X64-NEXT:    pslld $17, %xmm2
; X64-NEXT:    por %xmm1, %xmm0
; X64-NEXT:    por %xmm3, %xmm2
; X64-NEXT:    por %xmm2, %xmm0
; X64-NEXT:    retq
  %a.shifted = shl <4 x i32> %a, <i32 16, i32 16, i32 16, i32 16>
  %c.shifted = shl <4 x i32> %c, <i32 17, i32 17, i32 17, i32 17>
  %or.ab = or <4 x i32> %a.shifted, %b
  %or.cd = or <4 x i32> %c.shifted, %d
  %r = or <4 x i32> %or.ab, %or.cd
  ret <4 x i32> %r
}

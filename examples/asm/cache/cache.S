.section .text
.global test1
.type test1, @function

test1:
	# ABI prologue
	addi sp, sp, -112     # allocate 112 bytes on the stack
	sw ra, 104(sp)        # save return address
	sw s0, 96(sp)         # save callee-saved registers
	sw s1, 88(sp)
	sw s2, 80(sp)
	sw s3, 72(sp)
	sw s4, 64(sp)
	sw s5, 56(sp)
	sw s6, 48(sp)
	sw s7, 40(sp)
	sw s8, 32(sp)
	sw s9, 24(sp)
	sw s10, 16(sp)
	sw s11, 8(sp)
	addi s0, sp, 112     # set up s0 to point to start of stack frame

    la   a0, __data_start    # cache start address
    li   a3, 0xCAFECAFE    # return value	
	sw a3, (a0)

#     .globl flush_data_section
flush_data_section:
    la   a0, __data_start    # cache start address
    la   a1, __data_end      # cache end address

    li   t0, 512              # 512 bytes taken from the derivlist.txt
                              
flush_loop:
    beq  a0, a1, end_flush          # if cache end address, done

    cbo.zero 0(a0)             # flush cache block containing [a0]

    add  a0, a0, t0          # a0 += block size
    blt  a0, a1, flush_loop          # loop while a0 < a1

end_flush:

	# li t0, 0x80000770
	# sw zero, 0(t0)
	# sw zero, 1(t0)
	# lw t1, (t0)
	# addi t0, t0, 1
	# sw t1, (t0)

	# // way 1
	# li t0, 0x80001770
	# sw zero, 0(t0)
	# sw zero, 1(t0)
	# lw t1, (t0)
	# addi t0, t0, 1
	# sw t1, (t0)

	# // way 2
	# li t0, 0x80002770
	# sw zero, 0(t0)
	# sw zero, 1(t0)
	# lw t1, (t0)
	# addi t0, t0, 1
	# sw t1, (t0)

	# // way 3
	# li t0, 0x80003770
	# sw zero, 0(t0)
	# sw zero, 1(t0)
	# lw t1, (t0)
	# addi t0, t0, 1
	# sw t1, (t0)


    # ABI epilogue
	lw s11, 8(sp)        # restore callee-saved registers
	lw s10, 16(sp)
	lw s9, 24(sp)
	lw s8, 32(sp)
	lw s7, 40(sp)
	lw s6, 48(sp)
	lw s5, 56(sp)
	lw s4, 64(sp)
	lw s3, 72(sp)
	lw s2, 80(sp)
	lw s1, 88(sp)
	lw s0, 96(sp)
	lw ra, 104(sp)       # restore return address
	addi sp, sp, 112     # deallocate stack space
	jr ra                # return to caller



# READ/WRITE VARIABLES

.section .data

# READ-ONLY VARIABLES

.section .rodata
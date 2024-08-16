.include "data.s"
.include "lib/printNumber.s"
.include "lib/sys_write.s"
.include "lib/sys_exit.s"
.include "lib/sys_open.s"
.include "lib/sys_close.s"
.include "lib/sys_stat.s"

.section .text
.global _start
_start:
    movq %rsp, %rbp
    subq $144, %rsp

    movq %rbp, %rbx
    cmpq $2, (%rbx)
    jne  exit_usage
section0:
    addq $16, %rbx

    open (%rbx), O_RDONLY(%rip), $0
    testq %rax, %rax
    js exit_error

    pushq %rax

    stat %rax, -144(%rbp)
    leaq -144(%rbp), %rbx

    popq %rax
    close %rax
section1:
    # st_dev
    statField  (%rbx), file_id(%rip), file_id_len(%rip)

    # st_ino
    statField  8(%rbx), file_Inode(%rip), file_Inode_len(%rip)

    # st_mode
    statField  16(%rbx), file_type(%rip), file_type_len(%rip)

    # st_nlink
    statField  24(%rbx), links_number(%rip), links_number_len(%rip)

    # st_uid
    statField  32(%rbx), user_id(%rip), user_id_len(%rip)

    # st_gid
    statField  40(%rbx), group_id(%rip), group_id_len(%rip)

    # st_size
    statField  48(%rbx), file_size(%rip), file_size_len(%rip)

    # st_blksize
    statField  56(%rbx), block_size(%rip), block_size_len(%rip)

    # st_blocks
    statField  64(%rbx), blocks_number(%rip), blocks_number_len(%rip)

exit_success:
    exit $0

exit_usage:
    write $1, usage(%rip), usage_len(%rip)
    exit $-1

exit_error:
    write $2, error(%rip), error_len(%rip)
    exit $-2

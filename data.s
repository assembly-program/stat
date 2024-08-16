.section .data
file_id: .string "File ID: "
file_id_len: .quad . - file_id

file_Inode: .string "Inode number: "
file_Inode_len: .quad . - file_Inode

file_type: .string "File type: "
file_type_len: .quad . - file_type

links_number: .string "Links number: "
links_number_len: .quad . - links_number

user_id: .string "User ID: "
user_id_len: .quad . - user_id

group_id: .string "Group ID: "
group_id_len: .quad . - group_id

device_id: .string "Device ID: "
device_id_len: .quad . - device_id

file_size: .string "File size: "
file_size_len: .quad . - file_size

block_size: .string "Block size: "
block_size_len: .quad . - block_size

blocks_number: .string "Blocks number: "
blocks_number_len: .quad . - blocks_number

usage: .string "Usage: stat <filename>\n"
usage_len: .quad . - usage

error: .string "error: failed to open file\n"
error_len: .quad . - error

.macro statField num, str, str_len
    write $1, \str, \str_len

    movq     \num, %rax
    cvtsi2sd %rax, %xmm0
    movq     $0, %rdi
    call     printNumber

    writeln $1
.endm


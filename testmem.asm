again:
lui $8,0xffbb
ori $8,0xaa55
lui $9,0xaa55
ori $9,0xffbb
sw $8,0($0)
sw $9,4($0)
lw $10,0($0)
lw $11,4($0)
sw $0,0($0)
sh $8,0($0)
sh $8,2($0)
lh $10,0($0)
lhu $11,0($0)
lh $10,2($0)
lhu $11,2($0)
sw $0,0($0)
sh $9,0($0)
sh $9,2($0)
lh $10,0($0)
lhu $11,0($0)
lh $10,2($0)
lhu $11,2($0)
sw $0,0($0)
sb $8,0($0)
sb $8,1($0)
sb $8,2($0)
sb $8,3($0)
lb $10,0($0)
lb $11,1($0)
lb $10,2($0)
lb $11,3($0)
lbu $10,0($0)
lbu $11,1($0)
lbu $10,2($0)
lbu $11,3($0)
sw $0,0($0)
sb $9,0($0)
sb $9,1($0)
sb $9,2($0)
sb $9,3($0)
lb $10,0($0)
lb $11,1($0)
lb $10,2($0)
lb $11,3($0)
lbu $10,0($0)
lbu $11,1($0)
lbu $10,2($0)
lbu $11,3($0)
j again
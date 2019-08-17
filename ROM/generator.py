import copy
from pprint import pprint

HLT = 0b1000000000000000
MI  = 0b0100000000000000
RI  = 0b0010000000000000
RO  = 0b0001000000000000
IO  = 0b0000100000000000
II  = 0b0000010000000000
AI  = 0b0000001000000000
AO  = 0b0000000100000000
EO  = 0b0000000010000000
SU  = 0b0000000001000000
BI  = 0b0000000000100000
OI  = 0b0000000000010000
CE  = 0b0000000000001000
CO  = 0b0000000000000100
J   = 0b0000000000000010
FI  = 0b0000000000000001

FLAGS_Z0C0 = 0b00
FLAGS_Z0C1 = 0b01
FLAGS_Z1C0 = 0b10
FLAGS_Z1C1 = 0b11

JC = 0b0111
JZ = 0b1000

template = [
    [CO|MI, RO|II|CE, 0    , 0    , 0           , 0, 0, 0,], # Fetch - 0000
    [CO|MI, RO|II|CE, IO|MI, RO|AI, 0           , 0, 0, 0,], # LDA   - 0001
    [CO|MI, RO|II|CE, IO|MI, RO|BI, EO|AI|FI    , 0, 0, 0,], # ADD   - 0010
    [CO|MI, RO|II|CE, IO|MI, RO|BI, EO|AI|SU|FI , 0, 0, 0,], # SUB   - 0011
    [CO|MI, RO|II|CE, IO|MI, AO|RI, 0           , 0, 0, 0,], # STA   - 0100
    [CO|MI, RO|II|CE, IO|AI, 0    , 0           , 0, 0, 0,], # LDI   - 0101
    [CO|MI, RO|II|CE, IO|J , 0    , 0           , 0, 0, 0,], # JMP   - 0110
    [CO|MI, RO|II|CE, 0    , 0    , 0           , 0, 0, 0,], # JC    - 0111
    [CO|MI, RO|II|CE, 0    , 0    , 0           , 0, 0, 0,], # JZ    - 1000
    [CO|MI, RO|II|CE, 0    , 0    , 0           , 0, 0, 0,],
    [CO|MI, RO|II|CE, 0    , 0    , 0           , 0, 0, 0,],
    [CO|MI, RO|II|CE, 0    , 0    , 0           , 0, 0, 0,],
    [CO|MI, RO|II|CE, 0    , 0    , 0           , 0, 0, 0,],
    [CO|MI, RO|II|CE, 0    , 0    , 0           , 0, 0, 0,],
    [CO|MI, RO|II|CE, AO|OI, 0    , 0           , 0, 0, 0,], # OUT   - 1110
    [CO|MI, RO|II|CE, HLT  , 0    , 0           , 0, 0, 0,], # HLT   - 1111
]

memory = [
    copy.deepcopy(template), 
    copy.deepcopy(template), 
    copy.deepcopy(template), 
    copy.deepcopy(template)
]

# Setup the special instructions
memory[FLAGS_Z0C1][JC][2] = IO|J
memory[FLAGS_Z1C0][JZ][2] = IO|J
memory[FLAGS_Z1C1][JC][2] = IO|J
memory[FLAGS_Z1C1][JZ][2] = IO|J

memory_str = list()
# memory_str = ['{0:016b}'.format(word) for word in memory]
for addr in range(0, 512):
    flags       = (addr & 0b110000000) >> 7
    instruction = (addr & 0b001111000) >> 3
    step        = (addr & 0b000000111)
    pprint('ADDR: {0:09b} - {1:016b}'.format(addr, memory[flags][instruction][step]))
    memory_str.append('{0:016b}'.format(memory[flags][instruction][step]))

with open('microcode.coe', 'w') as f:
    f.write('memory_initialization_radix=2;\n')
    f.write('memory_initialization_vector=\n')
    out = ',\n'.join(memory_str)
    out += ';'
    f.write(out)
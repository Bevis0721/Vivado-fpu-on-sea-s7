# Instruction
2020年新工科联盟-Xilinx暑期学校（Summer School）项目。 目标是将fpu通过FPGA实现连接到esp32实现基本的浮点运算。
--2020.7.26 16:50

2020.7.31 实现二进制的浮点数运算
上传代码（无IP核）。
qspi_adder is a data process module, we change its time cycle to compute float (add, minus, multiply, divide).
QSPO_slave_tp is the top module to connect each module.
qspi_slave is a module to connect ram with FPGA.
FPU is a module to compute,
Git stats

通过串口监视器进行输入和观察输出
为方便演示，输入1=输入2=3.14（以二进制方式输入）

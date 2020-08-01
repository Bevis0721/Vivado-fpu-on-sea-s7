# Instruction ESP32添加FPU（无外设）

项⽬概要：在esp32上增加一定的浮点数运算处理  
使⽤的⼯具版本： upycraft v1.0  
板卡型号：Spartan Edge Accelerator Board  
仓库⽬录：如描述  
组队人员：  
  队长 2018112801  
  队员 2018112772


2020年新工科联盟-Xilinx暑期学校（Summer School）项目。 目标是将fpu通过FPGA实现连接到esp32实现基本的浮点运算。
--2020.7.26 16:50

2020.7.31 实现二进制的浮点数运算
上传代码（无IP核）。
qspi_adder is a data process module, we change its time cycle to compute float (add, minus, multiply, divide).  
QSPO_slave_tp is the top module to connect each module.  
qspi_slave is a module to connect ram with FPGA.  
FPU is a module to compute。  
Git stats

通过串口监视器进行输入和观察输出    
为方便演示，输入1=输入2=3.14（以二进制方式输入）  
3.14与9.85的16进制表示：  
![image](https://github.com/Bevis0721/Vivado-fpu-on-sea-s7/blob/master/%E6%A1%88%E4%BE%8B%E6%BC%94%E7%A4%BA/3.14.jpg)  
![image](https://github.com/Bevis0721/Vivado-fpu-on-sea-s7/blob/master/%E6%A1%88%E4%BE%8B%E6%BC%94%E7%A4%BA/9.8596.jpg) 

由于modqspi传输会丢失初始的数据，因此输入第一个数据无视，最后一个输入为运算符确定（0123，加减乘除）  
此处以乘法为例：  

![image](https://github.com/Bevis0721/Vivado-fpu-on-sea-s7/blob/master/%E6%A1%88%E4%BE%8B%E6%BC%94%E7%A4%BA/%E6%B5%AE%E7%82%B9%E6%95%B0%E4%B9%98%E6%B3%95.JPG)

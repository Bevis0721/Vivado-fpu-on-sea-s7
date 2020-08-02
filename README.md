# ESP32添加FPU（无外设）
2020年新工科联盟-Xilinx暑期学校（Summer School）项目。   
目标：将fpu通过FPGA实现连接到esp32实现基本的浮点运算。 
## 项目概要：在esp32上增加浮点数运算处理   
通过upycraft的串口监视器发送数据，运算后返回到串口监视器验证。  
### 实现原理
float型浮点数可以按照IEEE754转换为32位二进制数，数据通过串口输入，利用QSPI通信协议模块传输到RAM端，RAM端数据被FPGA端读取并进行FPU的运算，将结果输出返回到RAM端，再次通过QSPI通信模块传输到串口显示器加以验证。  
### 实现功能
按规定输入两个二进制显示的float数和运算符，最后返回一个二进制运算结果。  
## 使用的⼯具版本： 
upycraft v1.0    
## 板卡型号：
Spartan Edge Accelerator Board  (SEA board)  


## 组队人员：  
  队长 2018112801  
  队员 2018112772

## 上传记录
目标：将fpu通过FPGA实现连接到esp32实现基本的浮点运算。  
2020.7.26    
创立仓库   

2020.7.31   
实现二进制的浮点数运算  
上传代码（无IP核）。  
qspi_adder is a data process module, we change its time cycle to compute float (add, minus, multiply, divide).  
QSPO_slave_tp is the top module to connect each module.  
qspi_slave is a module to connect ram with FPGA.  
FPU is a module to compute。  

2020.8.01  
修改格式  
## 案例演示

通过串口监视器进行输入和观察输出    
为方便演示，输入1=输入2=3.14（以二进制方式输入）  
3.14与9.85的16进制表示：  
![image](https://github.com/Bevis0721/Vivado-fpu-on-sea-s7/blob/master/%E6%A1%88%E4%BE%8B%E6%BC%94%E7%A4%BA/3.14.jpg)  
![image](https://github.com/Bevis0721/Vivado-fpu-on-sea-s7/blob/master/%E6%A1%88%E4%BE%8B%E6%BC%94%E7%A4%BA/9.8596.jpg) 

由于modqspi传输会丢失初始的数据，因此输入第一个数据无视，最后一个输入为运算符确定（0123，加减乘除）  
此处以乘法为例：  

![image](https://github.com/Bevis0721/Vivado-fpu-on-sea-s7/blob/master/%E6%A1%88%E4%BE%8B%E6%BC%94%E7%A4%BA/%E6%B5%AE%E7%82%B9%E6%95%B0%E4%B9%98%E6%B3%95.JPG)

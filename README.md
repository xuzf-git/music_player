# music-player

基于 MIPS 架构、UART 串口通信等方法，通过 Verilog HDL 设计实现包含 CPU 和外设控制器的音乐播放器

## 架构

架构图如下所示：

![image-20211003194531073.png](https://i.loli.net/2021/10/03/PiI6Dr7UcRJqtEb.png)

最终的 **I/O方案** 包括通信和播放两个模块，一个控制中心CPU

1. 通信模块：首先通过传输开关向 CPU 发送“开始传输”的信号，CPU接到此信号后向UART发送cpu_ready的控制信号，UART接到此信号后开始传输数据以及data_ready 信号给CPU，CPU将接收到的数据写入到RAM中，实现了数据输入

2. 播放模块：首先通过 播放开关 向 CPU 发送开始播放信号，CPU 执行音乐播放程序，将音频数据从RAM中取出，传输给蜂鸣器进行播放。

在这个IO方案里，外设通过 CPU 间接访问内存，解决了DMA方式的访存冲突问题

## MIPS 音乐播放程序

```assembly
addiu $4, $0, 0                  // 四号寄存器保存音乐数据首数据地址
// ***********初始化指令区*********** //
begin:
    关闭传输使能指令       
    关闭蜂鸣器使能指令      
    死循环指令         
// **********传输数据指令区**********//
打开uart使能          
transfer_data_command_area:
    等待uart把数据传到32位寄存器
    lw $2, 1023($0)             // 取数据写在 2 号寄存器中
    sw $2, ($4)
    addiu $4, $4, 4
    beq $2, 0, transfer_end
    j transfer_data_command_area
transfer_end: 
    j begin
// **********播放歌曲指令区********** //
addiu $3, $0, 0                 // 取歌曲数据首地址保存在 3 号寄存器中
lw $2, ($3)                     // 3 号寄存器作为数据地址取数据保存到 2 号寄存器
sw $2, 1022($0)                 // 保存频率数据
addiu $3, $3, 4                 // 计算时间数据地址
lw $2, ($3)                     // 取时间数据
sw $2, 1021($0)                 // 保存时间数据
启动蜂鸣器             
play_command_area:
    等待当前节拍播放完毕     
    addiu $3, $3, 4             // 计算频率数据地址
    lw $2, ($3)                 // 取频率数据
    beq $2, 0, play_end              // 如果取到的数据为全零，说明为结尾，跳出循环
    sw $2, 1022($0)             // 保存频率数据
    addiu $3, $3, 4             // 计算时间数据地址
    lw $2, ($3)                 // 取时间数据
    sw $2, 1021($0)             // 保存时间数据
    j play_command_area
play_end:
    j begin
// ********************************* //
```

MIPS程序，由于没有实现中断功能而且功能简单。所以将指令分为三个区域，

1. 初始化指令区，
2. 传输数据指令区，
3. 播放歌曲指令区，

在初始化完成后，程序停在初始化指令区，等待按下传送或者播放按钮后，根据信号修改 PC 值，PC 跳转到相应的指令区域，执行完毕后在跳转回初始化指令区。采用特殊的指令实现外设的启动和等待。外设和CPU 间数据交互采用 `sw` 和 `lw` 读写特殊地址的方式完成。

## 仿真

### UART与CPU异步通信

![image-20211003195241008.png](https://i.loli.net/2021/10/03/Xdzc53xRHCwSF2u.png)

### CPU执行音乐播放程序

![image-20211003195625390.png](https://i.loli.net/2021/10/03/MHUxoJCj6mAfDPK.png)


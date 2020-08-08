# CPU2020
Project: Central Processing Unit
---

### **Specification**

An efficient CPU implementation is optimised to solve commonly occurring computing problems. Features must be chosen carefully to achieve the best performance in the greatest number of applications for the smallest number of transistors.

Design a CPU with an ISA that is optimised to execute the following algorithms efficiently. Describe the CPU using block schematics and Verilog modules, and simulate using Quartus Prime. You will need to implement the benchmark algorithms in the machine code for your ISA.

You may assume that the **CPU word length (and the C++ int variables used below) are all 16 bits**. Your CPU should **implement enough memory for at least 2K words of instructions and 2K words of data**. Your CPU may use separate instruction and data memory units, or one combined memory unit.

***

#### **Structure (Unfinalised)**:
📦CPU2020 </br>
 ┣ 📂Task 1</br>
 ┃ ┣ 📂code</br>
 ┃ ┃ ┣ 📜.DS_Store</br>
 ┃ ┃ ┣ 📜Fibonacci.cpp</br>
 ┃ ┃ ┣ 📜LCG.cpp</br>
 ┃ ┃ ┗ 📜linkedlist.cpp</br>
 ┃ ┗ 📜.DS_Store</br>
 ┣ 📂Task 2</br>
 ┣ 📂Task 3</br>
 ┗ 📜README.md</br>


#### **✅ Task 1: *Calculate Fibonacci numbers using recursion***

This benchmark requires a ***stack*** to keep track of all the nested intermediate data values in a (very inefficient) recursive implementation of the fib() function. Alternative implementations that don’t require a stack are not permitted. The stack is a history of all the functions the CPU is currently executing, so that when it finishes a function it can return to where it left off, including all the local variables that were being used. You could implement the stack with custom hardware or using normal data memory, designing appropriate instructions in your ISA.

*Code example:* 		

`int fib(const int n){`

`int fib(const int n){` 

`int y;`

`if (n<=1) y = 1;`

`else`

`y = fib(n-1);`

`y = y + fib(n-2);`

`return y;}`  --> ***see Fibonacci.cpp in code file***

A typical use of the benchmark would be **fib(5)**.



#### 💡Task 1 Approach

##### ✨Highlight in our Design：

Rather than performing a recursive loop to calculate a fibonacci number which has an **exponential increasing rate of execution time**, in our design, we choose to use a **linear increasing rate** so that it takes less time to perform fibonacci calculation. Another improvement of this design is besides stacking the memory, it can also read from the previous history if the given input number is  already calculated from the calculation before.

**ISA: **

It keeps the MU0 ISA so that each instruction is composed of **4 bit opcode + 1 bit random + 11 bit oprand**.



**Instruction Set:**

This is used to help write the decoder verilog file which 0 illustrates port is in use and 1 means not in use.

|  Ins  | op\[15\] | op\[14\] | op\[13\] | op\[12\] |     | EXEC2 | EXEC1 | FETCH | Extra |       |  EQ   |  MI   |     | CON\[0\]: Wren | CON\[1\]:IR_enable & Mux2 | CON\[2\]: *PC_cnt_en* | CON\[3\]: *PC_sload* | CON\[4\]: ALU_add\_sub | CON\[5\]: ACC_enable | CON\[6\]: ACC_shiftin | CON\[7\]: ACC\_sload | CON\[8\]: Mux1 | CON\[9\]: LSL | CON\[10\]: Mux3 |
| :---: | :------: | :------: | :------: | :------: | --- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | --- | :------------: | ------------------------- | :-------------------: | :------------------: | :--------------------: | :------------------: | :-------------------: | :------------------: | :------------: | ------------- | :-------------: |
|  LDA  |    0     |    0     |    0     |    0     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    0     |    0     |    0     |    0     |     |   0   |   1   |   0   |   1   |       |   x   |   x   |     |       0        | 1                         |           0           |          0           |           0            |          0           |           0           |          0           |       1        | 0             |        0        |
|       |    0     |    0     |    0     |    0     |     |   1   |   0   |   0   |   x   |       |   x   |   x   |     |       0        | 0                         |           1           |          0           |           0            |          1           |           0           |          1           |       x        | 0             |        1        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  STA  |    0     |    0     |    0     |    1     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    0     |    0     |    0     |    1     |     |   0   |   1   |   0   |   0   |       |   x   |   x   |     |       1        | 1                         |           1           |          0           |           0            |          0           |           0           |          0           |       1        | 0             |        0        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  ADD  |    0     |    0     |    1     |    0     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    0     |    0     |    1     |    0     |     |   0   |   1   |   0   |   1   |       |   x   |   x   |     |       0        | 1                         |           0           |          0           |           0            |          0           |           0           |          0           |       1        | 0             |        0        |
|       |    0     |    0     |    1     |    0     |     |   1   |   0   |   0   |   x   |       |   x   |   x   |     |       0        | 0                         |           1           |          0           |           1            |          1           |           0           |          1           |       x        | 0             |        0        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  SUB  |    0     |    0     |    1     |    1     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    0     |    0     |    1     |    1     |     |   0   |   1   |   0   |   1   |       |   x   |   x   |     |       0        | 1                         |           0           |          0           |           0            |          0           |           0           |          0           |       1        | 0             |        0        |
|       |    0     |    0     |    1     |    1     |     |   1   |   0   |   0   |   x   |       |   x   |   x   |     |       0        | 0                         |           1           |          0           |           0            |          1           |           0           |          1           |       x        | 0             |        0        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  JMP  |    0     |    1     |    0     |    0     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    0     |    1     |    0     |    0     |     |   0   |   1   |   0   |   0   |       |   x   |   x   |     |       0        | 1                         |           0           |          1           |           0            |          0           |           0           |          0           |       x        | 0             |        0        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  JMI  |    0     |    1     |    0     |    1     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    0     |    1     |    0     |    1     |     |   0   |   1   |   0   |   0   |       |   x   |   1   |     |       0        | 1                         |           0           |          1           |           0            |          0           |           0           |          0           |       x        | 0             |        0        |
|       |    0     |    1     |    0     |    1     |     |   0   |   1   |   0   |   0   |       |   x   |   0   |     |       0        | 0                         |           1           |          0           |           0            |          0           |           0           |          0           |       x        | 0             |        0        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  JEQ  |    0     |    1     |    1     |    0     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    0     |    1     |    1     |    0     |     |   0   |   1   |   0   |   0   |       |   1   |   x   |     |       0        | 1                         |           0           |          1           |           0            |          0           |           0           |          0           |       x        | 0             |        0        |
|       |    0     |    1     |    1     |    0     |     |   0   |   1   |   0   |   0   |       |   0   |   x   |     |       0        | 0                         |           1           |          0           |           0            |          0           |           0           |          0           |       x        | 0             |        0        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  STP  |    0     |    1     |    1     |    1     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    0     |    1     |    1     |    1     |     |   0   |   1   |   0   |   x   |       |   x   |   x   |     |       0        | 1                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  LDI  |    1     |    0     |    0     |    0     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    1     |    0     |    0     |    0     |     |   0   |   1   |   0   |   0   |       |   x   |   x   |     |       0        | 1                         |           1           |          0           |           0            |          1           |           0           |          1           |       x        | 0             |        1        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  LSL  |    1     |    0     |    0     |    1     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    1     |    0     |    0     |    1     |     |   0   |   1   |   0   |   0   |       |   x   |   x   |     |       0        | 1                         |           1           |          0           |           1            |          1           |           0           |          1           |       x        | 1             |        0        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  LSR  |    1     |    0     |    1     |    0     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    1     |    0     |    1     |    0     |     |   0   |   1   |   0   |   0   |       |   x   |   x   |     |       0        | 1                         |           1           |          0           |           0            |          1           |           0           |          0           |       x        | 0             |        0        |
|       |          |          |          |          |     |       |       |       |       |       |       |       |     |                |                           |                       |                      |                        |                      |                       |                      |                |               |                 |
|  FIB  |    1     |    0     |    1     |    1     |     |   0   |   0   |   1   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |
|       |    1     |    0     |    1     |    1     |     |   0   |   1   |   0   |   1   |       |   x   |   x   |     |       0        | 1                         |           1           |          0           |           0            |          0           |           0           |          0           |       x        | 0             |        0        |
|       |    1     |    0     |    1     |    1     |     |   1   |   0   |   0   |   x   |       |   x   |   x   |     |       0        | 0                         |           0           |          0           |           0            |          0           |           0           |          0           |       0        | 0             |        0        |



**Component List:**

This list generalises the components used in this task and the corresponding functionality.

|        Name        |        Component        | Quantity |                                  Function                                   |
| :----------------: | :---------------------: | :------: | :-------------------------------------------------------------------------: |
| Instruction + Data | RAM(16 bits&4096 words) |    1     |                Store the instruction and data to be executed                |
|       EQ_MI        |      Verilog File       |    1     |                         Provide signal to JMI & JEQ                         |
|      LDA_LDI       |      Verilog File       |    1     |                   Overcome the difference in word length                    |
|      Decoder       |      Verilog File       |    1     |              Main control unit that controls each port in CPU               |
|    Statemachine    |      Verilog File       |    1     |                        Control the state of the CPU                         |
|     Fibonacci      |      Verilog File       |    1     |         A special block designed specifically for Fibonacci series          |
|        Dffn        |          .bdf           |    1     |                         Store the current the state                         |
|         IR         |         LPM_FF          |    1     |                        Store the current instruction                        |
|        ALU         |       LPM_ADD_SUB       |    1     |                           Do Arithmetic operation                           |
|         PC         |       LPM_COUNTER       |    1     |                Record the memory address of next instruction                |
|        ACC         |      LPM_SHIFTREG       |    1     |                   Store the results after most executions                   |
|        MUX1        |         BUSMUX          |    1     | Select between the address from PC and operand from the current instruction |
|        MUX2        |         BUSMUX          |    1     |                      Save one clock cycle after fetch                       |
|        MUX3        |         BUSMUX          |    1     |              Select between the value from ALU or the LDA_LDI               |
|        MUX4        |         NUXMUX          |    1     |                       Select between the ACC and RAM                        |

---

#### **✅Task 2: *Calculate pseudo-random integers with a linear congruential generator (LCG)***

One commonly used way to implement random numbers on a computer is the linear congruential generator which computes the sequence: x<sub>n+1</sub> = (a * x<sub>n</sub> + 𝑏) mod 2<sup>N</sup>. For suitably chosen a, b and N this sequence approximates random numbers in the range [0..2N-1]. Typically, N is chosen to be the computer word length, so the modulo operation is truncation that happens at no cost. This example requires multiplication: there are many ways to implement this in hardware or software and you may choose whatever works, however you are not allowed to use a Verilog IP blocks, nor to use a Verilog multiply operator, since they use fixed hardware constructs that restrict implementation choices.

*Code Example:*

`int lcong(`

`const unsigned int a,
             const unsigned int b,
             const int n,
             const unsigned int s)`

`{unsigned int y = s;`

` unsigned int sum = 0;
for (int i = n ; i > 0; i--){
y = y*a + b // calculate the new pseudo-random number
sum = sum + y // add it to the total` 

`}` 

`return sum;`

`}` --> ***see LCG.cpp in code file***

The benchmark code finds N numbers in the sequence and adds them together. A typical problem here would have a = 25385, b = 3, n = 8. You might try to investigate which values of a, b lead to optimal generators, achieving the longest possible sequence before it repeats. Parameter s is a seed – it defines a starting point for the sequence.				



#### 💡Task 2 Approach:

##### Maths and Programming Method to Find the suitable coefficients a and b:

The pseudo-random numbers are generated by calculate the next number x<sub>n+1</sub> , do a division by 2<sup>N</sup> (which here N is chosen to be the word length N = 16) and then take its remainder. So the range of the remainber is kept in the range [0,2<sup>N-1</sup>].

In our LCG.cpp program, we put the first 65536 (2<sup>16</sup>) terms of the random numbers generated in a vector and check the elements stored previously see if the repetition happens. If the repetition does not happen in first 65535 terms we can say the coefficients a and b. Here, the optimal a is 73, b is 3. Also, we found whatever the seed we start with, as long as we do not change the coefficients, the answer produced are fixed within a set.


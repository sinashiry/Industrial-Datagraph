$regfile = "m8def.dat"
$crystal = 8000000
$baud = 9600
Config Adc = Single , Prescaler = Auto , Reference = Avcc
Dim Analog As Word
Dim Temp As Single
Dim A As Byte
Dim B As Integer
Dim C As Bit
Start Adc
B = 0
Do
'B = Waitkey()
Analog = Getadc(0)
Temp = Analog / 2.048
A = Temp
Printbin A
Waitms 10
'If B < 330 Then Incr B
'If B > 328 Then Waitms 300
Loop
End                                                         'end program
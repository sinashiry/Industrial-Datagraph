$regfile = "m32def.dat"
$crystal = 8000000
Config Porta = Input
Config Portb.1 = Input
Config Portb.4 = Input
Config Graphlcd = 240 * 128 , Dataport = Portd , Controlport = Portc , Ce = 2 , Cd = 3 , Wr = 0 , Rd = 1 , Reset = 4 , Fs = 5 , Mode = 8
'===interrupts===
Config Int2 = Rising
On Int2 Button
Enable Int2
Enable Interrupts
Cls : Cursor Off
'===connecting===
Open "comb.0:9600,8,n,1" For Input As #1
Open "comb.3:9600,8,n,1" For Input As #2
'===dims===
Dim A As Byte
Dim B As Byte
Dim Dama(231) As Byte
Dim Dama2(231) As Byte
Dim Dama1line As Byte
Dim Dama1line0 As Byte
Dim Dama1wait As Byte
Dim Dama2line As Byte
Dim Dama2line0 As Byte
Dim Dama2wait As Byte
Dim Dama01 As Byte
Dim Dama02 As Byte
Dim C As Byte
Dim D As Byte
Dim E As Byte
Dim F As Byte
Dim G As Byte
Dim H As Byte
Dim I As Byte
Dim I2 As Byte
Dim X As Byte
Dim X2 As Byte
Dim But As Byte
Dim But1 As Byte
Dim Maincir As Byte
Dim Kelvin As Word
Dim W As Bit
Dim W1 As Bit
Dim W2 As Bit
Dim W21 As Bit
Dim W3 As Bit
Dim W31 As Bit
Dim W4 As Bit
Dim W41 As Bit
Dim Z As Byte
Dim Z2 As Byte
Dim Z1 As Byte
Dim Z3 As Byte
Dim W5 As Byte
Dim W51 As Byte
Dim Z4 As Byte
Dim Disp As Byte
Dim Disp1 As Byte
Dim Disp2 As Byte
Dim Graphwait As Byte
Dim Curtemp As Bit
Dim Mintemp As Bit
Dim Maxtemp As Bit
Dim Keltemp As Bit
Dim Senstime As Bit
Dim Sensselect As Bit
Dim Mainsensor1 As Bit
Dim Mainsensor2 As Bit
Dim Change As Byte
Dim Zoom1 As Byte
Dim Zoom2 As Bit
Dim Zoom3 As Bit
Dim Zoom4 As Bit
Dim Zoompic As Byte
Dim Kk As Byte
Dim Ss As Byte

'===aliases===
Up Alias But.0
Down Alias But.1
Right0 Alias But.2
Left0 Alias But.3
No Alias But.4
Yes Alias But.5
Esc Alias But.6
Menu Alias But.7
Sen1sw Alias Pinb.1
Sen2sw Alias Pinb.4

First:
'===magadir===
E = 0
F = 100
Z = 160
Z1 = 200
Z2 = 200
Z3 = 200
Z4 = 200
Curtemp = 1
Maxtemp = 0
Mintemp = 0
Keltemp = 0
Pinb.0 = 0
Pinb.1 = 0
Dama1wait = 1
'===cls===
Start0:
Cls Graph
Cls Text
Do
Locate 9 , 6
Lcd "PLEASE ENTER SENSOR"
If Pinb.1 = 1 Then Gosub Sensor1
If Pinb.4 = 1 Then Gosub Sensor2
Loop
Sensor1:
Cls Text
Wait 2
Locate 9 , 10
Lcd "Please Wait"
For I = 230 To 5 Step -1
  Dama(i) = Waitkey(#1)
  Dama(i) = 100 - Dama(i)
Next
Cls Text
Mainsensor1 = 1
Start1:
Change = 1
Cls Text
Cls Graph
'===lines===
Line(4 , 5)(4 , 101) , 255
Line(4 , 101)(230 , 101) , 255
'===vertical_sign===
Pset 3 , 5 , 1
Pset 2 , 5 , 1
Pset 5 , 5 , 1
Pset 6 , 5 , 1
Pset 3 , 4 , 1
Pset 5 , 4 , 1
Pset 4 , 4 , 1
Pset 4 , 3 , 1
'===vertical_psets===
Pset 3 , 90 , 1
Pset 3 , 80 , 1
Pset 3 , 70 , 1
Pset 3 , 60 , 1
Pset 3 , 50 , 1
Pset 3 , 40 , 1
Pset 3 , 30 , 1
Pset 3 , 20 , 1
Pset 3 , 10 , 1
'===horizontal_sign===
Pset 228 , 99 , 1
Pset 228 , 100 , 1
Pset 228 , 102 , 1
Pset 228 , 103 , 1
Pset 229 , 100 , 1
Pset 229 , 102 , 1
'===horizontal_psets===
Pset 14 , 102 , 1
Pset 24 , 102 , 1
Pset 34 , 102 , 1
Pset 44 , 102 , 1
Pset 54 , 102 , 1
Pset 64 , 102 , 1
Pset 74 , 102 , 1
Pset 84 , 102 , 1
Pset 94 , 102 , 1
Pset 104 , 102 , 1
Pset 114 , 102 , 1
Pset 124 , 102 , 1
Pset 134 , 102 , 1
Pset 144 , 102 , 1
Pset 154 , 102 , 1
Pset 164 , 102 , 1
Pset 174 , 102 , 1
Pset 184 , 102 , 1
Pset 194 , 102 , 1
Pset 204 , 102 , 1
Pset 214 , 102 , 1
Pset 224 , 102 , 1
'===LCDs===
Locate 1 , 2
Lcd "T('c )"
Locate 13 , 30
Lcd "t"
'===start program===
Do
If Pinb.1 = 0 Then Gosub Start0
If Pinb.4 = 1 Then
   If Sensselect = 0 Then
      Gosub Sensorselect
   End If
End If
If Curtemp = 1 Then
   Locate 14 , 1
   Lcd "Ctemp:"
End If
If Maxtemp = 1 Then
   Locate 15 , 1
   Lcd "max.t:"
End If
If Mintemp = 1 Then
   Locate 16 , 1
   Lcd "min.t:"
End If
If Keltemp = 1 Then
   Locate 14 , 11
   Lcd "Ctemp(K):"
End If
If Senstime = 1 Then
   Locate 15 , 11
   Lcd "SensTime:"
End If
'==== sensor1===
For I = 5 To 230
    X = I + 1
    Dama1line = Dama(x)
    Dama1line0 = Dama(i)
   Line(i , Dama1line0)(x , Dama1line) , 255
Next
Wait Dama1wait
For I = 5 To 230
   X = I + 1
   Dama1line = Dama(x)
   Dama1line0 = Dama(i)
   Line(i , Dama1line0)(x , Dama1line) , 0
Next
For I = 230 To 5 Step -1
    X = I + 1
    Dama(x) = Dama(i)
Next
Dama01 = Waitkey(#1)
If Dama01 < 70 Then Dama(5) = Dama01
D = Dama(5)
Kelvin = D + 273
If Zoom1 = 1 Then Dama(5) = Dama(5)
If Zoom2 = 1 Then Dama(5) = 2 * Dama(5)
If Zoom3 = 1 Then Dama(5) = 3.333333 * Dama(5)
If Zoom4 = 1 Then Dama(5) = 4 * Dama(5)
Dama(5) = 100 - Dama(5)
'=====
If Curtemp = 1 Then
   Locate 14 , 7
   Lcd D
End If
If D > E Then
   E = D
End If
If Maxtemp = 1 Then
   Locate 15 , 7
   Lcd E
End If
If D < F Then
   F = D
End If
If Mintemp = 1 Then
   Locate 16 , 7
   Lcd F
End If
If Keltemp = 1 Then
   Locate 14 , 21
   Lcd Kelvin ; ""
End If
If Senstime = 1 Then
   Locate 15 , 21
   Lcd Dama1wait
End If
If Menu = 1 Then
   Menu = 0
   Waitms 500
   Gosub Menu1
End If
Loop
End
Return
'====sensor2====
Sensor2:
Cls Text
Wait 2
Locate 9 , 10
Lcd "Please Wait"
For I2 = 230 To 5 Step -1
  Dama2(i2) = Waitkey(#2)
  Dama2(i2) = 100 - Dama2(i2)
Next
Cls Text
Mainsensor2 = 1
Start2:
Change = 2
Cls Graph
Cls Text
'===lines===
Line(4 , 5)(4 , 101) , 255
Line(4 , 101)(230 , 101) , 255
'===vertical_sign===
Pset 3 , 5 , 1
Pset 2 , 5 , 1
Pset 5 , 5 , 1
Pset 6 , 5 , 1
Pset 3 , 4 , 1
Pset 5 , 4 , 1
Pset 4 , 4 , 1
Pset 4 , 3 , 1
'===vertical_psets===
Pset 3 , 90 , 1
Pset 3 , 80 , 1
Pset 3 , 70 , 1
Pset 3 , 60 , 1
Pset 3 , 50 , 1
Pset 3 , 40 , 1
Pset 3 , 30 , 1
Pset 3 , 20 , 1
Pset 3 , 10 , 1
'===horizontal_sign===
Pset 228 , 99 , 1
Pset 228 , 100 , 1
Pset 228 , 102 , 1
Pset 228 , 103 , 1
Pset 229 , 100 , 1
Pset 229 , 102 , 1
'===horizontal_psets===
Pset 14 , 102 , 1
Pset 24 , 102 , 1
Pset 34 , 102 , 1
Pset 44 , 102 , 1
Pset 54 , 102 , 1
Pset 64 , 102 , 1
Pset 74 , 102 , 1
Pset 84 , 102 , 1
Pset 94 , 102 , 1
Pset 104 , 102 , 1
Pset 114 , 102 , 1
Pset 124 , 102 , 1
Pset 134 , 102 , 1
Pset 144 , 102 , 1
Pset 154 , 102 , 1
Pset 164 , 102 , 1
Pset 174 , 102 , 1
Pset 184 , 102 , 1
Pset 194 , 102 , 1
Pset 204 , 102 , 1
Pset 214 , 102 , 1
Pset 224 , 102 , 1
'===LCDs===
Locate 1 , 2
Lcd "T('c )"
Locate 13 , 30
Lcd "t"
'===start program===
Do
If Pinb.4 = 0 Then Gosub Start0
If Pinb.1 = 1 Then
   If Sensselect = 0 Then
      Gosub Sensorselect
   End If
End If
If Curtemp = 1 Then
   Locate 14 , 1
   Lcd "Ctemp:"
End If
If Maxtemp = 1 Then
   Locate 15 , 1
   Lcd "max.t:"
End If
If Mintemp = 1 Then
   Locate 16 , 1
   Lcd "min.t:"
End If
If Keltemp = 1 Then
   Locate 14 , 11
   Lcd "Ctemp(K):"
End If
If Senstime = 1 Then
   Locate 15 , 11
   Lcd "SensTime:"
End If
For I2 = 5 To 230
    X2 = I2 + 1
    Dama2line = Dama2(x2)
    Dama2line0 = Dama2(i2)
   Line(i2 , Dama2line0)(x2 , Dama2line) , 255
Next
Wait Dama1wait
For I2 = 5 To 230
   X2 = I2 + 1
   Dama2line = Dama2(x2)
   Dama2line0 = Dama2(i2)
   Line(i2 , Dama2line0)(x2 , Dama2line) , 0
Next
For I2 = 230 To 5 Step -1
    X2 = I2 + 1
    Dama2(x2) = Dama2(i2)
Next
Dama02 = Waitkey(#2)
If Dama02 < 70 Then Dama2(5) = Dama02
D = Dama2(5)
Kelvin = D + 273
If Zoom1 = 1 Then Dama2(5) = Dama2(5)
If Zoom2 = 1 Then Dama2(5) = 2 * Dama2(5)
If Zoom3 = 1 Then Dama2(5) = 3.333333 * Dama2(5)
If Zoom4 = 1 Then Dama2(5) = 4 * Dama2(5)
Dama2(5) = 100 - Dama2(5)
'=====
If Curtemp = 1 Then
   Locate 14 , 7
   Lcd D
End If
If D > E Then
   E = D
End If
If Maxtemp = 1 Then
   Locate 15 , 7
   Lcd E
End If
If D < F Then
   F = D
End If
If Mintemp = 1 Then
   Locate 16 , 7
   Lcd F
End If
If Keltemp = 1 Then
   Locate 14 , 21
   Lcd Kelvin ; ""
End If
If Senstime = 1 Then
   Locate 15 , 21
   Lcd Dama1wait
End If
If Menu = 1 Then
   Menu = 0
   Waitms 500
   Gosub Menu1
End If
Loop
Return
Displaygraph:
Cls Graph
Cls Text
Locate 7 , 6
Lcd "USE ESC BUTTON FOR"
Locate 9 , 6
Lcd "BACK TO NORMAL TYPE"
Wait 4
Graphwait = 3
Displaygraph1:
Cls Graph
Cls Text
Do
Showpic 195 , 60 , C
If Sen1sw = 1 Then
   Showpic 10 , 10 , Temp01
   Disp = Waitkey(#1)
End If
If Sen2sw = 1 Then
   Showpic 10 , 10 , Temp02
   Disp = Waitkey(#2)
End If
Disp1 = Disp / 10
Disp2 = Disp Mod 10
If Disp1 = 0 Then Showpic 110 , 50 , 0
If Disp1 = 1 Then Showpic 110 , 50 , 1
If Disp1 = 2 Then Showpic 110 , 50 , 2
If Disp1 = 3 Then Showpic 110 , 50 , 3
If Disp1 = 4 Then Showpic 110 , 50 , 4
If Disp1 = 5 Then Showpic 110 , 50 , 5
If Disp1 = 6 Then Showpic 110 , 50 , 6
If Disp1 = 7 Then Showpic 110 , 50 , 7
If Disp1 = 8 Then Showpic 110 , 50 , 8
If Disp1 = 9 Then Showpic 110 , 50 , 9
If Disp2 = 0 Then Showpic 150 , 50 , 0
If Disp2 = 1 Then Showpic 150 , 50 , 1
If Disp2 = 2 Then Showpic 150 , 50 , 2
If Disp2 = 3 Then Showpic 150 , 50 , 3
If Disp2 = 4 Then Showpic 150 , 50 , 4
If Disp2 = 5 Then Showpic 150 , 50 , 5
If Disp2 = 6 Then Showpic 150 , 50 , 6
If Disp2 = 7 Then Showpic 150 , 50 , 7
If Disp2 = 8 Then Showpic 150 , 50 , 8
If Disp2 = 9 Then Showpic 150 , 50 , 9
Locate 15 , 2
Lcd "BACK[ESC]"
Locate 15 , 14
Lcd "YES[Ch.WAIT]"
Wait Graphwait
Showpic 110 , 50 , Backnum
If Yes = 1 Then
   Wait 1
   Yes = 0
   Gosub Graphwait
End If
If Esc = 1 Then
   Wait 1
   Esc = 0
   If Change = 1 Then Gosub Start1
   If Change = 2 Then Gosub Start2
End If
Loop
Graphwait:
Cls Graph
Cls Text
Locate 2 , 2
Lcd "between two senses time"
Locate 7 , 11
Lcd "wait="
Locate 15 , 2
Lcd "BACK[ESC]"
Showpic 70 , 45 , Leftpic
Showpic 150 , 45 , Rightpic
Do
If Left0 = 1 Then
   Wait 1
   Left0 = 0
   Decr Graphwait
End If
If Right0 = 1 Then
   Wait 1
   Right0 = 0
   Incr Graphwait
End If
If Graphwait < 1 Then Graphwait = 1
If Graphwait > 9 Then Graphwait = 9
If Esc = 1 Then
   Wait 1
   Esc = 0
   Gosub Displaygraph1
End If
Locate 7 , 16
Lcd Graphwait
Loop
Return
Button:
L1:
But.0 = Pina.0                                              'up
But.1 = Pina.1                                              'down
But.2 = Pina.2                                              'right
But.3 = Pina.3                                              'left
But.4 = Pina.4                                              'No
But.5 = Pina.5                                              'YES
But.6 = Pina.6                                              'ESC
But.7 = Pina.7                                              'MENU
Waitms 10
But1.0 = Pina.0
But1.1 = Pina.1
But1.2 = Pina.2
But1.3 = Pina.3
But1.4 = Pina.4
But1.5 = Pina.5
But1.6 = Pina.6
But1.7 = Pina.7
If A <> B Then
   Goto L1
   Else
   nop
End If
Return
Menu1:
Cls
Maincir = 16
Do
Showpic 27 , Maincir , Mainmenucircle
Locate 3 , 5
Lcd "1.SENSOR SELECT"
Locate 5 , 5
Lcd "2.SETTINGS"
Locate 7 , 5
Lcd "3.GRAPHICAL VIEW"
Locate 9 , 5
Lcd "4.ABOUT"
Locate 11 , 5
Lcd "5.EXIT"
If Down = 1 Then
   Maincir = 16 + Maincir
   Cls Graph
   Down = 0
   Waitms 500
End If
If Up = 1 Then
   Maincir = Maincir - 16
   Cls Graph
   Up = 0
   Waitms 500
End If
If Maincir < 15 Then Maincir = 80
If Maincir > 80 Then Maincir = 16

If Maincir = 16 Then
   If Yes = 1 Then
       Wait 1
       Yes = 0
       Gosub Sensorselect
   End If
End If
If Maincir = 32 Then
   If Yes = 1 Then
      Wait 1
      Yes = 0
      Gosub Settings
   End If
End If
If Maincir = 48 Then
   If Yes = 1 Then
      Wait 1
      Yes = 0
      Gosub Displaygraph
   End If
End If
If Maincir = 64 Then
   If Yes = 1 Then
      Wait 1
      Yes = 0
      Gosub About
   End If
End If
If Maincir = 80 Then
   If Yes = 1 Then
      Wait 1
      Yes = 0
      If Change = 1 Then Gosub Start1
      If Change = 2 Then Gosub Start2
   End If
End If
If Esc = 1 Then
   Wait 1
   Esc = 0
   If Change = 1 Then Gosub Start1
   If Change = 2 Then Gosub Start2
End If
If No = 1 Then
   Wait 1
   No = 0
   If Change = 1 Then Gosub Start1
   If Change = 2 Then Gosub Start2
End If
Loop
Return
Sensorselect:
Cls
Maincir = 16
Do
Showpic 27 , Maincir , Mainmenucircle
Locate 3 , 5
Lcd "1.SENSOR ONE"
Locate 5 , 5
Lcd "2.SENSOR TWO"
Locate 15 , 3
Lcd "SELECT[YES]"
Locate 15 , 18
Lcd "BACK[NO]"
If Down = 1 Then
   Maincir = 16 + Maincir
   Cls Graph
   Down = 0
   Waitms 500
End If
If Up = 1 Then
   Maincir = Maincir - 16
   Cls Graph
   Up = 0
   Waitms 500
End If
If Menu = 1 Then
   Menu = 0
   Waitms 100
   Gosub Menu1
End If
If No = 1 Then Gosub Menu1
If Maincir < 15 Then Maincir = 32
If Maincir > 32 Then Maincir = 16
If Maincir = 16 Then
   If Yes = 1 Then
      Sensselect = 1
      If Mainsensor1 = 1 Then Gosub Start1
      If Mainsensor1 = 0 Then Gosub Sensor1
   End If
End If
If Maincir = 32 Then
   If Yes = 1 Then
      Sensselect = 1
      If Mainsensor2 = 1 Then Gosub Start2
      If Mainsensor2 = 0 Then Gosub Sensor2
   End If
End If
Loop
Return
Settings:
Cls
Maincir = 16
Do
Showpic 27 , Maincir , Mainmenucircle
Locate 3 , 5
Lcd "1.ZOOM"
Locate 5 , 5
Lcd "2.BETWEEN TWO SENSES TIME"
Locate 7 , 5
Lcd "3.SHOW MAX&MIN TEMP"
Locate 15 , 3
Lcd "SELECT[YES]"
Locate 15 , 18
Lcd "BACK[NO]"
If Down = 1 Then
   Maincir = 16 + Maincir
   Cls Graph
   Down = 0
   Waitms 500
End If
If Up = 1 Then
   Maincir = Maincir - 16
   Cls Graph
   Up = 0
   Waitms 500
End If
If No = 1 Then
   No = 0
   Waitms 100
   Gosub Menu1
End If
If Menu = 1 Then
   Menu = 0
   Waitms 100
   Gosub Menu1
End If
If Esc = 1 Then
   Wait 1
   Esc = 0
   If Change = 1 Then Gosub Start1
   If Change = 2 Then Gosub Start2
End If
If Maincir < 15 Then Maincir = 48
If Maincir > 48 Then Maincir = 16
If Maincir = 16 Then
   If Yes = 1 Then
      Wait 1
      Yes = 0
      Gosub Zoom
   End If
End If
If Maincir = 32 Then
   If Yes = 1 Then
   Wait 1
   Yes = 0
   Gosub Betweentosenstime
   End If
End If
If Maincir = 48 Then
   If Yes = 1 Then
   Wait 1
   Yes = 0
   Gosub Showhide
   End If
End If
If Maincir = 64 Then
   If Yes = 1 Then
   Wait 1
   Yes = 0
   Gosub First
   End If
End If
Loop
Return
Zoom:
Maincir = 16
Zoompic = 16
Cls Text
Cls Graph
Do
Showpic 27 , Maincir , Mainmenucircle
Showpic 160 , Zoompic , Selectpichide
Locate 3 , 5
Lcd "1.x1 (0~100)"
Locate 5 , 5
Lcd "2.x2 (0~50)"
Locate 7 , 5
Lcd "3.x3 (0~30)"
Locate 9 , 5
Lcd "4.x4 (0~25)"
Locate 15 , 3
Lcd "SELECT[YES]"
Locate 15 , 18
Lcd "BACK[NO]"
If Down = 1 Then
   Maincir = 16 + Maincir
   Cls Graph
   Down = 0
   Waitms 500
End If
If Up = 1 Then
   Maincir = Maincir - 16
   Cls Graph
   Up = 0
   Waitms 500
End If
If No = 1 Then
   No = 0
   Waitms 100
   Gosub Settings
End If
If Menu = 1 Then
   Menu = 0
   Waitms 100
   Gosub Menu1
End If
If Esc = 1 Then
   Wait 1
   Esc = 0
   If Change = 1 Then Gosub Start1
   If Change = 2 Then Gosub Start2
End If
If Maincir < 15 Then Maincir = 64
If Maincir > 64 Then Maincir = 16
If Maincir = 16 Then
   If Yes = 1 Then
      Cls Graph
      Wait 1
      Yes = 0
      Zoompic = 16
      Zoom1 = 1
      Zoom2 = 0
      Zoom3 = 0
      Zoom4 = 0
   End If
End If
If Maincir = 32 Then
   If Yes = 1 Then
      Cls Graph
      Wait 1
      Yes = 0
      Zoompic = 32
      Zoom1 = 0
      Zoom2 = 1
      Zoom3 = 0
      Zoom4 = 0
   End If
End If
If Maincir = 48 Then
   If Yes = 1 Then
      Cls Graph
      Wait 1
      Yes = 0
      Zoompic = 48
      Zoom1 = 0
      Zoom2 = 0
      Zoom3 = 1
      Zoom4 = 0
   End If
End If
If Maincir = 64 Then
   If Yes = 1 Then
      Cls Graph
      Wait 1
      Yes = 0
      Zoompic = 64
      Zoom1 = 0
      Zoom2 = 0
      Zoom3 = 0
      Zoom4 = 1
   End If
End If
Loop
Return
Betweentosenstime:
Cls Graph
Cls Text
Locate 2 , 2
Lcd "between two senses time"
Locate 7 , 11
Lcd "wait="
Showpic 70 , 45 , Leftpic
Showpic 150 , 45 , Rightpic
Do
If Left0 = 1 Then
   Wait 1
   Left0 = 0
   Decr Dama1wait
End If
If Right0 = 1 Then
   Wait 1
   Right0 = 0
   Incr Dama1wait
End If
If Dama1wait < 1 Then Dama1wait = 1
If Dama1wait > 9 Then Dama1wait = 9
If No = 1 Then
   No = 0
   Waitms 100
   Gosub Settings
End If
If Menu = 1 Then
   Menu = 0
   Waitms 100
   Gosub Menu1
End If
If Esc = 1 Then
   Wait 1
   Esc = 0
   If Change = 1 Then Gosub Start1
   If Change = 2 Then Gosub Start2
End If
Locate 7 , 16
Lcd Dama1wait
Loop
Return
Showhide:
Maincir = 16
Cls
Do
Showpic 27 , Maincir , Mainmenucircle
Showpic Z , 16 , Selectpichide
Showpic Z1 , 32 , Selectpichide
Showpic Z2 , 48 , Selectpichide
Showpic Z3 , 64 , Selectpichide
Showpic Z4 , 80 , Selectpichide
Locate 3 , 5
Lcd "1.CURRENT TEMP"
Locate 5 , 5
Lcd "2.MAXIMUM TEMP"
Locate 7 , 5
Lcd "3.MINIMUM TEMP"
Locate 9 , 5
Lcd "4.CURRENT TEMP(K)"
Locate 11 , 5
Lcd "5.SENS TIME"
Locate 1 , 20
Lcd "SHOW"
Locate 1 , 26
Lcd "HIDE"
Locate 15 , 3
Lcd "CHANGE[YES]"
Locate 15 , 18
Lcd "BACK[NO]"
If Down = 1 Then
   Maincir = 16 + Maincir
   Cls Graph
   Down = 0
   Waitms 500
End If
If Up = 1 Then
   Maincir = Maincir - 16
   Cls Graph
   Up = 0
   Waitms 500
End If
If No = 1 Then
   No = 0
   Waitms 100
   Gosub Settings
End If
If Menu = 1 Then
   Menu = 0
   Waitms 100
   Gosub Menu1
End If
If Maincir < 15 Then Maincir = 79
If Maincir > 80 Then Maincir = 16
Waitms 600
'If Maincir = 16 Then
 '  If Yes = 1 Then
    '  Yes = 0
   '   Showpic 160 , 16 , Selectpicshow
  '    Waitms 500
 '  End If
'End If
If Maincir = 16 Then
   If Yes = 1 Then
      Yes = 0
      Cls Graph
      If W = 0 Then
         W1 = 1
         Z = 200
         Curtemp = 1
      End If
      If W = 1 Then
         W1 = 0
         Z = 160
         Curtemp = 0
      End If
      W = W1
   End If
End If
If Maincir = 32 Then
   If Yes = 1 Then
      Yes = 0
      Cls Graph
      If W2 = 0 Then
         W21 = 1
         Z1 = 160
         Maxtemp = 1
      End If
      If W2 = 1 Then
         W21 = 0
         Z1 = 200
         Maxtemp = 0
      End If
      W2 = W21
   End If
End If
If Maincir = 48 Then
   If Yes = 1 Then
      Yes = 0
      Cls Graph
      If W3 = 0 Then
         W31 = 1
         Z2 = 160
         Mintemp = 1
      End If
      If W3 = 1 Then
         W31 = 0
          Z2 = 200
         Mintemp = 0
      End If
      W3 = W31
   End If
End If
If Maincir = 64 Then
   If Yes = 1 Then
      Yes = 0
      Cls Graph
      If W4 = 0 Then
         W41 = 1
         Z3 = 160
         Keltemp = 1
      End If
      If W4 = 1 Then
         W41 = 0
         Z3 = 200
         Keltemp = 0
      End If
      W4 = W41
   End If
End If
If Maincir = 80 Then
   If Yes = 1 Then
      Yes = 0
      Cls Graph
      If W5 = 0 Then
         W51 = 1
         Z4 = 160
         Senstime = 1
      End If
      If W5 = 1 Then
         W51 = 0
         Z4 = 200
         Senstime = 0
      End If
      W5 = W51
   End If
End If
If No = 1 Then
   Wait 1
   No = 0
   Gosub Settings
End If
If Esc = 1 Then
   Wait 1
   Esc = 0
   If Change = 1 Then Gosub Start1
   If Change = 2 Then Gosub Start2
End If
If Menu = 1 Then
   Wait 1
   Menu = 0
   Gosub Menu1
End If
Loop
About:
Cls Graph
Cls Text
Showpic 1 , 1 , Aboutpic
Locate 15 , 2
Lcd "MAIN P.[ESC]"
Locate 15 , 18
Lcd "BACK[NO]"
Do
If No = 1 Then
   Wait 1
   No = 0
   Gosub Menu1
End If
If Esc = 1 Then
   Wait 1
   Esc = 0
   If Change = 1 Then Gosub Start1
   If Change = 2 Then Gosub Start2
End If
If Menu = 1 Then
   Wait 1
   Menu = 0
   Gosub Menu1
End If
Loop
Leftpic:
$bgf "left.bgf"
Rightpic:
$bgf "right.bgf"
Backnum:
$bgf "backnum.bgf"
Temp02:
$bgf "temp02.bgf"
Temp01:
$bgf "temp01.bgf"
C:
$bgf "c.bgf"
0:
$bgf "0.bgf"
1:
$bgf "1.bgf"
2:
$bgf "2.bgf"
3:
$bgf "3.bgf"
4:
$bgf "4.bgf"
5:
$bgf "5.bgf"
6:
$bgf "6.bgf"
7:
$bgf "7.bgf"
8:
$bgf "8.bgf"
9:
$bgf "9.bgf"
Aboutpic:
$bgf "about.bgf"
Mainmenucircle:
$bgf "CIRCLEFORMENU.bgf"
Selectpicshow:
$bgf "selectpicshow.bgf"
Selectpichide:
$bgf "selectpichide.bgf"
#include "fbgfx.bi"

Using FB

Type bola
	x As Single
	y As Single
	speed As Single
	xlimit As byte
	ylimit As byte
End Type

Type palo
	x1 As Single
	x2 As Single
	speed As Single
	xlimit As byte
End Type

Dim Shared pelota As bola
Dim Shared pelota2 As bola
Dim Shared barra As palo
Dim choque As Integer
'Dim myimage As Any Ptr = ImageCreate( 112, 24 )

'BLoad "prueba.png", myImage

ScreenRes 800, 600, 8

' Posiciones y límites

choque = 0
pelota.x = 120
pelota.y = 120
pelota2.x = 440
pelota2.y = 100
pelota.xlimit = 0
pelota.ylimit = 0
pelota2.xlimit = 1
pelota2.xlimit = 1
pelota.speed = 2
pelota2.speed = 2
barra.x1 = 300
barra.x2 = 400
barra.speed = 20

Do

	' Borra la pantalla

	Cls

	'Put (10,10), myImage

	' Dibujando Circulos, barra + Color

	Circle (pelota.x, pelota.y), 20, 5
	Circle (pelota2.x, pelota2.y), 20, 2
	Line ( barra.x1, 570 )-(barra.x2, 570), 15
	
	' distancia entre dos puntos
	
	/'
	
	Recordar las mates distancia entre dos puntos en geometria:

	d = sqrt((x2-x1)^2+(y2-y1)^2)

	'/

	choque = sqr(((pelota2.x-pelota.x)*(pelota2.x-pelota.x))+((pelota2.y-pelota.y)*(pelota2.y-pelota.x)))

	' Implementando colisiones :O

	if choque <= 38 and choque >= -38 Then
		If pelota.xlimit = 1 Then
			pelota.xlimit = 0
		else
			pelota.xlimit = 1
		End If
		If pelota2.xlimit = 1 Then
			pelota2.xlimit = 0
		else
			pelota2.xlimit = 1
		End If
		If pelota.ylimit = 1 Then
			pelota.ylimit = 0
		else
			pelota.ylimit = 1
		End If
		If pelota2.ylimit = 1 Then
			pelota2.ylimit = 0
		else
			pelota2.ylimit = 1
		End If	
	End If

	' Creando Límites 

	If pelota.x >= 780 Then pelota.xlimit = 1
	If pelota2.x >= 780 Then pelota2.xlimit = 1
	If pelota.x <= 20 Then pelota.xlimit = 0
	If pelota2.x <= 20 Then pelota2.xlimit = 0
	If pelota.y >= 580 Then pelota.ylimit = 1
	If pelota2.y >= 580 Then pelota2.ylimit = 1
	If pelota.y <= 20 Then pelota.ylimit = 0
	If pelota2.y <= 20 Then pelota2.ylimit = 0

	' Mov. Pelota 1

	If pelota.xlimit = 1 Then pelota.x -= pelota.speed

	If pelota.xlimit = 0 Then pelota.x += pelota.speed

	If pelota.ylimit = 1 Then pelota.y -= pelota.speed

	If pelota.ylimit = 0 Then pelota.y += pelota.speed

	' Mov. Pelota 2

	If pelota2.xlimit = 1 Then pelota2.x -= pelota2.speed

	If pelota2.xlimit = 0 Then pelota2.x += pelota2.speed

	If pelota2.ylimit = 1 Then pelota2.y -= pelota2.speed

	If pelota2.ylimit = 0 Then pelota2.y += pelota2.speed

	print "Posicion X ="; pelota.x

	print "Posicion Y ="; pelota.y;

	' Mov. Barra
	
	If MultiKey(SC_RIGHT) and barra.x2 <= 770 Then
		barra.x1 = barra.x1 + barra.speed
		barra.x2 = barra.x2 + barra.speed
	End If
	If MultiKey(SC_LEFT) and barra.x1 >= 30 Then
		barra.x1 = barra.x1 - barra.speed
		barra.x2 = barra.x2 - barra.speed		
	End If
	
	Sleep 10, 1

	'ImageDestroy( myImage )

Loop Until MultiKey(SC_Q) Or MultiKey(SC_ESCAPE)
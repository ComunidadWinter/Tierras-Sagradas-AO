VERSION 5.00
Begin VB.Form frmDuelos 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   9060
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5520
   LinkTopic       =   "Form1"
   Picture         =   "frmDuelos.frx":0000
   ScaleHeight     =   9060
   ScaleWidth      =   5520
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Label Jugador8 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   3120
      TabIndex        =   7
      Top             =   7680
      Width           =   1335
   End
   Begin VB.Label Jugador7 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   1080
      TabIndex        =   6
      Top             =   7680
      Width           =   1335
   End
   Begin VB.Label Jugador6 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   3120
      TabIndex        =   5
      Top             =   6120
      Width           =   1335
   End
   Begin VB.Label Jugador5 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   1080
      TabIndex        =   4
      Top             =   6120
      Width           =   1335
   End
   Begin VB.Label Jugador4 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   3120
      TabIndex        =   3
      Top             =   4320
      Width           =   1335
   End
   Begin VB.Label Jugador3 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   1150
      TabIndex        =   2
      Top             =   4320
      Width           =   1335
   End
   Begin VB.Label Jugador2 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   3120
      TabIndex        =   1
      Top             =   2520
      Width           =   1335
   End
   Begin VB.Label Jugador1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   1080
      TabIndex        =   0
      Top             =   2520
      Width           =   1335
   End
   Begin VB.Image Image1 
      Height          =   375
      Left            =   5040
      Top             =   0
      Width           =   495
   End
   Begin VB.Image Ingresar 
      Height          =   480
      Index           =   3
      Left            =   1880
      Top             =   8150
      Width           =   1785
   End
   Begin VB.Image Ingresar 
      Height          =   480
      Index           =   2
      Left            =   1900
      Top             =   6580
      Width           =   1785
   End
   Begin VB.Image Ingresar 
      Height          =   480
      Index           =   1
      Left            =   1950
      Top             =   4740
      Width           =   1785
   End
   Begin VB.Image Ingresar 
      Height          =   480
      Index           =   0
      Left            =   1900
      Top             =   3000
      Width           =   1785
   End
End
Attribute VB_Name = "frmDuelos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
Set form_Moviment = New clsFormMovementManager
form_Moviment.Initialize Me
Ingresar(0).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Normal.jpg")
Ingresar(1).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Normal.jpg")
Ingresar(2).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Normal.jpg")
Ingresar(3).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Normal.jpg")


Me.Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Main.jpg")

End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Ingresar(0).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Normal.jpg")
Ingresar(1).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Normal.jpg")
Ingresar(2).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Normal.jpg")
Ingresar(3).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Normal.jpg")
End Sub
Private Sub Image1_Click()
Unload Me
End Sub
Private Sub Ingresar_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
If Index = 0 Then Ingresar(0).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Iluminado.jpg")
If Index = 1 Then Ingresar(1).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Iluminado.jpg")
If Index = 2 Then Ingresar(2).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Iluminado.jpg")
If Index = 3 Then Ingresar(3).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Iluminado.jpg")
End Sub
Private Sub Ingresar_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
If Index = 0 Then Ingresar(0).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Presionado.jpg")
If Index = 1 Then Ingresar(1).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Presionado.jpg")
If Index = 2 Then Ingresar(2).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Presionado.jpg")
If Index = 3 Then Ingresar(3).Picture = LoadPicture(App.Path & "\Data\GRAFICOS\Principal\Duelos_Ingresar_Presionado.jpg")
End Sub
Private Sub Ingresar_Click(Index As Integer)
If Index = 0 Then Call SendData("ARE" & 1)
If Index = 1 Then Call SendData("ARE" & 2)
If Index = 2 Then Call SendData("ARE" & 3)
If Index = 3 Then Call SendData("ARE" & 4)
End Sub

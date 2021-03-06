Attribute VB_Name = "AA_ComercioUsuarios"
'#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-
'
'Estado del modulo: TERMINADO
'
'Modulo AA_Fran_Comercio:
'   Creado por Ghinzul - Fran Central
'       Este modulo fue creado desde 0 unicamente por mi.
'           Terminado: 18/10/13 11:06 am
'   Funcionamiento:
'       comMen: Mensaje al usuario en consola comun.
'       comMensaje: Mensaje al usuario en consola de comercio.
'       comManda: Los usuarios se mandan comercio.
'       comIniciarForm: Inicia el comercio.
'       comCancelar: Comercio cancelado.
'       comReset: Volver nulos las variables.
'       comMandoOferta: Uno de los usuarios envio su oferta.
'       comAceptaORechaza: Acepto o Rechazo la oferta del otro usuario.
'       comHacerCambio: Intercambio de los items ofrecidos.
'       comLogBug: Cualquier error que halla en el sistema, queda registrado.
'       comChat: Chat entre los usuarios que estan comerciando.
'El sistema anda 100%, el sistema es nuevo y la idea esta sacada de Tierras Perdidas Ao.
'Los usuarios pueden comerciar con uno o mas items a la vez, y esta programado de una manera de que no halla
'   ningun tipo de bug o algun tipo de trampa, para que nadie cague items a nadie.
'#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-
Option Explicit
Public Sub comMen(Userindex As Integer, Mensaje As String)
SendData SendTarget.toindex, Userindex, 0, "||" & Mensaje
End Sub
Private Sub comMensaje(Userindex As Integer, Mensaje As String)
SendData SendTarget.toindex, Userindex, 0, "MEC" & Mensaje
End Sub
Public Sub comManda(Userindex As Integer)
Dim Target As Integer
    With UserList(Userindex)
        Target = .flags.TargetUser
            If Not Target > 0 Or Target = Userindex Then
                comMen Userindex, "9"
                Exit Sub
            End If
            If MapInfo(.Pos.Map).Pk = True Then
                    comMen Userindex, "323"
                Exit Sub
            End If
            If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = ZONAPELEA Then
                    comMen Userindex, "291"
                Exit Sub
            End If
            If Distancia(.Pos, UserList(Target).Pos) > 1 Then
                comMen Userindex, "158"
                Exit Sub
            End If
            If MapData(UserList(Target).Pos.Map, UserList(Target).Pos.X, UserList(Target).Pos.Y).trigger = ZONAPELEA Then
                    comMen Userindex, "422"
                Exit Sub
            End If
            If UserList(Target).cComercio.cComercia = True Then
                comMen Userindex, "422"
                Exit Sub
            End If
            If Target = .cComercio.cQuien Then
                comIniciarForm Userindex, .cComercio.cQuien
                .cComercio.cComercia = True
                UserList(.cComercio.cQuien).cComercio.cComercia = True
                UserList(Target).cComercio.cQuien = Userindex
                Exit Sub
            End If
            If UserList(Target).cComercio.cQuien = Userindex Then
                comMen Userindex, "592"
                Exit Sub
            End If
        UserList(Target).cComercio.cQuien = Userindex
        comMen Target, "593@" & .name
        comMen Userindex, "594@" & UserList(Target).name
    End With
End Sub
Private Sub comIniciarForm(Userindex As Integer, UserIndex2 As Integer)
On Error GoTo ErrorIniciarForm
Dim comIte      As String
Dim comIl       As Long
Dim comTemp     As String
    With UserList(Userindex)
        For comIl = 1 To 20
            comTemp = "(Nada)"
                If .Invent.Object(comIl).ObjIndex > 0 Then comTemp = ObjData(.Invent.Object(comIl).ObjIndex).name
            comIte = comIte & .Invent.Object(comIl).ObjIndex & "-" & .Invent.Object(comIl).Amount & "-" & comTemp & ","
        Next comIl
    End With
SendData SendTarget.toindex, Userindex, 0, "ICO" & UserList(UserIndex2).name & "$" & comIte
comIte = ""
    With UserList(UserIndex2)
        For comIl = 1 To 20
            comTemp = "(Nada)"
                If .Invent.Object(comIl).ObjIndex > 0 Then comTemp = ObjData(.Invent.Object(comIl).ObjIndex).name
            comIte = comIte & .Invent.Object(comIl).ObjIndex & "-" & .Invent.Object(comIl).Amount & "-" & comTemp & ","
        Next comIl
    End With
SendData SendTarget.toindex, UserIndex2, 0, "ICO" & UserList(Userindex).name & "$" & comIte
comIte = ""
Exit Sub
ErrorIniciarForm:
comLogBug "Bug Entre " & UserList(Userindex).name & " y " & UserList(UserIndex2).name & ". En el sub comIniciarForm."
End Sub
Public Sub comCancelar(Userindex As Integer)
    With UserList(Userindex)
        If .cComercio.cComercia = True Then
            SendData SendTarget.toindex, .cComercio.cQuien, 0, "||596"
            comReset .cComercio.cQuien
            comReset Userindex
        End If
    End With
End Sub
Public Sub comReset(Userindex As Integer)
On Error GoTo ErrorReset
Dim comI As Long
SendData SendTarget.toindex, Userindex, 0, "VCC"
    With UserList(Userindex)
            For comI = 1 To 20
                .cComercio.cObj(comI).Amount = 0
                .cComercio.cObj(comI).ObjIndex = 0
            Next comI
        .cComercio.cOfrecio = False
        .cComercio.cRespuesta = 0
        .cComercio.cRecivio = False
        .cComercio.cComercia = False
        .cComercio.cQuien = 0
    End With
Exit Sub
ErrorReset:
comLogBug "Bug de " & UserList(Userindex).name & ". En el sub comReset."
End Sub
Public Sub comMandoOferta(Userindex As Integer, rData As String)
On Error GoTo ErrorMandoOferta
    With UserList(Userindex)
            If .cComercio.cOfrecio = True Then
                comMensaje Userindex, "Servidor> Ya has enviado una oferta, espera a que te responda el otro usuario.~255~0~0"
                Exit Sub
            End If
        Dim iMoC As Long, cDatPalOtro As String, cNamePutTemp As String, cTempGrh As Integer
            For iMoC = 1 To 20
                cNamePutTemp = "(Nada)"
                Dim cTempItMo As String
                cTempItMo = ReadField(iMoC, rData, Asc(","))
                    If ReadField(2, cTempItMo, Asc("-")) > 0 Then
                        .cComercio.cObj(iMoC).Amount = ReadField(2, cTempItMo, Asc("-"))
                        .cComercio.cObj(iMoC).ObjIndex = .Invent.Object(iMoC).ObjIndex
                    End If
                    If .cComercio.cObj(iMoC).ObjIndex > 0 Then
                        cNamePutTemp = ObjData(.cComercio.cObj(iMoC).ObjIndex).name
                        cTempGrh = ObjData(.cComercio.cObj(iMoC).ObjIndex).GrhIndex
                    End If
                cDatPalOtro = cDatPalOtro & cTempGrh & "-" & .cComercio.cObj(iMoC).Amount & "-" & cNamePutTemp & ","
            Next iMoC
            
        SendData SendTarget.toindex, .cComercio.cQuien, 0, "IOR" & UserList(Userindex).flags.OroQueOferto
        SendData SendTarget.toindex, .cComercio.cQuien, 0, "ICI" & cDatPalOtro
        
        .cComercio.cOfrecio = True
        UserList(.cComercio.cQuien).cComercio.cRecivio = True
            If UserList(.cComercio.cQuien).cComercio.cRecivio = True And .cComercio.cRecivio = True Then comMensaje .cComercio.cQuien, "Servidor> Ya has recibido respuesta, debes ACEPTAR o RECHAZAR la oferta~255~255"
    End With
Exit Sub
ErrorMandoOferta:
comLogBug "Bug de " & UserList(Userindex).name & ". En el sub comMandoOferta."
End Sub
Public Sub comAceptaORechaza(Userindex As Integer, Resp As Byte)
On Error GoTo ErrorAceptaORechaza
    If Resp = 0 Then Exit Sub
    With UserList(Userindex)
        .cComercio.cRespuesta = Resp
            If Resp = 1 Then
                comCancelar Userindex
                Exit Sub
            End If
            If .cComercio.cRespuesta = 2 And UserList(.cComercio.cQuien).cComercio.cRespuesta = 2 Then comHacerCambio Userindex, .cComercio.cQuien
    End With
Exit Sub
ErrorAceptaORechaza:
comLogBug "Bug de " & UserList(Userindex).name & ". En el sub comAceptaORechaza."
End Sub
Private Sub comHacerCambio(Userindex As Integer, UserIndex2 As Integer)
On Error GoTo ErrorHacerCambio
Dim iCamb As Long

        If UserList(Userindex).flags.Privilegios > PlayerType.User And UserList(Userindex).flags.Privilegios < PlayerType.Administrador Then Exit Sub

    With UserList(Userindex)
        For iCamb = 1 To 20
            If .cComercio.cObj(iCamb).ObjIndex > 0 Then
            
                If Not TieneObjetos(.cComercio.cObj(iCamb).ObjIndex, .cComercio.cObj(iCamb).Amount, Userindex) Then
                    comCancelar Userindex
                    SendData SendTarget.toindex, Userindex, 0, "||597"
                    SendData SendTarget.toindex, UserIndex2, 0, "||598"
                 Exit Sub
                End If
                
                If ObjData(.cComercio.cObj(iCamb).ObjIndex).OBJType = otLlaves Then
                    comCancelar Userindex
                    SendData SendTarget.toindex, Userindex, 0, "||599"
                    SendData SendTarget.toindex, UserIndex2, 0, "||599"
                 Exit Sub
                End If
                
                If ObjData(.cComercio.cObj(iCamb).ObjIndex).Intransferible = 1 Or ObjData(.cComercio.cObj(iCamb).ObjIndex).ItemDios = 1 Then
                    comCancelar Userindex
                    SendData SendTarget.toindex, Userindex, 0, "||600"
                    SendData SendTarget.toindex, UserIndex2, 0, "||601"
                 Exit Sub
                End If
                
                If .Stats.GLD < .flags.OroQueOferto Then
                    comCancelar Userindex
                    SendData SendTarget.toindex, Userindex, 0, "||602"
                    SendData SendTarget.toindex, UserIndex2, 0, "||603"
                 Exit Sub
                End If
            End If
                
            If UserList(UserIndex2).cComercio.cObj(iCamb).ObjIndex > 0 Then
            
                If Not TieneObjetos(UserList(UserIndex2).cComercio.cObj(iCamb).ObjIndex, UserList(UserIndex2).cComercio.cObj(iCamb).Amount, UserIndex2) Then
                    comCancelar UserIndex2
                    SendData SendTarget.toindex, UserIndex2, 0, "||597"
                    SendData SendTarget.toindex, Userindex, 0, "||598"
                 Exit Sub
                End If
                
                If ObjData(UserList(UserIndex2).cComercio.cObj(iCamb).ObjIndex).OBJType = otLlaves Then
                    comCancelar UserIndex2
                    SendData SendTarget.toindex, Userindex, 0, "||599"
                    SendData SendTarget.toindex, UserIndex2, 0, "||599"
                 Exit Sub
                End If
                
                If ObjData(UserList(UserIndex2).cComercio.cObj(iCamb).ObjIndex).Intransferible = 1 Or ObjData(UserList(UserIndex2).cComercio.cObj(iCamb).ObjIndex).ItemDios = 1 Then
                    comCancelar UserIndex2
                    SendData SendTarget.toindex, UserIndex2, 0, "||600"
                    SendData SendTarget.toindex, Userindex, 0, "||601"
                 Exit Sub
                End If
                
                If UserList(UserIndex2).Stats.GLD < UserList(UserIndex2).flags.OroQueOferto Then
                    comCancelar UserIndex2
                    SendData SendTarget.toindex, UserIndex2, 0, "||602"
                    SendData SendTarget.toindex, Userindex, 0, "||603"
                 Exit Sub
                End If
            End If
        Next iCamb
        
        For iCamb = 1 To 20
        
                    If UserList(Userindex).Invent.Object(iCamb).Equipped <> 0 Then Desequipar Userindex, iCamb
                        QuitarUserInvItem Userindex, iCamb, UserList(Userindex).cComercio.cObj(iCamb).Amount
                        UpdateUserInv False, Userindex, CByte(iCamb)
            
                    If UserList(UserIndex2).Invent.Object(iCamb).Equipped <> 0 Then Desequipar UserIndex2, iCamb
                        QuitarUserInvItem UserIndex2, iCamb, UserList(UserIndex2).cComercio.cObj(iCamb).Amount
                        UpdateUserInv False, UserIndex2, CByte(iCamb)
        
            If .cComercio.cObj(iCamb).ObjIndex > 0 Then
                If Not MeterItemEnInventario(UserIndex2, .cComercio.cObj(iCamb)) Then TirarItemAlPiso UserList(UserIndex2).Pos, .cComercio.cObj(iCamb)
                Call LogComercios("" & UserList(Userindex).name & " le entrego en comercio: " & UserList(Userindex).cComercio.cObj(iCamb).Amount & " - " & ObjData(UserList(Userindex).cComercio.cObj(iCamb).ObjIndex).name & " a " & UserList(UserIndex2).name & "")
            End If
            If UserList(UserIndex2).cComercio.cObj(iCamb).ObjIndex > 0 Then
                If Not MeterItemEnInventario(Userindex, UserList(UserIndex2).cComercio.cObj(iCamb)) Then TirarItemAlPiso UserList(Userindex).Pos, UserList(UserIndex2).cComercio.cObj(iCamb)
                Call LogComercios("" & UserList(UserIndex2).name & " le entrego en comercio: " & UserList(UserIndex2).cComercio.cObj(iCamb).Amount & " - " & ObjData(UserList(UserIndex2).cComercio.cObj(iCamb).ObjIndex).name & " a " & UserList(Userindex).name & "")
            End If
        Next iCamb
    End With
    
'Restamos el oro que ofrecio cada uno
UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - UserList(Userindex).flags.OroQueOferto
UserList(UserIndex2).Stats.GLD = UserList(UserIndex2).Stats.GLD - UserList(UserIndex2).flags.OroQueOferto

'Sumamos el oro que recibe de la otra persona
UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + UserList(UserIndex2).flags.OroQueOferto
UserList(UserIndex2).Stats.GLD = UserList(UserIndex2).Stats.GLD + UserList(Userindex).flags.OroQueOferto

SendUserGLD Userindex
SendUserGLD UserIndex2
SendData SendTarget.toindex, Userindex, 0, "||604"
SendData SendTarget.toindex, UserIndex2, 0, "||604"
comReset UserIndex2
comReset Userindex
Exit Sub
ErrorHacerCambio:
comLogBug "Bug entre " & UserList(Userindex).name & " y " & UserList(UserIndex2).name & ". En el sub comHacerCambio."
End Sub
Private Sub comLogBug(Texto As String)
Dim nfile As Integer
nfile = FreeFile
Open App.Path & "\BugsComercio.txt" For Append Shared As #nfile
Print #nfile, "Bug de Comercio> " & Texto & " - [" & Date & " - " & Time & "]"
Close #nfile
End Sub
Public Sub comChat(Texto As String, Userindex As Integer)
    With UserList(Userindex)
        If .cComercio.cComercia = False Or .cComercio.cQuien = 0 Then Exit Sub
        SendData SendTarget.toindex, .cComercio.cQuien, 0, "MEC" & .name & "> " & Texto & FONTTYPE_GLOBALNOBLE
    End With
End Sub


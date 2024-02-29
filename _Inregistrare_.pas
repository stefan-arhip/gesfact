unit _Inregistrare_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, _PersonalEdit_, Buttons, ComCtrls, ExtCtrls, Menus, Registry;

type
  TInregistrare_ = class(TForm)
    Panel2: TPanel;
    Panel9: TPanel;
    Panel4: TPanel;
    ProgressBar1: TProgressBar;
    Panel3: TPanel;
    Nou2: TSpeedButton;
    Deschidere2: TSpeedButton;
    Salvare2: TSpeedButton;
    Tiparire2: TSpeedButton;
    Optiuni2: TSpeedButton;
    Exit1: TSpeedButton;
    Panel1: TPanel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    Perioada: TPersonalEdit;
    Serial: TPersonalEdit;
    Utilizator: TPersonalEdit;
    MainMenu1: TMainMenu;
    Iesire1: TMenuItem;
    Aleator: TPersonalEdit;
    N1: TMenuItem;
    CtrlAltEnd1: TMenuItem;
    Cod: TEdit;
    Timer1: TTimer;
    Inregistrata: TLabel;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    procedure Iesire1Click(Sender: TObject);
    procedure CtrlAltEnd1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Salvare2Click(Sender: TObject);
    procedure Deschidere2Click(Sender: TObject);
    procedure Nou2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodAles:String;
    Function Execute:Boolean;
  end;

var
  Inregistrare_: TInregistrare_;

Function VerificareLicenta:Boolean;

implementation

{$R *.DFM}

Uses _Main_, _Parola_, _Furnizor_;

Function EsteNumar(s:String):Boolean;
Var Rezultat:Boolean;
    x:Extended;
Begin
  Rezultat:=True;
  Try
    x:=StrToFloat(s);
  Except
    Rezultat:=False;
  End;
  EsteNumar:=Rezultat;
End;

Procedure BreakIn4(Var a,b,c,d,e:String;f:String);
Var i,j:Integer;
Begin
  a:='';
  j:=0;
  For i:=j+1 To Length(f) Do
    Begin
      If f[i]='~' Then
        Begin
          j:=i;
          Break;
        End;
      a:=a+f[i];
    End;
  b:='';
  For i:=j+1 To Length(f) Do
    Begin
      If f[i]='~' Then
        Begin
          j:=i;
          Break;
        End;
      b:=b+f[i];
    End;
  c:='';
  For i:=j+1 To Length(f) Do
    Begin
      If f[i]='~' Then
        Begin
          j:=i;
          Break;
        End;
      c:=c+f[i];
    End;
  d:='';
  For i:=j+1 To Length(f) Do
    Begin
      If f[i]='~' Then
        Begin
          j:=i;
          Break;
        End;
      d:=d+f[i];
    End;
  e:='';
  For i:=j+1 To Length(f) Do
    Begin
      If f[i]='~' Then
        Begin
          j:=i;
          Break;
        End;
      e:=e+f[i];
    End;
End;

Function GetSerialNumber(d:String):String;
Var
  SerialNum:DWord;
  A,B:DWord;
  C:Array[0..255] Of Char;
  Buffer:Array[0..255] Of Char;
Begin
  If GetVolumeInformation(
                          PChar(d),
                          Buffer,
                          256,
                          @SerialNum,
                          A,
                          B,
                          C,
                          256)
    Then
      Begin
        If SerialNum<0 Then
          SerialNum:=-SerialNum;
        Result:=IntToStr(SerialNum);
      End;
End;

Function Codare(a,b,c,d:String):String;
Var t1,t2,t3:String[20];
    i:Integer;
Begin
  If Length(a)=0 Then
    a:=' ';
  t1:='';
  While Length(t1)<20 Do
    t1:=t1+a;            //nume operator
  If Length(b)=0 Then
    b:='1';
  If Length(c)=0 Then
    c:='1';
  If Length(d)=0 Then
    d:='1';
  t2:='';
  While Length(t2)<20 Do
    t2:=t2+b+            //HDD id
           c+            //nr.aleator
           d;            //perioada inreg.
  t3:='';
  For i:=1 To 20 Do
    Begin
      t3[i]:=Chr(33+((Ord(t1[i])+StrToInt(t2[i])-33) Mod 125)-1);
      t3:=t3+t3[i];
    End;
  Result:=t3;
End;

Procedure ScriereRegistri(a,b,c,d,e:String);
Begin
  With TRegistry.Create Do
    Begin
      RootKey:=HKEY_CURRENT_USER;
      If OpenKey('Software\GesFact',TRUE) Then
        WriteString('',a+'~'+b+'~'+c+'~'+d+'~'+e)
      Else
        MessageDlg('Registry read error',mtError,[mbOk],0);
      CloseKey;
    End;
End;

Procedure CitireRegistri(Var a,b,c,d,e:String);
Var f:String;
Begin
  With TRegistry.Create do
    Begin
      RootKey:=HKEY_CURRENT_USER;
      If OpenKey('Software\GesFact',True) Then
        Begin
          f:=ReadString('');
          BreakIn4(a,b,c,d,e,f);
          If a='' Then
            a:='Utilizator';
          If Not EsteNumar(b) Then
            b:=GetSerialNumber('C:\');
          If Not EsteNumar(d) Then
            d:='1';
          If Not EsteNumar(e) Then
            e:='1';
        End
      Else
        MessageDlg('Registry read error', mtError, [mbOk], 0);
      CloseKey;
    End;
End;

Function VerificareLicenta:Boolean;
Var a,b,c,d,e,f,g:String;
Begin
  CitireRegistri(a,b,c,d,e);
  g:=GetSerialNumber('C:\');
  If EsteNumar(e) And EsteNumar(d) Then
    Begin
      f:=Codare(a,g,d,e);
      VerificareLicenta:=(b=g) And                //HDD id.
                         (Codare(a,b,d,e)=c) And  //
                         (c=f) And
                         (StrToInt(d)>0);
    End
  Else
    VerificareLicenta:=False;
End;

function TInregistrare_.Execute: Boolean;
begin
  Result:=(ShowModal=mrOK);
  CodAles:=Cod.Text;
end;

procedure TInregistrare_.Iesire1Click(Sender: TObject);
begin
  Close;
end;

procedure TInregistrare_.CtrlAltEnd1Click(Sender: TObject);
begin
  Parola_.Edit1.Text:='';
  If Parola_.Execute Then
    If Parola_.Pass='Stefan'+Aleator.Text Then
      Cod.Text:=Codare(Utilizator.Text,GetSerialNumber('C:\'),Perioada.Text,Aleator.Text);
end;

procedure TInregistrare_.BitBtn1Click(Sender: TObject);
begin
  ScriereRegistri(Utilizator.Text,Serial.Text,Cod.Text,Perioada.Text,Aleator.Text);
end;

procedure TInregistrare_.Salvare2Click(Sender: TObject);
Var f:TextFile;
    a,b,c,d,e:String;
begin
  If SaveDialog1.Execute Then
    Begin
      CitireRegistri(a,b,c,d,e);
      AssignFile    (f,SaveDialog1.FileName);
      Rewrite       (f);
      Write         (f,a+'~'+b+'~'+c+'~'+d+'~'+e);
      CloseFile     (f);
    End;
end;

procedure TInregistrare_.Deschidere2Click(Sender: TObject);
Var f:TextFile;
    a,b,c,d,e,xx:String;
begin
  If OpenDialog1.Execute Then
    Begin
      AssignFile    (f,SaveDialog1.FileName);
      Reset         (f);
      Read          (f,xx);
      CloseFile     (f);
      BreakIn4      (a,b,c,d,e,xx);
      Utilizator.Text:=a;
      Serial    .Text:=b;
      Cod       .Text:=c;
      Perioada  .Text:=d;
      Aleator   .Text:=e;
      ScriereRegistri(Utilizator.Text,Serial.Text,Cod.Text,Perioada.Text,Aleator.Text);
      
    End;
end;

procedure TInregistrare_.Nou2Click(Sender: TObject);
Var a,b,c,d,e:String;
    f        :TextFile;
begin
  Randomize;
  Shake(Inregistrare_,Main_.ShakeIt.Checked);
  a:='';
  b:='';
  c:='';
  d:='';
  e:='';
  CitireRegistri(a,b,c,d,e);
  If VerificareLicenta Then
    Begin
      If (StrToInt(d)<>0) And (Inregistrare_.Tag=0) Then
        Begin
          Inregistrare_.Tag:=1;
          d:=IntToStr(StrToInt(d)-1);
        End;
      c:=Codare(a,b,d,e);
      ScriereRegistri(a,b,c,d,e);
      If a='' Then a:='Utilizator';
      Utilizator.Text:=a;
      Serial    .Text:=b;
      Cod       .Text:=c;
      Perioada  .Text:=d;
      Aleator   .Text:=e;
      Inregistrare_.Inregistrata.Caption:='inregistrata';
    End
  Else
    Begin
      /////
      AssignFile(f,dirEXE+'GesFact.reg');
      Rewrite(f);
      Writeln(f,'REGEDIT4');
      Writeln(f,'');
      Writeln(f,'[HKEY_CURRENT_USER\Software\GesFact]');
      Writeln(f,'  @  = "'+a+'~'+GetSerialNumber('C:\')+'~'+c+'~'+d+'~'+e+'"');
      CloseFile(f);
      /////
      Utilizator.Text:=a;
      Serial    .Text:=GetSerialNumber('C:\');
      Cod       .Text:=c;
      Perioada  .Text:=d;
      Aleator   .Text:=IntToStr(Random(10000));
      Inregistrare_.Inregistrata.Caption:='neinregistrata';
    End;
end;

end.

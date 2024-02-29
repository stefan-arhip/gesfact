unit _Produs_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ComCtrls, ExtCtrls, Buttons, ToolWin, Menus,
  _PersonalEdit_, _Numedit_, _Furnizor_;

type
  TProdus_ = class(TForm)
    MainMenu1: TMainMenu;
    Fisier1: TMenuItem;
    Deschidere1: TMenuItem;
    Salvare1: TMenuItem;
    N1: TMenuItem;
    Iesire1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Cod: TEdit;
    Categorie: TComboBox;
    Tip: TComboBox;
    Denumire: TPersonalEdit;
    Comentariu: TMemo;
    Pret: TNumEdit;
    Cantitate: TNumEdit;
    UM: TComboBox;
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
    procedure Exit1Click(Sender: TObject);
    procedure Salvare2Click(Sender: TObject);
    procedure Deschidere2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DenumireChange(Sender: TObject);
  private
    { Private declarations }
    Function VerificareCorectitudine:Boolean;
  public
    { Public declarations }
    Fisier:String;
    Extensie:String;    
  end;

Procedure ProdusNou(Var Produs:TProdus);

var
  Produs_: TProdus_;

implementation

uses _Main_;

{$R *.DFM}

Const NumeOriginal:String='';

Procedure ProdusNou(Var Produs:TProdus);
Begin
  Produs.Denumire  :='';
  Produs.UM        :='';
  Produs.Pret      :=0;
  Produs.Cantitate :=0;
  Produs.Cod       :='';
  Produs.Categorie :='';
  Produs.Tip       :='';
  Produs.Comentariu:='';
End;

Function TProdus_.VerificareCorectitudine:Boolean;
Var s:String;
Begin
  s:='';
  If Denumire.Text='' Then
    Begin
      MessageDlg('Este obligatorie completarea denumirii produsului!',mtWarning,[mbYes],0);
      s:='!';
    End
  Else
    Begin
      If UM.Text='' Then
        s:=s+#13'     U.M.';
//      If StrToNumber(Pret.Text,'')=0 Then
//        s:=s+#13'     Pret';
      If s<>'' Then
        If MessageDlg('Este recomandata completarea campurilor:'+s+#13+
                      'Se salveaza fara a se tine cont de avertisment?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
          s:='';
    End;
  Result:=s='';
End;

procedure TProdus_.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TProdus_.Salvare2Click(Sender: TObject);
Var Produs:TProdus;
    f     :File Of TProdus;
begin
  If VerificareCorectitudine Then
    Begin
      Produs.Denumire  :=Denumire.Text;
      Fisier           :=Denumire.Text;
      Produs.UM        :=UM.Text;
      Produs.Pret      :=StrToNumber(Pret     .Text,'Pret produs / serviciu');
      Produs.Cantitate :=StrToNumber(Cantitate.Text,'Cantitate produs / serviciu');
      Produs.Cod       :=Cod.Text;
      Produs.Categorie :=Categorie.Text;
      Produs.Tip       :=Tip.Text;
      Produs.Comentariu:=Comentariu.Text;
      If NumeOriginal<>Produs.Denumire Then
        DeleteFile(dirEXE+dirPRD+NumeOriginal+'.'+Extensie);
      AssignFile(f,dirEXE+dirPRD+UpperCase(Produs.Denumire)+'.'+ExtPRD);
      Rewrite   (f);
      Write     (f,Produs);
      CloseFile (f);
    End;
  DenumireChange(Sender);
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TProdus_.Deschidere2Click(Sender: TObject);
Var Produs:TProdus;
    f     :File Of TProdus;
begin
  //citire fisier
  If FileExists(dirEXE+dirPRD+Fisier+'.'+ExtPRD) Then
    Begin
      AssignFile(f,dirEXE+dirPRD+Fisier+'.'+ExtPRD);
      Reset     (f);
      Read      (f,Produs);
      CloseFile (f);
    End
  Else
    ProdusNou(Produs);
  //identitate
  Denumire.Text  :=Produs.Denumire;
  NumeOriginal   :=Produs.Denumire;    (*pentru salvare ca*)
  UM.Text        :=Produs.UM;
  Pret.Text      :=FloatToStr(Produs.Pret);
  Cantitate.Text :=FloatToStr(Produs.Cantitate);
  Cod.Text       :=Produs.Cod;
  Categorie.Text :=Produs.Categorie;
  Tip.Text       :=Produs.Tip;
  Comentariu.Text:=Produs.Comentariu;
  DenumireChange(Sender);
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TProdus_.FormActivate(Sender: TObject);
begin
  Deschidere2Click(Sender);
  Denumire.SetFocus;
  Shake(Produs_,Main_.ShakeIt.Checked);
end;

procedure TProdus_.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Main_.RefreshListe;
end;

procedure TProdus_.DenumireChange(Sender: TObject);
Var Produs:TProdus;
    f     :File Of TProdus;
begin
  //citire fisier
  If FileExists(dirEXE+dirPRD+Fisier+'.'+ExtPRD) Then
    Begin
      AssignFile(f,dirEXE+dirPRD+Fisier+'.'+ExtPRD);
      Reset     (f);
      Read      (f,Produs);
      CloseFile (f);
    End
  Else
    ProdusNou(Produs);
  //identitate
  Denumire  .Font.Color:=RedIsFalse(Denumire.Text  =Produs.Denumire);
  Label1    .Font.Color:=Denumire  .Font.Color;
  UM        .Font.Color:=RedIsFalse(UM.Text        =Produs.UM);
  Label2    .Font.Color:=UM        .Font.Color;
  Pret      .Font.Color:=RedIsFalse(Pret.Text      =FloatToStr(Produs.Pret));
  Label3    .Font.Color:=Pret      .Font.Color;
  Cantitate .Font.Color:=RedIsFalse(Cantitate.Text =FloatToStr(Produs.Cantitate));
  Label4    .Font.Color:=Cantitate .Font.Color;
  Cod       .Font.Color:=RedIsFalse(Cod.Text       =Produs.Cod);
  Label5    .Font.Color:=Cod       .Font.Color;
  Categorie .Font.Color:=RedIsFalse(Categorie.Text =Produs.Categorie);
  Label6    .Font.Color:=Categorie .Font.Color;
  Tip       .Font.Color:=RedIsFalse(Tip.Text       =Produs.Tip);
  Label7    .Font.Color:=Tip       .Font.Color;
  Comentariu.Font.Color:=RedIsFalse(Comentariu.Text=Produs.Comentariu);
  Label8    .Font.Color:=Comentariu.Font.Color;
  Salvare1.Enabled:=IsRedFontComponent(Produs_);
  Salvare2.Enabled:=Salvare1.Enabled;
end;







end.


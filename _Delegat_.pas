unit _Delegat_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ComCtrls, ExtCtrls, Buttons, ToolWin, Menus;

type
  TDelegat_ = class(TForm)
    MainMenu1: TMainMenu;
    Fisier1: TMenuItem;
    Deschidere1: TMenuItem;
    Salvare1: TMenuItem;
    N1: TMenuItem;
    Iesire1: TMenuItem;
    Panel1: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    Label33: TLabel;
    Label35: TLabel;
    Nume: TEdit;
    SerieCI: TEdit;
    NrCI: TEdit;
    CIElibde: TEdit;
    Transport: TEdit;
    NrInmatr: TEdit;
    CNP: TEdit;
    Functie: TEdit;
    Departament: TEdit;
    Telefon: TEdit;
    Interior: TEdit;
    Mobil: TEdit;
    Email: TEdit;
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
    procedure NumeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Function VerificareCorectitudine:Boolean;
  public
    { Public declarations }
  end;

var
  Delegat_: TDelegat_;

implementation

uses _Furnizor_, _Main_;

{$R *.DFM}

Function TDelegat_.VerificareCorectitudine:Boolean;
Var s:String;
Begin
  s:='';
  If Nume.Text='' Then
    Begin
      MessageDlg('Este obligatorie completarea numelui delegatului!',mtWarning,[mbYes],0);
      s:='!';
    End
  Else
    Begin
      If SerieCI.Text='' Then
        s:=s+#13'     Serie C.I.';
      If NrCI.Text='' Then
        s:=s+#13'     Nr. C.I.';
      If CIElibDe.Text='' Then
        s:=s+#13'     C.I. elib. de';
      If s<>'' Then
        If MessageDlg('Este recomandata completarea campurilor:'+s+#13+
                      'Se salveaza fara a se tine cont de avertisment?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
          s:='';
    End;
  Result:=s='';
End;

procedure TDelegat_.Exit1Click(Sender: TObject);
begin
  Furnizor_.NumeChange(Sender);
  Close;
end;

procedure TDelegat_.Salvare2Click(Sender: TObject);
Var p:Integer;
begin
  If VerificareCorectitudine Then
    Begin
      p:=Furnizor_.ListaDelegati.Row;
      Furnizor_.ListaDelegati.Cells[ 1,p]:=Nume.Text;
      Furnizor_.ListaDelegati.Cells[ 2,p]:=SerieCI.Text;
      Furnizor_.ListaDelegati.Cells[ 3,p]:=NrCI.Text;
      Furnizor_.ListaDelegati.Cells[ 4,p]:=CIElibDe.Text;
      Furnizor_.ListaDelegati.Cells[ 5,p]:=CNP.Text;
      Furnizor_.ListaDelegati.Cells[ 6,p]:=Functie.Text;
      Furnizor_.ListaDelegati.Cells[ 7,p]:=Departament.Text;
      Furnizor_.ListaDelegati.Cells[ 8,p]:=Telefon.Text;
      Furnizor_.ListaDelegati.Cells[ 9,p]:=Interior.Text;
      Furnizor_.ListaDelegati.Cells[10,p]:=Mobil.Text;
      Furnizor_.ListaDelegati.Cells[11,p]:=Email.Text;
      Furnizor_.ListaDelegati.Cells[12,p]:=Transport.Text;
      Furnizor_.ListaDelegati.Cells[13,p]:=NrInmatr.Text;
    End;
  NumeChange(Sender);
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TDelegat_.Deschidere2Click(Sender: TObject);
Var p:Integer;
begin
  p               :=Furnizor_.ListaDelegati.Row;
  Nume.Text       :=Furnizor_.ListaDelegati.Cells[ 1,p];
  SerieCI.Text    :=Furnizor_.ListaDelegati.Cells[ 2,p];
  NrCI.Text       :=Furnizor_.ListaDelegati.Cells[ 3,p];
  CIElibDe.Text   :=Furnizor_.ListaDelegati.Cells[ 4,p];
  CNP.Text        :=Furnizor_.ListaDelegati.Cells[ 5,p];
  Functie.Text    :=Furnizor_.ListaDelegati.Cells[ 6,p];
  Departament.Text:=Furnizor_.ListaDelegati.Cells[ 7,p];
  Telefon.Text    :=Furnizor_.ListaDelegati.Cells[ 8,p];
  Interior.Text   :=Furnizor_.ListaDelegati.Cells[ 9,p];
  Mobil.Text      :=Furnizor_.ListaDelegati.Cells[10,p];
  Email.Text      :=Furnizor_.ListaDelegati.Cells[11,p];
  Transport.Text  :=Furnizor_.ListaDelegati.Cells[12,p];
  NrInmatr.Text   :=Furnizor_.ListaDelegati.Cells[13,p];
  NumeChange(Sender);
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TDelegat_.FormActivate(Sender: TObject);
begin
  NumeChange(Sender);
  Nume.SetFocus;
  Shake(Delegat_,Main_.ShakeIt.Checked);
end;

procedure TDelegat_.NumeChange(Sender: TObject);
Var i:Integer;
begin
  i:=Furnizor_.ListaDelegati.Row;
  Nume       .Font.Color:=RedIsFalse(Nume       .Text=Furnizor_.ListaDelegati.Cells[ 1,i]);
  Label25    .Font.Color:=Nume       .Font.Color;
  SerieCI    .Font.Color:=RedIsFalse(SerieCI    .Text=Furnizor_.ListaDelegati.Cells[ 2,i]);
  Label26    .Font.Color:=SerieCI    .Font.Color;
  NrCI       .Font.Color:=RedIsFalse(NrCI       .Text=Furnizor_.ListaDelegati.Cells[ 3,i]);
  Label27    .Font.Color:=NrCI       .Font.Color;
  CIElibDe   .Font.Color:=RedIsFalse(CIElibDe   .Text=Furnizor_.ListaDelegati.Cells[ 4,i]);
  Label28    .Font.Color:=CIElibDe   .Font.Color;
  CNP        .Font.Color:=RedIsFalse(CNP        .Text=Furnizor_.ListaDelegati.Cells[ 5,i]);
  Label29    .Font.Color:=CNP        .Font.Color;
  Functie    .Font.Color:=RedIsFalse(Functie    .Text=Furnizor_.ListaDelegati.Cells[ 6,i]);
  Label30    .Font.Color:=Functie    .Font.Color;
  Departament.Font.Color:=RedIsFalse(Departament.Text=Furnizor_.ListaDelegati.Cells[ 7,i]);
  Label31    .Font.Color:=Departament.Font.Color;
  Telefon    .Font.Color:=RedIsFalse(Telefon    .Text=Furnizor_.ListaDelegati.Cells[ 8,i]);
  Label32    .Font.Color:=Telefon    .Font.Color;
  Interior   .Font.Color:=RedIsFalse(Interior   .Text=Furnizor_.ListaDelegati.Cells[ 9,i]);
  Label33    .Font.Color:=Interior   .Font.Color;
  Mobil      .Font.Color:=RedIsFalse(Mobil      .Text=Furnizor_.ListaDelegati.Cells[10,i]);
  Label34    .Font.Color:=Mobil      .Font.Color;
  Email      .Font.Color:=RedIsFalse(Email      .Text=Furnizor_.ListaDelegati.Cells[11,i]);
  Label35    .Font.Color:=Email      .Font.Color;
  Transport  .Font.Color:=RedIsFalse(Transport  .Text=Furnizor_.ListaDelegati.Cells[12,i]);
  Label36    .Font.Color:=Transport  .Font.Color;
  NrInmatr   .Font.Color:=RedIsFalse(NrInmatr   .Text=Furnizor_.ListaDelegati.Cells[13,i]);
  Label37    .Font.Color:=NrInmatr   .Font.Color;
  Salvare1.Enabled:=IsRedFontComponent(Delegat_);
  Salvare2.Enabled:=Salvare1.Enabled;
end;

procedure TDelegat_.FormClose(Sender: TObject; var Action: TCloseAction);
Var s:String;
    i:Integer;
begin
  s:='';
  For i:=1 To 13 Do
    s:=s+Furnizor_.ListaDelegati.Cells[ 1,Furnizor_.ListaDelegati.RowCount-1];
  If (s='') And (Furnizor_.ListaDelegati.RowCount>2) Then
    Furnizor_.ListaDelegati.RowCount:=Furnizor_.ListaDelegati.RowCount-1;
  Furnizor_.NumeChange(Sender);
end;





end.


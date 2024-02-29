unit _Adaugare_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Menus, _Numedit_, _Furnizor_, ComCtrls, ExtCtrls,
  ToolWin;

type
  TAdaugare_ = class(TForm)
    MainMenu1: TMainMenu;
    Iesire1: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Denumire: TComboBox;
    Pret: TNumEdit;
    Cantitate: TNumEdit;
    UM: TComboBox;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
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
    procedure Iesire1Click(Sender: TObject);
    procedure DenumireChange(Sender: TObject);
    procedure UMChange(Sender: TObject);
    procedure PretChange(Sender: TObject);
    procedure CantitateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Produs:TProdus;
    Function Execute:Boolean;
  end;

var
  Adaugare_: TAdaugare_;

implementation

Uses _Main_, _Produs_;

{$R *.DFM}

function TAdaugare_.Execute: Boolean;
begin
  Produs.Denumire :=            Denumire .Text;
  Produs.UM       :=            UM       .Text;
  Produs.Pret     :=StrToNumber(Pret     .Text,'');
  Produs.Cantitate:=StrToNumber(Cantitate.Text,'');
  Result:=(ShowModal=mrOK);
end;

procedure TAdaugare_.Iesire1Click(Sender: TObject);
begin
  Close;
end;

procedure TAdaugare_.DenumireChange(Sender: TObject);
Var f:File Of TProdus;
    s:String;
begin
  BitBtn1.Enabled:=(Denumire.Text<>'') And
                   (UM.Text<>'') And
                   (StrToNumber(Pret     .Text,'')<>0) And
                   (StrToNumber(Cantitate.Text,'')<>0);
  s:=Denumire.Text;
  //citire fisier
  If FileExists(dirEXE+dirPRD+s+'.'+ExtPRD) Then
    Begin
      AssignFile(f,dirEXE+dirPRD+s+'.'+ExtPRD);
      Reset     (f);
      Read      (f,Produs);
      CloseFile (f);
    End;
//  Else
//    ProdusNou(Produs);
  //identitate
  Denumire.Text  :=Produs.Denumire;
  UM.Text        :=Produs.UM;
  Pret.Text      :=FloatToStr(Produs.Pret);
  Cantitate.Text :=FloatToStr(Produs.Cantitate);
//  ShowProgress(Panel4,ProgressBar1);
end;

procedure TAdaugare_.UMChange(Sender: TObject);
begin
  Produs.UM:=UM.Text;
  BitBtn1.Enabled:=(Denumire.Text<>'') And
                   (UM      .Text<>'') And
                   (StrToNumber(Pret     .Text,'')<>0) And
                   (StrToNumber(Cantitate.Text,'')<>0);
end;

procedure TAdaugare_.PretChange(Sender: TObject);
begin
  Produs.Pret:=StrToNumber(Pret.Text,'');
  BitBtn1.Enabled:=(Denumire.Text<>'') And
                   (UM      .Text<>'') And
                   (StrToNumber(Pret     .Text,'')<>0) And
                   (StrToNumber(Cantitate.Text,'')<>0);
end;

procedure TAdaugare_.CantitateChange(Sender: TObject);
begin
  Produs.Cantitate:=StrToNumber(Cantitate.Text,'');
  BitBtn1.Enabled:=(Denumire.Text<>'') And
                   (UM      .Text<>'') And
                   (StrToNumber(Pret     .Text,'')<>0) And
                   (StrToNumber(Cantitate.Text,'')<>0);
end;

procedure TAdaugare_.FormActivate(Sender: TObject);
begin
  Shake(Adaugare_,Main_.ShakeIt.Checked);
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TAdaugare_.Exit1Click(Sender: TObject);
begin
  Close;
end;

end.

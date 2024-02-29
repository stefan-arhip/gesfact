unit _Istoric_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, ComCtrls, Buttons;

type
  TIstoric_ = class(TForm)
    MainMenu1: TMainMenu;
    Meniuascuns1: TMenuItem;
    Iesire1: TMenuItem;
    Panel2: TPanel;
    Panel9: TPanel;
    Panel4: TPanel;
    ProgressBar1: TProgressBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel1: TPanel;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel3: TPanel;
    Nou2: TSpeedButton;
    Deschidere2: TSpeedButton;
    Salvare2: TSpeedButton;
    Tiparire2: TSpeedButton;
    Optiuni2: TSpeedButton;
    Exit1: TSpeedButton;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Iesire1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Istoric_: TIstoric_;

implementation

uses _Main_;

{$R *.DFM}

procedure TIstoric_.RadioButton1Click(Sender: TObject);
begin
  Memo1.Visible:=True;
  Memo2.Visible:=False;
end;

procedure TIstoric_.RadioButton2Click(Sender: TObject);
begin
  Memo1.Visible:=False;
  Memo2.Visible:=True;
end;

procedure TIstoric_.FormShow(Sender: TObject);
begin
  RadioButton1.Left:=305;
  RadioButton2.Left:=250;
  If RadioButton1.Checked Then
    RadioButton1Click(Sender); //selecteaza informatiile despre aplicatie
  If RadioButton2.Checked Then
    RadioButton2Click(Sender); //       sau istoricul realizarii acesteia
end;

procedure TIstoric_.Iesire1Click(Sender: TObject);
begin
  Istoric_.Close;
end;   

procedure TIstoric_.FormActivate(Sender: TObject);
begin
  Shake(Istoric_,Main_.ShakeIt.Checked);
end;

end.

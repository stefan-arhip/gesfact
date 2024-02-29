unit _Alegere_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Menus, ComCtrls, ExtCtrls, ToolWin;

type
  TAlegere_ = class(TForm)
    MainMenu1: TMainMenu;
    Iesire1: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    ComboBox1: TComboBox;
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
    procedure ComboBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Ales:String;
    Function Execute:Boolean;
  end;

var
  Alegere_: TAlegere_;

implementation

Uses _Main_;

{$R *.DFM}

function TAlegere_.Execute: Boolean;
begin
  Result:=(ShowModal=mrOK);
  Ales:=ComboBox1.Items[ComboBox1.ItemIndex];
end;

procedure TAlegere_.Iesire1Click(Sender: TObject);
begin
  Close;
end;

procedure TAlegere_.ComboBox1Change(Sender: TObject);
begin
  BitBtn1.Enabled:=ComboBox1.ItemIndex<>-1;
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TAlegere_.FormActivate(Sender: TObject);
begin
  ComboBox1Change(Sender);
  ComboBox1.SetFocus;
  Shake(Alegere_,Main_.ShakeIt.Checked);
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TAlegere_.Exit1Click(Sender: TObject);
begin
  Close;
end;

end.

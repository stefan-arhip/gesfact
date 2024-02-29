unit _Parola_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Menus, ComCtrls, ExtCtrls;

type
  TParola_ = class(TForm)
    MainMenu1: TMainMenu;
    Iesire1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
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
    procedure FormCreate(Sender: TObject);
    procedure Iesire1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Pass:String;
    Function Execute:Boolean;
  end;

var
  Parola_: TParola_;

implementation

{$R *.DFM}

function TParola_.Execute: Boolean;
begin
  Result:=(ShowModal=mrOK);
  Pass:=Edit1.Text;
end;

procedure TParola_.FormCreate(Sender: TObject);
begin
  Edit1.PasswordChar:=#174;
end;

procedure TParola_.Iesire1Click(Sender: TObject);
begin
  Close;
end;

end.

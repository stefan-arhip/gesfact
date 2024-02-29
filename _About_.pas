unit _About_;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI, Dialogs, Menus, ComCtrls;

type
  TAbout_ = class(TForm)
    MainMenu1: TMainMenu;
    Iesire1: TMenuItem;
    Panel3: TPanel;
    Panel9: TPanel;
    Panel4: TPanel;
    ProgressBar1: TProgressBar;
    Panel5: TPanel;
    Nou2: TSpeedButton;
    Deschidere2: TSpeedButton;
    Salvare2: TSpeedButton;
    Tiparire2: TSpeedButton;
    Optiuni2: TSpeedButton;
    Exit1: TSpeedButton;
    Panel6: TPanel;
    Label3: TLabel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Panel1: TPanel;
    procedure Label2Click(Sender: TObject);
    procedure ProgramIconClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Iesire1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About_: TAbout_;

implementation

uses _Main_;

{$R *.DFM}

Procedure Executie (s:String);
  Var t:Array[0..79]Of Char;
  Begin
    StrPCopy(t,s);
    ShellExecute(0, Nil, t, Nil, Nil, SW_NORMAL);
  End;

procedure TAbout_.Label2Click(Sender: TObject);
begin
  Executie ('http:\\'+Label2.Caption);
  Label2.Font.Color:=clRed;
end;

procedure TAbout_.ProgramIconClick(Sender: TObject);
begin
  Executie ('mailto:stedanarh@go.ro');
end;

procedure TAbout_.FormActivate(Sender: TObject);
begin
  Width:=305;
  Height:=232;
  Shake(About_,Main_.ShakeIt.Checked);
end;

procedure TAbout_.Iesire1Click(Sender: TObject);
begin
  Close;
end;

end.


unit _Vizualizare_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus, ExtCtrls, ShellApi, Clipbrd, Printers, Buttons;

type
  TVizualizare_ = class(TForm)
    Container: TRichEdit;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    ColorDialog1: TColorDialog;
    MainMenu1: TMainMenu;
    Iesire1: TMenuItem;
    ListBox1: TListBox;
    Panel1: TPanel;
    Fisier1: TMenuItem;
    Salvare4: TMenuItem;
    N2: TMenuItem;
    Tiparire4: TMenuItem;
    Undo1: TMenuItem;
    N1: TMenuItem;
    Cut1: TMenuItem;
    Copy4: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    N3: TMenuItem;
    SelectAll4: TMenuItem;
    Editare2: TMenuItem;
    Undo2: TMenuItem;
    N5: TMenuItem;
    Cut2: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    Delete2: TMenuItem;
    N6: TMenuItem;
    SelectAll2: TMenuItem;
    Container2: TRichEdit;
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
    N4: TMenuItem;
    Deschidere1: TMenuItem;
    CtrlC1: TMenuItem;
    procedure Export1Click(Sender: TObject);
    procedure Tiparire2Click(Sender: TObject);
    procedure Iesire1Click(Sender: TObject);
    procedure SaveDialog1TypeChange(Sender: TObject);
    procedure SelectAll4Click(Sender: TObject);
    procedure Copy4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure WM_SpoolerStatus(var Msg:TWMSPOOLERSTATUS); Message WM_SPOOLERSTATUS;
    { Private declarations }
  public
    { Public declarations }
    Fisier:String;
  end;

var
  Vizualizare_: TVizualizare_;

implementation

Uses _Main_, _Inregistrare_;

{$R *.DFM}

procedure TVizualizare_.WM_SpoolerStatus(var Msg: TWMSpoolerStatus);
begin
  If Msg.JobsLeft=0 Then
    Panel1.Visible:=False
  Else
    Begin
      Panel1.Left:=(Width-Panel1.Width) Div 2;
      Panel1.Top:=(Height-Panel1.Height) Div 2;
      Panel1.Caption:='GesFact - Tiparire '+IntToStr(Msg.JobsLeft)+' documente...';
      Panel1.Visible:=True;
    End;
  Vizualizare_.Enabled:=Not Panel1.Visible;
end;

procedure TVizualizare_.Export1Click(Sender: TObject);
Var i:Integer;
begin
  SaveDialog1.InitialDir:=dirEXE+dirEXP;
  SaveDialog1.FileName:=Fisier;
  If SaveDialog1.Execute Then
    Begin
      Case SaveDialog1.FilterIndex Of
        1:  //.RTF
          Container.Lines.SaveToFile(SaveDialog1.FileName);
        2:  //.TXT
          Begin
            ListBox1.Clear;
            For i:=1 To Container.Lines.Capacity Do
              ListBox1.Items.Add(Container.Lines[i-1]);
            ListBox1.Items.SaveToFile(SaveDialog1.FileName);
          End;
      End;
      If MessageDlg('Raportul a fost exportat in fisierul'#13+
                    '"'+SaveDialog1.FileName+'"'#13+
                    'Se deschide pentru vizualizare?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
        ShellExecute(0,Nil,PChar(SaveDialog1.FileName),Nil,Nil,SW_Maximize);//SW_Normal, SW_Show
    End;
end;

procedure TVizualizare_.Tiparire2Click(Sender: TObject);
begin
  Printer.Orientation:=poPortrait;
  If PrinterSetupDialog1.Execute Then
    Container.Print('Tiparire factura...');
end;

procedure TVizualizare_.Iesire1Click(Sender: TObject);
begin
  Close;
end;

procedure TVizualizare_.SaveDialog1TypeChange(Sender: TObject);
begin
  Case SaveDialog1.FilterIndex Of
    1:
      SaveDialog1.DefaultExt:='RTF';
    2:
      SaveDialog1.DefaultExt:='TXT';
  End;
end;

procedure TVizualizare_.SelectAll4Click(Sender: TObject);
begin
  Container.SelectAll;
end;

procedure TVizualizare_.Copy4Click(Sender: TObject);
begin
  Container.CopyToClipboard;
end;

procedure TVizualizare_.FormActivate(Sender: TObject);
Const numeFont       :String='monosb.ttf';
Var   dw             :Array [0..255] Of Char;
      DirectorWindows:String;
begin
/////////////////////////////////////////////////////////////////////////////
  Salvare2   .Enabled:=Inregistrare_.Inregistrata.Caption='inregistrata';  //
  Tiparire2  .Enabled:=Salvare2.Enabled;                                   //
  Salvare4   .Enabled:=Salvare2.Enabled;                                   //
  Tiparire4  .Enabled:=Salvare2.Enabled;                                   //
  Copy2      .Enabled:=Salvare2.Enabled;                                   //
  Copy4      .Enabled:=Salvare2.Enabled;                                   //
  CtrlC1     .Enabled:=Salvare2.Enabled;                                   //
  SelectAll2 .Enabled:=Salvare2.Enabled;                                   //
  SelectAll4 .Enabled:=Salvare2.Enabled;                                   //
  If Salvare2.Enabled Then                                                 //
    Container.Color  :=clWindow                                            //  
  Else                                                                     //
    Container.Color  :=clBtnFace;                                          //
/////////////////////////////////////////////////////////////////////////////
  Left  :=0;
  Top   :=0;
  Width :=Screen.Width;
  Height:=Screen.Height;
  GetWindowsDirectory(dw,255);
  DirectorWindows:=PutBackSlashAtTheEnd(StrPas(dw));
  CopyFile(PChar(dirEXE+'FONTS\'+numeFont),
           PChar(DirectorWindows  +'FONTS\'+numeFont),False);
  If FileExists (DirectorWindows  +'FONTS\'+numeFont) Then
    Container.Font.Name:='Monospac821 BT'
   Else
    Container.Font.Name:='Courier New';
  Container.Font.Style:=[fsBold];
  ShowProgress(Panel4,ProgressBar1);
end;

end.

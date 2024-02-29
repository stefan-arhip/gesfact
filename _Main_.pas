unit _Main_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Buttons, ToolWin, Menus, Grids, StdCtrls, Mask,
  FileCtrl, ShellApi, IniFiles;

type
  TMain_ = class(TForm)
    Panel1: TPanel;
    GroupBox6: TGroupBox;
    FisiereVanzatori: TFileListBox;
    FisiereCumparatori: TFileListBox;
    MainMenu1: TMainMenu;
    Fisier1: TMenuItem;
    Deschidere1: TMenuItem;
    Salvare1: TMenuItem;
    N1: TMenuItem;
    Iesire1: TMenuItem;
    Vanzator1: TMenuItem;
    Adaugare1: TMenuItem;
    Modificare1: TMenuItem;
    Stergere1: TMenuItem;
    Cumparator1: TMenuItem;
    Adaugare2: TMenuItem;
    Modificare2: TMenuItem;
    Stergere2: TMenuItem;
    Produse1: TMenuItem;
    Adaugare3: TMenuItem;
    Modificare3: TMenuItem;
    Stergere3: TMenuItem;
    Factura1: TMenuItem;
    Adaugare4: TMenuItem;
    Modificare4: TMenuItem;
    Stergere4: TMenuItem;
    Label1: TLabel;
    ListaVanzatori: TListBox;
    Label2: TLabel;
    ListaCumparatori: TListBox;
    ListaFacturi: TListBox;
    Label4: TLabel;
    Label3: TLabel;
    ListaProduse: TListBox;
    PopupMenu1: TPopupMenu;
    Adaugare5: TMenuItem;
    Modificare5: TMenuItem;
    Stergere5: TMenuItem;
    Editare1: TMenuItem;
    Listavanzatori1: TMenuItem;
    Listacumparatori1: TMenuItem;
    Listaproduse1: TMenuItem;
    Listafacturi1: TMenuItem;
    FisiereProduse: TFileListBox;
    FisiereFacturi: TFileListBox;
    N2: TMenuItem;
    Tiparire5: TMenuItem;
    N3: TMenuItem;
    Tiparire4: TMenuItem;
    Ajutor1: TMenuItem;
    Despre1: TMenuItem;
    N4: TMenuItem;
    Ajutor2: TMenuItem;
    Versiune1: TMenuItem;
    N5: TMenuItem;
    Proprietati1: TMenuItem;
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
    Timer1: TTimer;
    EditatInformatic: TEdit;
    ShakeIt: TCheckBox;
    N6: TMenuItem;
    Inregistrare1: TMenuItem;
    Inregistrata: TCheckBox;
    procedure Iesire1Click(Sender: TObject);
    procedure Adaugare1Click(Sender: TObject);
    procedure Adaugare2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Modificare1Click(Sender: TObject);
    procedure Modificare2Click(Sender: TObject);
    procedure Adaugare4Click(Sender: TObject);
    procedure Modificare4Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Stergere1Click(Sender: TObject);
    procedure Adaugare5Click(Sender: TObject);
    procedure Adaugare3Click(Sender: TObject);
    procedure Modificare3Click(Sender: TObject);
    procedure Stergere3Click(Sender: TObject);
    procedure Modificare5Click(Sender: TObject);
    procedure Stergere5Click(Sender: TObject);
    procedure Stergere2Click(Sender: TObject);
    procedure Stergere4Click(Sender: TObject);
    procedure Listavanzatori1Click(Sender: TObject);
    procedure Listacumparatori1Click(Sender: TObject);
    procedure Listaproduse1Click(Sender: TObject);
    procedure Listafacturi1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Tiparire2Click(Sender: TObject);
    procedure Despre1Click(Sender: TObject);
    procedure Ajutor2Click(Sender: TObject);
    procedure Versiune1Click(Sender: TObject);
    procedure Proprietati1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Deschidere2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ListaVanzatoriEnter(Sender: TObject);
    procedure ListaCumparatoriEnter(Sender: TObject);
    procedure ListaProduseEnter(Sender: TObject);
    procedure ListaFacturiEnter(Sender: TObject);
    procedure Inregistrare1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshListe;
    Procedure ScriereSetari(f:String);
    Procedure CitireSetari (f:String);
  end;

Function  AddSpace(s:String;e:Integer;AlDr:Boolean):String;
Function  DeleteSpaces(s:String):String;
Procedure Shake(form:TForm;ShakeIt:Boolean);
Procedure ShowProgress(Panel:TPanel;Bar:TProgressBar);
Function  PutBackSlashAtTheEnd(s:String):String;

Const dirEXE:String='';
      dirVNZ:String='VANZATORI\';
      dirCMP:String='CUMPARATORI\';
      dirPRD:String='PRODUSE\';
      dirFCT:String='FACTURI\';
      dirEXP:String='EXPORT\';
      dirDEL:String='STERSE\';
      extVNZ:String='VNZ';
      extCMP:String='CMP';
      extPRD:String='PRD';
      extFCT:String='FCT';
      extEXP:String='TXT';

var   Main_: TMain_;
      mHandle:THandle;    // Mutexhandle

implementation

uses _Factura_, _Produs_, _About_, _Istoric_, _Vizualizare_, _Furnizor_, _Inregistrare_;

{$R *.DFM}

Const WinMax:Boolean=False;
      WinX  :Integer=  0;
      WinY  :Integer=  0;
      WinW  :Integer=640;
      WinH  :Integer=480;

Procedure CreareDirector(s:String);
Begin
  If Not DirectoryExists(dirEXE+s) Then
    Begin
      If MessageDlg('Nu exista directorul "'+s+'"'#13+
                    'Se permite aplicatiei sa-l creeze?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
        Begin
          ChDir(dirEXE);
          MkDir(s);
        End
      Else
        Begin
          MessageDlg('Nu exista directorul "'+s+'".'#13+
                     'Aplicatia nu poate fi lansata in executie si se inchide!',mtError,[MBoK],0);
          Application.Terminate;
        End;
    End;
End;

Procedure TMain_.ScriereSetari(f:String);
Var ini:TIniFile;
Begin
  ini:=TIniFile.Create(f);
  Try
//directoare
    If dirEXE=PutBackSlashAtTheEnd(ExtractFileDir(Application.ExeName)) Then
      dirExe:='[.]';
    ini.WriteString  ('Director','aplicatie    .',dirEXE);
    ini.WriteString  ('Director','vanzatori    .',dirVNZ);
    ini.WriteString  ('Director','cumparatori  .',dirCMP);
    ini.WriteString  ('Director','produse      .',dirPRD);
    ini.WriteString  ('Director','facturi      .',dirFCT);
    ini.WriteString  ('Director','export       .',dirEXP);
    ini.WriteString  ('Director','sterse       .',dirDEL);
//extensii
    ini.WriteString  ('Extensie','vanzatori    .',extVNZ);
    ini.WriteString  ('Extensie','cumparatori  .',extCMP);
    ini.WriteString  ('Extensie','produse      .',extPRD);
    ini.WriteString  ('Extensie','facturi      .',extFCT);
    ini.WriteString  ('Extensie','export       .',extEXP);
//pozitie
    ini.WriteInteger ('Pozitie ','poz x        .',WinX  );
    ini.WriteInteger ('Pozitie ','poz y        .',WinY  );
    ini.WriteInteger ('Pozitie ','dim x        .',WinW  );
    ini.WriteInteger ('Pozitie ','dim y        .',WinH  );
    ini.WriteBool    ('Pozitie ','maximizata   .',WinMax);
//diverse
    ini.WriteString  ('Diverse ','comentariu   .',EditatInformatic.Text);
    ini.WriteBool    ('Diverse ','animatie     .',ShakeIt.Checked);
    ini.WriteBool    ('Diverse ','inregistrare .',Inregistrata.Checked);
  Finally
    ini.Free;
  End;
End;

Procedure TMain_.CitireSetari(f:String);
Var
  ini:TIniFile;
begin
  ini:=TIniFile.Create(f);
  Try
//directoare
    dirEXE               :=ini.ReadString ('Director','aplicatie    .',dirEXE);
    If Not DirectoryExists(dirExe) Then
      dirEXE:=PutBackSlashAtTheEnd(ExtractFileDir(Application.ExeName));
    dirVNZ               :=ini.ReadString ('Director','vanzatori    .',dirVNZ);
    dirCMP               :=ini.ReadString ('Director','cumparatori  .',dirCMP);
    dirPRD               :=ini.ReadString ('Director','produse      .',dirPRD);
    dirFCT               :=ini.ReadString ('Director','facturi      .',dirFCT);
    dirEXP               :=ini.ReadString ('Director','export       .',dirEXP);
    dirDEL               :=ini.ReadString ('Director','sterse       .',dirDEL);
//extensii
    extVNZ               :=ini.ReadString ('Extensie','vanzatori    .',extVNZ);
    extCMP               :=ini.ReadString ('Extensie','cumparatori  .',extCMP);
    extPRD               :=ini.ReadString ('Extensie','produse      .',extPRD);
    extFCT               :=ini.ReadString ('Extensie','facturi      .',extFCT);
    extEXP               :=ini.ReadString ('Extensie','export       .',extEXP);
//pozitie
    Left                 :=ini.ReadInteger('Pozitie ','poz x        .',     0);
    Top                  :=ini.ReadInteger('Pozitie ','poz y        .',     0);
    Width                :=ini.ReadInteger('Pozitie ','dim x        .',   640);
    Height               :=ini.ReadInteger('Pozitie ','dim y        .',   480);
    WinMax               :=ini.ReadBool   ('Pozitie ','maximizata   .',  True);
//diverse
    EditatInformatic.Text:=ini.ReadString ('Diverse ','comentariu   .',EditatInformatic.Text);
    ShakeIt.Checked      :=ini.ReadBool   ('Diverse ','animatie     .',ShakeIt.Checked);
    Inregistrata.Checked :=ini.ReadBool   ('Diverse ','inregistrare .',Inregistrata.Checked);
    Inregistrata.Checked :=VerificareLicenta;
  Finally
    ini.Free;
  End;
end;

Procedure ShowProgress(Panel:TPanel;Bar:TProgressBar);
Var i:Integer;
Begin
  Panel.Visible:=True;
  For i:=1 To 1000 Do
    Begin
      Bar.Position:=i Div 10;
      Bar.Refresh;
    End;
  Panel.Visible:=False;
End;

Function PutBackSlashAtTheEnd(s:String):String;
Begin
  If s[Length(s)]<>'\' Then
    s:=s+'\';
  Result:=s;
End;

Procedure Shake(form:TForm;ShakeIt:Boolean);
Var n:Integer;
    OldLeft,OldTop:Integer;
Begin
  If ShakeIt Then
    Begin
      OldLeft:=Form.Left;
      OldTop :=Form.Top;
      For n:=1 To 30 Do
        Begin
          Form.Left:=(OldLeft-10)+(Random(20));
          Form.Top :=(OldTop-10)+(Random(20));
        End;
      Form.Left:=OldLeft;
      Form.Top :=OldTop;
    End;
end;

Function AddSpace(s:String;e:Integer;AlDr:Boolean):String;
Var s1,s2:String;
Begin
  If AlDr Then
    Begin
      s1:=' ';
      s2:='';
    End
  Else
    Begin
      s1:='';
      s2:=' ';
    End;
  While Length(s)<e Do
    Begin
      s:=s1+s+s2;
    End;
  Result:=s;
End;

Function DeleteSpaces(s:String):String;
Var i:Integer;
Begin
  i:=0;
  While i<=Length(s) Do
    If s[i]=' ' Then
      Delete(s,i,1)
    Else
      Inc(i);
  Result:=s;
End;

Function FaraExtensie(s,e:String):String;
Begin
  Delete(s,Length(s)-Length(e)+1,Length(e));
  Result:=s;
End;

procedure TMain_.RefreshListe;
Var i:Integer;
    pV,pC,pP,pF:Integer;
begin
//vanzatori
  pV                          :=ListaVanzatori.ItemIndex;
  FisiereVanzatori  .Directory:='C:\';
  FisiereVanzatori  .Mask     :='*.'+ExtVNZ;
  FisiereVanzatori  .Directory:=dirEXE+dirVNZ;
  ListaVanzatori.Clear;
  For i:=1 To FisiereVanzatori.Items.Capacity Do
    ListaVanzatori.Items.Add(FaraExtensie(FisiereVanzatori.Items[i-1],'.'+ExtVNZ));
  If ListaVanzatori.Items.Capacity<>0 Then
    ListaVanzatori.ItemIndex  :=0;
  If pV<>-1 Then
    ListaVanzatori.ItemIndex  :=pV;
//cumparatori
  pC                          :=ListaCumparatori.ItemIndex;
  FisiereCumparatori.Directory:='C:\';
  FisiereCumparatori.Mask     :='*.'+ExtCMP;
  FisiereCumparatori.Directory:=dirEXE+dirCMP;
  ListaCumparatori.Clear;
  For i:=1 To FisiereCumparatori.Items.Capacity Do
    ListaCumparatori.Items.Add(FaraExtensie(FisiereCumparatori.Items[i-1],'.'+ExtCMP));
  If ListaCumparatori.Items.Capacity<>0 Then
    ListaCumparatori.ItemIndex:=0;
  If pC<>-1 Then
    ListaCumparatori.ItemIndex  :=pC;
//produse
  pP                          :=ListaProduse.ItemIndex;
  FisiereProduse.Directory:='C:\';
  FisiereProduse.Mask:='*.'+ExtPRD;
  FisiereProduse.Directory:=dirEXE+dirPRD;
  ListaProduse.Clear;
  For i:=1 To FisiereProduse.Items.Capacity Do
    ListaProduse.Items.Add(FaraExtensie(FisiereProduse.Items[i-1],'.'+ExtPRD));
  If ListaProduse.Items.Capacity<>0 Then
    ListaProduse.ItemIndex:=0;
  If pP<>-1 Then
    ListaProduse.ItemIndex  :=pP;
//facturi
  pF                          :=ListaFacturi.ItemIndex;
  FisiereFacturi.Directory:='C:\';
  FisiereFacturi.Mask:='*.'+ExtFCT;
  FisiereFacturi.Directory:=dirEXE+dirFCT;
  ListaFacturi.Clear;
  For i:=1 To FisiereFacturi.Items.Capacity Do
    ListaFacturi.Items.Add(FaraExtensie(FisiereFacturi.Items[i-1],'.'+ExtFCT));
  If ListaFacturi.Items.Capacity<>0 Then
    ListaFacturi.ItemIndex:=0;
  If pF<>-1 Then
    ListaFacturi.ItemIndex  :=pF;
End;

procedure TMain_.Iesire1Click(Sender: TObject);
begin
  Close;
end;

procedure TMain_.FormCreate(Sender: TObject);
begin
  mHandle:=CreateMutex(Nil,True,'XYZ');
  If GetLastError=ERROR_ALREADY_EXISTS Then
    Begin
      MessageDlg('Aplicatia este deja lansata in executie!',mtInformation,[mbOk],0);
      Halt;
    End;
  CitireSetari       (PutBackSlashAtTheEnd(ExtractFileDir(Application.ExeName))+'GesFact.ini');
  CreareDirector     (dirVNZ);
  CreareDirector     (dirCMP);
  CreareDirector     (dirPRD);
  CreareDirector     (dirFCT);
  CreareDirector     (dirEXP);
  CreareDirector     (dirDEL);
  ListaVanzatoriEnter(Sender);
end;

procedure TMain_.Adaugare1Click(Sender: TObject);
begin
  Furnizor_.Caption:='GesFact - adaugare Vanzator';
  Furnizor_.Fisier:='';
  Furnizor_.Extensie:=ExtVNZ;
  Furnizor_.ShowModal;
end;

procedure TMain_.Modificare1Click(Sender: TObject);
begin
  If ListaVanzatori.ItemIndex<>-1 Then
    Begin
      Furnizor_.Caption:='GesFact - modificare Vanzator';
      Furnizor_.Fisier:=ListaVanzatori.Items[ListaVanzatori.ItemIndex];
      Furnizor_.Extensie:=ExtVNZ;
      Furnizor_.ShowModal;
    End;
end;

procedure TMain_.Adaugare2Click(Sender: TObject);
begin
  Furnizor_.Caption:='GesFact - adaugare Cumparator';
  Furnizor_.Fisier:='';
  Furnizor_.Extensie:=ExtCMP;
  Furnizor_.ShowModal;
end;

procedure TMain_.Modificare2Click(Sender: TObject);
begin
  If ListaCumparatori.ItemIndex<>-1 Then
    Begin
      Furnizor_.Caption:='GesFact - modificare Cumparator';
      Furnizor_.Fisier:=ListaCumparatori.Items[ListaCumparatori.ItemIndex];
      Furnizor_.Extensie:=ExtCMP;
      Furnizor_.ShowModal;
    End;
end;

procedure TMain_.Adaugare4Click(Sender: TObject);
begin
  Factura_.Caption:='GesFact - adaugare Factura';
  Factura_.Fisier:='';
  Factura_.Extensie:=ExtFCT;
//!!  Factura_.ListaVanzatori.Items:=ListaVanzatori.Items;
//!!  Factura_.ListaCumparatori.Items:=ListaCumparatori.Items;
  Factura_.ShowModal;
end;

procedure TMain_.Modificare4Click(Sender: TObject);
begin
  If ListaFacturi.ItemIndex<>-1 Then
    Begin
      Factura_.Caption:='GesFact - modificare Factura';
      Factura_.Fisier:=ListaFacturi.Items[ListaFacturi.ItemIndex];
      Factura_.Extensie:=ExtFCT;
//!!      Factura_.ListaVanzatori.Items:=ListaVanzatori.Items;
//!!      Factura_.ListaCumparatori.Items:=ListaCumparatori.Items;
      Factura_.ShowModal;
    End;
end;

procedure TMain_.FormResize(Sender: TObject);
begin
//  If Left  <  0 Then Left  :=  0;
//  If Top   <  0 Then Top   :=  0;
  If Width <640 Then Width :=640;
  If Height<480 Then Height:=480;
//-- vanzatori
  Label1          .Left  :=7;
  ListaVanzatori  .Left  :=Label1.Left;
  ListaVanzatori  .Height:=Panel1.Height-33;
  ListaVanzatori  .Width :=(Panel1.Width-(7*2)-(6*3)) Div 4;
//-- cumparatori
  Label2          .Left  :=7+ListaVanzatori.Width+6;
  ListaCumparatori.Left  :=Label2.Left;
  ListaCumparatori.Height:=ListaVanzatori.Height;
  ListaCumparatori.Width :=ListaVanzatori.Width;
//-- produse
  Label3          .Left  :=7+2*(ListaVanzatori.Width+6);
  ListaProduse    .Left  :=Label3.Left;
  ListaProduse    .Height:=ListaVanzatori.Height;
  ListaProduse    .Width :=ListaVanzatori.Width;
//-- facturi
  Label4          .Left  :=7+3*(ListaVanzatori.Width+6);
  ListaFacturi    .Left  :=Label4.Left;
  ListaFacturi    .Height:=ListaVanzatori.Height;
  ListaFacturi    .Width :=ListaVanzatori.Width;
end;

procedure TMain_.Stergere1Click(Sender: TObject);
Var s:String;
    p:Integer;
begin
  If ListaVanzatori.ItemIndex<>-1 Then
    Begin
      p:=ListaVanzatori.ItemIndex;
      s:=ListaVanzatori.Items[p];
      If p<>-1 Then
        If MessageDlg('Sterg vanzatorul "'+s+'"?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
          Begin
            If FileExists    (dirEXE+dirVNZ+s+'.'+ExtVNZ) Then
              DeleteFile     (dirEXE+dirVNZ+s+'.'+ExtVNZ);
            If Not RenameFile(dirEXE+dirVNZ+s+'.'+ExtVNZ,
                              dirEXE+dirDEL+s+'.'+ExtVNZ) Then
                   MessageDlg('Fisierul "'+
                              dirEXE+dirVNZ+s+'.'+ExtVNZ+
                              '" nu poate fi sters!',mtError,[mbOk],0);
          End;
      Main_.Activate;
      If p<ListaVanzatori.Items.Capacity Then
        ListaVanzatori.ItemIndex:=p
      Else
        ListaVanzatori.ItemIndex:=p-1;
    End;
end;

procedure TMain_.Adaugare5Click(Sender: TObject);
begin
  If ListaVanzatori.Focused Then
    Adaugare1Click(Sender);
  If ListaCumparatori.Focused Then
    Adaugare2Click(Sender);
  If ListaProduse.Focused Then
    Adaugare3Click(Sender);
  If ListaFacturi.Focused Then
    Adaugare4Click(Sender);
end;

procedure TMain_.Adaugare3Click(Sender: TObject);
begin
  Produs_.Caption:='GesFact - adaugare Produs';
  Produs_.Fisier:='';
  Produs_.Extensie:=ExtPRD;
  Produs_.ShowModal;
end;

procedure TMain_.Modificare3Click(Sender: TObject);
begin
  If ListaProduse.ItemIndex<>-1 Then
    Begin
        Produs_.Caption:='GesFact - modificare Produs';
      Produs_.Fisier:=ListaProduse.Items[ListaProduse.ItemIndex];
      Produs_.Extensie:=ExtPRD;
      Produs_.ShowModal;
    End;
end;

procedure TMain_.Stergere3Click(Sender: TObject);
Var s:String;
    p:Integer;
begin
  If ListaProduse.ItemIndex<>-1 Then
    Begin
      p:=ListaProduse.ItemIndex;
      s:=ListaProduse.Items[p];
      If p<>-1 Then
        If MessageDlg('Sterg produsul / serviciul "'+s+'"?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
          Begin
            If FileExists    (dirEXE+dirPRD+s+'.'+ExtPRD) Then
              DeleteFile     (dirEXE+dirPRD+s+'.'+ExtPRD);
            If Not RenameFile(dirEXE+dirPRD+s+'.'+ExtPRD,
                              dirEXE+dirDEL+s+'.'+ExtPRD) Then
                   MessageDlg('Fisierul "'+
                              dirEXE+dirPRD+s+'.'+ExtPRD+
                              '" nu poate fi sters!',mtError,[mbOk],0);
          End;
      Main_.Activate;
      If p<ListaProduse.Items.Capacity Then
        ListaProduse.ItemIndex:=p
      Else
        ListaProduse.ItemIndex:=p-1;
    End;
end;

procedure TMain_.Modificare5Click(Sender: TObject);
begin
  If ListaVanzatori.Focused Then
    Modificare1Click(Sender);
  If ListaCumparatori.Focused Then
    Modificare2Click(Sender);
  If ListaProduse.Focused Then
    Modificare3Click(Sender);
  If ListaFacturi.Focused Then
    Modificare4Click(Sender);
end;

procedure TMain_.Stergere5Click(Sender: TObject);
begin
  If ListaVanzatori.Focused Then
    Stergere1Click(Sender);
  If ListaCumparatori.Focused Then
    Stergere2Click(Sender);
  If ListaProduse.Focused Then
    Stergere3Click(Sender);
  If ListaFacturi.Focused Then
    Stergere4Click(Sender);
  RefreshListe;
end;

procedure TMain_.Stergere2Click(Sender: TObject);
Var s:String;
    p:Integer;
begin
  If ListaCumparatori.ItemIndex<>-1 Then
    Begin
      p:=ListaCumparatori.ItemIndex;
      s:=ListaCumparatori.Items[p];
      If p<>-1 Then
        If MessageDlg('Sterg cumparatorul "'+s+'"?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
          Begin
            If FileExists    (dirEXE+dirCMP+s+'.'+ExtCMP) Then
              DeleteFile     (dirEXE+dirCMP+s+'.'+ExtCMP);
            If Not RenameFile(dirEXE+dirCMP+s+'.'+ExtCMP,
                              dirEXE+dirDEL+s+'.'+ExtCMP) Then
                   MessageDlg('Fisierul "'+
                              dirEXE+dirCMP+s+'.'+ExtCMP+
                              '" nu poate fi sters!',mtError,[mbOk],0);
          End;
      Main_.Activate;
      If p<ListaCumparatori.Items.Capacity Then
        ListaCumparatori.ItemIndex:=p
      Else
        ListaCumparatori.ItemIndex:=p-1;
    End;
end;

procedure TMain_.Stergere4Click(Sender: TObject);
Var s:String;
    p:Integer;
begin
  If ListaFacturi.ItemIndex<>-1 Then
    Begin
      p:=ListaFacturi.ItemIndex;
      s:=ListaFacturi.Items[p];
      If p<>-1 Then
        If MessageDlg('Sterg factura "'+s+'"?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
          Begin
            If FileExists    (dirEXE+dirFCT+s+'.'+ExtFCT) Then
              DeleteFile     (dirEXE+dirFCT+s+'.'+ExtFCT);
            If Not RenameFile(dirEXE+dirFCT+s+'.'+ExtFCT,
                              dirEXE+dirDEL+s+'.'+ExtFCT) Then
                   MessageDlg('Fisierul "'+
                              dirEXE+dirFCT+s+'.'+ExtFCT+
                              '" nu poate fi sters!',mtError,[mbOk],0);
          End;
      Main_.Activate;
      If p<ListaFacturi.Items.Capacity Then
        ListaFacturi.ItemIndex:=p
      Else
        ListaFacturi.ItemIndex:=p-1;
    End;
end;

procedure TMain_.Listavanzatori1Click(Sender: TObject);
begin
  ListaVanzatori.SetFocus;
end;

procedure TMain_.Listacumparatori1Click(Sender: TObject);
begin
  ListaCumparatori.SetFocus;
end;

procedure TMain_.Listaproduse1Click(Sender: TObject);
begin
  ListaProduse.SetFocus;
end;

procedure TMain_.Listafacturi1Click(Sender: TObject);
begin
  ListaFacturi.SetFocus;
end;

procedure TMain_.PopupMenu1Popup(Sender: TObject);
begin
  N2       .Enabled:=ListaFacturi.Focused;
  Tiparire5.Enabled:=N2          .Enabled;
end;

procedure TMain_.Tiparire2Click(Sender: TObject);
begin
  Factura_.Tiparire2Click(Sender);
end;

procedure TMain_.Despre1Click(Sender: TObject);
begin
  About_.ShowModal;
end;

procedure TMain_.Ajutor2Click(Sender: TObject);
begin
  Istoric_.RadioButton2.Checked:=True;
  Istoric_.ShowModal;
end;

procedure TMain_.Versiune1Click(Sender: TObject);
begin
  Istoric_.RadioButton1.Checked:=True;
  Istoric_.ShowModal;
end;

procedure TMain_.Proprietati1Click(Sender: TObject);
Var s             :TShellExecuteInfo;
    FisierSelectat:String;
begin
  FisierSelectat:='';
  If ListaVanzatori.Focused Then
    FisierSelectat:=dirVNZ+ListaVanzatori.Items[ListaVanzatori.ItemIndex]+'.'+ExtVNZ;
  If ListaCumparatori.Focused Then
    FisierSelectat:=dirCMP+ListaCumparatori.Items[ListaCumparatori.ItemIndex]+'.'+ExtCMP;
  If ListaProduse.Focused Then
    FisierSelectat:=dirPRD+ListaProduse.Items[ListaProduse.ItemIndex]+'.'+ExtPRD;
  If ListaFacturi.Focused Then
    FisierSelectat:=dirFCT+ListaFacturi.Items[ListaFacturi.ItemIndex]+'.'+ExtFCT;
  If FisierSelectat<>'' Then
    FisierSelectat:=dirEXE+FisierSelectat;
  FillChar(s,SizeOf(s),0);
  s.cbSize:= SizeOf(s);
  s.lpFile:= PChar(FisierSelectat);
  s.lpVerb:= 'properties';
  s.fMask := SEE_MASK_INVOKEIDLIST;
  ShellExecuteEx(@s);
end;

procedure TMain_.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  If MessageDlg('Se inchide aplicatia?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
    Begin
//      WinMax:=Main_.WindowState:=wsMaximized;
      ScriereSetari(PutBackSlashAtTheEnd(ExtractFileDir(Application.ExeName))+'GesFact.ini');
      If mHandle<>0 Then CloseHandle(mHandle);
    End
  Else
    CanClose:=False;
end;

procedure TMain_.Deschidere2Click(Sender: TObject);
begin
  If Tag=0 Then
    Begin
      CitireSetari(PutBackSlashAtTheEnd(ExtractFileDir(Application.ExeName))+'GesFact.ini');
      If WinMax Then WindowState:=wsMaximized
      Else
        Begin
          WindowState:=wsNormal;
          If Left  <0             Then Left  :=0;
          If Top   <0             Then Top   :=0;
          If Width >Screen.Width  Then Width :=Screen.Width;
          If Height>Screen.Height Then Height:=Screen.Height;
        End;
      Tag:=1;
    End;
  RefreshListe;
  Shake(Main_,Main_.ShakeIt.Checked);
  ShowProgress(Panel4,ProgressBar1);
end;
         
procedure TMain_.Timer1Timer(Sender: TObject);
begin
//  If Left  <  0 Then Left  :=  0;
//  If Top   <  0 Then Top   :=  0;
//  If Width <640 Then Width :=640;
//  If Height<480 Then Height:=480;
  If WindowState=wsMaximized Then
    WinMax:=True
  Else
    Begin
      WinX  :=Left;
      WinY  :=Top;
      WinW  :=Width;
      WinH  :=Height;
      WinMax:=False;
    End;
end;

procedure TMain_.ListaVanzatoriEnter(Sender: TObject);
begin
  ListaVanzatori  .Color  :=clWindow;
  ListaCumparatori.Color  :=clBtnFace;
  ListaProduse    .Color  :=clBtnFace;
  ListaFacturi    .Color  :=clBtnFace;
  Tiparire2       .Enabled:=False;
  Tiparire4       .Enabled:=False;
end;

procedure TMain_.ListaCumparatoriEnter(Sender: TObject);
begin
  ListaVanzatori  .Color:=clBtnFace;
  ListaCumparatori.Color:=clWindow;
  ListaProduse    .Color:=clBtnFace;
  ListaFacturi    .Color:=clBtnFace;
  Tiparire2       .Enabled:=False;
  Tiparire4       .Enabled:=False;
end;

procedure TMain_.ListaProduseEnter(Sender: TObject);
begin
  ListaVanzatori  .Color:=clBtnFace;
  ListaCumparatori.Color:=clBtnFace;
  ListaProduse    .Color:=clWindow;
  ListaFacturi    .Color:=clBtnFace;
  Tiparire2       .Enabled:=False;
  Tiparire4       .Enabled:=False;
end;

procedure TMain_.ListaFacturiEnter(Sender: TObject);
begin
  ListaVanzatori  .Color:=clBtnFace;
  ListaCumparatori.Color:=clBtnFace;
  ListaProduse    .Color:=clBtnFace;
  ListaFacturi    .Color:=clWindow;
  Tiparire2       .Enabled:=True;
  Tiparire4       .Enabled:=True;
end;                  

procedure TMain_.Inregistrare1Click(Sender: TObject);
begin
  If Inregistrare_.Execute Then
    Begin
      If VerificareLicenta Then
        Inregistrare_.Inregistrata.Caption:='inregistrata'
      Else
        Inregistrare_.Inregistrata.Caption:='neinregistrata';
//      If VerificareLicenta Then
//        MessageDlg('Aplicatie inregistrata',mtInformation,[mbOk],0);//
    End;
end;

end.

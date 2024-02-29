unit _Furnizor_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Menus, ComCtrls, ExtCtrls, Buttons, ToolWin, StdCtrls, Mask,
  Tabnotbk, _PersonalEdit_, _Numedit_, Spin;

type
  TProdus=Record
            Denumire  :String[ 50];
            UM        :String[ 10];
            Pret      :Extended;
            Cantitate :Extended;
            Cod       :String[ 25];
            Categorie :String[ 25];
            Tip       :String[ 25];
            Comentariu:String[200];
          End;
  TAgentSocietate=Record
                    Implicit:Integer;
                    Agent   :Array[1.. 25]Of Record
                                               Nume         :String[ 50];
                                               CI:Record
                                                    Serie   :String[ 10];
                                                    Numar   :String[ 10];
                                                    Eliberat:String[ 50];
                                                  End;
                                               CNP          :String[ 15];
                                               Functie      :String[ 50];
                                               Departament  :String[ 50];
                                               Telefon      :String[ 25];
                                               Interior     :String[ 10];
                                               Mobil        :String[ 25];
                                               Email        :String[ 50];
                                               Transport    :String[ 25];
                                               NrInmatr     :String[ 25];
                                             End;
                  End;
  TVanzator=Record
              //identitate
              Nume           :String[ 50];
              IBAN           :String[ 50];
              Banca          :String[ 50];
              AtributFiscal  :String[ 10];
              CUI            :String[ 25];
              NrRegCom       :String[ 25];
              CNP            :String[ 25];
              CISerie        :String[ 25];
              CINumar        :String[ 25];
              CIEliberatDe   :String[ 25];
              CapitalSocial  :Extended;
              StatutPartener :String[ 25];
              TipPartener    :String[ 25];
              DiscountAcordat:Extended;
              //contact
              Adresa         :Record
                                TipStrada  :String[ 10];
                                NumeStrada :String[ 50];
                                NrStrada   :String[ 10];
                                Bloc       :String[ 10];
                                Scara      :String[ 10];
                                Etaj       :String[ 10];
                                Apartament :String[ 10];
                                Tara       :String[ 25];
                                Judet      :String[ 25];
                                Localitate :String[ 25];
                                CodPostal  :String[ 10];
                                Telefon    :Array[1..3]Of String[ 25];
                                Fax        :Array[1..3]Of String[ 25];
                                AdresaWeb  :String[ 50];
                                Email      :String[ 50];
                              End;
              AgentSocietate :TAgentSocietate;
              Comentariu     :String[200];
            End;
  TFactura=Record
             Vanzator     :TVanzator;
             ValoareTVA   :Extended;
             Achitata     :Boolean;
             NrFactura    :String[25];
             Data         :String[10];
             Aviz         :String[25];
             Cumparator   :TVanzator;
             Produs       :Array[1..50]Of TProdus;
             Achitat      :String[50];
             Scadenta     :Extended;
             Discount     :Extended;
             Penalizare   :Extended;
             DataLivrare  :String[16];//__-__-____ __:__
             CodUtilizator:String[200];
           End;
  TFurnizor_ = class(TForm)
    MainMenu1: TMainMenu;
    Fisier1: TMenuItem;
    Deschidere1: TMenuItem;
    Salvare1: TMenuItem;
    N1: TMenuItem;
    Iesire1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Adaugare1: TMenuItem;
    Modificare1: TMenuItem;
    Stergere1: TMenuItem;
    Panel1: TPanel;
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
    TabbedNotebook1: TTabbedNotebook;
    LStatut: TLabel;
    Ltip: TLabel;
    Lnume: TLabel;
    Ldiscount: TLabel;
    Liban: TLabel;
    Label6: TLabel;
    Lbanca: TLabel;
    Lcapitalsocial: TLabel;
    Ppersoanajuridica: TPanel;
    Latribut: TLabel;
    Lcui: TLabel;
    Lnrregcom: TLabel;
    Atribut: TEdit;
    CUI: TEdit;
    NrRegCom: TEdit;
    Ppersoanafizica: TPanel;
    LCNP: TLabel;
    Lserie: TLabel;
    Leliberat: TLabel;
    CNP: TEdit;
    Serie: TEdit;
    Eliberat: TEdit;
    Numar: TEdit;
    Tip: TComboBox;
    IBAN: TMaskEdit;
    Banca: TEdit;
    Nume: TPersonalEdit;
    Discount: TNumEdit;
    CapitalSocial: TNumEdit;
    Statut: TComboBox;
    Ladresa: TLabel;
    Lnr: TLabel;
    Lbl: TLabel;
    Lsc: TLabel;
    Let: TLabel;
    Lap: TLabel;
    Ltara: TLabel;
    Ljudet: TLabel;
    Llocalitate: TLabel;
    Lcod: TLabel;
    Ltel: TLabel;
    Lfax: TLabel;
    Lweb: TLabel;
    Lemail: TLabel;
    Strada: TEdit;
    Adresa: TComboBox;
    Nr: TEdit;
    Bl: TEdit;
    Sc: TEdit;
    Et: TEdit;
    Ap: TEdit;
    Tara: TComboBox;
    Judet: TComboBox;
    Localitate: TEdit;
    Cod: TEdit;
    Tel1: TEdit;
    Tel2: TEdit;
    Tel3: TEdit;
    Fax1: TEdit;
    Fax2: TEdit;
    Fax3: TEdit;
    Web: TEdit;
    Email: TEdit;
    ListaDelegati: TStringGrid;
    Comentariu: TMemo;
    procedure Iesire1Click(Sender: TObject);
    procedure Adaugare1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Salvare2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Modificare1Click(Sender: TObject);
    procedure Stergere1Click(Sender: TObject);
    procedure Deschidere2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NumeChange(Sender: TObject);
    procedure TipClick(Sender: TObject);
    procedure Panel9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    Function VerificareCorectitudine:Boolean;
  public
    { Public declarations }
    Fisier:String;
    Extensie:String;
  end;

Procedure VanzatorNou(Var Vanzator:TVanzator);
Function StrToNumber(s:String;MesajEroare:String):Extended;
Function RedIsFalse(b:Boolean):TColor;
Function IsRedFontComponent(Form:TForm):Boolean;

var
  Furnizor_: TFurnizor_;

implementation

uses _Main_, _Delegat_;

{$R *.DFM}

Const NumeOriginal:String='';

Var   OldMouseX,OldMouseY:Word;
      rect:TRect;

(*procedure TFurnizor_.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  OldMouseX:= X;
  OldMouseY:= Y;
  SetCapture(Handle);
end;

procedure TFurnizor_.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
end;

procedure TFurnizor_.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  If ssLeft In Shift Then
  Begin
    GetWindowRect(Handle,rect);
    SetWindowPos (Handle,HWND_TOPMOST,rect.Left+(X-OldMouseX),rect.Top+(Y-OldMouseY),
                                      rect.Right-rect.Left   ,rect.bottom-rect.Top,0);
  End;
end;  *)

Function RedIsFalse(b:Boolean):TColor;
Begin
  If b Then
    Result:=clBlack
  Else
    Result:=clRed;
End;

Function StrToNumber(s:String;MesajEroare:String):Extended;
Begin
  If s='' Then
    s:='0';
  Try
    Result:=StrToFloat(s);
  Except
    If MesajEroare<>'' Then
      MessageDlg('Valoarea "'+MesajEroare+'" = '+s+' nu este numar!',mtWarning,[mbOk],0);
    Result:=0;
  End;
End;

Function IsRedFontComponent(Form:TForm):Boolean;
Var b:Boolean;
    i:Integer;
Begin
  b:=False;
  For i:=1 To Form.ComponentCount Do
    Begin
      If Form.Components[i-1] Is TLabel      Then
        b:=b Or (TLabel        (Form.Components[i-1]).Font.Color=clRed);
      If Form.Components[i-1] Is TEdit       Then
        b:=b Or (TEdit         (Form.Components[i-1]).Font.Color=clRed);
      If Form.Components[i-1] Is TPersonalEdit Then
        b:=b Or (TPersonalEdit (Form.Components[i-1]).Font.Color=clRed);
      If Form.Components[i-1] Is TNumEdit      Then
        b:=b Or (TNumEdit      (Form.Components[i-1]).Font.Color=clRed);
      If Form.Components[i-1] Is TMaskEdit   Then
        b:=b Or (TMaskEdit     (Form.Components[i-1]).Font.Color=clRed);
      If Form.Components[i-1] Is TComboBox   Then
        b:=b Or (TComboBox     (Form.Components[i-1]).Font.Color=clRed);
      If Form.Components[i-1] Is TStringGrid Then
        b:=b Or (TStringGrid   (Form.Components[i-1]).Font.Color=clRed);
      If Form.Components[i-1] Is TMemo       Then
        b:=b Or (TMemo         (Form.Components[i-1]).Font.Color=clRed);
      If Form.Components[i-1] Is TBitBtn     Then
        b:=b Or (TBitBtn       (Form.Components[i-1]).Font.Color=clRed);
      If Form.Components[i-1] Is TCheckBox   Then
        b:=b Or (TCheckBox     (Form.Components[i-1]).Font.Color=clRed);
    End;
  Result:=b;
End;

Function TFurnizor_.VerificareCorectitudine:Boolean;
Var s:String;
Begin
  s:='';
  If Nume.Text='' Then
    s:=s+#13'     Nume';
  If (IBAN.Text='') Or (IBAN.Text='    -    -    -    -    -    ') Then
    s:=s+#13'     IBAN';
  If Banca.Text='' Then
    s:=s+#13'     Banca';
  If Tip.Items[Tip.ItemIndex]='Persoana Juridica' Then
    Begin
      If Atribut.Text='' Then
        s:=s+#13'     Atribut';
      If CUI.Text='' Then
        s:=s+#13'     CUI';
      If NrRegCom.Text='' Then
        s:=s+#13'     Nr. Reg. Com.';
    End;
  If Tip.Items[Tip.ItemIndex]='Persoana Fizica' Then
    Begin
      If CNP.Text='' Then
        s:=s+#13+'     CNP';
      If Serie.Text='' Then
        s:=s+#13+'     Serie carte de identitate';
      If Numar.Text='' Then
        s:=s+#13+'     Numar carte de identitate';
      If Eliberat.Text='' Then
        s:=s+#13+'     Carte de identitate eliberata de';
    End;
//  If StrToNumber(CapitalSocial.Text,'')=0 Then
//    s:=s+#13'     Capital social';
  If Adresa.Text='' Then
    s:=s+#13'     Adresa';
  If Tara.Text='' Then
    s:=s+#13'     Tara';
  If Judet.Text='' Then
    s:=s+#13'     Judet';
  If Localitate.Text='' Then
    s:=s+#13'     Localitate';
  If s<>'' Then
    If MessageDlg('Este recomandata completarea campurilor:'+s+#13+
                  'Se salveaza fara a se tine cont de avertisment?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
      s:='';
  Result:=s='';  
End;

Procedure VanzatorNou(Var Vanzator:TVanzator);
Var i:Integer;
Begin
  With Vanzator Do
    Begin
      //identitate
      Nume                  :='';
//      IBAN                  :='';
      IBAN                  :='    -    -    -    -    -    ';
      Banca                 :='';
      AtributFiscal         :='';
      CUI                   :='';
      NrRegCom              :='';
      CNP                   :='';
      CISerie               :='';
      CINumar               :='';
      CIEliberatDe          :='';
      CapitalSocial         :=0;
      StatutPartener        :='';
      TipPartener           :='Persoana Juridica';
      DiscountAcordat       :=0;
      //contact
      With Adresa Do
        Begin
          TipStrada         :='';
          NumeStrada        :='';
          NrStrada          :='';
          Bloc              :='';
          Scara             :='';
          Etaj              :='';
          Apartament        :='';
          Tara              :='';
          Judet             :='';
          Localitate        :='';
          CodPostal         :='';
          For i:=1 To 3 Do
            Begin
              Telefon[i]    :='';
              Fax    [i]    :='';
            End;
          AdresaWeb         :='';
          Email             :='';
        End;
      With AgentSocietate Do
        Begin
          Implicit          :=1;
          For i:=1 To 25 Do
            With Agent[i] Do
              Begin
                Nume        :='';
                With CI Do
                  Begin
                    Serie   :='';
                    Numar   :='';
                    Eliberat:='';
                  End;
                CNP         :='';
                Functie     :='';
                Departament :='';
                Telefon     :='';
                Interior    :='';
                Mobil       :='';
                Email       :='';
                Transport   :='';
                NrInmatr    :='';
              End;
            End;
      Comentariu            :='';
    End;
End;

procedure TFurnizor_.Iesire1Click(Sender: TObject);
begin
  Close;
end;

procedure TFurnizor_.Adaugare1Click(Sender: TObject);
Var i,p:Integer;
    b:Boolean;
begin
  If ListaDelegati.RowCount<25 Then
    Begin
      b:=False;
      p:=ListaDelegati.RowCount-1;
      For i:=1 To 13 Do
        If ListaDelegati.Cells[i,p]<>'' Then
          Begin
            b:=True;
            Break;
          End;
      If b Then
        Begin
          ListaDelegati.RowCount:=ListaDelegati.RowCount+1;
          ListaDelegati.Row:=ListaDelegati.RowCount-1;
        End;
      p:=ListaDelegati.Row;
      Delegat_.Nume.Text       :=ListaDelegati.Cells[ 1,p];
      Delegat_.SerieCI.Text    :=ListaDelegati.Cells[ 2,p];
      Delegat_.NrCI.Text       :=ListaDelegati.Cells[ 3,p];
      Delegat_.CIElibDe.Text   :=ListaDelegati.Cells[ 4,p];
      Delegat_.CNP.Text        :=ListaDelegati.Cells[ 5,p];
      Delegat_.Functie.Text    :=ListaDelegati.Cells[ 6,p];
      Delegat_.Departament.Text:=ListaDelegati.Cells[ 7,p];
      Delegat_.Telefon.Text    :=ListaDelegati.Cells[ 8,p];
      Delegat_.Interior.Text   :=ListaDelegati.Cells[ 9,p];
      Delegat_.Mobil.Text      :=ListaDelegati.Cells[10,p];
      Delegat_.Email.Text      :=ListaDelegati.Cells[11,p];
      Delegat_.Transport.Text  :=ListaDelegati.Cells[12,p];
      Delegat_.NrInmatr.Text   :=ListaDelegati.Cells[13,p];
      Delegat_.Caption         :='GesFact - adaugare delegat';
      Delegat_.ShowModal;
    End;
end;

procedure TFurnizor_.FormCreate(Sender: TObject);
Var i:Integer;
begin
  Ppersoanajuridica.Color:=clBtnFace;
  Ppersoanafizica  .Color:=clBtnFace;
  ListaDelegati.Cells[0,0]:='Poz';
  ListaDelegati.Cells[1,0]:='Numele delegatului';
  ListaDelegati.Cells[2,0]:='Serie CI';
  ListaDelegati.Cells[3,0]:='Numar CI';
  ListaDelegati.Cells[4,0]:='CI eliberata de...';
  For i:=1 To 100 Do
    ListaDelegati.Cells[0,i]:=IntToStr(i);
end;

procedure TFurnizor_.Salvare2Click(Sender: TObject);
Var Vanzator:TVanzator;
    f       :File Of TVanzator;
    i:Integer;
begin
  If VerificareCorectitudine Then
    Begin
      //identitate
      Vanzator.Nume                      :=Nume.Text;
      Fisier                             :=Nume.Text;
      Vanzator.IBAN                      :=IBAN.Text;
      Vanzator.Banca                     :=Banca.Text;
      Vanzator.AtributFiscal             :=Atribut.Text;
      Vanzator.CUI                       :=CUI.Text;
      Vanzator.NrRegCom                  :=NrRegCom.Text;
      Vanzator.CNP                       :=CNP.Text;
      Vanzator.CISerie                   :=Serie.Text;
      Vanzator.CINumar                   :=Numar.Text;
      Vanzator.CIEliberatDe              :=Eliberat.Text;
      Vanzator.CapitalSocial             :=StrToNumber(CapitalSocial.Text,'Capital social');
      Vanzator.StatutPartener            :=Statut.Text;
      Vanzator.TipPartener               :=Tip.Text;
      Vanzator.DiscountAcordat           :=StrToNumber(Discount.Text,'Discount acordat');
      //contact
      Vanzator.Adresa.TipStrada          :=Adresa.Text;
      Vanzator.Adresa.NumeStrada         :=Strada.Text;
      Vanzator.Adresa.NrStrada           :=Nr.Text;
      Vanzator.Adresa.Bloc               :=Bl.Text;
      Vanzator.Adresa.Scara              :=Sc.Text;
      Vanzator.Adresa.Etaj               :=Et.Text;
      Vanzator.Adresa.Apartament         :=Ap.Text;
      Vanzator.Adresa.Tara               :=Tara.Text;
      Vanzator.Adresa.Judet              :=Judet.Text;
      Vanzator.Adresa.Localitate         :=Localitate.Text;
      Vanzator.Adresa.CodPostal          :=Cod.Text;
      Vanzator.Adresa.Telefon[1]         :=Tel1.Text;
      Vanzator.Adresa.Telefon[2]         :=Tel2.Text;
      Vanzator.Adresa.Telefon[3]         :=Tel3.Text;
      Vanzator.Adresa.Fax    [1]         :=Fax1.Text;
      Vanzator.Adresa.Fax    [2]         :=Fax2.Text;
      Vanzator.Adresa.Fax    [3]         :=Fax3.Text;
      Vanzator.Adresa.AdresaWeb          :=Web.Text;
      Vanzator.Adresa.Email              :=Email.Text;
      Vanzator.AgentSocietate.Implicit   :=ListaDelegati.Row;
      For i:=1 To 25 Do
        With Vanzator.AgentSocietate.Agent[i] Do
          Begin
            Nume                         :=ListaDelegati.Cells[ 1,i];
            CI.Serie                     :=ListaDelegati.Cells[ 2,i];
            CI.Numar                     :=ListaDelegati.Cells[ 3,i];
            CI.Eliberat                  :=ListaDelegati.Cells[ 4,i];
            CNP                          :=ListaDelegati.Cells[ 5,i];
            Functie                      :=ListaDelegati.Cells[ 6,i];
            Departament                  :=ListaDelegati.Cells[ 7,i];
            Telefon                      :=ListaDelegati.Cells[ 8,i];
            Interior                     :=ListaDelegati.Cells[ 9,i];
            Mobil                        :=ListaDelegati.Cells[10,i];
            Email                        :=ListaDelegati.Cells[11,i];
            Transport                    :=ListaDelegati.Cells[12,i];
            NrInmatr                     :=ListaDelegati.Cells[13,i];
          End;
      Vanzator.Comentariu                :=Comentariu.Text;
      If Extensie=ExtVNZ Then
        Begin
          If NumeOriginal<>Vanzator.Nume Then
            DeleteFile(dirEXE+dirVNZ+NumeOriginal+'.'+Extensie);
          AssignFile(f,dirEXE+dirVNZ+UpperCase(Vanzator.Nume)+'.'+Extensie);
        End;
      If Extensie=ExtCMP Then
        Begin
          If NumeOriginal<>Vanzator.Nume Then
            DeleteFile(dirEXE+dirCMP+NumeOriginal+'.'+Extensie);
          AssignFile(f,dirEXE+dirCMP+UpperCase(Vanzator.Nume)+'.'+Extensie);
        End;
      Rewrite   (f);
      Write     (f,Vanzator);
      CloseFile (f);
      Salvare1.Enabled:=False;
      Salvare2.Enabled:=False;
    End;
  NumeChange(Sender);
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TFurnizor_.FormActivate(Sender: TObject);
begin
  TabbedNoteBook1.ActivePage:='Identitate';
  Deschidere2Click(Sender);
  Nume.SetFocus;
  Shake(Furnizor_,Main_.ShakeIt.Checked);
end;

procedure TFurnizor_.Modificare1Click(Sender: TObject);
begin
  Delegat_.Deschidere2Click(Sender);
  Delegat_.Caption         :='GesFact - modificare delegat';
  Delegat_.ShowModal;
end;

procedure TFurnizor_.Stergere1Click(Sender: TObject);
Var s:String;
    i,j,p:Integer;
begin
  p:=ListaDelegati.Row;
  s:=ListaDelegati.Cells[1,p];
  If (p<>-1) And (s<>'') Then
    If MessageDlg('Sterg delegatul "'+s+'"?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
      Begin
        For i:=ListaDelegati.Row To ListaDelegati.RowCount Do
          For j:=1 To 13 Do
            Begin
              ListaDelegati.Cells[j,i]  :=ListaDelegati.Cells[j,i+1];
              ListaDelegati.Cells[j,i+1]:='';
            End;
          If ListaDelegati.RowCount>2 Then
            ListaDelegati.RowCount:=ListaDelegati.RowCount-1;
          If p<ListaDelegati.RowCount Then
            ListaDelegati.Row:=p
          Else
            ListaDelegati.Row:=p-1;
      End;
  NumeChange(Sender);
end;

procedure TFurnizor_.Deschidere2Click(Sender: TObject);
Var Vanzator:TVanzator;
    f       :File Of TVanzator;
    i,j     :Integer;
    dir     :String;
begin
  //citire fisier
  If Extensie=ExtVNZ Then
    dir:=dirVNZ;
  If Extensie=ExtCMP Then
    dir:=dirCMP;
  If FileExists(dirEXE+dir+Fisier+'.'+Extensie) Then
    Begin
      AssignFile(f,dirEXE+dir+Fisier+'.'+Extensie);
      Reset     (f);
      Read      (f,Vanzator);
      CloseFile (f);
    End
  Else
    VanzatorNou(Vanzator);
  //identitate
  Nume.Text                          :=Vanzator.Nume;
  NumeOriginal (*pentru salvare ca*) :=Vanzator.Nume;
  IBAN.Text                          :=Vanzator.IBAN;
  Banca.Text                         :=Vanzator.Banca;
  Atribut.Text                       :=Vanzator.AtributFiscal;
  CUI.Text                           :=Vanzator.CUI;
  NrRegCom.Text                      :=Vanzator.NrRegCom;
  CNP.Text                           :=Vanzator.CNP;
  Serie.Text                         :=Vanzator.CISerie;
  Numar.Text                         :=Vanzator.CINumar;
  Eliberat.Text                      :=Vanzator.CIEliberatDe;
  CapitalSocial.Text                 :=FloatToStr(Vanzator.CapitalSocial);
  Statut.Text                        :=Vanzator.StatutPartener;
  If Vanzator.TipPartener='Persoana Juridica' Then
    Tip.ItemIndex                    :=0;// Persoana Juridica
  If Vanzator.TipPartener='Persoana Fizica' Then
    Tip.ItemIndex                    :=1;// Persoana Fizica
  TipClick(Sender);
  Discount.Text                      :=FloatToStr(Vanzator.DiscountAcordat);
  //contact
  Adresa.Text                        :=Vanzator.Adresa.TipStrada;
  Strada.Text                        :=Vanzator.Adresa.NumeStrada;
  Nr.Text                            :=Vanzator.Adresa.NrStrada;
  Bl.Text                            :=Vanzator.Adresa.Bloc;
  Sc.Text                            :=Vanzator.Adresa.Scara;
  Et.Text                            :=Vanzator.Adresa.Etaj;
  Ap.Text                            :=Vanzator.Adresa.Apartament;
  Tara.Text                          :=Vanzator.Adresa.Tara;
  Judet.Text                         :=Vanzator.Adresa.Judet;
  Localitate.Text                    :=Vanzator.Adresa.Localitate;
  Cod.Text                           :=Vanzator.Adresa.CodPostal;
  Tel1.Text                          :=Vanzator.Adresa.Telefon[1];
  Tel2.Text                          :=Vanzator.Adresa.Telefon[2];
  Tel3.Text                          :=Vanzator.Adresa.Telefon[3];
  Fax1.Text                          :=Vanzator.Adresa.Fax[1];
  Fax2.Text                          :=Vanzator.Adresa.Fax[2];
  Fax3.Text                          :=Vanzator.Adresa.Fax[3];
  Web.Text                           :=Vanzator.Adresa.AdresaWeb;
  Email.Text                         :=Vanzator.Adresa.Email;
  ListaDelegati.RowCount:=2;
  For i:=1 To 25 Do
    With Vanzator.AgentSocietate.Agent[i] Do
      Begin
        For j:=1 To 13 Do
          ListaDelegati.Cells[j,i]     :='';
        ListaDelegati.Cells  [ 1,i]    :=Nume;
        ListaDelegati.Cells  [ 2,i]    :=CI.Serie;
        ListaDelegati.Cells  [ 3,i]    :=CI.Numar;
        ListaDelegati.Cells  [ 4,i]    :=CI.Eliberat;
        ListaDelegati.Cells  [ 5,i]    :=CNP;
        ListaDelegati.Cells  [ 6,i]    :=Functie;
        ListaDelegati.Cells  [ 7,i]    :=Departament;
        ListaDelegati.Cells  [ 8,i]    :=Telefon;
        ListaDelegati.Cells  [ 9,i]    :=Interior;
        ListaDelegati.Cells  [10,i]    :=Mobil;
        ListaDelegati.Cells  [11,i]    :=Email;
        ListaDelegati.Cells  [12,i]    :=Transport;
        ListaDelegati.Cells  [13,i]    :=NrInmatr;
        If (Nume+CI.Serie+CI.Numar+CI.Eliberat+CNP+Functie+Departament+
            Telefon+Interior+Mobil+Email+Transport+NrInmatr)<>'' Then
          ListaDelegati.RowCount:=i+1;
      End;
  ListaDelegati.Row                  :=Vanzator.AgentSocietate.Implicit;
  Comentariu.Text                    :=Vanzator.Comentariu;
  NumeChange(Sender);
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TFurnizor_.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Main_.RefreshListe;
end;

procedure TFurnizor_.NumeChange(Sender: TObject);
Var Vanzator:TVanzator;
    f       :File Of TVanzator;
    i       :Integer;
    b       :Boolean;
    DIR     :String;
begin
  //citire fisier
  If Extensie=ExtVNZ Then
    dir:=dirVNZ;
  If Extensie=ExtCMP Then
    dir:=dirCMP;
  If FileExists(dirEXE+dir+Fisier+'.'+Extensie) Then
    Begin
      AssignFile(f,dirEXE+dir+Fisier+'.'+Extensie);
      Reset     (f);
      Read      (f,Vanzator);
      CloseFile (f);
    End
  Else
    VanzatorNou(Vanzator);
  //identitate
  Nume         .Font.Color:=RedIsFalse(Nume.Text                          =Vanzator.Nume);
   LNume         .Font.Color:=Nume.Font.Color;
  IBAN         .Font.Color:=RedIsFalse(IBAN.Text                          =Vanzator.IBAN);
   LIBAN         .Font.Color:=IBAN.Font.Color;
  Banca        .Font.Color:=RedIsFalse(Banca.Text                         =Vanzator.Banca);
   LBanca        .Font.Color:=Banca.Font.Color;
  Atribut      .Font.Color:=RedIsFalse(Atribut.Text                       =Vanzator.AtributFiscal);
   LAtribut      .Font.Color:=Atribut      .Font.Color;
  CUI          .Font.Color:=RedIsFalse(CUI.Text                           =Vanzator.CUI);
   LCUI          .Font.Color:=CUI          .Font.Color;
  NrRegCom     .Font.Color:=RedIsFalse(NrRegCom.Text                      =Vanzator.NrRegCom);
   LNrRegCom     .Font.Color:=NrRegCom     .Font.Color;
  CNP          .Font.Color:=RedIsFalse(CNP.Text                           =Vanzator.CNP);
   LCNP          .Font.Color:=CNP          .Font.Color;
  Serie      .Font.Color:=RedIsFalse(Serie.Text                         =Vanzator.CISerie);
  Numar      .Font.Color:=RedIsFalse(Numar.Text                         =Vanzator.CINumar);
   LSerie      .Font.Color:=RedIsFalse((Serie.Text=Vanzator.CISerie) And (Numar.Text=Vanzator.CINumar));
  Eliberat   .Font.Color:=RedIsFalse(Eliberat.Text                      =Vanzator.CIEliberatDe);
   LEliberat   .Font.Color:=Eliberat.Font.Color;
  CapitalSocial.Font.Color:=RedIsFalse(CapitalSocial.Text                 =FloatToStr(Vanzator.CapitalSocial));
   LCapitalSocial.Font.Color:=CapitalSocial.Font.Color;
  Statut       .Font.Color:=RedIsFalse(Statut.Text                        =Vanzator.StatutPartener);
   LStatut       .Font.Color:=Statut       .Font.Color;
  Tip          .Font.Color:=RedIsFalse(Tip.Text                           =Vanzator.TipPartener);
   LTip          .Font.Color:=Tip          .Font.Color;
  Discount     .Font.Color:=RedIsFalse(Discount.Text                      =FloatToStr(Vanzator.DiscountAcordat));
   LDiscount     .Font.Color:=Discount     .Font.Color;
  //contact
  Adresa       .Font.Color:=RedIsFalse(Adresa.Text                        =Vanzator.Adresa.TipStrada);
  Strada       .Font.Color:=RedIsFalse(Strada.Text                        =Vanzator.Adresa.NumeStrada);
   LAdresa       .Font.Color:=RedIsFalse((Adresa.Font.Color<>clRed) And (Strada.Font.Color<>clRed));
  Nr           .Font.Color:=RedIsFalse(Nr.Text                            =Vanzator.Adresa.NrStrada);
   LNr           .Font.Color:=Nr           .Font.Color;
  Bl           .Font.Color:=RedIsFalse(Bl.Text                            =Vanzator.Adresa.Bloc);
   LBl           .Font.Color:=Bl           .Font.Color;
  Sc           .Font.Color:=RedIsFalse(Sc.Text                            =Vanzator.Adresa.Scara);
   LSc           .Font.Color:=Sc           .Font.Color;
  Et           .Font.Color:=RedIsFalse(Et.Text                            =Vanzator.Adresa.Etaj);
   LEt           .Font.Color:=Et           .Font.Color;
  Ap           .Font.Color:=RedIsFalse(Ap.Text                            =Vanzator.Adresa.Apartament);
   LAp           .Font.Color:=Ap           .Font.Color;
  Tara         .Font.Color:=RedIsFalse(Tara.Text                          =Vanzator.Adresa.Tara);
   LTara         .Font.Color:=Tara         .Font.Color;
  Judet        .Font.Color:=RedIsFalse(Judet.Text                         =Vanzator.Adresa.Judet);
   LJudet        .Font.Color:=Judet        .Font.Color;
  Localitate   .Font.Color:=RedIsFalse(Localitate.Text                    =Vanzator.Adresa.Localitate);
   LLocalitate   .Font.Color:=Localitate   .Font.Color;
  Cod          .Font.Color:=RedIsFalse(Cod.Text                           =Vanzator.Adresa.CodPostal);
   LCod          .Font.Color:=Cod          .Font.Color;
  Tel1         .Font.Color:=RedIsFalse(Tel1.Text                          =Vanzator.Adresa.Telefon[1]);
  Tel2         .Font.Color:=RedIsFalse(Tel2.Text                          =Vanzator.Adresa.Telefon[2]);
  Tel3         .Font.Color:=RedIsFalse(Tel3.Text                          =Vanzator.Adresa.Telefon[3]);
   Ltel          .Font.Color:=RedIsFalse((Tel1.Font.Color<>clRed) And
                                         (Tel2.Font.Color<>clRed) And
                                         (Tel3.Font.Color<>clRed));
  Fax1         .Font.Color:=RedIsFalse(Fax1.Text                          =Vanzator.Adresa.Fax[1]);
  Fax2         .Font.Color:=RedIsFalse(Fax2.Text                          =Vanzator.Adresa.Fax[2]);
  Fax3         .Font.Color:=RedIsFalse(Fax3.Text                          =Vanzator.Adresa.Fax[3]);
   Lfax          .Font.Color:=RedIsFalse((Fax1.Font.Color<>clRed) And
                                         (Fax2.Font.Color<>clRed) And
                                         (Fax3.Font.Color<>clRed));
  Web          .Font.Color:=RedIsFalse(Web.Text                           =Vanzator.Adresa.AdresaWeb);
   LWeb          .Font.Color:=Web          .Font.Color;
  Email        .Font.Color:=RedIsFalse(Email.Text                         =Vanzator.Adresa.Email);
   LEmail        .Font.Color:=Email        .Font.Color;
  b:=True;
  For i:=1 To 25 Do
    With Vanzator.AgentSocietate.Agent[i] Do
      Begin
        If (ListaDelegati.Cells[ 1,i]   <>Nume       ) Or
           (ListaDelegati.Cells[ 2,i]   <>CI.Serie   ) Or
           (ListaDelegati.Cells[ 3,i]   <>CI.Numar   ) Or
           (ListaDelegati.Cells[ 4,i]   <>CI.Eliberat) Or
           (ListaDelegati.Cells[ 5,i]   <>CNP        ) Or
           (ListaDelegati.Cells[ 6,i]   <>Functie    ) Or
           (ListaDelegati.Cells[ 7,i]   <>Departament) Or
           (ListaDelegati.Cells[ 8,i]   <>Telefon    ) Or
           (ListaDelegati.Cells[ 9,i]   <>Interior   ) Or
           (ListaDelegati.Cells[10,i]   <>Mobil      ) Or
           (ListaDelegati.Cells[11,i]   <>Email      ) Or
           (ListaDelegati.Cells[12,i]   <>Transport  ) Or
           (ListaDelegati.Cells[13,i]   <>NrInmatr   ) Then
          Begin
            b:=False;
            Break;
          End;
      End;
  b:=b And (ListaDelegati.Row=Vanzator.AgentSocietate.Implicit);
  ListaDelegati.Font.Color:=RedIsFalse(b);
  Comentariu   .Font.Color:=RedIsFalse(Comentariu.Text                    =Vanzator.Comentariu);
  Salvare1.Enabled:=IsRedFontComponent(Furnizor_) And (Nume.Text<>'') And (Tip.ItemIndex<>-1);
  Salvare2.Enabled:=Salvare1.Enabled;
end;

procedure TFurnizor_.TipClick(Sender: TObject);
begin
  Ppersoanajuridica.Visible:=Tip.Items[Tip.ItemIndex]='Persoana Juridica';
  Ppersoanafizica  .Visible:=Tip.Items[Tip.ItemIndex]='Persoana Fizica';
  NumeChange(Sender);
end;

procedure TFurnizor_.Panel9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  OldMouseX:= X;
  OldMouseY:= Y;
  SetCapture(Handle);
end;

procedure TFurnizor_.Panel9MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  If ssLeft In Shift Then
  Begin
    GetWindowRect(Handle,rect);
    SetWindowPos (Handle,HWND_TOPMOST,rect.Left+(X-OldMouseX),rect.Top+(Y-OldMouseY),
                                      rect.Right-rect.Left   ,rect.bottom-rect.Top,0);
  End;
end;

procedure TFurnizor_.Panel9MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
end;

end.

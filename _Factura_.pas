unit _Factura_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Buttons, ToolWin, Menus, Grids, StdCtrls, Mask,
  FileCtrl, Printers, _Numedit_, _Furnizor_, _PersonalEdit_;

type
  TFactura_ = class(TForm)
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    ListaProduse: TStringGrid;
    GroupBox4: TGroupBox;
    DataFactura: TMaskEdit;
    Laviz: TLabel;
    Aviz: TEdit;
    GroupBox5: TGroupBox;
    Achitat: TComboBox;
    Scadenta: TCheckBox;
    Lzilescadenta: TLabel;
    Lachitat: TLabel;
    Ldiscount1: TLabel;
    Ldiscount2: TLabel;
    Penalizare: TCheckBox;
    Lprocentpenalizare: TLabel;
    GroupBox6: TGroupBox;
    MainMenu1: TMainMenu;
    Fisier1: TMenuItem;
    Deschidere1: TMenuItem;
    Salvare1: TMenuItem;
    N1: TMenuItem;
    Iesire1: TMenuItem;
    ProcentPenalizare: TNumEdit;
    Discount: TNumEdit;
    ZileScadenta: TNumEdit;
    Ltva: TLabel;
    Ldelegat: TLabel;
    Delegat: TComboBox;
    PopupMenu1: TPopupMenu;
    Adaugare1: TMenuItem;
    Modificare1: TMenuItem;
    Stergere1: TMenuItem;
    ListaVanzatori: TBitBtn;
    ListaCumparatori: TBitBtn;
    N2: TMenuItem;
    Tiparire1: TMenuItem;
    Llivrare: TLabel;
    Livrare: TMaskEdit;
    Achitata: TCheckBox;
    TVA: TComboBox;
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
    NumarFactura: TPersonalEdit;
    procedure Iesire1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScadentaClick(Sender: TObject);
    procedure PenalizareClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Salvare2Click(Sender: TObject);
    procedure Deschidere2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ListaVanzatoriClick(Sender: TObject);
    procedure ListaCumparatoriClick(Sender: TObject);
    procedure TVAChange(Sender: TObject);
    procedure NumarFacturaChange(Sender: TObject);
    procedure DataFacturaChange(Sender: TObject);
    procedure AvizChange(Sender: TObject);
    procedure DelegatChange(Sender: TObject);
    procedure AchitatChange(Sender: TObject);
    procedure ZileScadentaChange(Sender: TObject);
    procedure DiscountChange(Sender: TObject);
    procedure ProcentPenalizareChange(Sender: TObject);
    procedure Adaugare1Click(Sender: TObject);
    procedure Modificare1Click(Sender: TObject);
    procedure Stergere1Click(Sender: TObject);
    procedure Tiparire2Click(Sender: TObject);
    procedure LivrareChange(Sender: TObject);
    procedure AchitataClick(Sender: TObject);
  private
    { Private declarations }
    Function  VerificareCorectitudine:Boolean;
    Procedure VerificareSalvare;
  public
    { Public declarations }
    Fisier:String;
    Extensie:String;
    Procedure TiparireFactura(Factura:TFactura);
  end;

var
  Factura_: TFactura_;

implementation

uses _Main_, _Produs_, _Alegere_, _Adaugare_, _Delegat_, _Vizualizare_;

{$R *.DFM}

Const NumeOriginal:String='';

Var TempFactura         :TFactura;
    MaximCaractereRaport:Integer;

Procedure SetareHint(buton:TBitBtn;furnizor:TVanzator);
Begin
  With furnizor Do
    Begin
      If TipPartener  ='Persoana Juridica' Then
        buton.Hint   :='Nr.Reg.Com.:'+NrRegCom     +#13+
                       'Cod fiscal: '+AtributFiscal
                                     +CUI          +#13+
                       'Adresa:     '+Adresa.TipStrada+' '+
                                      Adresa.NumeStrada+' '+
                                      Adresa.NrStrada+#13+
                       'IBAN:       '+IBAN         +#13+
                       'Banca:      '+Banca
      Else
        buton.Hint   :='CNP:        '+CNP          +#13+
                       'Carte id.:  '+CISerie
                                     +CINumar+' elib.de '
                                     +CIEliberatDe+#13+
                       'Adresa:     '+Adresa.TipStrada+' '+
                                      Adresa.NumeStrada+' '+
                                      Adresa.NrStrada+#13+
                       'IBAN:       '+IBAN         +#13+
                       'Banca:      '+Banca;
  End;
End;

Function FaraExtensie(s,e:String):String;
Begin
  Delete(s,Length(s)-Length(e)+1,Length(e));
  Result:=s;
End;

Procedure FacturaNoua(Var Factura:TFactura);
Var i:Integer;
Begin
  VanzatorNou(Factura.Vanzator);
  Factura.ValoareTVA :=19;
  Factura.Achitata   :=False;
  Factura.NrFactura  :='';
  Factura.Data       :='';
  Factura.Aviz       :='';
  VanzatorNou(Factura.Cumparator);
  For i:=1 To 50 Do
    ProdusNou(Factura.Produs[i]);
  Factura.Achitat    :='';
  Factura.Scadenta   :=0;
  Factura.Discount   :=0;
  Factura.Penalizare :=0;
  Factura.DataLivrare:='';
End;

Procedure TFactura_.TiparireFactura(Factura:TFactura);
Var i,k                  :Integer;
    TotalValoare,TotalTVA:Extended;
    s,s1,s2              :String;
    TempCapitalSocial    :String;
    TempTVA              :String;
Begin
  Vizualizare_.Fisier:=Factura.NrFactura;
  Vizualizare_.Container.Clear;
//   ---   VANZATOR
  With Factura Do
    Begin
      If Vanzator.Nume               ='' Then Vanzator.Nume               :='__________';
      If Vanzator.NrRegCom           ='' Then Vanzator.NrRegCom           :='__________';
      If Vanzator.AtributFiscal      ='' Then Vanzator.AtributFiscal      :='____';
      If Vanzator.CUI                ='' Then Vanzator.CUI                :='________';
      If Vanzator.CNP                ='' Then Vanzator.CNP                :='__________';
      If Vanzator.CISerie            ='' Then Vanzator.CISerie            :='____';
      If Vanzator.CINumar            ='' Then Vanzator.CINumar            :='__________';
      If Vanzator.CIEliberatDe       ='' Then Vanzator.CIEliberatDe       :='__________';
      If Vanzator.Adresa.Judet       ='' Then Vanzator.Adresa.Judet       :='__________';
      If Vanzator.Adresa.Localitate  ='' Then Vanzator.Adresa.Localitate  :='__________';
      If Vanzator.Adresa.TipStrada   ='' Then Vanzator.Adresa.TipStrada   :='____';
      If Vanzator.Adresa.NumeStrada  ='' Then Vanzator.Adresa.NumeStrada  :='__________';
      If Vanzator.Adresa.NrStrada    ='' Then Vanzator.Adresa.NrStrada    :='____';
      If Vanzator.IBAN               ='' Then Vanzator.IBAN               :='__________';
      If Vanzator.Banca              ='' Then Vanzator.Banca              :='__________';
      If Vanzator.CapitalSocial      =0  Then TempCapitalSocial           :='__________'
                                         Else TempCapitalSocial           :=FloatToStrF(Vanzator.CapitalSocial,ffFixed,16,2);
      If ValoareTVA                  =0  Then TempTVA                     :='scutit'
                                         Else TempTVA                     :=FloatToStrF(ValoareTVA            ,ffFixed,16,2)+' %';
      If NrFactura                   ='' Then Nrfactura                   :='__________';
      If Data                        ='' Then Data                        :='__.__.____';
      If Aviz                        ='' Then Aviz                        :='__________';
      If Cumparator.Nume             ='' Then Cumparator.Nume             :='__________';
      If Cumparator.NrRegCom         ='' Then Cumparator.NrRegCom         :='__________';
      If Cumparator.AtributFiscal    ='' Then Cumparator.AtributFiscal    :='____';
      If Cumparator.CUI              ='' Then Cumparator.CUI              :='________';
      If Cumparator.CNP              ='' Then Cumparator.CNP              :='__________';
      If Cumparator.CISerie          ='' Then Cumparator.CISerie          :='____';
      If Cumparator.CINumar          ='' Then Cumparator.CINumar          :='__________';
      If Cumparator.CIEliberatDe     ='' Then Cumparator.CIEliberatDe     :='__________';
      If Cumparator.Adresa.Judet     ='' Then Cumparator.Adresa.Judet     :='__________';
      If Cumparator.Adresa.Localitate='' Then Cumparator.Adresa.Localitate:='__________';
      If Cumparator.Adresa.TipStrada ='' Then Cumparator.Adresa.TipStrada :='____';
      If Cumparator.Adresa.NumeStrada='' Then Cumparator.Adresa.NumeStrada:='__________';
      If Cumparator.Adresa.NrStrada  ='' Then Cumparator.Adresa.NrStrada  :='____';
      If Cumparator.IBAN             ='' Then Cumparator.IBAN             :='__________';
      If Cumparator.Banca            ='' Then Cumparator.Banca            :='__________';
      If Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].Nume
                                     ='' Then Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].Nume       :='__________';
      If Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].CI.Serie
                                     ='' Then Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].CI.Serie   :='____';
      If Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].CI.Numar
                                     ='' Then Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].CI.Numar   :='__________';
      If Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].CI.Eliberat
                                     ='' Then Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].CI.Eliberat:='__________';
      If Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].Transport
                                     ='' Then Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].Transport   :='__________';
      If Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].NrInmatr
                                     ='' Then Cumparator.AgentSocietate.Agent[Cumparator.AgentSocietate.Implicit].NrInmatr    :='__________';
      If DataLivrare                 ='' Then DataLivrare                 :='__________';
    End;
///
  s1:=AddSpace('Vanzator    '+Factura.Vanzator.Nume    ,46,False);
  s2:='Cumparator  '+Factura.Cumparator.Nume;
  Vizualizare_.Container.Lines.Add(s1+AddSpace(' '     ,25,False)+s2);
  If Factura.Vanzator.TipPartener='Persoana Juridica' Then
    s1:=AddSpace('Nr.Reg.Com. '+Factura.Vanzator.NrRegCom,46,False);
  If Factura.Vanzator.TipPartener='Persoana Fizica' Then
    s1:=AddSpace('Carte id.   '+Factura.Vanzator.CISerie+Factura.Vanzator.CINumar+' elib.de '+Factura.Vanzator.CIEliberatDe,46,False);
  If Factura.Cumparator.TipPartener='Persoana Juridica' Then
    s2:=AddSpace('Nr.Reg.Com. '+Factura.Cumparator.NrRegCom,46,False);
  If Factura.Cumparator.TipPartener='Persoana Fizica' Then
    s2:=AddSpace('Carte id.   '+Factura.Cumparator.CISerie+Factura.Cumparator.CINumar+' elib.de '+Factura.Cumparator.CIEliberatDe,46,False);
  Vizualizare_.Container.Lines.Add(s1+'        FACTURA          '+s2);
  If Factura.Vanzator.TipPartener='Persoana Juridica' Then
    s1:=AddSpace('Cod fiscal  '+Factura.Vanzator.AtributFiscal+Factura.Vanzator.CUI,46,False);
  If Factura.Vanzator.TipPartener='Persoana Fizica' Then
    s1:=AddSpace('CNP         '+Factura.Vanzator.CNP,46,False);
  If Factura.Cumparator.TipPartener='Persoana Juridica' Then
    s2:=AddSpace('Cod fiscal  '+Factura.Cumparator.AtributFiscal+Factura.Cumparator.CUI,46,False);
  If Factura.Cumparator.TipPartener='Persoana Fizica' Then
    s2:=AddSpace('CNP         '+Factura.Cumparator.CNP,46,False);
  Vizualizare_.Container.Lines.Add(s1+AddSpace(' '      ,25,False)+s2);
  s1:=AddSpace('Adresa      '+'jud.'+Factura.Vanzator.Adresa.Judet+', '+Factura.Vanzator.Adresa.Localitate,46,False);
  s2:='Adresa      '+'jud.'+Factura.Cumparator.Adresa.Judet+', '+Factura.Cumparator.Adresa.Localitate;
  Vizualizare_.Container.Lines.Add(s1+'|---------------------|  '+s2);
  s1:=AddSpace('            '+Factura.Vanzator.Adresa.TipStrada+' '+Factura.Vanzator.Adresa.NumeStrada+' '+Factura.Vanzator.Adresa.NrStrada,46,False);
  s2:=Factura.Cumparator.Adresa.TipStrada+' '+Factura.Cumparator.Adresa.NumeStrada+' '+Factura.Cumparator.Adresa.NrStrada;
  Vizualizare_.Container.Lines.Add(s1+'|Nr.factura '+AddSpace(Factura.NrFactura,10,True)+'|  '+'            '+s2);
  s1:=AddSpace('Cont        '+Factura.Vanzator.IBAN,46,False);
  s2:='Cont        '+Factura.Cumparator.IBAN;
  Vizualizare_.Container.Lines.Add(s1+'|Data fact. '+AddSpace(Factura.Data     ,10,True)+'|  '+s2);
  s1:=AddSpace('Banca       '+Factura.Vanzator.Banca,46,False);
  s2:='Banca       '+Factura.Cumparator.Banca;
  Vizualizare_.Container.Lines.Add(s1+'|Nr.aviz    '+AddSpace(Factura.Aviz    ,10,True)+'|  '+s2);
  s1:=AddSpace('Cap.social  '+TempCapitalSocial,46,False);
  Vizualizare_.Container.Lines.Add(s1+'|---------------------|');
  Vizualizare_.Container.Lines.Add('T.V.A.      '+TempTVA);
//   ---   PRODUSE
  Vizualizare_.Container.Lines.Add('');
  Vizualizare_.Container.Lines.Add('|-------------------------------------------------------------------------------------------------------------------|');
  Vizualizare_.Container.Lines.Add('| Nr. | Denumirea produselor                        | U.M.  | Cantitate   | Pret unitar | Valoare     | Valoare     |');
  Vizualizare_.Container.Lines.Add('| crt.| sau a serviciilor                           |       |             | fara T.V.A. | fara T.V.A. | T.V.A.      |');
  Vizualizare_.Container.Lines.Add('|-----|---------------------------------------------|-------|-------------|-------------|-------------|-------------|');
  s1:=AddSpace('6=5x'+FloatToStrF(Factura.ValoareTVA,ffFixed,16,0)+'%',8,True);
  Vizualizare_.Container.Lines.Add('|  0  |                       1                     |   2   |      3      |      4      |    5=3x4    |  '+ s1 +'   |');
  Vizualizare_.Container.Lines.Add('|-----|---------------------------------------------|-------|-------------|-------------|-------------|-------------|');
  k:=0;
  TotalValoare:=0;
  TotalTVA    :=0;
  For i:=1 To 50 Do
    Begin
      If Factura.Produs[i].Denumire<>'' Then
        Begin
          Inc(k);
          TotalValoare:=TotalValoare+Factura.Produs[i].Cantitate*Factura.Produs[i].Pret;
          TotalTVA    :=TotalTVA    +Factura.Produs[i].Cantitate*Factura.Produs[i].Pret*Factura.ValoareTVA/100;
          Vizualizare_.Container.Lines.Add('| '+AddSpace(IntToStr(k),3,True)                                            +' | '+
                                                AddSpace(            Factura.Produs[i].Denumire               ,43,False)+' | '+
                                                AddSpace(            Factura.Produs[i].UM                     , 5,False)+' | '+
                                                AddSpace(FloatToStrF(Factura.Produs[i].Cantitate,ffFixed,16,2),11,True) +' | '+
                                                AddSpace(FloatToStrF(Factura.Produs[i].Pret     ,ffFixed,16,2),11,True) +' | '+
                                                AddSpace(FloatToStrF(Factura.Produs[i].Cantitate*
                                                                     Factura.Produs[i].Pret     ,ffFixed,16,2),11,True) +' | '+
                                                AddSpace(FloatToStrF(Factura.Produs[i].Cantitate*
                                                                     Factura.Produs[i].Pret     *
                                                                     Factura.ValoareTVA/100     ,ffFixed,16,2),11,True) +' |');
        End;
    End;
//   ---   DISCOUNT     
  If (Factura.Discount<>0) Then
    Begin
      Vizualizare_.Container.Lines.Add('|     |                                             |       |             |             |             |             |');
      Vizualizare_.Container.Lines.Add('|     | DISCOUNT '+AddSpace(FloatToStrF(Factura.Discount,ffFixed,16,2),10,True)+
                                                                  ' %                       |       |             |             | '+
                                                           AddSpace(FloatToStrF(-TotalValoare*Factura.Discount/100,ffFixed,16,2),11,True)+' | '+
                                                           AddSpace(FloatToStrF(-TotalTVA    *Factura.Discount/100,ffFixed,16,2),11,True)+' |');
      TotalValoare:=TotalValoare-TotalValoare*Factura.Discount/100;
      TotalTVA    :=TotalTVA    -TotalTVA    *Factura.Discount/100;
      k:=k+2;
    End;
//   ---   MODALITATE PLATA
  s:='';
  If Factura.Achitat<>'' Then
    s:=s+Factura.Achitat;
  If Factura.Scadenta<>0 Then
    s:=s+' Scadenta la '+FloatToStrF(Factura.Scadenta,ffFixed,16,0)+' zile.';
//  If Factura.Discount<>0 Then
//    s:=s+' Discount '+FloatToStrF(Factura.Discount,ffFixed,16,2)+' %.';
  If Factura.Penalizare<>0 Then
    s:=s+' Penalizare '+FloatToStrF(Factura.Penalizare,ffFixed,16,2)+' % pe zi de intarziere.';
  If s<>'' Then
    k:=k+4;
  For i:=1 To MaximCaractereRaport-k do
    Vizualizare_.Container.Lines.Add('|     |                                             |       |             |             |             |             |');
  If s<>'' Then
    Begin
      Vizualizare_.Container.Lines.Add('|-------------------------------------------------------------------------------------------------------------------|');
      Vizualizare_.Container.Lines.Add('|                                                                                                                   |');
      Vizualizare_.Container.Lines.Add('| '+AddSpace(s,117-4,False)+' |');
      Vizualizare_.Container.Lines.Add('|                                                                                                                   |');
      Vizualizare_.Container.Lines.Add('|-------------------------------------------------------------------------------------------------------------------|');
    End
  Else
    Vizualizare_.Container.Lines.Add('|-------------------------------------------------------------------------|-------------|-------------|-------------|');
//   ---   TOTAL
  Vizualizare_.Container.Lines.Add('| Semnatura si | '+AddSpace('Date privind expeditia:'             ,56,False)+' | '+
                                                       AddSpace('Total'                               ,11,False)+' | '+
                                                       AddSpace(FloatToStrF(TotalValoare,ffFixed,16,2),11,True )+' | '+
                                                       AddSpace(FloatToStrF(TotalTVA    ,ffFixed,16,2),11,True )+' |');
  With Factura.Cumparator.AgentSocietate.Agent[Factura.Cumparator.AgentSocietate.Implicit] Do
    Begin
      Vizualizare_.Container.Lines.Add('| stampila     | '+AddSpace('Nume delegat     '+Nume,56,False)       +' | din care    |-------------|-------------|');
      Vizualizare_.Container.Lines.Add('| furnizorului | '+AddSpace('Carte identitate '+CI.Serie+CI.Numar+', elib.de '+CI.Eliberat,56,False)+
                                                                                                              ' | accize      |             |        X    |');
      Vizualizare_.Container.Lines.Add('|              | '+AddSpace('Mijloc transport '+Transport+' cu nr.inmatr. '+NrInmatr,56,False)+
                                                                                                              ' |-------------|---------------------------|');
      Vizualizare_.Container.Lines.Add('|              | Expedierea s-a facut in prezenta noastra la data de  '+
                                                                                                         '    | Semnatura   | Total                     |');
      Vizualizare_.Container.Lines.Add('|              |                  '+AddSpace(Factura.DataLivrare,39,False)            +' | de primire  | de plata'+AddSpace(FloatToStrF(TotalValoare+TotalTVA,ffFixed,16,2),17,True)+' |');
      Vizualizare_.Container.Lines.Add('|              | Semnaturile                                              |             |                           |');
      Vizualizare_.Container.Lines.Add('|              |                                                          |             |                           |');
    End;
  Vizualizare_.Container.Lines.Add('|-------------------------------------------------------------------------------------------------------------------|');
  If Main_.EditatInformatic.Text<>'' Then
    Vizualizare_.Container.Lines.Add(AddSpace(Main_.EditatInformatic.Text,(Length(Main_.EditatInformatic.Text)+117) Div 2,True));
//  ShowMessage('Linii in raport: '+IntToStr(Vizualizare_.Container.Lines.Capacity));
End;

Procedure TFactura_.VerificareSalvare;
Var Factura:TFactura;
    f:File Of TFactura;
    i:Integer;
    b:Boolean;
Begin
    //citire fisier
  If FileExists(dirEXE+dirFCT+Fisier+'.'+ExtFCT) Then
    Begin
      AssignFile(f,dirEXE+dirFCT+Fisier+'.'+ExtFCT);
      Reset     (f);
      Read      (f,Factura);
      CloseFile (f);
    End
  Else
    FacturaNoua(Factura);
  //identitate
  b:=(Factura.Vanzator.Nume                   =TempFactura.Vanzator.Nume                   ) And
     (Factura.Vanzator.IBAN                   =TempFactura.Vanzator.IBAN                   ) And
     (Factura.Vanzator.Banca                  =TempFactura.Vanzator.Banca                  ) And
     (Factura.Vanzator.AtributFiscal          =TempFactura.Vanzator.AtributFiscal          ) And
     (Factura.Vanzator.CUI                    =TempFactura.Vanzator.CUI                    ) And
     (Factura.Vanzator.NrRegCom               =TempFactura.Vanzator.NrRegCom               ) And
     (Factura.Vanzator.CapitalSocial          =TempFactura.Vanzator.CapitalSocial          ) And
     (Factura.Vanzator.Adresa.TipStrada       =TempFactura.Vanzator.Adresa.TipStrada       ) And
     (Factura.Vanzator.Adresa.NumeStrada      =TempFactura.Vanzator.Adresa.NumeStrada      ) And
     (Factura.Vanzator.Adresa.NrStrada        =TempFactura.Vanzator.Adresa.NrStrada        ) And
     (Factura.Vanzator.Adresa.Tara            =TempFactura.Vanzator.Adresa.Tara            ) And
     (Factura.Vanzator.Adresa.Judet           =TempFactura.Vanzator.Adresa.Judet           ) And
     (Factura.Vanzator.Adresa.Localitate      =TempFactura.Vanzator.Adresa.Localitate      ) And
     (Factura.Vanzator.AgentSocietate.Implicit=TempFactura.Vanzator.AgentSocietate.Implicit);
  If b Then
    For i:=1 To 25 Do
      Begin
        If (Factura.Vanzator.AgentSocietate.Agent[i].Nume       <>TempFactura.Vanzator.AgentSocietate.Agent[i].Nume) Or
           (Factura.Vanzator.AgentSocietate.Agent[i].CI.Serie   <>TempFactura.Vanzator.AgentSocietate.Agent[i].CI.Serie) Or
           (Factura.Vanzator.AgentSocietate.Agent[i].CI.Numar   <>TempFactura.Vanzator.AgentSocietate.Agent[i].CI.Numar) Or
           (Factura.Vanzator.AgentSocietate.Agent[i].CI.Eliberat<>TempFactura.Vanzator.AgentSocietate.Agent[i].CI.Eliberat) Then
          Begin
            b:=False;
            Break;
          End;
      End;
  ListaVanzatori   .Font.Color:=RedIsFalse(b);
  TVA              .Font.Color           :=RedIsFalse(Factura.ValoareTVA  =TempFactura.ValoareTVA);
   LTVA             .Font.Color          :=TVA             .Font.Color;
  Achitata         .Font.Color           :=RedIsFalse(Factura.Achitata    =TempFactura.Achitata);
  NumarFactura     .Font.Color           :=RedIsFalse(Factura.NrFactura   =TempFactura.NrFactura);
  DataFactura      .Font.Color           :=RedIsFalse(Factura.Data        =TempFactura.Data);
  Aviz             .Font.Color           :=RedIsFalse(Factura.Aviz        =TempFactura.Aviz);
   LAviz            .Font.Color           :=Aviz            .Font.Color;
  b:=(Factura.Cumparator.Nume                   =TempFactura.Cumparator.Nume                   ) And
     (Factura.Cumparator.IBAN                   =TempFactura.Cumparator.IBAN                   ) And
     (Factura.Cumparator.Banca                  =TempFactura.Cumparator.Banca                  ) And
     (Factura.Cumparator.AtributFiscal          =TempFactura.Cumparator.AtributFiscal          ) And
     (Factura.Cumparator.CUI                    =TempFactura.Cumparator.CUI                    ) And
     (Factura.Cumparator.NrRegCom               =TempFactura.Cumparator.NrRegCom               ) And
     (Factura.Cumparator.CapitalSocial          =TempFactura.Cumparator.CapitalSocial          ) And
     (Factura.Cumparator.Adresa.TipStrada       =TempFactura.Cumparator.Adresa.TipStrada       ) And
     (Factura.Cumparator.Adresa.NumeStrada      =TempFactura.Cumparator.Adresa.NumeStrada      ) And
     (Factura.Cumparator.Adresa.NrStrada        =TempFactura.Cumparator.Adresa.NrStrada        ) And
     (Factura.Cumparator.Adresa.Tara            =TempFactura.Cumparator.Adresa.Tara            ) And
     (Factura.Cumparator.Adresa.Judet           =TempFactura.Cumparator.Adresa.Judet           ) And
     (Factura.Cumparator.Adresa.Localitate      =TempFactura.Cumparator.Adresa.Localitate      ) And
     (Factura.Cumparator.AgentSocietate.Implicit=TempFactura.Cumparator.AgentSocietate.Implicit);
  If b Then
    For i:=1 To 25 Do
      Begin
        If (Factura.Cumparator.AgentSocietate.Agent[i].Nume       <>TempFactura.Cumparator.AgentSocietate.Agent[i].Nume) Or
           (Factura.Cumparator.AgentSocietate.Agent[i].CI.Serie   <>TempFactura.Cumparator.AgentSocietate.Agent[i].CI.Serie) Or
           (Factura.Cumparator.AgentSocietate.Agent[i].CI.Numar   <>TempFactura.Cumparator.AgentSocietate.Agent[i].CI.Numar) Or
           (Factura.Cumparator.AgentSocietate.Agent[i].CI.Eliberat<>TempFactura.Cumparator.AgentSocietate.Agent[i].CI.Eliberat) Then
          Begin
            b:=False;
            Break;
          End;
      End;
  ListaCumparatori   .Font.Color:=RedIsFalse(b);
  Delegat          .Font.Color           :=RedIsFalse((Factura.Cumparator.AgentSocietate.Implicit=
                                                   TempFactura.Cumparator.AgentSocietate.Implicit) And
                                                      (ListaCumparatori.Font.Color<>clRed));
   LDelegat          .Font.Color           :=Delegat         .Font.Color;
  b:=True;
  For i:=1 To 50 Do
    Begin
      If (Factura.Produs[i].Denumire <>TempFactura.Produs[i].Denumire ) Or
         (Factura.Produs[i].UM       <>TempFactura.Produs[i].UM       ) Or
         (Factura.Produs[i].Pret     <>TempFactura.Produs[i].Pret     ) Or
         (Factura.Produs[i].Cantitate<>TempFactura.Produs[i].Cantitate) Then
        Begin
          b:=False;
          Break;
        End;
    End;
  ListaProduse     .Font.Color           :=RedIsFalse(b);
  Achitat          .Font.Color           :=RedIsFalse(Factura.Achitat     =TempFactura.Achitat);
   LAchitat         .Font.Color           :=Achitat         .Font.Color;
  ZileScadenta     .Font.Color           :=RedIsFalse(Factura.Scadenta    =TempFactura.Scadenta);
  Scadenta         .Font.Color           :=ZileScadenta    .Font.Color;
   LZileScadenta    .Font.Color           :=ZileScadenta    .Font.Color;
  Discount         .Font.Color           :=RedIsFalse(Factura.Discount    =TempFactura.Discount);
   LDiscount1      .Font.Color            :=Discount        .Font.Color;
   LDiscount2      .Font.Color            :=Discount        .Font.Color;
  ProcentPenalizare .Font.Color          :=RedIsFalse(Factura.Penalizare  =TempFactura.Penalizare);
  Penalizare        .Font.Color          :=ProcentPenalizare.Font.Color;
   Lprocentpenalizare.Font.Color          :=Penalizare        .Font.Color;
  Livrare           .Font.Color          :=RedIsFalse(Factura.DataLivrare =TempFactura.DataLivrare);
   Llivrare          .Font.Color          :=Livrare           .Font.Color;
  Salvare1 .Enabled:=IsRedFontComponent(Factura_);
  Salvare2 .Enabled:=Salvare1.Enabled;
  Tiparire1.Enabled:=Not Salvare1.Enabled;
  Tiparire2.Enabled:=Tiparire1.Enabled;
End;

Function TFactura_.VerificareCorectitudine:Boolean;
Var s:String;
Begin
  s:='';
  If NumarFactura.Text='' Then
    Begin
      MessageDlg('Este obligatorie completarea numarului facturii!',mtWarning,[mbYes],0);
      s:='!';
    End
  Else
    Begin
      If ListaVanzatori.Caption='' Then
        s:=s+#13'     Vanzator';
      ///    . . .
      If ListaCumparatori.Caption='' Then
        s:=s+#13'     Cumparator';
      ///    E.T.C.
      If s<>'' Then
        If MessageDlg('Este recomandata completarea campurilor:'+s+#13+ 
                    'Se salveaza fara a se tine cont de avertisment?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
          s:='';
    End;
  Result:=s='';
End;

procedure TFactura_.Iesire1Click(Sender: TObject);
begin
  Close;
end;

procedure TFactura_.FormCreate(Sender: TObject);
Var i:Integer;
begin
  ListaProduse.Cells[0,0]:='Poz';
  ListaProduse.Cells[1,0]:='Denumire produse sau servicii';
  ListaProduse.Cells[2,0]:=' UM';
  ListaProduse.Cells[3,0]:='Cantitate';
  ListaProduse.Cells[4,0]:='Pret unitar';
  ListaProduse.Cells[5,0]:='  Valoare';
  ListaProduse.Cells[6,0]:='ValoareTVA';
  ListaProduse.Cells[0,1]:='  0';
  ListaProduse.Cells[1,1]:='               1';
  ListaProduse.Cells[2,1]:=' 2';
  ListaProduse.Cells[3,1]:='    3';
  ListaProduse.Cells[4,1]:=' 4(faraTVA)';
  ListaProduse.Cells[5,1]:='   5=3x4';
  ListaProduse.Cells[6,1]:=' 6=5/TVA';
  For i:=1 To 100 Do
    ListaProduse.Cells[0,i+1]:=AddSpace(IntToStr(i),3,True);
end;

procedure TFactura_.ScadentaClick(Sender: TObject);
begin
  ZileScadenta .Enabled:=Scadenta.Checked;
  Lzilescadenta.Enabled:=Scadenta.Checked;
  If Not ZileScadenta.Enabled Then
    ZileScadenta.Text:='0';
  VerificareSalvare;
end;

procedure TFactura_.PenalizareClick(Sender: TObject);
begin
  ProcentPenalizare .Enabled:=Penalizare.Checked;
  Lprocentpenalizare.Enabled:=Penalizare.Checked;
  If Not ProcentPenalizare.Enabled Then
    ProcentPenalizare.Text:='0';
  VerificareSalvare;    
end;

procedure TFactura_.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Main_.RefreshListe;
end;

procedure TFactura_.Salvare2Click(Sender: TObject);
Var Factura:TFactura;
    f      :File Of TFactura;
    i      :Integer;
begin
  If VerificareCorectitudine Then
    Begin
      If TempFactura.Vanzator.IBAN='    -    -    -    -    -    ' Then
        TempFactura.Vanzator.IBAN:='';
      If TempFactura.Cumparator.IBAN='    -    -    -    -    -    ' Then
        TempFactura.Cumparator.IBAN:='';
      If TempFactura.DataLivrare='  .  .       :  ' Then
        TempFactura.DataLivrare:='';
      Factura:=TempFactura;
      If NumeOriginal<>NumarFactura.Text Then
        DeleteFile(dirEXE+dirFCT+NumeOriginal+'.'+ExtFCT);
      AssignFile(f,dirEXE+dirFCT+NumarFactura.Text+'.'+ExtFCT);
      Rewrite(f);
      Write(f,Factura);
      CloseFile(f);
      NumeOriginal:=NumarFactura.Text;
      Fisier      :=NumeOriginal;
      Main_.RefreshListe;
      For i:=1 To Main_.ListaFacturi.Items.Capacity Do
        If Main_.ListaFacturi.Items[i-1]=Factura.NrFactura Then
          Begin
            Main_.ListaFacturi.ItemIndex:=i-1;
            Break;
          End;
      VerificareSalvare;
      ShowProgress(Panel4,ProgressBar1);
    End;
end;

procedure TFactura_.Deschidere2Click(Sender: TObject);
Var Factura:TFactura;
    f      :File Of TFactura;
    f2     :File Of TVanzator;
    i,j    :Integer;
    s      :String;
begin
  //citire fisier
  If FileExists(dirEXE+dirFCT+Fisier+'.'+ExtFCT) Then
    Begin
      AssignFile(f,dirEXE+dirFCT+Fisier+'.'+ExtFCT);
      Reset     (f);
      Read      (f,Factura);
      CloseFile (f);
    End
  Else
    FacturaNoua(Factura);
  TempFactura:=Factura;
  //identitate
  If (Fisier='') And (Main_.ListaVanzatori.ItemIndex<>-1) Then
    Begin
      ListaVanzatori.Caption:=Main_.ListaVanzatori.Items[Main_.ListaVanzatori.ItemIndex];
      //citire fisier
      If FileExists(dirEXE+dirVNZ+ListaVanzatori.Caption+'.'+ExtVNZ) Then
        Begin
          AssignFile(f2,dirEXE+dirVNZ+ListaVanzatori.Caption+'.'+ExtVNZ);
          Reset     (f2);
          Read      (f2,TempFactura.Vanzator);
          CloseFile (f2);
        End
      Else
        VanzatorNou(TempFactura.Vanzator);
      //identitate
      ListaVanzatori.Caption:=TempFactura.Vanzator.Nume;
      SetareHint(ListaVanzatori,TempFactura.Vanzator);
    End
  Else
    Begin
      ListaVanzatori.Caption  :=Factura.Vanzator.Nume;
      SetareHint(ListaVanzatori,Factura.Vanzator);
    End;
  If Factura.ValoareTVA=0 Then
    TVA.Text              :='scutit'
  Else
    TVA.Text              :=FloatToStr(Factura.ValoareTVA);
  Achitata.Checked        :=Factura.Achitata;
  If Fisier='' Then
    Begin
      NumarFactura.Text   :=IntToStr(Trunc(StrToNumber(Main_.ListaFacturi.Items[Main_.ListaFacturi.Items.Capacity-1],'ultima factura din lista')+1));
      TempFactura.NrFactura   :=NumarFactura.Text;
    End
  Else
    NumarFactura.Text     :=Factura.NrFactura;
  NumeOriginal            :=Factura.NrFactura;    (*pentru salvare ca*)
  If Fisier='' Then
    Begin
      DateTimeToString(s,'dd.mm.yyyy',Now);//__.__.____
      DataFactura.Text    :=s;
      TempFactura.Data    :=DataFactura.Text;
    End
  Else
    DataFactura.Text      :=Factura.Data;
  Aviz.Text               :=Factura.Aviz;
  If (Fisier='') And (Main_.ListaCumparatori.ItemIndex<>-1) Then
    Begin
      ListaCumparatori.Caption:=Main_.ListaCumparatori.Items[Main_.ListaCumparatori.ItemIndex];
      //citire fisier
      If FileExists(dirEXE+dirCMP+ListaCumparatori.Caption+'.'+ExtCMP) Then
        Begin
          AssignFile(f2,dirEXE+dirCMP+ListaCumparatori.Caption+'.'+ExtCMP);
          Reset     (f2);
          Read      (f2,TempFactura.Cumparator);
          CloseFile (f2);
        End
      Else
        VanzatorNou(TempFactura.Cumparator);
      //identitate
      ListaCumparatori.Caption:=TempFactura.Cumparator.Nume;
      SetareHint(ListaCumparatori,TempFactura.Cumparator);
      Delegat.Clear;
      For i:=1 To 25 Do
        If TempFactura.Cumparator.AgentSocietate.Agent[i].Nume<>'' Then
          Delegat.Items.Add(TempFactura.Cumparator.AgentSocietate.Agent[i].Nume);
      Delegat.ItemIndex   :=TempFactura.Cumparator.AgentSocietate.Implicit-1;
      TempFactura.Discount:=TempFactura.Cumparator.DiscountAcordat;
    End
  Else
    Begin
      ListaCumparatori.Caption  :=Factura.Cumparator.Nume;
      SetareHint(ListaCumparatori,Factura.Cumparator);
      Delegat.Clear;
      For i:=1 To 25 Do
        If Factura.Cumparator.AgentSocietate.Agent[i].Nume<>'' Then
          Delegat.Items.Add(Factura.Cumparator.AgentSocietate.Agent[i].Nume);
      Delegat.ItemIndex:=Factura.Cumparator.AgentSocietate.Implicit-1;
    End;
  ListaProduse.RowCount:=3;
  For i:=1 To 50 Do
    Begin
      For j:=1 To 6 Do
        ListaProduse.Cells[j,i+1]:='';
      ListaProduse.Cells  [1,i+1]:=Factura.Produs[i].Denumire;
      ListaProduse.Cells  [2,i+1]:=Factura.Produs[i].UM;
      ListaProduse.Cells  [3,i+1]:=AddSpace(FloatToStrF(Factura.Produs[i].Cantitate,ffFixed,16,2),9,True);
      ListaProduse.Cells  [4,i+1]:=AddSpace(FloatToStrF(Factura.Produs[i].Pret,ffFixed,16,2),11,True);
      ListaProduse.Cells  [5,i+1]:=AddSpace(FloatToStrF(Factura.Produs[i].Cantitate*Factura.Produs[i].Pret,ffFixed,16,2),10,True);
      ListaProduse.Cells  [6,i+1]:=AddSpace(FloatToStrF(Factura.Produs[i].Pret*
                                                        Factura.Produs[i].Cantitate*
                                                        Factura.ValoareTVA/100,ffFixed,16,2),10,True);
      If Factura.Produs[i].Denumire<>'' Then
        ListaProduse.RowCount:=2+i;
    End;
  ListaProduse.Row:=2;
  Achitat.Text          :=Factura.Achitat;
  ZileScadenta.Text     :=FloatToStrF(Factura.Scadenta,ffFixed,16,0);
  Scadenta.Checked      :=StrToNumber(ZileScadenta.Text,'')<>0;
  ScadentaClick(Sender);
  If (Fisier='') And (Main_.ListaCumparatori.ItemIndex<>-1) Then
    Begin
      Discount.Text     :=FloatToStrF(TempFactura.Discount,ffFixed,16,2);
    End
  Else
    Discount.Text       :=FloatToStrF(Factura.Discount,ffFixed,16,2);
  ProcentPenalizare.Text:=FloatToStrF(Factura.Penalizare,ffFixed,16,2);
  Penalizare.Checked    :=StrToNumber(ProcentPenalizare.Text,'')<>0;
  PenalizareClick(Sender);
  If Fisier='' Then
    Begin
      DateTimeToString(s,'dd.mm.yyyy hh:mm',Now);//__.__.____ __:__
      Livrare.Text      :=s;
      TempFactura.DataLivrare:=Livrare.Text;
    End
  Else
    Livrare.Text        :=Factura.DataLivrare;
  VerificareSalvare;
  ShowProgress(Panel4,ProgressBar1);
end;

procedure TFactura_.FormActivate(Sender: TObject);
begin
  Deschidere2Click(Sender);
  ListaVanzatori.SetFocus;
  Shake(Factura_,Main_.ShakeIt.Checked);
end;

procedure TFactura_.ListaVanzatoriClick(Sender: TObject);
Var f       :File Of TVanzator;
    i       :Integer;
begin
  Alegere_.Caption        :='Alegere Vanzator';
  Alegere_.Label1.Caption :='Alegere Vanzator';
  Alegere_.ComboBox1.Items:=Main_.ListaVanzatori.Items;
  For i:=1 To Main_.ListaVanzatori.Items.Capacity Do
    If ListaVanzatori.Caption=Alegere_.ComboBox1.Items[i-1] Then
      Begin
        Alegere_.ComboBox1.ItemIndex:=i-1;
        Break;
      End;
  If Alegere_.Execute Then
    Begin
      //citire fisier
      If FileExists(dirEXE+dirVNZ+Alegere_.Ales+'.'+ExtVNZ) Then
        Begin
          AssignFile(f,dirEXE+dirVNZ+Alegere_.Ales+'.'+ExtVNZ);
          Reset     (f);
          Read      (f,TempFactura.Vanzator);
          CloseFile (f);
        End
      Else
        VanzatorNou(TempFactura.Vanzator);
      //identitate
      ListaVanzatori.Caption:=TempFactura.Vanzator.Nume;
      SetareHint(ListaVanzatori,TempFactura.Vanzator);
      VerificareSalvare;
    End;
end;

procedure TFactura_.ListaCumparatoriClick(Sender: TObject);
Var f       :File Of TVanzator;
    i       :Integer;
begin
  Alegere_.Caption        :='Alegere Cumparator';
  Alegere_.Label1.Caption :='Alegere Cumparator';
  Alegere_.ComboBox1.Items:=Main_.ListaCumparatori.Items;
  For i:=1 To Alegere_.ComboBox1.Items.Capacity Do
    If ListaCumparatori.Caption=Alegere_.ComboBox1.Items[i-1] Then
      Begin
        Alegere_.ComboBox1.ItemIndex:=i-1;
        Break;
      End;
  If Alegere_.Execute Then
    Begin
      //citire fisier
      If FileExists(dirEXE+dirCMP+Alegere_.Ales+'.'+ExtCMP) Then
        Begin
          AssignFile(f,dirEXE+dirCMP+Alegere_.Ales+'.'+ExtCMP);
          Reset     (f);
          Read      (f,TempFactura.Cumparator);
          CloseFile (f);
        End
      Else
        VanzatorNou(TempFactura.Cumparator);
      //identitate
      ListaCumparatori.Caption:=TempFactura.Cumparator.Nume;
      SetareHint(ListaCumparatori,TempFactura.Cumparator);
      Delegat.Clear;
      For i:=1 To 25 Do
        If TempFactura.Cumparator.AgentSocietate.Agent[i].Nume<>'' Then
          Delegat.Items.Add(TempFactura.Cumparator.AgentSocietate.Agent[i].Nume);
      Delegat.ItemIndex:=TempFactura.Cumparator.AgentSocietate.Implicit-1;
      Discount.Text:=FloatToStrF(TempFactura.Cumparator.DiscountAcordat,ffFixed,16,2);
      VerificareSalvare;
    End;
end;

procedure TFactura_.TVAChange(Sender: TObject);
Var i,p:Integer;
begin
  TempFactura.ValoareTVA:=StrToNumber(TVA.Text,'');
  p:=ListaProduse.Row;
  For i:=2 To ListaProduse.RowCount-1 Do
    ListaProduse.Cells[ 6,p]:=FloatToStrF(Adaugare_.Produs.Cantitate*
                                          Adaugare_.Produs.Pret*
                                          TempFactura.ValoareTVA/100,ffFixed,16,2);
  VerificareSalvare;                                        
end;

procedure TFactura_.NumarFacturaChange(Sender: TObject);
begin
  TempFactura.NrFactura:=NumarFactura.Text;
  VerificareSalvare;
end;

procedure TFactura_.DataFacturaChange(Sender: TObject);
begin
  TempFactura.Data:=DataFactura.Text;
  VerificareSalvare;  
end;

procedure TFactura_.AvizChange(Sender: TObject);
begin
  TempFactura.Aviz:=Aviz.Text;
  VerificareSalvare;  
end;

procedure TFactura_.DelegatChange(Sender: TObject);
begin
  TempFactura.Cumparator.AgentSocietate.Implicit:=Delegat.ItemIndex+1;
  VerificareSalvare;
end;

procedure TFactura_.AchitatChange(Sender: TObject);
begin
  TempFactura.Achitat:=Achitat.Text;
  VerificareSalvare;  
end;

procedure TFactura_.ZileScadentaChange(Sender: TObject);
begin
  TempFactura.Scadenta:=StrToNumber(ZileScadenta.Text,'');
  VerificareSalvare;  
end;

procedure TFactura_.DiscountChange(Sender: TObject);
begin
  TempFactura.Discount:=StrToNumber(Discount.Text,'');
  VerificareSalvare;  
end;

procedure TFactura_.ProcentPenalizareChange(Sender: TObject);
begin
  TempFactura.Penalizare:=StrToNumber(ProcentPenalizare.Text,'');
  VerificareSalvare;
end;

procedure TFactura_.Adaugare1Click(Sender: TObject);
Var p:Integer;
begin
  If ListaProduse.RowCount<50 Then
    Begin
      p:=ListaProduse.RowCount-1;
      If ListaProduse.Cells[1,p]<>'' Then  // daca exista denumire
        Begin
          ListaProduse.RowCount   :=ListaProduse.RowCount+1;
          ListaProduse.Row        :=ListaProduse.RowCount-1;
        End;
      Adaugare_.Produs            :=TempFactura.Produs[p-1];
      Adaugare_.Denumire.Items    :=Main_.ListaProduse.Items;
      Adaugare_.Denumire.ItemIndex:=-1;
      Adaugare_.UM.Items          :=Produs_.UM.Items;
      p                           :=ListaProduse.Row;
      Adaugare_.Denumire.Text     :=ListaProduse.Cells[ 1,p];
      Adaugare_.UM.Text           :=ListaProduse.Cells[ 2,p];
      Adaugare_.Cantitate.Text    :=DeleteSpaces(ListaProduse.Cells[ 3,p]);
      Adaugare_.Pret.Text         :=DeleteSpaces(ListaProduse.Cells[ 4,p]);
      p:=ListaProduse.Row;
      Adaugare_.Caption           :='GesFact - adaugare produs / serviciu';
      If Adaugare_.Execute Then
        Begin
          TempFactura.Produs[ p-1]:=Adaugare_.Produs;
          ListaProduse.Cells[ 1,p]:=TempFactura.Produs[p-1].Denumire;
          ListaProduse.Cells[ 2,p]:=TempFactura.Produs[p-1].UM;
          ListaProduse.Cells[ 3,p]:=AddSpace(FloatToStrF(TempFactura.Produs[p-1].Cantitate,ffFixed,16,2),9,True);
          ListaProduse.Cells[ 4,p]:=AddSpace(FloatToStrF(TempFactura.Produs[p-1].Pret,ffFixed,16,2),11,True);
          ListaProduse.Cells[ 5,p]:=AddSpace(FloatToStrF(TempFactura.Produs[p-1].Cantitate*TempFactura.Produs[p-1].Pret,ffFixed,16,2),10,True);
          ListaProduse.Cells[ 6,p]:=AddSpace(FloatToStrF(TempFactura.Produs[p-1].Pret*
                                                         TempFactura.Produs[p-1].Cantitate*
                                                         TempFactura.ValoareTVA/100,ffFixed,16,2),10,True);
          VerificareSalvare;
        End
      Else
        Begin
          If (ListaProduse.Cells[1,p]='') And (ListaProduse.RowCount>3) Then
            ListaProduse.RowCount:=ListaProduse.RowCount-1;
        End;
    End;
end;

procedure TFactura_.Modificare1Click(Sender: TObject);
Var p:Integer;
begin
  Adaugare_.Denumire.Items    :=Main_.ListaProduse.Items;
//  Adaugare_.Denumire.ItemIndex:=-1;
  Adaugare_.UM.Items          :=Produs_.UM.Items;
  p                           :=ListaProduse.Row;
  Adaugare_.Produs            :=TempFactura.Produs[p-1];
  Adaugare_.Denumire.Text     :=ListaProduse.Cells[ 1,p];
  Adaugare_.UM.Text           :=ListaProduse.Cells[ 2,p];
  Adaugare_.Cantitate.Text    :=DeleteSpaces(ListaProduse.Cells[ 3,p]);
  Adaugare_.Pret.Text         :=DeleteSpaces(ListaProduse.Cells[ 4,p]);
  Adaugare_.Caption           :='GesFact - modificare produs / serviciu';
  If Adaugare_.Execute Then
    Begin
      p:=ListaProduse.Row;
      TempFactura.Produs[p-1]:=Adaugare_.Produs;
      ListaProduse.Cells[ 1,p]:=TempFactura.Produs[p-1].Denumire;
      ListaProduse.Cells[ 2,p]:=TempFactura.Produs[p-1].UM;
      ListaProduse.Cells[ 3,p]:=AddSpace(FloatToStrF(TempFactura.Produs[p-1].Cantitate,ffFixed,16,2),9,True);
      ListaProduse.Cells[ 4,p]:=AddSpace(FloatToStrF(TempFactura.Produs[p-1].Pret,ffFixed,16,2),11,True);
      ListaProduse.Cells[ 5,p]:=AddSpace(FloatToStrF(TempFactura.Produs[p-1].Cantitate*TempFactura.Produs[p-1].Pret,ffFixed,16,2),10,True);
      ListaProduse.Cells[ 6,p]:=AddSpace(FloatToStrF(TempFactura.Produs[p-1].Pret*
                                                     TempFactura.Produs[p-1].Cantitate*
                                                     TempFactura.ValoareTVA/100,ffFixed,16,2),10,True);
      VerificareSalvare;                                               
    End;
end;

procedure TFactura_.Stergere1Click(Sender: TObject);
Var s:String;
    i,j,p:Integer;
begin
  p:=ListaProduse.Row;
  s:=ListaProduse.Cells[1,p];
  If (p<>-1) And (s<>'') Then
    If MessageDlg('Sterg produsul / serviciul "'+s+'"?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
      Begin
        For i:=ListaProduse.Row To ListaProduse.RowCount Do
          For j:=1 To 13 Do
            Begin
              ListaProduse.Cells[j,i]  :=ListaProduse.Cells[j,i+1];
              ListaProduse.Cells[j,i+1]:='';
            End;
          If ListaProduse.RowCount>3 Then
            ListaProduse.RowCount:=ListaProduse.RowCount-1;
          If p<ListaProduse.RowCount Then
            ListaProduse.Row:=p
          Else
            ListaProduse.Row:=p-1;
        For i:=1 To 50 Do
          With TempFactura.Produs[i] Do
            Begin
              Denumire :=ListaProduse.Cells[ 1,i+1];
              UM       :=ListaProduse.Cells[ 2,i+1];
              Cantitate:=StrToNumber(ListaProduse.Cells[ 3,i+1],'');
              Pret     :=StrToNumber(ListaProduse.Cells[ 4,i+1],'');
            End;
        VerificareSalvare;      
      End;
///  NumeChange(Sender);
end;

procedure TFactura_.Tiparire2Click(Sender: TObject);
Var Factura:TFactura;
    f      :File Of TFactura;
    s      :String;
    i,k    :Integer;
begin
  Alegere_.Caption:='Alegere format pagina';
  Alegere_.Label1.Caption:='Alegere format pagina';
  Alegere_.ComboBox1.Clear;
  Alegere_.ComboBox1.Items.Add('Format A5');
  Alegere_.ComboBox1.Items.Add('Format A4');
//  ShowMessage('w '+IntToStr(Printer.PageWidth)+#13+
//              'h '+IntToStr(Printer.PageHeight));
  Alegere_.ComboBox1.ItemIndex:=0;    //implicit A5
  If Alegere_.Execute Then
    Begin
      //citire fisier
      s:=Main_.ListaFacturi.Items[Main_.ListaFacturi.ItemIndex];
      If FileExists(dirEXE+dirFCT+s+'.'+ExtFCT) Then
        Begin
          AssignFile(f,dirEXE+dirFCT+s+'.'+ExtFCT);
          Reset     (f);
          Read      (f,Factura);
          CloseFile (f);
        End
      Else
        FacturaNoua(Factura);
      If Alegere_.Ales='Format A4' Then
        MaximCaractereRaport:=53;////////////////////////////////////////////////////////////////////////
      If Alegere_.Ales='Format A5' Then                                                                //
        Begin                                                                                          //
          k:=0;                                                                                        //
          For i:=1 To 50 Do                                                                            //
            If Factura.Produs[i].Denumire<>'' Then                                                     //
              Inc(k);                                                                                  //
          If (Factura.Discount<>0) Then                                                                //
            k:=k+2;                                                                                    //
          If (Factura.Achitat<>'') Or (Factura.Scadenta<>0) Or (Factura.Penalizare<>0) Then            //
            k:=k+4;                                                                                    //
          If Main_.EditatInformatic.Text<>'' Then                                                      //
            k:=k+1;                                                                                    //
          If k>14 Then                                                                                 //
            Begin                                                                                      //
              MessageDlg('Factura nu incape intr-un format A5.'#13+                                    //
                         'Raportul va fi generat in format A4.',mtInformation,[mbOk],0);               //
              MaximCaractereRaport:=53;//////////////////////////////////////////////////////////////////
            End
          Else
            MaximCaractereRaport:=14;
        End;
      TiparireFactura(Factura);
      Vizualizare_.ShowModal;
    End;
end;

procedure TFactura_.LivrareChange(Sender: TObject);
begin
  TempFactura.DataLivrare:=Livrare.Text;
  VerificareSalvare;
end;

procedure TFactura_.AchitataClick(Sender: TObject);
begin
  TempFactura.Achitata:=Achitata.Checked;
  VerificareSalvare;
end;

end.

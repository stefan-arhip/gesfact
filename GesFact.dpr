program GesFact;

uses
  Forms,
  Windows,
  Dialogs,
  Controls,
  _Main_ in '_Main_.pas' {Main_},
  _Delegat_ in '_Delegat_.pas' {Delegat_},
  _Factura_ in '_Factura_.pas' {Factura_},
  _Produs_ in '_Produs_.pas' {Produs_},
  _Alegere_ in '_Alegere_.pas' {Alegere_},
  _Adaugare_ in '_Adaugare_.pas' {Adaugare_},
  _Vizualizare_ in '_Vizualizare_.pas' {Vizualizare_},
  _About_ in '_About_.pas' {About_},
  _Istoric_ in '_Istoric_.pas' {Istoric_},
  _Furnizor_ in '_Furnizor_.pas' {Furnizor_},
  _Inregistrare_ in '_Inregistrare_.pas' {Inregistrare_},
  _Parola_ in '_Parola_.pas' {Parola_};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMain_, Main_);
  Application.CreateForm(TDelegat_, Delegat_);
  Application.CreateForm(TFactura_, Factura_);
  Application.CreateForm(TProdus_, Produs_);
  Application.CreateForm(TAlegere_, Alegere_);
  Application.CreateForm(TAdaugare_, Adaugare_);
  Application.CreateForm(TVizualizare_, Vizualizare_);
  Application.CreateForm(TAbout_, About_);
  Application.CreateForm(TIstoric_, Istoric_);
  Application.CreateForm(TFurnizor_, Furnizor_);
  Application.CreateForm(TInregistrare_, Inregistrare_);
  Application.CreateForm(TParola_, Parola_);
  Application.HintHidePause:=10000;
  Application.Run;
end.

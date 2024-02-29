unit _PersonalEdit_;

interface

uses
    StdCtrls, Classes, SysUtils;

type
  TPersonalEdit = class(TEdit)
  private
    PreviousText     :string;
    fCaracterePermise:string;
  public
    constructor Create(AOwner: TComponent); override;
    procedure   Change;                     override;
    procedure   KeyPress(var Key: Char);    override;
  published
    property CaracterePermise: string read fCaracterePermise write fCaracterePermise;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TPersonalEdit]);
end;

constructor TPersonalEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Text:= '';
  PreviousText:= '';
end;

procedure TPersonalEdit.KeyPress(var Key: Char);
begin
   PreviousText:= Text;
   inherited KeyPress(Key);
end;

procedure TPersonalEdit.Change;
var i,j:integer;
    s1,s2:String;
    b:Boolean;
begin
  s1:=Text;
  s2:=fCaracterePermise;
  b:=False;
  For i:=1 To Length(s1) Do
    Begin
      b:=True;
      For j:=1 To Length(s2) Do
        If s1[i]=s2[j] Then
          Begin
            b:=False;
            Break;
          End;
      If b Then
        Break;
    End;
  If b Then
    Text:= PreviousText;
  inherited Change;
end;

end.

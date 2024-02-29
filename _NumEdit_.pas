unit _Numedit_;

interface

uses
  StdCtrls, Classes, SysUtils;

type
  TNumEdit = class(TEdit)
  public
    procedure KeyPress(var Key: Char); override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TNumEdit]);
end;

procedure TNumEdit.KeyPress(var Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-', DecimalSeparator]) then
  begin
//    ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = DecimalSeparator) or (Key = '-')) and
          (Pos(Key, Text) > 0) then begin
//    ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end
  else if (Key = '-') and
          (SelStart <> 0) then begin
//    ShowMessage('Only allowed at beginning of number: ' + Key);
    Key := #0;
  end;
 inherited KeyPress(Key);
end;

end.

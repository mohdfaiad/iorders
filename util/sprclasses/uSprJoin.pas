unit uSprJoin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, StrUtils, ImgList;

type
  TsprJoin = class(TObject)
  private
    FTable: string;
    FKind: string;
    FFieldLeft: string;
    FFieldRight: string;
    FOptions: string;
  public
    constructor Create;
    procedure Clear;
    procedure ProcessField(Field: TField; ProcessStr: string; JoinAlias: string; var ResultFieldName: string);
    property Table: string read FTable write FTable;
    property Kind: string read FKind write FKind;
    property FieldLeft: string read FFieldLeft write FFieldLeft;
    property FieldRight: string read FFieldRight write FFieldRight;
    property Options: string read FOptions write FOptions;
  end;

implementation

constructor TsprJoin.Create;
begin
  inherited;
  Clear;
end;

procedure TsprJoin.Clear;
begin
  FTable := '';
  FKind := '';
  FFieldLeft := '';
  FFieldRight := '';
  FOptions := 'with (nolock)';
end;

procedure TsprJoin.ProcessField(Field: TField; ProcessStr: string; JoinAlias: string; var ResultFieldName: string);
var
  L: TStringList;
  vDS: TDataSet;
  I: Integer;
begin
  if not Assigned(Field) then
    Exit;

  vDS := Field.DataSet;
  if Field.FieldKind = fkLookup then
  begin
    L := TStringList.Create;
    try
      L.CommaText := ProcessStr;
      if L.Count = 1 then
      begin
        ResultFieldName := ProcessStr;
        Self.Clear;
      end else
      if L.Count >= 3 then
      begin
        Self.Table := L.Strings[0];
        Self.FieldLeft := L.Strings[1];
        if L.Count > 3 then
          Self.Kind := L.Strings[3]
        else
          Self.Kind := 'left';
        if L.Count > 4 then
        begin
          Self.Options := '';
          for I := 4 to L.Count - 1 do
            Self.Options := Self.Options + L.Strings[I];
        end;

        Self.FieldRight := vDS.FieldByName(Field.KeyFields).Origin;
        ResultFieldName := JoinAlias + '.' + L.Strings[2];
      end;
    finally
      L.Free;
    end;
  end else
  begin
    ResultFieldName := ProcessStr;
    Self.Clear;
  end;
end;


end.
 
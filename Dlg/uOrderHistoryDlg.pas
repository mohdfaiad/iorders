unit uOrderHistoryDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSprItemDlg, StdCtrls, ComCtrls, ExtCtrls;

type
  TOrderHistoryDlg = class(TSprItemDlg)
    lbActionName: TLabel;
    lbSrcStatusName: TLabel;
    lbResStatusName: TLabel;
    lbUserInsName: TLabel;
    lbSrcBasisName: TLabel;
    lbResBasisName: TLabel;
    lbComments: TLabel;
    lbExecMsg: TLabel;
    lbIErr: TLabel;
    lbStartDate: TLabel;
    lbEndDate: TLabel;
    lbActionCode: TLabel;
    edActionName: TEdit;
    edSrcStatusName: TEdit;
    edResStatusName: TEdit;
    edUserInsName: TEdit;
    edSrcBasisName: TEdit;
    edResBasisName: TEdit;
    edComments: TMemo;
    edExecMsg: TMemo;
    edIErr: TEdit;
    edActionCode: TEdit;
    edStartDate: TEdit;
    edEndDate: TEdit;
    ldOrderId: TLabel;
    edOrderId: TEdit;
    lbID: TLabel;
    edID: TEdit;
    Bevel1: TBevel;
  private
    { Private declarations }
  protected
    procedure OwnInitialize; override;
    procedure UpdControls; override;
  public
    { Public declarations }
  end;

var
  OrderHistoryDlg: TOrderHistoryDlg;

implementation

{$R *.dfm}

procedure TOrderHistoryDlg.OwnInitialize;
begin
  inherited;
  Self.AddMap('OrderId', edOrderId);
  Self.AddMap('Id', edID);    
  Self.AddMap('ActionName', edActionName);
  Self.AddMap('SrcStatusName', edSrcStatusName);
  Self.AddMap('ResStatusName', edResStatusName);
  Self.AddMap('UserInsName', edUserInsName);
  Self.AddMap('SrcBasisName', edSrcBasisName);
  Self.AddMap('ResBasisName', edResBasisName);
  Self.AddMap('Comments', edComments);
  Self.AddMap('ExecMsg', edExecMsg);
  Self.AddMap('IErr', edIErr);
  Self.AddMap('StartDate', edStartDate);
  Self.AddMap('EndDate', edEndDate);
  Self.AddMap('ActionCode', edActionCode);
end;

procedure TOrderHistoryDlg.UpdControls;
begin
  inherited;
  if not DataSet.FieldByName('Comments').IsNull then
  begin
    lbComments.Font.Style := lbComments.Font.Style + [fsBold];
    edComments.Font.Style := edComments.Font.Style + [fsBold];
  end
  else
  begin
    lbComments.Font.Style := lbComments.Font.Style - [fsBold];
    edComments.Font.Style := edComments.Font.Style - [fsBold];
  end;
end;


initialization
  RegisterClasses([TOrderHistoryDlg]);

end.

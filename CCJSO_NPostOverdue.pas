unit CCJSO_NPostOverdue;

{*******************************************************
 * © PgkSoft 17.12.2015
 * Новая почта.
 * Загрузка, обработка экспресс накладных.
 * Заказы с просроченным сроком прибытия и получения
 *******************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ExtCtrls, ComCtrls, ToolWin, Excel97, ComObj, DB,
  ADODB;

type
  TfrmCCJSO_NPostOverdue = class(TForm)
    pnlControl: TPanel;
    pnlParm: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    aList: TActionList;
    aExec: TAction;
    aExit: TAction;
    toolbrControl: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    spOverdue: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExecExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
  private
    { Private declarations }
    ISign_Activate : integer;
    procedure ShowGets;
  public
    { Public declarations }
  end;

var
  frmCCJSO_NPostOverdue: TfrmCCJSO_NPostOverdue;

implementation

uses
  Util,
  UMAIN, UCCenterJournalNetZkz, ExDBGRID;

{$R *.dfm}

procedure TfrmCCJSO_NPostOverdue.FormCreate(Sender: TObject);
begin
  ISign_Activate := 0;
end;

procedure TfrmCCJSO_NPostOverdue.FormActivate(Sender: TObject);
begin
  if ISign_Activate = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(329,self.Icon);
    { Форма активна }
    ISign_Activate := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_NPostOverdue.ShowGets;
begin
  if ISign_Activate = 1 then begin
  end;
end;

procedure TfrmCCJSO_NPostOverdue.aExecExecute(Sender: TObject);
var
  vExcel               : OleVariant;
  vDD                  : OleVariant;
  WS                   : OleVariant;
  MyRange              : OleVariant;
  Cell1, Cell2         : OLEVariant;
  I                    : integer;
  iExcelNumLine        : integer;
  iExcelNumLineTable   : integer;
  fl_cnt               : integer;
  num_cnt              : integer;
  iInteriorColor       : integer;
  iHorizontalAlignment : integer;
  SFontSize            : string;
begin
  SFontSize := '10';
  iExcelNumLine := 1;
  try
    pnlControl_Show.Caption := 'Запуск табличного процессора...';
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    { Заголовок заказа  }
    vExcel.ActiveCell[iExcelNumLine, 1].Font.Bold := True;
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Заказы с просроченным сроком прибытия и получения'; inc(iExcelNumLine);
    inc(iExcelNumLine);

    pnlControl_Show.Caption := 'Формирование набора данных...';
    if spOverdue.Active then spOverdue.Active := false;
    spOverdue.Parameters.ParamValues['@SignOverdue'] := 1;
    spOverdue.Open;
    if not spOverdue.IsEmpty then begin
      vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Заказы которые просрочены по прибытию в отделение'; inc(iExcelNumLine);
      fl_cnt := spOverdue.FieldCount;
      inc(iExcelNumLine);
      { Заголовок товарных позиций заказа }
      for I := 1 to fl_cnt do begin
        vExcel.ActiveCell[iExcelNumLine, I].Value := spOverdue.Fields[I - 1].FieldName;
        SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
        vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
      end;
      inc(iExcelNumLine);
      spOverdue.First;
      pnlControl_Show.Caption := 'Формирование отчета...';
      while not spOverdue.Eof do begin
        for num_cnt := 1 to fl_cnt do begin
          vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := spOverdue.Fields[num_cnt - 1].AsString;
          SetPropExcelCell(WS, num_cnt, iExcelNumLine, 0, xlLeft);
          vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
        end;
        inc(iExcelNumLine);
        spOverdue.Next;
      end;
    end;

    pnlControl_Show.Caption := 'Формирование набора данных...';
    if spOverdue.Active then spOverdue.Active := false;
    spOverdue.Parameters.ParamValues['@SignOverdue'] := 2;
    spOverdue.Open;
    if not spOverdue.IsEmpty then begin
      vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Заказы которые просрочены по получению'; inc(iExcelNumLine);
      fl_cnt := spOverdue.FieldCount;
      inc(iExcelNumLine);
      { Заголовок товарных позиций заказа }
      for I := 1 to fl_cnt do begin
        vExcel.ActiveCell[iExcelNumLine, I].Value := spOverdue.Fields[I - 1].FieldName;
        SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
        vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
      end;
      inc(iExcelNumLine);
      spOverdue.First;
      pnlControl_Show.Caption := 'Формирование отчета...';
      while not spOverdue.Eof do begin
        for num_cnt := 1 to fl_cnt do begin
          vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := spOverdue.Fields[num_cnt - 1].AsString;
          SetPropExcelCell(WS, num_cnt, iExcelNumLine, 0, xlLeft);
          vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
        end;
        inc(iExcelNumLine);
        spOverdue.Next;
      end;
    end;

    { Штрина столбцов }
    vExcel.Columns[01].ColumnWidth := 07;  { № п/п           }
    vExcel.Columns[02].ColumnWidth := 10;  { Заказ          }
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  pnlControl_Show.Caption := '';
end;

procedure TfrmCCJSO_NPostOverdue.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

end.

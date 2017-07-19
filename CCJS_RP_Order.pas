unit CCJS_RP_Order;

{*******************************************************
 * � PgkSoft 13.05.2015
 * ������ �������� �������
 * ������ �������� ������ �������
 *******************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Excel97, ActnList, StdCtrls, ToolWin, ComObj,
  DB, ADODB,
  UCCenterJournalNetZkz, CheckLst;

type
  TfrmCCJS_RP_Order = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Client: TPanel;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    pnlPage: TPanel;
    pageControl: TPageControl;
    tabParm: TTabSheet;
    actionList: TActionList;
    aExcel: TAction;
    aClose: TAction;
    tollBar: TToolBar;
    tlbtnExcel: TToolButton;
    tlbtnClose: TToolButton;
    spRP_Zakaz: TADOStoredProc;
    pnlParm_OrderLink: TPanel;
    grbxOrderLink: TGroupBox;
    pnlParm_Main: TPanel;
    chbxOutAddFields: TCheckBox;
    pnlParm_OrderLink_Control: TPanel;
    tlbrOrderLink: TToolBar;
    pnlParm_OrderLink_Control_Show: TPanel;
    pnlPharmGroup_List: TPanel;
    chListBoxOrdersLink: TCheckListBox;
    aOrderLinkList_All: TAction;
    aOrderLinkList_ClearSelect: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    chbxOutAsSinglOrder: TCheckBox;
    aExcel_LinkList: TAction;
    aExcel_LinkList_OutAsSinglOrder: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aOrderLinkList_AllExecute(Sender: TObject);
    procedure aOrderLinkList_ClearSelectExecute(Sender: TObject);
    procedure chListBoxOrdersLinkClickCheck(Sender: TObject);
    procedure aExcel_LinkListExecute(Sender: TObject);
    procedure aExcel_LinkList_OutAsSinglOrderExecute(Sender: TObject);
    procedure chbxOutAsSinglOrderClick(Sender: TObject);
  private
    { Private declarations }
    ISignActive          : integer;
    Order                : integer;
    OrderShipping        : string;
    Client               : string;
    SOrderDate           : string;
    Phone                : string;
    City                 : string;
    Street               : string;
    SOrderSum            : string;
    SOrderAmountShipping : string;
    SOrderAmountCOD      : string;
    SCoolantSum          : string;
    SOrderSumFull        : string;
    SOrderComment        : string;
    SNote                : string;
    OrderName            : string;
    RecHeaderItem        : TJSO_OrderHeaderItem;
    RecSession           : TUserSession;
    SignListLink         : boolean;
    MainOrderLink        : integer;
    IdUserAction         : longint;
    { -- }
    vExcel               : OleVariant;
    vDD                  : OleVariant;
    WS                   : OleVariant;
    MyRange              : OleVariant;
    Cell1, Cell2, Cell3, Cell4: OLEVariant;
    iExcelNumLine        : integer;
    iExcelNumLineTable   : integer;
    fl_cnt               : integer;
    iInteriorColor       : integer;
    iHorizontalAlignment : integer;
    SFontSize            : string;
    SNameAddSum          : string;
    NumRecSelectList     : integer;
    { -- }
    procedure ShowGets;
    procedure CreateListOrderLink;
    procedure CreateSLOrders;
    procedure InitReport_HeaderFields;
    procedure ExecReport(Mode : integer);
  public
    { Public declarations }
    procedure SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
    procedure SetRecSession(Parm : TUserSession);
    procedure SetOrdersListLink(Parm : boolean);
  end;

var
  frmCCJS_RP_Order: TfrmCCJS_RP_Order;

implementation

uses
  Util, IdGlobal,
  UMain, ExDBGRID, CCJSO_DM;

const
  cMode_SinglOrder         = 0;
  cMode_LinkOrder          = 1;
  cMode_OrdersAsSinglOrder = 2;

{$R *.dfm}

procedure TfrmCCJS_RP_Order.FormCreate(Sender: TObject);
begin
  { ������������� }
  ISignActive    := 0;
  Order          := 0;
  OrderShipping  := '';
  Client         := '';
  SOrderComment  := '';
  SNote          := '';
  SignListLink   := false;
  IdUserAction   := 0;
end;

procedure TfrmCCJS_RP_Order.FormActivate(Sender: TObject);
var
  SCaption : string;
  IErr     : integer;
  SErr     : string;
begin
  if ISignActive = 0 then begin
    { ������ ���� }
    FCCenterJournalNetZkz.imgMain.GetIcon(243,self.Icon);
    { ������������� }
    InitReport_HeaderFields;
    { ���������� ����� �������� }
    IdUserAction := FCCenterJournalNetZkz.GetIdUserAction;
    { ���������� ��������� ������ }
    SCaption := '� ' + VarToStr(Order);
    pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;
    SCaption := Client; pnlTop_Client.Caption := SCaption;
    { ����������� ����� �� ������ �� ������� ��������� ������� }
    if SignListLink then begin
      { �������� �������� ����� }
      if RecHeaderItem.NParentOrderID = 0 then begin
        MainOrderLink := RecHeaderItem.orderID;
      end else begin
        DM_CCJSO.JSOGetMainParentOrder(RecSession.CurrentUser, RecHeaderItem.OrderID, MainOrderLink, IErr, SErr );
      end;
      CreateListOrderLink;
      { ����������� �������������� �������� }
      tlbtnExcel.Action := aExcel_LinkList;
    end else begin
      { �� ���������� }
      chbxOutAsSinglOrder.Visible := false;
      grbxOrderLink.Visible := false;
      self.Height := self.Height - grbxOrderLink.Height;
    end;
    { ����� ������� }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_Order.InitReport_HeaderFields;
begin
  Order                := RecHeaderItem.orderID;
  OrderShipping        := RecHeaderItem.orderShipping;
  Client               := RecHeaderItem.orderShipName;
  SOrderDate           := RecHeaderItem.SOrderDt;
  Phone                := RecHeaderItem.orderPhone;
  Street               := RecHeaderItem.orderShipStreet;
  SOrderSum            := CurrToStrF(RecHeaderItem.orderAmount, ffFixed, 2);
  SOrderAmountShipping := CurrToStrF(RecHeaderItem.NOrderAmountShipping, ffFixed, 2);
  SOrderAmountCOD      := CurrToStrF(RecHeaderItem.NOrderAmountCOD, ffFixed, 2);
  SCoolantSum          := CurrToStrF(RecHeaderItem.NCoolantSum, ffFixed, 2);
  SOrderSumFull        := CurrToStrF(RecHeaderItem.orderAmount + RecHeaderItem.NOrderAmountShipping + RecHeaderItem.NOrderAmountCOD + RecHeaderItem.NCoolantSum, ffFixed, 2);
  City                 := RecHeaderItem.SOrderShipCity;
  SOrderComment        := RecHeaderItem.SOrderComment;
  SNote                := RecHeaderItem.SNote;
  OrderName            := RecHeaderItem.orderName;
end;

procedure TfrmCCJS_RP_Order.CreateListOrderLink;
begin
  pnlControl_Show.Caption := '�������� ������ �������...';
  try
    chListBoxOrdersLink.Clear;
    if DM_CCJSO.spdsLinkOrdersList.Active then DM_CCJSO.spdsLinkOrdersList.Active := false;
    DM_CCJSO.spdsLinkOrdersList.Parameters.ParamValues['@Order'] := MainOrderLink;
    DM_CCJSO.spdsLinkOrdersList.Open;
    DM_CCJSO.spdsLinkOrdersList.First;
    while not DM_CCJSO.spdsLinkOrdersList.Eof do begin
      chListBoxOrdersLink.Items.AddObject
       (
        DM_CCJSO.spdsLinkOrdersList.FieldByName('SorderID').AsString + ' �� ' +
          DM_CCJSO.spdsLinkOrdersList.FieldByName('SOrderDt').AsString + ', ����� ' +
          CurrToStrF(DM_CCJSO.spdsLinkOrdersList.FieldByName('orderAmount').AsCurrency, ffFixed, 2) +
          iif(DM_CCJSO.spdsLinkOrdersList.FieldByName('orderID').AsInteger = MainOrderLink,', ��������',''),
        TObject(DM_CCJSO.spdsLinkOrdersList.FieldByName('orderID').AsInteger)
       );
      DM_CCJSO.spdsLinkOrdersList.Next;
    end;
  except
    on e:Exception do begin
      ShowMessage('���� ��� ������������ ������ ����� �����.' + chr(10) + e.Message);
    end;
  end;
  pnlControl_Show.Caption := '';
end;

procedure TfrmCCJS_RP_Order.ShowGets;
begin
  if ISignActive = 1 then begin
    if SignListLink then begin
      { ����������� �������� }
      if chbxOutAsSinglOrder.Checked
        then tlbtnExcel.Action := aExcel_LinkList_OutAsSinglOrder
        else tlbtnExcel.Action := aExcel_LinkList;
      { ������ � ��������� ���������� }
      if aOrderLinkList_All.Checked then begin
        chListBoxOrdersLink.Enabled := false;
        aExcel_LinkList.Enabled := true;
        aExcel_LinkList_OutAsSinglOrder.Enabled := true;
        aOrderLinkList_ClearSelect.Enabled := false;
      end else begin
        chListBoxOrdersLink.Enabled := true;
        if GetCountCheckListBox(chListBoxOrdersLink) = 0 then begin
          aExcel_LinkList.Enabled := false;
          aExcel_LinkList_OutAsSinglOrder.Enabled := false;
          aOrderLinkList_ClearSelect.Enabled := false;
        end else begin
          aExcel_LinkList.Enabled := true;
          aExcel_LinkList_OutAsSinglOrder.Enabled := true;
          aOrderLinkList_ClearSelect.Enabled := true;
        end;
      end;
      if chListBoxOrdersLink.Count = 0 then aExcel.Enabled := false;
    end;
  end;
end;

procedure TfrmCCJS_RP_Order.SetRecHeaderItem(Parm : TJSO_OrderHeaderItem); begin RecHeaderItem := Parm; end;
procedure TfrmCCJS_RP_Order.SetOrdersListLink(Parm : boolean); begin SignListLink := Parm; end;
procedure TfrmCCJS_RP_Order.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCJS_RP_Order.ExecReport(Mode : integer);
var
  I              : integer;
  num_cnt        : integer;
  NumbRegistered : integer;
  ActionNote     : string;
  SActionDate    : string;
  SCaption       : string;
  IErr           : integer;
  SErr           : string;

  procedure ExcelRecordOrder; begin
    vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := spRP_Zakaz.Fields[num_cnt - 1].AsString;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '������'           then iHorizontalAlignment := xlCenter;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '���-��'           then iHorizontalAlignment := xlCenter;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '��.���.'          then iHorizontalAlignment := xlCenter;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '����'             then iHorizontalAlignment := xlRight;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '�����'            then iHorizontalAlignment := xlRight;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '������'           then iHorizontalAlignment := xlCenter;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '���.�����.'       then iHorizontalAlignment := xlCenter;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '��. � ����.'      then iHorizontalAlignment := xlCenter;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '����� ������.'    then iHorizontalAlignment := xlCenter;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '���������������'  then iHorizontalAlignment := xlCenter;
    if spRP_Zakaz.Fields[num_cnt - 1].FieldName = '������������'     then iHorizontalAlignment := xlCenter;
    SetPropExcelCell(WS, num_cnt, iExcelNumLine, iInteriorColor, iHorizontalAlignment);
    vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
  end; { ExcelRecordOrder }

  procedure DeliveryAdd(ACaption: string; AValue: string; IncLine: Boolean);
  begin
    if IncLine then
      inc(iExcelNumLine);
    SetPropExcelCell(WS,1,iExcelNumLine,0,xlLeft);
    SetPropExcelCell(WS,2,iExcelNumLine,0,xlLeft);
    SetPropExcelCell(WS,3,iExcelNumLine,0,xlLeft);
    SetPropExcelCell(WS,4,iExcelNumLine,0,xlRight);
    SetPropExcelCell(WS,5,iExcelNumLine,0,xlRight);
    SetPropExcelCell(WS,6,iExcelNumLine,0,xlLeft);
    Cell1 := WS.Cells[iExcelNumLine,1];
    Cell2 := WS.Cells[iExcelNumLine,3];
    MyRange := WS.Range[Cell1, Cell2]; MyRange.Merge(false);
    MyRange.Value := ACaption;
    Cell1 := WS.Cells[iExcelNumLine,4];
    Cell2 := WS.Cells[iExcelNumLine,5];
    MyRange := WS.Range[Cell1, Cell2]; MyRange.Merge(false);
    MyRange.Value := AValue;
    vExcel.ActiveCell[iExcelNumLine, 6].Value := ' ���.';
  end;

  procedure FooterAdd(ACaption: string; IncLine: Boolean);
  begin
    if IncLine then
      inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Font.Bold := True;
    vExcel.ActiveCell[iExcelNumLine, 1].Font.Size := 16;
    vExcel.ActiveCell[iExcelNumLine, 1].Value := ACaption;
  end;

begin

  SFontSize := '10';
  try
    pnlControl_Show.Caption := '�������� ��������� ������...';
    if DM_CCJSO.spdsSelectList.Active then DM_CCJSO.spdsSelectList.Active := false;
    DM_CCJSO.spdsSelectList.Parameters.ParamValues['@IDENT']    := IdUserAction;
    DM_CCJSO.spdsSelectList.Parameters.ParamValues['@UnitCode'] := 'OrderNetJournal';
    DM_CCJSO.spdsSelectList.Open;
    pnlControl_Show.Caption := '������ ���������� ����������...';
    vExcel := CreateOLEObject('Excel.Application');
    vExcel.SheetsInNewWorkbook := DM_CCJSO.spdsSelectList.RecordCount*2;
    vDD := vExcel.Workbooks.Add;
    DM_CCJSO.spdsSelectList.First;
    NumRecSelectList := 0;
    while not DM_CCJSO.spdsSelectList.Eof do begin
      iExcelNumLine := 1;
      inc(NumRecSelectList);
      WS := vDD.Sheets[NumRecSelectList];
      WS.Activate;
      { �������������� ���� ��������� ������ }
      DM_CCJSO.GetRecHeader(DM_CCJSO.spdsSelectList.FieldValues['NPRN'],RecHeaderItem,IErr,SErr);
      InitReport_HeaderFields;
      { �������� ���� ������� ������ <����� ����� � ��������> }
      DM_CCJSO.JSOHistGetActionDateInfo(
                                        RecSession.CurrentUser,
                                        Order,
                                        'SetCurrentOrderStatus',
                                        cModeHistGetActionDateInfo_Last,
                                        cStatus_GoodsReady,
                                        NumbRegistered,
                                        SActionDate,
                                        ActionNote,
                                        IErr,
                                        SErr
                                       );
      WS.Name := '����� ' + RecHeaderItem.SorderID;
      { �������������� ���������� }
      if chbxOutAddFields.Checked then WS.PageSetup.Orientation := xlLandscape;
      { ��������� ������ }
      vExcel.ActiveCell[iExcelNumLine, 2].Font.Bold := True;
      vExcel.ActiveCell[iExcelNumLine, 2].Value := '����� � ' + OrderName + ' �� ' + SOrderDate; inc(iExcelNumLine);
      //inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1].Value := '��������: ������'; inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1].Value := '����������: ' + Client + ' ���. ' + Phone; inc(iExcelNumLine);
      { ����� }
      if Length(trim(City)) <> 0 then begin
        vExcel.ActiveCell[iExcelNumLine, 1].Value := '�����: ' + City; inc(iExcelNumLine);
      end;
      { ����������� ����� }
      if Length(trim(RecHeaderItem.orderEmail)) <> 0 then begin
        vExcel.ActiveCell[iExcelNumLine, 1].Value := 'EMail: ' + RecHeaderItem.orderEmail; inc(iExcelNumLine);
      end;
      { ������ }
      vExcel.ActiveCell[iExcelNumLine, 1].Value := '�����: ' + Street; inc(iExcelNumLine);
      { ����� ����� � �������� }
      if Length(trim(SActionDate)) <> 0 then begin
        { ���������� }
        Cell1 := WS.Cells[iExcelNumLine,1];  Cell2 := WS.Cells[iExcelNumLine,8];
        MyRange := WS.Range[Cell1, Cell2]; MyRange.Merge(false);
        MyRange.Value := cStatus_GoodsReady + ': ' +SActionDate;
        { �������� ������� }
        WS.Range[CellName(01,iExcelNumLine) + ':' + CellName(08,iExcelNumLine)].WrapText:=true;
        inc(iExcelNumLine);
      end;
      { ���������� ������ }
      if Length(trim(SOrderComment)) <> 0 then begin
        SCaption := StringReplace( StringReplace(SOrderComment,chr(10),' ',[rfReplaceAll, rfIgnoreCase]),chr(13),' ',[rfReplaceAll, rfIgnoreCase] );
        { ���������� }
        Cell1 := WS.Cells[iExcelNumLine,1];  Cell2 := WS.Cells[iExcelNumLine,8];
        MyRange := WS.Range[Cell1, Cell2]; MyRange.Merge(false);
        MyRange.Value := StringReplace(SOrderComment,chr(10),' ',[rfReplaceAll, rfIgnoreCase]);
        vExcel.ActiveCell[iExcelNumLine, 1].Value := SCaption;
        { �������� ������� }
        MyRange.WrapText:=true;
        MyRange.VerticalAlignment := xlTop;
        MyRange.RowHeight := ((Length(SCaption)/50))*17; { �������������� ������ ������ 50 �������� }
        inc(iExcelNumLine);
      end;
      { ���������� ������ }
      if Length(trim(SNote)) <> 0 then begin
        SCaption := StringReplace( StringReplace(SNote,chr(10),' ',[rfReplaceAll, rfIgnoreCase]),chr(13),' ',[rfReplaceAll, rfIgnoreCase] );
        { ���������� }
        Cell1 := WS.Cells[iExcelNumLine,1];  Cell2 := WS.Cells[iExcelNumLine,8];
        MyRange := WS.Range[Cell1, Cell2]; MyRange.Merge(false);
        MyRange.Value := SCaption;
        vExcel.ActiveCell[iExcelNumLine, 1].Value := StringReplace( StringReplace(SNote,chr(10),' ',[rfReplaceAll, rfIgnoreCase]),chr(13),' ',[rfReplaceAll, rfIgnoreCase] );
        { �������� ������� }
        MyRange.WrapText := true;
        MyRange.VerticalAlignment := xlTop;
        MyRange.RowHeight := ((Length(SCaption)/50))*17; { �������������� ������ ������ 50 �������� }
        inc(iExcelNumLine);
      end;
      pnlControl_Show.Caption := '������������ ������ ������...';
      if spRP_Zakaz.Active then spRP_Zakaz.Active := false;
      spRP_Zakaz.Parameters.ParamValues['@OrderID'] := Order;
      spRP_Zakaz.Open;
      fl_cnt := spRP_Zakaz.FieldCount;
      inc(iExcelNumLine); iExcelNumLineTable := iExcelNumLine;
      { ��������� �������� ������� ������ }
      for I := 1 to fl_cnt do begin
        if chbxOutAddFields.Checked then begin
          vExcel.ActiveCell[iExcelNumLine, I].Value := spRP_Zakaz.Fields[I - 1].FieldName;
          SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
          vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
        end else begin
          if not (
                     (spRP_Zakaz.Fields[I - 1].FieldName = '��. � ����.')
                  or (spRP_Zakaz.Fields[I - 1].FieldName = '����� ������.')
                  or (spRP_Zakaz.Fields[I - 1].FieldName = '���������������')
                  or (spRP_Zakaz.Fields[I - 1].FieldName = '������������')
                  or (spRP_Zakaz.Fields[I - 1].FieldName = '���.�����.')
                 ) then begin
            vExcel.ActiveCell[iExcelNumLine, I].Value := spRP_Zakaz.Fields[I - 1].FieldName;
            SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
            vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
          end;
        end;
      end;
      inc(iExcelNumLine);
      spRP_Zakaz.First;
      pnlControl_Show.Caption := '������������ ������...';
      { ������� �������� ������� ������ }
      while not spRP_Zakaz.Eof do begin
        if spRP_Zakaz.FieldByName('���.�����.').AsString = '��'
          then iInteriorColor := 6 { ������ ���������� �������� ������ � ��������� ������������� }
          else iInteriorColor := 0;
        for num_cnt := 1 to fl_cnt do begin
          iHorizontalAlignment := xlLeft;
          if chbxOutAddFields.Checked then begin
            ExcelRecordOrder;
          end else begin
            if not (
                       (spRP_Zakaz.Fields[num_cnt - 1].FieldName = '��. � ����.')
                    or (spRP_Zakaz.Fields[num_cnt - 1].FieldName = '����� ������.')
                    or (spRP_Zakaz.Fields[num_cnt - 1].FieldName = '���������������')
                    or (spRP_Zakaz.Fields[num_cnt - 1].FieldName = '������������')
                    or (spRP_Zakaz.Fields[num_cnt - 1].FieldName = '���.�����.')
                   ) then begin
              ExcelRecordOrder;
            end;
          end;
        end;
        inc(iExcelNumLine);
        spRP_Zakaz.Next;
      end;
      { ������ �������� }
      vExcel.Columns[01].ColumnWidth := 04;  { � �/�           }
      vExcel.Columns[02].ColumnWidth := 07;  { ������          }
      vExcel.Columns[03].ColumnWidth := 25;  { ������������    }
      vExcel.Columns[04].ColumnWidth := 04;  { ���-��          }
      vExcel.Columns[05].ColumnWidth := 06;  { ��.���.         }
      vExcel.Columns[06].ColumnWidth := 07;  { ����            }
      vExcel.Columns[07].ColumnWidth := 07;  { �����           }
      vExcel.Columns[08].ColumnWidth := 15;  { ������          }
      vExcel.Columns[09].ColumnWidth := 07;  { ���.�����.      }
      vExcel.Columns[10].ColumnWidth := 06;   { ��. � ����.     }
      vExcel.Columns[11].ColumnWidth := 10;  { ����� ������.   }
      vExcel.Columns[12].ColumnWidth := 08;  { ��������������� }
      vExcel.Columns[13].ColumnWidth := 10;  { ������������    }
      { ������� ���� }
      WS.Range[CellName(01,iExcelNumLineTable) + ':' + CellName(14,iExcelNumLine-1)].WrapText:=true;
      vExcel.ActiveCell[iExcelNumLine, 3].Value := '�����'; vExcel.ActiveCell[iExcelNumLine, 7].Value := SOrderSum + ' ���.';
      if RecHeaderItem.NCoolantSum > 0 then begin
        inc(iExcelNumLine);
        vExcel.ActiveCell[iExcelNumLine, 3].Value := '��������'; vExcel.ActiveCell[iExcelNumLine, 7].Value := SCoolantSum + ' ���.';
      end;
      if RecHeaderItem.NOrderAmountShipping > 0 then begin
        inc(iExcelNumLine);
        if      RecHeaderItem.NOrderAmountShipping = 70  then SNameAddSum := '�������'
        else if RecHeaderItem.NOrderAmountShipping = 150 then SNameAddSum := '������� �����'
        else if RecHeaderItem.NOrderAmountShipping = 35  then SNameAddSum := '�������� ������'
        else SNameAddSum := '�������� ������';
        vExcel.ActiveCell[iExcelNumLine, 3].Value := SNameAddSum; vExcel.ActiveCell[iExcelNumLine, 7].Value := SOrderAmountShipping + ' ���.';
      end;
      if RecHeaderItem.NOrderAmountCOD > 0 then begin
        inc(iExcelNumLine);
        vExcel.ActiveCell[iExcelNumLine, 3].Value := '���������� ������'; vExcel.ActiveCell[iExcelNumLine, 7].Value := SOrderAmountCOD + ' ���.';
      end;
      inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 3].Value := '�����'; vExcel.ActiveCell[iExcelNumLine, 7].Value := SOrderSumFull + ' ���.';
      inc(iExcelNumLine); inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1].Value := '���������� ����������: ������������� ��������� � �������� ������� �������� �� ��������';
        vExcel.Cells[iExcelNumLine, 1].Font.Size := SFontSize;
      inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1].Value := '(������������� ��� �� 19.03.1994�. � 172)';
        vExcel.Cells[iExcelNumLine, 1].Font.Size := SFontSize;
      inc(iExcelNumLine); inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1].Value := '�������� : _____________ ����';
      vExcel.ActiveCell[iExcelNumLine, 3].Value := '�������� ����������: _____________ ����';
      inc(iExcelNumLine); inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1].Value := '������   ______________ ����';
      vExcel.ActiveCell[iExcelNumLine, 3].Value := '������� (��� ����������)  ______________ ����';
      inc(iExcelNumLine); inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1].Value := '������   ______________ ����';

      if length(trim(RecHeaderItem.Apteka)) = 0 then begin
        { ��������� �� ��������� �������� ����� ��� ��������}
        inc(iExcelNumLine); inc(iExcelNumLine); inc(iExcelNumLine);
        //iExcelNumLine := 1;
        //inc(NumRecSelectList);
        //WS := vDD.Sheets[NumRecSelectList];
        //WS.Activate;
        //WS.Name := '����� ' + RecHeaderItem.SorderID + '(� ��������)';
        { ��������� ������ }
        vExcel.ActiveCell[iExcelNumLine, 2].Font.Bold := True;
        vExcel.ActiveCell[iExcelNumLine, 2].Value := '����� � ' + IntToStr(Order) + ' �� ' + SOrderDate; inc(iExcelNumLine);
        //inc(iExcelNumLine);
        vExcel.ActiveCell[iExcelNumLine, 1].Value := '��������: ' + Client + ' ���. ' + Phone; inc(iExcelNumLine);
        { ����� }
         vExcel.ActiveCell[iExcelNumLine, 1].Value := '�����: ' + City; inc(iExcelNumLine);
        { ����������� ����� }
        vExcel.ActiveCell[iExcelNumLine, 1].Value := 'EMail: ' + RecHeaderItem.orderEmail; inc(iExcelNumLine);
        { ����� }
        vExcel.ActiveCell[iExcelNumLine, 1].Value := '�����: ' + Street; inc(iExcelNumLine);
        inc(iExcelNumLine);
        { ��� ������� }
        vExcel.ActiveCell[iExcelNumLine, 1].Value := RecHeaderItem.orderPayment; inc(iExcelNumLine);

        DeliveryAdd('�����', SOrderSum, False);
        if      RecHeaderItem.NOrderAmountShipping = 70  then SNameAddSum := '�������'
        else if RecHeaderItem.NOrderAmountShipping = 150 then SNameAddSum := '������� �����'
        else if RecHeaderItem.NOrderAmountShipping = 35  then SNameAddSum := '�������� ������'
        else SNameAddSum := '�������� ������';
        DeliveryAdd(SNameAddSum, SOrderAmountShipping, True);
        DeliveryAdd('�����', SOrderSumFull, True);
        // ��������� ������
        inc(iExcelNumLine); inc(iExcelNumLine); inc(iExcelNumLine);
        // ��������� ������

        vExcel.ActiveCell[iExcelNumLine, 2].Font.Bold := True;
        vExcel.ActiveCell[iExcelNumLine, 2].Value := '����� � ' + IntToStr(Order) + ' �� ' + SOrderDate;
        FooterAdd('��������: ' + Client + ' ���. ' + Phone, true);
        FooterAdd('�����: ' + City, true);
        FooterAdd('EMail: ' + RecHeaderItem.orderEmail, true);
        FooterAdd('�����: ' + Street, true);
      end;

      {--}
      DM_CCJSO.spdsSelectList.Next;
    end; { while not DM_CCJSO.spdsSelectList.Eof do }
    WS := vDD.Sheets[1];
    WS.Activate;
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  pnlControl_Show.Caption := '';

end; { ExecReport }

procedure TfrmCCJS_RP_Order.aExcelExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  { ������� ����� � ������ }
  DM_CCJSO.SLClear(IdUserAction,IErr,SErr);
  DM_CCJSO.SLInert(IdUserAction,'OrderNetJournal',Order,0,RecSession.CurrentUser,IErr,SErr);
  ExecReport(cMode_SinglOrder);
  DM_CCJSO.SLClear(IdUserAction,IErr,SErr);
end;

procedure TfrmCCJS_RP_Order.aCloseExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJS_RP_Order.aOrderLinkList_AllExecute(Sender: TObject);
var
  i : integer;
begin
  if aOrderLinkList_All.Checked then begin
    aOrderLinkList_All.ImageIndex := 353;
    for i := 0 to chListBoxOrdersLink.Count-1 do chListBoxOrdersLink.Checked[i] := true;
  end else aOrderLinkList_All.ImageIndex := 352;
  ShowGets;
end;

procedure TfrmCCJS_RP_Order.aOrderLinkList_ClearSelectExecute(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to chListBoxOrdersLink.Count-1 do chListBoxOrdersLink.Checked[i] := false;
  ShowGets;
end;

procedure TfrmCCJS_RP_Order.chListBoxOrdersLinkClickCheck(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_RP_Order.CreateSLOrders;
var
  IErr                 : integer;
  SErr                 : string;
  iListBoxItems        : integer;
begin
  DM_CCJSO.SLClear(IdUserAction,IErr,SErr);
  if aOrderLinkList_All.Checked then begin
    { ��� ������ }
    DM_CCJSO.spdsLinkOrdersList.First;
    while not DM_CCJSO.spdsLinkOrdersList.Eof do begin
      DM_CCJSO.SLInert(IdUserAction,'OrderNetJournal',DM_CCJSO.spdsLinkOrdersList.FieldByName('orderID').AsInteger,0,RecSession.CurrentUser,IErr,SErr);
      DM_CCJSO.spdsLinkOrdersList.Next;
    end;
  end else begin
    { ��������� ������ }
    DM_CCJSO.spdsLinkOrdersList.First;
    while not DM_CCJSO.spdsLinkOrdersList.Eof do begin
      iListBoxItems := chListBoxOrdersLink.Items.IndexOfObject( TObject(DM_CCJSO.spdsLinkOrdersList.FieldByName('orderID').AsInteger) );
      if chListBoxOrdersLink.Checked[iListBoxItems] then begin
        DM_CCJSO.SLInert(IdUserAction,'OrderNetJournal',DM_CCJSO.spdsLinkOrdersList.FieldByName('orderID').AsInteger,0,RecSession.CurrentUser,IErr,SErr);
      end;
      DM_CCJSO.spdsLinkOrdersList.Next;
    end;
  end;
end;

procedure TfrmCCJS_RP_Order.aExcel_LinkListExecute(Sender: TObject);
var
  IErr                 : integer;
  SErr                 : string;
begin
  { ��������� ������ �������}
  CreateSLOrders;
  ExecReport(cMode_LinkOrder);
  DM_CCJSO.SLClear(IdUserAction,IErr,SErr);
end;

procedure TfrmCCJS_RP_Order.aExcel_LinkList_OutAsSinglOrderExecute(Sender: TObject);
var
  IErr                 : integer;
  SErr                 : string;
begin
  { ��������� ������ �������}
  CreateSLOrders;
  {--}
  DM_CCJSO.SLClear(IdUserAction,IErr,SErr);
end;

procedure TfrmCCJS_RP_Order.chbxOutAsSinglOrderClick(Sender: TObject);
begin
  ShowGets;
end;

end.

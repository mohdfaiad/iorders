unit JOPH_DM;

interface

uses
  SysUtils, Classes, ActnList, DB, ADODB, Dialogs, Variants;

  { Условия отбора - журнал заказов клиентов }
  type TJOPH_Condition = record
    { JOPH Header }
    Header_Begin                 : String;  { base  }
    Header_End                   : String;  { base  }
    Header_Prefix                : integer; { base  }
    Header_Pharmacy              : String;  { base  }
    Header_RN_Pharmacy           : integer; { base+ }
    Header_Client                : String;  { base  }
    Header_RN_Client             : integer; { base+ }
    Header_Phone                 : String;  { base  }
    Header_RN_Phone              : integer; { base+ }
    Header_City                  : String;  { base  }
    Header_RN_City               : integer; { base+ }
    Item_ArtCode                 : string;  { base  }
    Item_ArtName                 : string;  { base  }
    Item_ArtSignRef              : boolean; { base+ }
    Hist_NameOperation           : string;  { base  }
    Hist_RN_NameOperation        : integer; { base+ }
  end;

  { Данные по товарной позиции, которая выбрана при выполнении действий замены или добавления товарной позиции в заказе }
  type TNetNomenclature = record
    NArtCode         : integer;
    SArtCode         : string;
    SNomenclature    : string;
    SNamesSite       : string;
    SManufacturer    : string;
    NKoefUpack       : integer;
    NGrantedInCheck  : integer;
    BNoRecipt        : boolean;
    BTypeKeep        : boolean;
    NMakeFrom        : integer;
    NOstatAptek      : integer;
    NOstatAptekReal  : integer;
    NRemnSklad       : integer;
    NTotalRemnSklad  : integer;
    NCenaSite        : currency;
    NCenaIApteka     : currency;
    NCenaOpt         : currency;
    {--}
    ItemCount        : integer;
    SignPharm        : integer; { для вабора с привязкой торговой точки
                                   0 - без привязки к ТТ
                                   1 - инициализирована запись с набора данных qrspRemnItemIPA
                                   2 - инициализирована запись с набора данных qrspNetTermItem
                                }
  end;

  type TRemnItemIPA = record
    NArtCode        : integer;
    NAptekaOstat    : integer;
    NAptekaCena     : currency;
    SAptekaName     : string;
    NAptekaID       : integer;
    SAptekaPhone    : string;
    SAptekaIP       : string;
    SAptekaAdress   : string;
    DiffMinute      : integer;
	  NSumKol         : integer;
  end;

  type TNetTermItem = record
    NArtCode      : integer;
    NAptekaOstat  : integer;
    NAptekaCena   : currency;
    SAptekaName   : string;
    NAptekaID     : integer;
    SAptekaPhone  : string;
    SAptekaIP     : string;
    SAptekaAdress : string;
    DiffMinute    : integer;
    NArtCodeTerm  : integer;
    SArtNameTerm  : string;
    ISignTerm     : integer;
  end;

  { Заказы клиентов- заголовка заказа }
  type TJOPH_Header = record
    NRN                  : int64;
    NParentRN            : int64;
    NMadeOutRN           : int64;
    NOrderID             : integer;
    SOrderID             : string;
    SPrefixOrder         : string;
    NaptekaID            : integer;
    SPharmacy            : string;
    NPharmAuthor         : integer;
    SPharmAuthor         : string;
    SDocNumber           : string;
    COrderAmount         : currency;
    COrderAmountShipping : currency;
    COrderAmountCOD      : currency;
    SOrderCurrency       : string;
    NAutoGenShipping     : integer;
    SOrderShipping       : string;
    NAutoGenPayment      : integer;
    SOrderPayment        : string;
    SOrderPhone          : string;
    NAutoGenPhone        : integer;
    SOrderShipName       : string;
    NAutoGenShipName     : integer;
    NAutoGenCity         : integer;
    SOrderCity           : string;
    SOrderShipStreet     : string;
    NAutoGenShipStreet   : integer;
    SOrderEMail          : string;
    NAutoGenEmail        : integer;
    SOrderComment        : string;
    SOrderDT             : string;
    NOrderStatus         : integer;
    SStatusName          : string;
    SOrderStatus         : string;
    SOrderStatusDate     : string;
    NUSER                : integer;
    SUSER                : string;
    SCreateDate          : string;
    SCloseDate           : string;
    NID_IPA_DhRes        : integer;
    IStateArmour         : integer;
    SDispatchDeclaration : string;
    SNoteCourier         : string;
    bStateConnection     : boolean;
    ISignNew             : integer;
    SSetQueueDate        : string;
    NGroupPharm          : integer;
    SGroupPharm          : string;
    SExport1CDate        : string;
    BSignBell            : boolean;
    SSignBell            : string;
    SBellDate            : string;
    SSMSDate             : string;
    SPayDate             : string;
    SAssemblingDate      : string;
    NNPOST_StateID       : integer;
    SNPOST_StateName     : string;
    SNPOST_StateDate     : string;
    SBlackListDate       : string;
    SDateReceived        : string;
    SChildDateReceived   : string;
    SStockDateBegin      : string;
    SPharmAssemblyDate   : string;
    NPharmAssemblyUser   : integer;
  end;

type
  TDMJOPH = class(TDataModule)
    qrspMain: TADOStoredProc;
    dsMain: TDataSource;
    qrspItem: TADOStoredProc;
    dsItem: TDataSource;
    dsHist: TDataSource;
    qrspHist: TADOStoredProc;
    qrspQueMain: TADOStoredProc;
    qrspQueSlave: TADOStoredProc;
    dsQueMain: TDataSource;
    dsQueSlave: TDataSource;
    spLetActionClose: TADOStoredProc;
    spSetInQueue: TADOStoredProc;
    spQueForcedCheck: TADOStoredProc;
    spQueForcedClose: TADOStoredProc;
    qrspNetNomenclature: TADOStoredProc;
    dsNetNomenclature: TDataSource;
    qrspRemnItemIPA: TADOStoredProc;
    dsRemnItemIPA: TDataSource;
    qrspNetTermItem: TADOStoredProc;
    dsNetTermItem: TDataSource;
    spGetPrimaryArtCode: TADOStoredProc;
    procedure dsQueMainDataChange(Sender: TObject; Field: TField);
    procedure dsNetNomenclatureDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ExecConditionJOPHItem(JOPHOrderBy : string; JOPHDirection : boolean);
    procedure ExecConditionJOPHHist;
    procedure ExecConditionJOPHQueSlave(OrderBy : string; Direction : boolean);
    procedure ExecConditionRemnItemIPA(
                                       SignGrid              : integer;
                                       OrderBy               : string;
                                       Direction             : boolean;
                                       IDENT                 : int64;
                                       ItemCode              : integer;
                                       ItemQuantity          : integer;
                                       OnlyCount             : boolean;
                                       OnlyCountForAllItem   : boolean;
                                       OnlyItemOnAllPharmacy : boolean;
                                       SPharmacy             : string;
                                       NPharmacy             : integer;
                                       AccountMonth          : smallint
                                      );
    procedure ExecConditionNetTermItem(
                                       SignGrid             : integer;
                                       OrderBy              : string;
                                       Direction            : boolean;
                                       ItemCode             : integer;
                                       PrimaryArtCode       : integer;
                                       ItemQuantity         : integer;
                                       OnlyCount            : boolean;
                                       SPharmacy            : string;
                                       NPharmacy            : integer;
                                       SignTerm             : boolean;
                                       SignOnlyCurrentTerm  : boolean
                                      );
    procedure LetActionClose(Mode : boolean; RNHist : int64; USER : integer; var SignState : byte);
    procedure SetInQueue(USER : integer; RN : int64);
    function  SignQueForcedCheck(USER : integer; RN : int64) : boolean;
    procedure QueForcedClose(USER : integer; RN : int64);
    function  GetPrimaryArtCode(ArtCode : integer; USER : integer; Pharmacy : integer) : integer;
  end;

Const
  cDefOrderItems_GridMainNom = 1;
  cDefOrderItems_GridOrder   = 2;
  {--}
  cDefOrderItems_SelectItem_WithoutPharm  = 0;
  cDefOrderItems_SelectItem_WithPharmItem = 1;
  cDefOrderItems_SelectItem_WithPharmTerm = 2;

var
  DMJOPH: TDMJOPH;

implementation

uses UMAIN, UCCenterJournalNetZkz, {JOPH_Queue,} CCJO_DefOrderItems, ExDBGRID;

{$R *.dfm}

procedure TDMJOPH.ExecConditionJOPHItem(JOPHOrderBy : string; JOPHDirection : boolean);
begin
end;

procedure TDMJOPH.ExecConditionJOPHHist;
begin
end;

procedure TDMJOPH.dsQueMainDataChange(Sender: TObject; Field: TField);
begin
{
  if length(frmJOPH_Queue.GetSortSlaveField) = 0 then begin
    // Первичная инициализация через определени сортировки по умолчанию
    frmJOPH_Queue.GridSlave.OnTitleClick(get_column_by_fieldname('NArtCode',frmJOPH_Queue.GridSlave));
  end else begin
    ExecConditionJOPHQueSlave(frmJOPH_Queue.GetSortSlaveField,frmJOPH_Queue.GetSortSlaveDirection);
  end;
  frmJOPH_Queue.ShowGets;}
end;

procedure TDMJOPH.ExecConditionJOPHQueSlave(OrderBy : string; Direction : boolean);
begin
{
  if frmJOPH_Queue.GridMain.DataSource.DataSet.IsEmpty then begin
    qrspQueSlave.Active := false;
    qrspQueSlave.Parameters.ParamByName('@NRN').Value := 0;
    qrspQueSlave.Parameters.ParamByName('@OrderBy').Value := OrderBy;
    qrspQueSlave.Parameters.ParamByName('@Direction').Value := Direction;
    qrspQueSlave.Active := true;
  end else begin
    qrspQueSlave.Active := false;
    qrspQueSlave.Parameters.ParamByName('@NRN').Value := frmJOPH_Queue.GridMain.DataSource.DataSet.FieldByName('NRN').AsVariant;
    qrspQueSlave.Parameters.ParamByName('@OrderBy').Value := OrderBy;
    qrspQueSlave.Parameters.ParamByName('@Direction').Value := Direction;
    qrspQueSlave.Active := true;
  end;}
end;

procedure TDMJOPH.ExecConditionRemnItemIPA(
                                           SignGrid              : integer;
                                           OrderBy               : string;
                                           Direction             : boolean;
                                           IDENT                 : int64;
                                           ItemCode              : integer;
                                           ItemQuantity          : integer;
                                           OnlyCount             : boolean;
                                           OnlyCountForAllItem   : boolean;
                                           OnlyItemOnAllPharmacy : boolean;
                                           SPharmacy             : string;
                                           NPharmacy             : integer;
                                           AccountMonth          : smallint
                                          );
var
  SignIsEmpty : boolean;
begin
  if (
          (SignGrid = cDefOrderItems_GridMainNom)
      and (qrspNetNomenclature.IsEmpty)
     )
     or
     (
          (SignGrid = cDefOrderItems_GridOrder)
     )
     then SignIsEmpty := true
     else SignIsEmpty := false;
  if SignIsEmpty then begin
    qrspRemnItemIPA.Active := false;
    qrspRemnItemIPA.Parameters.ParamByName('@OrderBy').Value               := OrderBy;
    qrspRemnItemIPA.Parameters.ParamByName('@Direction').Value             := Direction;
    qrspRemnItemIPA.Parameters.ParamByName('@IDENT').Value                 := 0;
    qrspRemnItemIPA.Parameters.ParamByName('@ItemCode').Value              := 0;
    qrspRemnItemIPA.Parameters.ParamByName('@ItemQuantity').Value          := 0;
    qrspRemnItemIPA.Parameters.ParamByName('@OnlyCount').Value             := 0;
    qrspRemnItemIPA.Parameters.ParamByName('@OnlyCountForAllItem').Value   := 0;
    qrspRemnItemIPA.Parameters.ParamByName('@OnlyItemOnAllPharmacy').Value := 0;
    qrspRemnItemIPA.Parameters.ParamByName('@SPharmacy').Value             := '';
    qrspRemnItemIPA.Parameters.ParamByName('@NPharmacy').Value             := 0;
    qrspRemnItemIPA.Parameters.ParamByName('@AccountMonth').Value          := 0;
    qrspRemnItemIPA.Active := true;
  end else begin
    qrspRemnItemIPA.Active := false;
    qrspRemnItemIPA.Parameters.ParamByName('@OrderBy').Value               := OrderBy;
    qrspRemnItemIPA.Parameters.ParamByName('@Direction').Value             := Direction;
    qrspRemnItemIPA.Parameters.ParamByName('@IDENT').Value                 := IDENT;
    qrspRemnItemIPA.Parameters.ParamByName('@ItemCode').Value              := ItemCode;
    qrspRemnItemIPA.Parameters.ParamByName('@ItemQuantity').Value          := ItemQuantity;
    qrspRemnItemIPA.Parameters.ParamByName('@OnlyCount').Value             := OnlyCount;
    qrspRemnItemIPA.Parameters.ParamByName('@OnlyCountForAllItem').Value   := OnlyCountForAllItem;
    qrspRemnItemIPA.Parameters.ParamByName('@OnlyItemOnAllPharmacy').Value := OnlyItemOnAllPharmacy;
    qrspRemnItemIPA.Parameters.ParamByName('@SPharmacy').Value             := SPharmacy;
    qrspRemnItemIPA.Parameters.ParamByName('@NPharmacy').Value             := NPharmacy;
    qrspRemnItemIPA.Parameters.ParamByName('@AccountMonth').Value          := AccountMonth;
    qrspRemnItemIPA.Active := true;
  end;
end;

procedure TDMJOPH.ExecConditionNetTermItem(
                                           SignGrid             : integer;
                                           OrderBy              : string;
                                           Direction            : boolean;
                                           ItemCode             : integer;
                                           PrimaryArtCode       : integer;
                                           ItemQuantity         : integer;
                                           OnlyCount            : boolean;
                                           SPharmacy            : string;
                                           NPharmacy            : integer;
                                           SignTerm             : boolean;
                                           SignOnlyCurrentTerm  : boolean
                                          );
var
  SignIsEmpty : boolean;
begin
  if (
          (SignGrid = cDefOrderItems_GridMainNom)
      and (qrspNetNomenclature.IsEmpty)
     )
     or
     (
          (SignGrid = cDefOrderItems_GridOrder)
     )
     then SignIsEmpty := true
     else SignIsEmpty := false;
  if SignIsEmpty then begin
    qrspNetTermItem.Active := false;
    qrspNetTermItem.Parameters.ParamByName('@OrderBy').Value             := OrderBy;
    qrspNetTermItem.Parameters.ParamByName('@Direction').Value           := Direction;
    qrspNetTermItem.Parameters.ParamByName('@ItemCode').Value            := 0;
    qrspNetTermItem.Parameters.ParamByName('@PrimaryArtCode').Value      := 0;
    qrspNetTermItem.Parameters.ParamByName('@itemQuantity').Value        := 0;
    qrspNetTermItem.Parameters.ParamByName('@OnlyCount').Value           := false;
    qrspNetTermItem.Parameters.ParamByName('@SPharmacy').Value           := '';
    qrspNetTermItem.Parameters.ParamByName('@NPharmacy').Value           := 0;
    qrspNetTermItem.Parameters.ParamByName('@SignTerm').Value            := false;
    qrspNetTermItem.Parameters.ParamByName('@SignOnlyCurrentTerm').Value := false;
    qrspNetTermItem.Active := true;
  end else begin
    qrspNetTermItem.Active := false;
    qrspNetTermItem.Parameters.ParamByName('@OrderBy').Value             := OrderBy;
    qrspNetTermItem.Parameters.ParamByName('@Direction').Value           := Direction;
    qrspNetTermItem.Parameters.ParamByName('@ItemCode').Value            := ItemCode;
    qrspNetTermItem.Parameters.ParamByName('@PrimaryArtCode').Value      := PrimaryArtCode;
    qrspNetTermItem.Parameters.ParamByName('@itemQuantity').Value        := ItemQuantity;
    qrspNetTermItem.Parameters.ParamByName('@OnlyCount').Value           := OnlyCount;
    qrspNetTermItem.Parameters.ParamByName('@SPharmacy').Value           := SPharmacy;
    qrspNetTermItem.Parameters.ParamByName('@NPharmacy').Value           := NPharmacy;
    qrspNetTermItem.Parameters.ParamByName('@SignTerm').Value            := SignTerm;
    qrspNetTermItem.Parameters.ParamByName('@SignOnlyCurrentTerm').Value := SignOnlyCurrentTerm;
    qrspNetTermItem.Active := true;
  end;
end;

procedure TDMJOPH.LetActionClose(Mode : boolean; RNHist : int64; USER : integer; var SignState : byte);
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  try
    spLetActionClose.Parameters.ParamValues['@Mode']   := Mode;
    spLetActionClose.Parameters.ParamValues['@RNHist'] := RNHist;
    spLetActionClose.Parameters.ParamValues['@NUSER']  := USER;
    spLetActionClose.ExecProc;
    IErr := spLetActionClose.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      SignState := spLetActionClose.Parameters.ParamValues['@SignState'];
    end else begin
      SErr := spLetActionClose.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDMJOPH.SetInQueue(USER : integer; RN : int64);
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  try
    spSetInQueue.Parameters.ParamValues['@USER'] := USER;
    spSetInQueue.Parameters.ParamValues['@RN']   := RN;
    spSetInQueue.ExecProc;
    IErr := spSetInQueue.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      ShowMessage('Заказ поставлен в очередь на обработку');
    end else begin
      SErr := spSetInQueue.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
      ShowMessage(SErr);
    end;
  end;
end;

function TDMJOPH.SignQueForcedCheck(USER : integer; RN : int64) : boolean;
var
  IErr      : integer;
  SErr      : string;
  SignCheck : boolean;
begin
  IErr := 0;
  SErr := '';
  SignCheck := false;
  try
    spQueForcedCheck.Parameters.ParamValues['@USER'] := USER;
    spQueForcedCheck.Parameters.ParamValues['@RN']   := RN;
    spQueForcedCheck.ExecProc;
    IErr := spQueForcedCheck.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      SignCheck := spQueForcedCheck.Parameters.ParamValues['@SignCheck'];
    end else begin
      SErr := spQueForcedCheck.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
      ShowMessage(SErr);
    end;
  end;
  result := SignCheck;
end;

procedure TDMJOPH.QueForcedClose(USER : integer; RN : int64);
var
  IErr      : integer;
  SErr      : string;
begin
  IErr := 0;
  SErr := '';
  try
    spQueForcedClose.Parameters.ParamValues['@USER'] := USER;
    spQueForcedClose.Parameters.ParamValues['@RN']   := RN;
    spQueForcedClose.ExecProc;
    IErr := spQueForcedClose.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
    end else begin
      SErr := spQueForcedClose.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
      ShowMessage(SErr);
    end;
  end;
end;

procedure TDMJOPH.dsNetNomenclatureDataChange(Sender: TObject; Field: TField);
begin
  if          frmCCJO_DefOrderItems.pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
    if length(frmCCJO_DefOrderItems.GetItemIPASortField) = 0 then begin
      { Первичная инициализация через определени сортировки по умолчанию }
      frmCCJO_DefOrderItems.GridItemIPA.OnTitleClick(get_column_by_fieldname('SAptekaName',frmCCJO_DefOrderItems.GridItemIPA));
    end else begin
      frmCCJO_DefOrderItems.aItemIPACond.Execute;
    end;
  end else if frmCCJO_DefOrderItems.pgGridSlave.ActivePage.Name = 'tabGridSlave_Term' then begin
    if length(frmCCJO_DefOrderItems.GetTermIPASortField) = 0 then begin
      { Первичная инициализация через определени сортировки по умолчанию }
      frmCCJO_DefOrderItems.GridTermItemIPA.OnTitleClick(get_column_by_fieldname('SAptekaName',frmCCJO_DefOrderItems.GridTermItemIPA));
    end else begin
      ExecConditionNetTermItem(
                               cDefOrderItems_GridMainNom,
                               frmCCJO_DefOrderItems.GetTermIPASortField,
                               frmCCJO_DefOrderItems.GetTermIPASortDirection,
                               frmCCJO_DefOrderItems.GetItemIPAItemCode,
                               frmCCJO_DefOrderItems.GetPrimaryArtCode,
                               frmCCJO_DefOrderItems.GetItemIPAItemQuantity,
                               frmCCJO_DefOrderItems.GetItemIPAOnlyCount,
                               frmCCJO_DefOrderItems.GetItemIPASPharmacy,
                               frmCCJO_DefOrderItems.GetItemIPANPharmacy,
                               frmCCJO_DefOrderItems.GetGignTerm,
                               frmCCJO_DefOrderItems.SignOnlyCurrentTerm
                              );
    end;
  end;
  frmCCJO_DefOrderItems.ShowGets;
end;

function TDMJOPH.GetPrimaryArtCode(ArtCode : integer; USER : integer; Pharmacy : integer) : integer;
var
  IErr : integer;
  SErr : string;
  PrimaryArtCode : integer;
begin
  IErr := 0;
  SErr := '';
  PrimaryArtCode := 0;
  try
    spGetPrimaryArtCode.Parameters.ParamValues['@ArtCode']  := ArtCode;
    spGetPrimaryArtCode.Parameters.ParamValues['@USER']     := USER;
    spGetPrimaryArtCode.Parameters.ParamValues['@Pharmacy'] := Pharmacy;
    spGetPrimaryArtCode.ExecProc;
    IErr := spGetPrimaryArtCode.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      PrimaryArtCode := spGetPrimaryArtCode.Parameters.ParamValues['@PrimaryArtCode'];
    end else begin
      SErr := spGetPrimaryArtCode.Parameters.ParamValues['@SErr'];
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
  result := PrimaryArtCode;
end;

end.

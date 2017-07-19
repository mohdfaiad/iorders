// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program IOrders;

uses
  Forms,
  Windows,
  UEnterPassw in 'UEnterPassw.pas' {FEnterpassw},
  uDMJSO in 'uDMJSO.pas' {dmJSO: TDataModule},
  uSprGridFrm in '..\Util\sprClasses\uSprGridFrm.pas' {sprGridFrm: TFrame},
  CCJSO_DM in 'CCJSO_DM.pas' {DM_CCJSO: TDataModule},
  UtilsBase in 'UtilsBase.pas',
  uSprCommonDlg in '..\Util\sprClasses\uSprCommonDlg.pas' {SprCommonDlg},
  uSprRef in '..\Util\sprClasses\uSprRef.pas' {fmSprRef},
  uSprItemDlg in '..\Util\sprClasses\uSprItemDlg.pas' {SprItemDlg},
  uActionDlg in 'uActionDlg.pas' {ActionDlg},
  uActionCore in 'uActionCore.pas',
  uAlertCore in 'Core\uAlertCore.pas',
  uBPCtxFrame in 'Frames\uBPCtxFrame.pas' {BPCtxFrame: TFrame},
  uBPSpecRef in 'uBPSpecRef.pas' {fmBPSpecRef},
  uIPTelMapFrame in 'Frames\uIPTelMapFrame.pas' {IPTelMapFrame: TFrame},
  uOrderHistoryDlg in 'Dlg\uOrderHistoryDlg.pas',
  ufmCommonAlert in 'Core\ufmCommonAlert.pas' {fmCommonAlert},
  ufrmAlert in 'Core\ufrmAlert.pas' {frmAlert: TFrame},
  ufrmCallClientAlert in 'Core\ufrmCallClientAlert.pas' {frmCallClientAlert: TFrame},
  uClientRef in 'Refs\uClientRef.pas' {fmClientRef},
  uIPTelMapRef in 'Refs\uIPTelMapRef.pas' {fmIPTelMapRef},
  uPayTransStatusGrid in 'uPayTransStatusGrid.pas' {PayTransStatusGrid: TFrame},
  UCCenterJournalNetZkz in 'UCCenterJournalNetZkz.pas' {FCCenterJournalNetZkz},
  uMain in 'uMain.pas' {Form1: TDataModule},
  Util in 'Util.pas',
  CCJS_PickPharmacy in 'CCJS_PickPharmacy.pas' {frmCCJS_PickPharmacy},
  CCJS_UpdPharmacyZakaz in 'CCJS_UpdPharmacyZakaz.pas' {frmCCJS_UpdPharmacyZakaz},
  CCJS_JournalRegLoadOrders in 'CCJS_JournalRegLoadOrders.pas' {frmCCJS_JournalRegLoadOrders},
  UStateConnectionPharmacy in 'UStateConnectionPharmacy.pas' {frmStateConnectionPharmacy},
  CCJS_MarkDispatchDeclaration in 'CCJS_MarkDispatchDeclaration.pas' {frmCCJS_MarkDispatchDeclaration},
  CCJS_MarkNote in 'CCJS_MarkNote.pas' {frmCCJS_MarkNote},
  UReference in 'UReference.pas' {frmReference},
  ExDBGRID in 'ExDBGRID.pas',
  CCJS_State in 'CCJS_State.pas' {frmCCJS_State},
  CCJS_SetDrivers in 'CCJS_SetDrivers.pas' {frmCCJS_SetDrivers},
  CCJS_PartsPosition in 'CCJS_PartsPosition.pas' {frmCCJS_PartsPosition},
  CCJS_OrderStatus in 'CCJS_OrderStatus.pas' {frmCCJS_OrderStatus},
  CCJS_ArtCodeTerm in 'CCJS_ArtCodeTerm.pas' {frmCCJS_ArtCodeTerm},
  CCJFB_Status in 'CCJFB_Status.pas' {frmCCJFB_Status},
  CCJS_RP_QuantIndicatorsUserExperience in 'CCJS_RP_QuantIndicatorsUserExperience.pas' {frmCCJS_RP_QuantIndicatorsUserExperience},
  CCJSO_Condition in 'CCJSO_Condition.pas' {frmCCJSO_Condition},
  CCJSO_JRegError in 'CCJSO_JRegError.pas' {frmCCJSO_JRegError},
  CCJSO_SumArmor in 'CCJSO_SumArmor.pas' {frmCCJSO_SumArmor},
  CCJS_ComeBack in 'CCJS_ComeBack.pas' {frmCCJS_ComeBack},
  CCJS_RP_Order in 'CCJS_RP_Order.pas' {frmCCJS_RP_Order},
  CCJS_ItemCard in 'CCJS_ItemCard.pas' {frmCCJS_ItemCard},
  CCJS_RP_StateOpenOrder in 'CCJS_RP_StateOpenOrder.pas' {frmCCJS_RP_StateOpenOrder},
  CCJRMO_Status in 'CCJRMO_Status.pas' {frmCCJRMO_Status},
  CCJS_RP_Pay in 'CCJS_RP_Pay.pas' {frmCCJS_RP_Pay},
  CCJS_RP_JEMailBadArmor in 'CCJS_RP_JEMailBadArmor.pas' {frmCCJS_RP_JEMailBadArmor},
  CCJS_RP_Courier in 'CCJS_RP_Courier.pas' {frmCCJS_RP_Courier},
  CCJS_Pay in 'CCJS_Pay.pas' {frmCCJS_Pay},
  CCJRMO_Item in 'CCJRMO_Item.pas' {frmCCJRMO_Item},
  CCJRMO_State in 'CCJRMO_State.pas' {frmCCJRMO_State},
  CCJCALL_Status in 'CCJCALL_Status.pas' {frmCCJCALL_Status},
  CCJCall_RP_Statistics in 'CCJCall_RP_Statistics.pas' {frmCCJCall_RP_Statistics},
  CCJSO_MyOrder in 'CCJSO_MyOrder.pas' {frmCCJSO_MyOrder},
  DepED_WAlert in 'DepED_WAlert.pas' {frmDepED_WAlert},
  CCJSO_JournalAlert in 'CCJSO_JournalAlert.pas' {frmCCJSO_JournalAlert},
  CCJAL_CreateUserMsg in 'CCJAL_CreateUserMsg.pas' {frmCCJAL_CreateUserMsg},
  CCJSO_SessionUsers in 'CCJSO_SessionUsers.pas' {frmCCJSO_SessionUser},
  CCSJO_AlertContents in 'CCSJO_AlertContents.pas' {frmCCSJO_AlertContents},
  CCJSO_OrderHeaderItem in 'CCJSO_OrderHeaderItem.pas' {frmCCJSO_OrderHeaderItem},
  CCJSO_NPost_StateDate in 'CCJSO_NPost_StateDate.pas' {frmCCJSO_NPost_StateDate},
  CCJSO_NPostOverdue in 'CCJSO_NPostOverdue.pas' {frmCCJSO_NPostOverdue},
  CCJSO_RP_ConsolidatedNetOrder in 'CCJSO_RP_ConsolidatedNetOrder.pas' {frmCCJSO_RP_ConsolidatedNetOrder},
  CCJSO_SetFieldDate in 'CCJSO_SetFieldDate.pas' {frmCCJSO_SetFieldDate},
  CCJSO_RP_PayCashOnDelivery in 'CCJSO_RP_PayCashOnDelivery.pas' {frmCCJSO_RP_PayCashOnDelivery},
  CCJSO_Version in 'CCJSO_Version.pas' {frmCCJSO_Version},
  CCJSO_SetLink in 'CCJSO_SetLink.pas' {frmCCJSO_SetLink},
  CCJSO_BlackListControl in 'CCJSO_BlackListControl.pas' {frmCCJSO_BlackListControl},
  CC_BlackListJournal in 'CC_BlackListJournal.pas' {frmCC_BlackListJournal},
  CCJSO_HeaderHistory in 'CCJSO_HeaderHistory.pas' {frmCCJSO_HeaderHistory},
  CCJSO_RP_StateOrdersDeliveryPay in 'CCJSO_RP_StateOrdersDeliveryPay.pas' {frmCCJSO_RP_StateOrdersDeliveryPay},
  CCJSO_AutoDial in 'CCJSO_AutoDial.pas' {frmCCJSO_AutoDial},
  CCJSO_AccessUserAlert in 'CCJSO_AccessUserAlert.pas' {frmCCJSO_AccessUserAlert},
  CCJSO_RefStatusSequence in 'CCJSO_RefStatusSequence.pas' {frmCCJSO_RefStatusSequence},
  CCJSO_RefUsers in 'CCJSO_RefUsers.pas' {frmCCJSO_RefUsers},
  CCJSO_AutoGenRefNomencl in 'CCJSO_AutoGenRefNomencl.pas' {frmAutoGenRefNomencl},
  CCJSO_JournalMsgClient in 'CCJSO_JournalMsgClient.pas' {frmCCJSO_JournalMsgClient},
  CCJSO_ClientNotice_PayDetails in 'CCJSO_ClientNotice_PayDetails.pas' {frmCCJSO_ClientNotice_PayDetails},
  CCJO_DefOrderItems in 'CCJO_DefOrderItems.pas' {frmCCJO_DefOrderItems};

{$R *.res}

begin
  Application.Initialize;
  FEnterpassw := TFEnterpassw.Create(nil);
  FEnterpassw.ShowModal;
  if not FEnterpassw.presultat then
  begin
    exit;
  end;
  Application.Title := 'Интернет заказы';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM_CCJSO, DM_CCJSO);
  Application.CreateForm(TdmJSO, dmJSO);
  Application.CreateForm(TFCCenterJournalNetZkz, FCCenterJournalNetZkz);
  Application.Run;
end.

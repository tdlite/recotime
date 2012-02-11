unit EventSystemLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 8291 $
// File generated on 28.01.2012 14:30:13 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\system32\es.dll (1)
// LIBID: {4E14FB90-2E22-11D1-9964-00C04FBBB345}
// LCID: 0
// Helpfile: 
// HelpString: EventSystem 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  EventSystemLibMajorVersion = 1;
  EventSystemLibMinorVersion = 0;

  LIBID_EventSystemLib: TGUID = '{4E14FB90-2E22-11D1-9964-00C04FBBB345}';

  IID_IEnumEventObject: TGUID = '{F4A07D63-2E25-11D1-9964-00C04FBBB345}';
  IID_IEventObjectCollection: TGUID = '{F89AC270-D4EB-11D1-B682-00805FC79216}';
  IID_IEventControl: TGUID = '{0343E2F4-86F6-11D1-B760-00C04FB926AF}';
  IID_IPublisherFilter: TGUID = '{465E5CC0-7B26-11D1-88FB-0080C7D771BF}';
  IID_IFiringControl: TGUID = '{E0498C93-4EFE-11D1-9971-00C04FBBB345}';
  IID_IEventSubscription: TGUID = '{4A6B0E15-2E38-11D1-9965-00C04FBBB345}';
  IID_IMultiInterfaceEventControl: TGUID = '{0343E2F5-86F6-11D1-B760-00C04FB926AF}';
  IID_IMultiInterfacePublisherFilter: TGUID = '{465E5CC1-7B26-11D1-88FB-0080C7D771BF}';
  IID_IEventSystem: TGUID = '{4E14FB9F-2E22-11D1-9964-00C04FBBB345}';
  IID_IEventPublisher: TGUID = '{E341516B-2E32-11D1-9964-00C04FBBB345}';
  IID_IEventClass: TGUID = '{FB2B72A0-7A68-11D1-88F9-0080C7D771BF}';
  IID_IEventClass2: TGUID = '{FB2B72A1-7A68-11D1-88F9-0080C7D771BF}';
  IID_IEventObjectChange: TGUID = '{F4A07D70-2E25-11D1-9964-00C04FBBB345}';
  IID_IEventObjectChange2: TGUID = '{7701A9C3-BD68-438F-83E0-67BF4F53A422}';
  IID_IEventProperty: TGUID = '{DA538EE2-F4DE-11D1-B6BB-00805FC79216}';
  IID_IDontSupportEventSubscription: TGUID = '{784121F1-62A6-4B89-855F-D65F296DE83A}';
  IID_IEventClass3: TGUID = '{7FB7EA43-2D76-4EA8-8CD9-3DECC270295E}';
  IID_IEventClassInternal: TGUID = '{9F83871A-195F-44B5-A46F-18FFFE152F7C}';
  IID_IAmAFiringAgent: TGUID = '{0771CB93-DA7C-44B5-8196-422E6A2FBC40}';
  IID_IEventClassParallelFiringTimeout: TGUID = '{A5657E5C-7BAE-4E81-9C17-284655918763}';
  IID_IEventSubscription2: TGUID = '{4A6B0E16-2E38-11D1-9965-00C04FBBB345}';
  IID_IEventSubscription3: TGUID = '{FBC1D17D-C498-43A0-81AF-423DDD530AF6}';
  IID_IEventSubscriptionInternal: TGUID = '{9B724996-D383-4C5F-B0F6-2814708C7633}';
  IID_IEventSystem2: TGUID = '{99CC098F-A48A-4E9C-8E58-965C0AFC19D5}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum __MIDL_IEventObjectChange_0001
type
  __MIDL_IEventObjectChange_0001 = TOleEnum;
const
  EOC_NewObject = $00000000;
  EOC_ModifiedObject = $00000001;
  EOC_DeletedObject = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IEnumEventObject = interface;
  IEventObjectCollection = interface;
  IEventObjectCollectionDisp = dispinterface;
  IEventControl = interface;
  IEventControlDisp = dispinterface;
  IPublisherFilter = interface;
  IFiringControl = interface;
  IFiringControlDisp = dispinterface;
  IEventSubscription = interface;
  IEventSubscriptionDisp = dispinterface;
  IMultiInterfaceEventControl = interface;
  IMultiInterfacePublisherFilter = interface;
  IEventSystem = interface;
  IEventSystemDisp = dispinterface;
  IEventPublisher = interface;
  IEventPublisherDisp = dispinterface;
  IEventClass = interface;
  IEventClassDisp = dispinterface;
  IEventClass2 = interface;
  IEventClass2Disp = dispinterface;
  IEventObjectChange = interface;
  IEventObjectChange2 = interface;
  IEventProperty = interface;
  IEventPropertyDisp = dispinterface;
  IDontSupportEventSubscription = interface;
  IEventClass3 = interface;
  IEventClass3Disp = dispinterface;
  IEventClassInternal = interface;
  IAmAFiringAgent = interface;
  IEventClassParallelFiringTimeout = interface;
  IEventSubscription2 = interface;
  IEventSubscription2Disp = dispinterface;
  IEventSubscription3 = interface;
  IEventSubscription3Disp = dispinterface;
  IEventSubscriptionInternal = interface;
  IEventSystem2 = interface;
  IEventSystem2Disp = dispinterface;

// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}
  PSYSINT1 = ^SYSINT; {*}
  PUserType1 = ^TGUID; {*}
  PUserType2 = ^COMEVENTSYSCHANGEINFO; {*}

  EOC_ChangeType = __MIDL_IEventObjectChange_0001; 

  __MIDL___MIDL_itf_ESTlb_0001_0072_0001 = packed record
    cbSize: LongWord;
    changeType: EOC_ChangeType;
    objectID: WideString;
    partitionId: WideString;
    applicationId: WideString;
    reserved: array[0..9] of TGUID;
  end;

  COMEVENTSYSCHANGEINFO = __MIDL___MIDL_itf_ESTlb_0001_0072_0001; 

// *********************************************************************//
// Interface: IEnumEventObject
// Flags:     (0)
// GUID:      {F4A07D63-2E25-11D1-9964-00C04FBBB345}
// *********************************************************************//
  IEnumEventObject = interface(IUnknown)
    ['{F4A07D63-2E25-11D1-9964-00C04FBBB345}']
    function Clone(out ppInterface: IEnumEventObject): HResult; stdcall;
    function Next(cReqElem: LongWord; out ppInterface: IUnknown; out cRetElem: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(cSkipElem: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEventObjectCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F89AC270-D4EB-11D1-B682-00805FC79216}
// *********************************************************************//
  IEventObjectCollection = interface(IDispatch)
    ['{F89AC270-D4EB-11D1-B682-00805FC79216}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(const objectID: WideString): OleVariant; safecall;
    function Get_NewEnum: IEnumEventObject; safecall;
    function Get_Count: Integer; safecall;
    procedure Add(var Item: OleVariant; const objectID: WideString); safecall;
    procedure Remove(const objectID: WideString); safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[const objectID: WideString]: OleVariant read Get_Item; default;
    property NewEnum: IEnumEventObject read Get_NewEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IEventObjectCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F89AC270-D4EB-11D1-B682-00805FC79216}
// *********************************************************************//
  IEventObjectCollectionDisp = dispinterface
    ['{F89AC270-D4EB-11D1-B682-00805FC79216}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[const objectID: WideString]: OleVariant readonly dispid 0; default;
    property NewEnum: IEnumEventObject readonly dispid 1;
    property Count: Integer readonly dispid 2;
    procedure Add(var Item: OleVariant; const objectID: WideString); dispid 3;
    procedure Remove(const objectID: WideString); dispid 4;
  end;

// *********************************************************************//
// Interface: IEventControl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0343E2F4-86F6-11D1-B760-00C04FB926AF}
// *********************************************************************//
  IEventControl = interface(IDispatch)
    ['{0343E2F4-86F6-11D1-B760-00C04FB926AF}']
    procedure SetPublisherFilter(const methodName: WideString; 
                                 const pPublisherFilter: IPublisherFilter); safecall;
    function Get_AllowInprocActivation: Integer; safecall;
    procedure Set_AllowInprocActivation(pfAllowInprocActivation: Integer); safecall;
    function GetSubscriptions(const methodName: WideString; const optionalCriteria: WideString; 
                              var optionalErrorIndex: SYSINT): IEventObjectCollection; safecall;
    function SetDefaultQuery(const methodName: WideString; const criteria: WideString): SYSINT; safecall;
    property AllowInprocActivation: Integer read Get_AllowInprocActivation write Set_AllowInprocActivation;
  end;

// *********************************************************************//
// DispIntf:  IEventControlDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0343E2F4-86F6-11D1-B760-00C04FB926AF}
// *********************************************************************//
  IEventControlDisp = dispinterface
    ['{0343E2F4-86F6-11D1-B760-00C04FB926AF}']
    procedure SetPublisherFilter(const methodName: WideString; 
                                 const pPublisherFilter: IPublisherFilter); dispid 1;
    property AllowInprocActivation: Integer dispid 2;
    function GetSubscriptions(const methodName: WideString; const optionalCriteria: WideString; 
                              var optionalErrorIndex: SYSINT): IEventObjectCollection; dispid 3;
    function SetDefaultQuery(const methodName: WideString; const criteria: WideString): SYSINT; dispid 4;
  end;

// *********************************************************************//
// Interface: IPublisherFilter
// Flags:     (0)
// GUID:      {465E5CC0-7B26-11D1-88FB-0080C7D771BF}
// *********************************************************************//
  IPublisherFilter = interface(IUnknown)
    ['{465E5CC0-7B26-11D1-88FB-0080C7D771BF}']
    function Initialize(const methodName: WideString; const dispUserDefined: IDispatch): HResult; stdcall;
    function PrepareToFire(const methodName: WideString; const firingControl: IFiringControl): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IFiringControl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E0498C93-4EFE-11D1-9971-00C04FBBB345}
// *********************************************************************//
  IFiringControl = interface(IDispatch)
    ['{E0498C93-4EFE-11D1-9971-00C04FBBB345}']
    procedure FireSubscription(const subscription: IEventSubscription); safecall;
  end;

// *********************************************************************//
// DispIntf:  IFiringControlDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E0498C93-4EFE-11D1-9971-00C04FBBB345}
// *********************************************************************//
  IFiringControlDisp = dispinterface
    ['{E0498C93-4EFE-11D1-9971-00C04FBBB345}']
    procedure FireSubscription(const subscription: IEventSubscription); dispid 1;
  end;

// *********************************************************************//
// Interface: IEventSubscription
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4A6B0E15-2E38-11D1-9965-00C04FBBB345}
// *********************************************************************//
  IEventSubscription = interface(IDispatch)
    ['{4A6B0E15-2E38-11D1-9965-00C04FBBB345}']
    function Get_SubscriptionID: WideString; safecall;
    procedure Set_SubscriptionID(const pbstrSubscriptionID: WideString); safecall;
    function Get_SubscriptionName: WideString; safecall;
    procedure Set_SubscriptionName(const pbstrSubscriptionName: WideString); safecall;
    function Get_PublisherID: WideString; safecall;
    procedure Set_PublisherID(const pbstrPublisherID: WideString); safecall;
    function Get_EventClassID: WideString; safecall;
    procedure Set_EventClassID(const pbstrEventClassID: WideString); safecall;
    function Get_methodName: WideString; safecall;
    procedure Set_methodName(const pbstrMethodName: WideString); safecall;
    function Get_SubscriberCLSID: WideString; safecall;
    procedure Set_SubscriberCLSID(const pbstrSubscriberCLSID: WideString); safecall;
    function Get_SubscriberInterface: IUnknown; safecall;
    procedure Set_SubscriberInterface(const ppSubscriberInterface: IUnknown); safecall;
    function Get_PerUser: Integer; safecall;
    procedure Set_PerUser(pfPerUser: Integer); safecall;
    function Get_OwnerSID: WideString; safecall;
    procedure Set_OwnerSID(const pbstrOwnerSID: WideString); safecall;
    function Get_Enabled: Integer; safecall;
    procedure Set_Enabled(pfEnabled: Integer); safecall;
    function Get_Description: WideString; safecall;
    procedure Set_Description(const pbstrDescription: WideString); safecall;
    function Get_MachineName: WideString; safecall;
    procedure Set_MachineName(const pbstrMachineName: WideString); safecall;
    function GetPublisherProperty(const bstrPropertyName: WideString): OleVariant; safecall;
    procedure PutPublisherProperty(const bstrPropertyName: WideString; var propertyValue: OleVariant); safecall;
    procedure RemovePublisherProperty(const bstrPropertyName: WideString); safecall;
    function GetPublisherPropertyCollection: IEventObjectCollection; safecall;
    function GetSubscriberProperty(const bstrPropertyName: WideString): OleVariant; safecall;
    procedure PutSubscriberProperty(const bstrPropertyName: WideString; 
                                    var propertyValue: OleVariant); safecall;
    procedure RemoveSubscriberProperty(const bstrPropertyName: WideString); safecall;
    function GetSubscriberPropertyCollection: IEventObjectCollection; safecall;
    function Get_InterfaceID: WideString; safecall;
    procedure Set_InterfaceID(const pbstrInterfaceID: WideString); safecall;
    property SubscriptionID: WideString read Get_SubscriptionID write Set_SubscriptionID;
    property SubscriptionName: WideString read Get_SubscriptionName write Set_SubscriptionName;
    property PublisherID: WideString read Get_PublisherID write Set_PublisherID;
    property EventClassID: WideString read Get_EventClassID write Set_EventClassID;
    property methodName: WideString read Get_methodName write Set_methodName;
    property SubscriberCLSID: WideString read Get_SubscriberCLSID write Set_SubscriberCLSID;
    property SubscriberInterface: IUnknown read Get_SubscriberInterface write Set_SubscriberInterface;
    property PerUser: Integer read Get_PerUser write Set_PerUser;
    property OwnerSID: WideString read Get_OwnerSID write Set_OwnerSID;
    property Enabled: Integer read Get_Enabled write Set_Enabled;
    property Description: WideString read Get_Description write Set_Description;
    property MachineName: WideString read Get_MachineName write Set_MachineName;
    property InterfaceID: WideString read Get_InterfaceID write Set_InterfaceID;
  end;

// *********************************************************************//
// DispIntf:  IEventSubscriptionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4A6B0E15-2E38-11D1-9965-00C04FBBB345}
// *********************************************************************//
  IEventSubscriptionDisp = dispinterface
    ['{4A6B0E15-2E38-11D1-9965-00C04FBBB345}']
    property SubscriptionID: WideString dispid 1;
    property SubscriptionName: WideString dispid 2;
    property PublisherID: WideString dispid 3;
    property EventClassID: WideString dispid 4;
    property methodName: WideString dispid 5;
    property SubscriberCLSID: WideString dispid 6;
    property SubscriberInterface: IUnknown dispid 7;
    property PerUser: Integer dispid 8;
    property OwnerSID: WideString dispid 9;
    property Enabled: Integer dispid 10;
    property Description: WideString dispid 11;
    property MachineName: WideString dispid 12;
    function GetPublisherProperty(const bstrPropertyName: WideString): OleVariant; dispid 13;
    procedure PutPublisherProperty(const bstrPropertyName: WideString; var propertyValue: OleVariant); dispid 14;
    procedure RemovePublisherProperty(const bstrPropertyName: WideString); dispid 15;
    function GetPublisherPropertyCollection: IEventObjectCollection; dispid 16;
    function GetSubscriberProperty(const bstrPropertyName: WideString): OleVariant; dispid 17;
    procedure PutSubscriberProperty(const bstrPropertyName: WideString; 
                                    var propertyValue: OleVariant); dispid 18;
    procedure RemoveSubscriberProperty(const bstrPropertyName: WideString); dispid 19;
    function GetSubscriberPropertyCollection: IEventObjectCollection; dispid 20;
    property InterfaceID: WideString dispid 21;
  end;

// *********************************************************************//
// Interface: IMultiInterfaceEventControl
// Flags:     (0)
// GUID:      {0343E2F5-86F6-11D1-B760-00C04FB926AF}
// *********************************************************************//
  IMultiInterfaceEventControl = interface(IUnknown)
    ['{0343E2F5-86F6-11D1-B760-00C04FB926AF}']
    function SetMultiInterfacePublisherFilter(const classFilter: IMultiInterfacePublisherFilter): HResult; stdcall;
    function GetSubscriptions(var eventIID: TGUID; const bstrMethodName: WideString; 
                              const optionalCriteria: WideString; var optionalErrorIndex: SYSINT; 
                              out ppCollection: IEventObjectCollection): HResult; stdcall;
    function SetDefaultQuery(var eventIID: TGUID; const bstrMethodName: WideString; 
                             const bstrCriteria: WideString; out errorIndex: SYSINT): HResult; stdcall;
    function Get_AllowInprocActivation(out pfAllowInprocActivation: Integer): HResult; stdcall;
    function Set_AllowInprocActivation(pfAllowInprocActivation: Integer): HResult; stdcall;
    function Get_FireInParallel(out pfFireInParallel: Integer): HResult; stdcall;
    function Set_FireInParallel(pfFireInParallel: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMultiInterfacePublisherFilter
// Flags:     (0)
// GUID:      {465E5CC1-7B26-11D1-88FB-0080C7D771BF}
// *********************************************************************//
  IMultiInterfacePublisherFilter = interface(IUnknown)
    ['{465E5CC1-7B26-11D1-88FB-0080C7D771BF}']
    function Initialize(const pEIC: IMultiInterfaceEventControl): HResult; stdcall;
    function PrepareToFire(var iid: TGUID; const methodName: WideString; 
                           const firingControl: IFiringControl): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEventSystem
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4E14FB9F-2E22-11D1-9964-00C04FBBB345}
// *********************************************************************//
  IEventSystem = interface(IDispatch)
    ['{4E14FB9F-2E22-11D1-9964-00C04FBBB345}']
    function Query(const progID: WideString; const queryCriteria: WideString; out errorIndex: SYSINT): IUnknown; safecall;
    procedure Store(const progID: WideString; const pInterface: IUnknown); safecall;
    procedure Remove(const progID: WideString; const queryCriteria: WideString; 
                     out errorIndex: SYSINT); safecall;
    function Get_EventObjectChangeEventClassID: WideString; safecall;
    function QueryS(const progID: WideString; const queryCriteria: WideString): IUnknown; safecall;
    procedure RemoveS(const progID: WideString; const queryCriteria: WideString); safecall;
    property EventObjectChangeEventClassID: WideString read Get_EventObjectChangeEventClassID;
  end;

// *********************************************************************//
// DispIntf:  IEventSystemDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4E14FB9F-2E22-11D1-9964-00C04FBBB345}
// *********************************************************************//
  IEventSystemDisp = dispinterface
    ['{4E14FB9F-2E22-11D1-9964-00C04FBBB345}']
    function Query(const progID: WideString; const queryCriteria: WideString; out errorIndex: SYSINT): IUnknown; dispid 1;
    procedure Store(const progID: WideString; const pInterface: IUnknown); dispid 2;
    procedure Remove(const progID: WideString; const queryCriteria: WideString; 
                     out errorIndex: SYSINT); dispid 3;
    property EventObjectChangeEventClassID: WideString readonly dispid 4;
    function QueryS(const progID: WideString; const queryCriteria: WideString): IUnknown; dispid 5;
    procedure RemoveS(const progID: WideString; const queryCriteria: WideString); dispid 6;
  end;

// *********************************************************************//
// Interface: IEventPublisher
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E341516B-2E32-11D1-9964-00C04FBBB345}
// *********************************************************************//
  IEventPublisher = interface(IDispatch)
    ['{E341516B-2E32-11D1-9964-00C04FBBB345}']
    function Get_PublisherID: WideString; safecall;
    procedure Set_PublisherID(const pbstrPublisherID: WideString); safecall;
    function Get_PublisherName: WideString; safecall;
    procedure Set_PublisherName(const pbstrPublisherName: WideString); safecall;
    function Get_PublisherType: WideString; safecall;
    procedure Set_PublisherType(const pbstrPublisherType: WideString); safecall;
    function Get_OwnerSID: WideString; safecall;
    procedure Set_OwnerSID(const pbstrOwnerSID: WideString); safecall;
    function Get_Description: WideString; safecall;
    procedure Set_Description(const pbstrDescription: WideString); safecall;
    function GetDefaultProperty(const bstrPropertyName: WideString): OleVariant; safecall;
    procedure PutDefaultProperty(const bstrPropertyName: WideString; var propertyValue: OleVariant); safecall;
    procedure RemoveDefaultProperty(const bstrPropertyName: WideString); safecall;
    function GetDefaultPropertyCollection: IEventObjectCollection; safecall;
    property PublisherID: WideString read Get_PublisherID write Set_PublisherID;
    property PublisherName: WideString read Get_PublisherName write Set_PublisherName;
    property PublisherType: WideString read Get_PublisherType write Set_PublisherType;
    property OwnerSID: WideString read Get_OwnerSID write Set_OwnerSID;
    property Description: WideString read Get_Description write Set_Description;
  end;

// *********************************************************************//
// DispIntf:  IEventPublisherDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E341516B-2E32-11D1-9964-00C04FBBB345}
// *********************************************************************//
  IEventPublisherDisp = dispinterface
    ['{E341516B-2E32-11D1-9964-00C04FBBB345}']
    property PublisherID: WideString dispid 1;
    property PublisherName: WideString dispid 2;
    property PublisherType: WideString dispid 3;
    property OwnerSID: WideString dispid 4;
    property Description: WideString dispid 5;
    function GetDefaultProperty(const bstrPropertyName: WideString): OleVariant; dispid 6;
    procedure PutDefaultProperty(const bstrPropertyName: WideString; var propertyValue: OleVariant); dispid 7;
    procedure RemoveDefaultProperty(const bstrPropertyName: WideString); dispid 8;
    function GetDefaultPropertyCollection: IEventObjectCollection; dispid 9;
  end;

// *********************************************************************//
// Interface: IEventClass
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB2B72A0-7A68-11D1-88F9-0080C7D771BF}
// *********************************************************************//
  IEventClass = interface(IDispatch)
    ['{FB2B72A0-7A68-11D1-88F9-0080C7D771BF}']
    function Get_EventClassID: WideString; safecall;
    procedure Set_EventClassID(const pbstrEventClassID: WideString); safecall;
    function Get_EventClassName: WideString; safecall;
    procedure Set_EventClassName(const pbstrEventClassName: WideString); safecall;
    function Get_OwnerSID: WideString; safecall;
    procedure Set_OwnerSID(const pbstrOwnerSID: WideString); safecall;
    function Get_FiringInterfaceID: WideString; safecall;
    procedure Set_FiringInterfaceID(const pbstrFiringInterfaceID: WideString); safecall;
    function Get_Description: WideString; safecall;
    procedure Set_Description(const pbstrDescription: WideString); safecall;
    function Get_CustomConfigCLSID: WideString; safecall;
    procedure Set_CustomConfigCLSID(const pbstrCustomConfigCLSID: WideString); safecall;
    function Get_TypeLib: WideString; safecall;
    procedure Set_TypeLib(const pbstrTypeLib: WideString); safecall;
    property EventClassID: WideString read Get_EventClassID write Set_EventClassID;
    property EventClassName: WideString read Get_EventClassName write Set_EventClassName;
    property OwnerSID: WideString read Get_OwnerSID write Set_OwnerSID;
    property FiringInterfaceID: WideString read Get_FiringInterfaceID write Set_FiringInterfaceID;
    property Description: WideString read Get_Description write Set_Description;
    property CustomConfigCLSID: WideString read Get_CustomConfigCLSID write Set_CustomConfigCLSID;
    property TypeLib: WideString read Get_TypeLib write Set_TypeLib;
  end;

// *********************************************************************//
// DispIntf:  IEventClassDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB2B72A0-7A68-11D1-88F9-0080C7D771BF}
// *********************************************************************//
  IEventClassDisp = dispinterface
    ['{FB2B72A0-7A68-11D1-88F9-0080C7D771BF}']
    property EventClassID: WideString dispid 1;
    property EventClassName: WideString dispid 2;
    property OwnerSID: WideString dispid 3;
    property FiringInterfaceID: WideString dispid 4;
    property Description: WideString dispid 5;
    property CustomConfigCLSID: WideString dispid 6;
    property TypeLib: WideString dispid 7;
  end;

// *********************************************************************//
// Interface: IEventClass2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB2B72A1-7A68-11D1-88F9-0080C7D771BF}
// *********************************************************************//
  IEventClass2 = interface(IEventClass)
    ['{FB2B72A1-7A68-11D1-88F9-0080C7D771BF}']
    function Get_PublisherID: WideString; safecall;
    procedure Set_PublisherID(const pbstrPublisherID: WideString); safecall;
    function Get_MultiInterfacePublisherFilterCLSID: WideString; safecall;
    procedure Set_MultiInterfacePublisherFilterCLSID(const pbstrPubFilCLSID: WideString); safecall;
    function Get_AllowInprocActivation: Integer; safecall;
    procedure Set_AllowInprocActivation(pfAllowInprocActivation: Integer); safecall;
    function Get_FireInParallel: Integer; safecall;
    procedure Set_FireInParallel(pfFireInParallel: Integer); safecall;
    property PublisherID: WideString read Get_PublisherID write Set_PublisherID;
    property MultiInterfacePublisherFilterCLSID: WideString read Get_MultiInterfacePublisherFilterCLSID write Set_MultiInterfacePublisherFilterCLSID;
    property AllowInprocActivation: Integer read Get_AllowInprocActivation write Set_AllowInprocActivation;
    property FireInParallel: Integer read Get_FireInParallel write Set_FireInParallel;
  end;

// *********************************************************************//
// DispIntf:  IEventClass2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB2B72A1-7A68-11D1-88F9-0080C7D771BF}
// *********************************************************************//
  IEventClass2Disp = dispinterface
    ['{FB2B72A1-7A68-11D1-88F9-0080C7D771BF}']
    property PublisherID: WideString dispid 8;
    property MultiInterfacePublisherFilterCLSID: WideString dispid 9;
    property AllowInprocActivation: Integer dispid 10;
    property FireInParallel: Integer dispid 11;
    property EventClassID: WideString dispid 1;
    property EventClassName: WideString dispid 2;
    property OwnerSID: WideString dispid 3;
    property FiringInterfaceID: WideString dispid 4;
    property Description: WideString dispid 5;
    property CustomConfigCLSID: WideString dispid 6;
    property TypeLib: WideString dispid 7;
  end;

// *********************************************************************//
// Interface: IEventObjectChange
// Flags:     (0)
// GUID:      {F4A07D70-2E25-11D1-9964-00C04FBBB345}
// *********************************************************************//
  IEventObjectChange = interface(IUnknown)
    ['{F4A07D70-2E25-11D1-9964-00C04FBBB345}']
    function ChangedSubscription(changeType: EOC_ChangeType; const bstrSubscriptionID: WideString): HResult; stdcall;
    function ChangedEventClass(changeType: EOC_ChangeType; const bstrEventClassID: WideString): HResult; stdcall;
    function ChangedPublisher(changeType: EOC_ChangeType; const bstrPublisherID: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEventObjectChange2
// Flags:     (0)
// GUID:      {7701A9C3-BD68-438F-83E0-67BF4F53A422}
// *********************************************************************//
  IEventObjectChange2 = interface(IUnknown)
    ['{7701A9C3-BD68-438F-83E0-67BF4F53A422}']
    function ChangedSubscription(var pInfo: COMEVENTSYSCHANGEINFO): HResult; stdcall;
    function ChangedEventClass(var pInfo: COMEVENTSYSCHANGEINFO): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEventProperty
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA538EE2-F4DE-11D1-B6BB-00805FC79216}
// *********************************************************************//
  IEventProperty = interface(IDispatch)
    ['{DA538EE2-F4DE-11D1-B6BB-00805FC79216}']
    function Get_Name: WideString; safecall;
    procedure Set_Name(const propertyName: WideString); safecall;
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(var propertyValue: OleVariant); safecall;
    property Name: WideString read Get_Name write Set_Name;
  end;

// *********************************************************************//
// DispIntf:  IEventPropertyDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA538EE2-F4DE-11D1-B6BB-00805FC79216}
// *********************************************************************//
  IEventPropertyDisp = dispinterface
    ['{DA538EE2-F4DE-11D1-B6BB-00805FC79216}']
    property Name: WideString dispid 1;
    function Value: OleVariant; dispid 2;
  end;

// *********************************************************************//
// Interface: IDontSupportEventSubscription
// Flags:     (0)
// GUID:      {784121F1-62A6-4B89-855F-D65F296DE83A}
// *********************************************************************//
  IDontSupportEventSubscription = interface(IUnknown)
    ['{784121F1-62A6-4B89-855F-D65F296DE83A}']
  end;

// *********************************************************************//
// Interface: IEventClass3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7FB7EA43-2D76-4EA8-8CD9-3DECC270295E}
// *********************************************************************//
  IEventClass3 = interface(IEventClass2)
    ['{7FB7EA43-2D76-4EA8-8CD9-3DECC270295E}']
    function Get_EventClassPartitionID: WideString; safecall;
    procedure Set_EventClassPartitionID(const pbstrEventClassPartitionID: WideString); safecall;
    function Get_EventClassApplicationID: WideString; safecall;
    procedure Set_EventClassApplicationID(const pbstrEventClassApplicationID: WideString); safecall;
    property EventClassPartitionID: WideString read Get_EventClassPartitionID write Set_EventClassPartitionID;
    property EventClassApplicationID: WideString read Get_EventClassApplicationID write Set_EventClassApplicationID;
  end;

// *********************************************************************//
// DispIntf:  IEventClass3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7FB7EA43-2D76-4EA8-8CD9-3DECC270295E}
// *********************************************************************//
  IEventClass3Disp = dispinterface
    ['{7FB7EA43-2D76-4EA8-8CD9-3DECC270295E}']
    property EventClassPartitionID: WideString dispid 12;
    property EventClassApplicationID: WideString dispid 13;
    property PublisherID: WideString dispid 8;
    property MultiInterfacePublisherFilterCLSID: WideString dispid 9;
    property AllowInprocActivation: Integer dispid 10;
    property FireInParallel: Integer dispid 11;
    property EventClassID: WideString dispid 1;
    property EventClassName: WideString dispid 2;
    property OwnerSID: WideString dispid 3;
    property FiringInterfaceID: WideString dispid 4;
    property Description: WideString dispid 5;
    property CustomConfigCLSID: WideString dispid 6;
    property TypeLib: WideString dispid 7;
  end;

// *********************************************************************//
// Interface: IEventClassInternal
// Flags:     (16) Hidden
// GUID:      {9F83871A-195F-44B5-A46F-18FFFE152F7C}
// *********************************************************************//
  IEventClassInternal = interface(IUnknown)
    ['{9F83871A-195F-44B5-A46F-18FFFE152F7C}']
    function GetAllowPerUserInprocActivation(out pfAllowPerUserInprocActivation: Integer): HResult; stdcall;
    function GetAllowPerUserActivateAsActivator(out pfAllowPerUserActivateAsActivator: Integer): HResult; stdcall;
    function GetAllowPerUserMoniker(out pfAllowPerUserMoniker: Integer): HResult; stdcall;
    function GetSerialFiringTimeout(out pdwSerialFiringTimeout: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAmAFiringAgent
// Flags:     (16) Hidden
// GUID:      {0771CB93-DA7C-44B5-8196-422E6A2FBC40}
// *********************************************************************//
  IAmAFiringAgent = interface(IUnknown)
    ['{0771CB93-DA7C-44B5-8196-422E6A2FBC40}']
  end;

// *********************************************************************//
// Interface: IEventClassParallelFiringTimeout
// Flags:     (0)
// GUID:      {A5657E5C-7BAE-4E81-9C17-284655918763}
// *********************************************************************//
  IEventClassParallelFiringTimeout = interface(IUnknown)
    ['{A5657E5C-7BAE-4E81-9C17-284655918763}']
    function Get_ParallelFiringTimeout(out pdwParallelFiringTimeout: LongWord): HResult; stdcall;
    function Set_ParallelFiringTimeout(pdwParallelFiringTimeout: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEventSubscription2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4A6B0E16-2E38-11D1-9965-00C04FBBB345}
// *********************************************************************//
  IEventSubscription2 = interface(IEventSubscription)
    ['{4A6B0E16-2E38-11D1-9965-00C04FBBB345}']
    function Get_FilterCriteria: WideString; safecall;
    procedure Set_FilterCriteria(const pbstrFilterCriteria: WideString); safecall;
    function Get_SubscriberMoniker: WideString; safecall;
    procedure Set_SubscriberMoniker(const pbstrMoniker: WideString); safecall;
    property FilterCriteria: WideString read Get_FilterCriteria write Set_FilterCriteria;
    property SubscriberMoniker: WideString read Get_SubscriberMoniker write Set_SubscriberMoniker;
  end;

// *********************************************************************//
// DispIntf:  IEventSubscription2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4A6B0E16-2E38-11D1-9965-00C04FBBB345}
// *********************************************************************//
  IEventSubscription2Disp = dispinterface
    ['{4A6B0E16-2E38-11D1-9965-00C04FBBB345}']
    property FilterCriteria: WideString dispid 22;
    property SubscriberMoniker: WideString dispid 23;
    property SubscriptionID: WideString dispid 1;
    property SubscriptionName: WideString dispid 2;
    property PublisherID: WideString dispid 3;
    property EventClassID: WideString dispid 4;
    property methodName: WideString dispid 5;
    property SubscriberCLSID: WideString dispid 6;
    property SubscriberInterface: IUnknown dispid 7;
    property PerUser: Integer dispid 8;
    property OwnerSID: WideString dispid 9;
    property Enabled: Integer dispid 10;
    property Description: WideString dispid 11;
    property MachineName: WideString dispid 12;
    function GetPublisherProperty(const bstrPropertyName: WideString): OleVariant; dispid 13;
    procedure PutPublisherProperty(const bstrPropertyName: WideString; var propertyValue: OleVariant); dispid 14;
    procedure RemovePublisherProperty(const bstrPropertyName: WideString); dispid 15;
    function GetPublisherPropertyCollection: IEventObjectCollection; dispid 16;
    function GetSubscriberProperty(const bstrPropertyName: WideString): OleVariant; dispid 17;
    procedure PutSubscriberProperty(const bstrPropertyName: WideString; 
                                    var propertyValue: OleVariant); dispid 18;
    procedure RemoveSubscriberProperty(const bstrPropertyName: WideString); dispid 19;
    function GetSubscriberPropertyCollection: IEventObjectCollection; dispid 20;
    property InterfaceID: WideString dispid 21;
  end;

// *********************************************************************//
// Interface: IEventSubscription3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FBC1D17D-C498-43A0-81AF-423DDD530AF6}
// *********************************************************************//
  IEventSubscription3 = interface(IEventSubscription2)
    ['{FBC1D17D-C498-43A0-81AF-423DDD530AF6}']
    function Get_EventClassPartitionID: WideString; safecall;
    procedure Set_EventClassPartitionID(const pbstrEventClassPartitionID: WideString); safecall;
    function Get_EventClassApplicationID: WideString; safecall;
    procedure Set_EventClassApplicationID(const pbstrEventClassApplicationID: WideString); safecall;
    function Get_SubscriberPartitionID: WideString; safecall;
    procedure Set_SubscriberPartitionID(const pbstrSubscriberPartitionID: WideString); safecall;
    function Get_SubscriberApplicationID: WideString; safecall;
    procedure Set_SubscriberApplicationID(const pbstrSubscriberApplicationID: WideString); safecall;
    property EventClassPartitionID: WideString read Get_EventClassPartitionID write Set_EventClassPartitionID;
    property EventClassApplicationID: WideString read Get_EventClassApplicationID write Set_EventClassApplicationID;
    property SubscriberPartitionID: WideString read Get_SubscriberPartitionID write Set_SubscriberPartitionID;
    property SubscriberApplicationID: WideString read Get_SubscriberApplicationID write Set_SubscriberApplicationID;
  end;

// *********************************************************************//
// DispIntf:  IEventSubscription3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FBC1D17D-C498-43A0-81AF-423DDD530AF6}
// *********************************************************************//
  IEventSubscription3Disp = dispinterface
    ['{FBC1D17D-C498-43A0-81AF-423DDD530AF6}']
    property EventClassPartitionID: WideString dispid 24;
    property EventClassApplicationID: WideString dispid 25;
    property SubscriberPartitionID: WideString dispid 26;
    property SubscriberApplicationID: WideString dispid 27;
    property FilterCriteria: WideString dispid 22;
    property SubscriberMoniker: WideString dispid 23;
    property SubscriptionID: WideString dispid 1;
    property SubscriptionName: WideString dispid 2;
    property PublisherID: WideString dispid 3;
    property EventClassID: WideString dispid 4;
    property methodName: WideString dispid 5;
    property SubscriberCLSID: WideString dispid 6;
    property SubscriberInterface: IUnknown dispid 7;
    property PerUser: Integer dispid 8;
    property OwnerSID: WideString dispid 9;
    property Enabled: Integer dispid 10;
    property Description: WideString dispid 11;
    property MachineName: WideString dispid 12;
    function GetPublisherProperty(const bstrPropertyName: WideString): OleVariant; dispid 13;
    procedure PutPublisherProperty(const bstrPropertyName: WideString; var propertyValue: OleVariant); dispid 14;
    procedure RemovePublisherProperty(const bstrPropertyName: WideString); dispid 15;
    function GetPublisherPropertyCollection: IEventObjectCollection; dispid 16;
    function GetSubscriberProperty(const bstrPropertyName: WideString): OleVariant; dispid 17;
    procedure PutSubscriberProperty(const bstrPropertyName: WideString; 
                                    var propertyValue: OleVariant); dispid 18;
    procedure RemoveSubscriberProperty(const bstrPropertyName: WideString); dispid 19;
    function GetSubscriberPropertyCollection: IEventObjectCollection; dispid 20;
    property InterfaceID: WideString dispid 21;
  end;

// *********************************************************************//
// Interface: IEventSubscriptionInternal
// Flags:     (16) Hidden
// GUID:      {9B724996-D383-4C5F-B0F6-2814708C7633}
// *********************************************************************//
  IEventSubscriptionInternal = interface(IUnknown)
    ['{9B724996-D383-4C5F-B0F6-2814708C7633}']
    function IsTransient(out pfIsTransient: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEventSystem2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {99CC098F-A48A-4E9C-8E58-965C0AFC19D5}
// *********************************************************************//
  IEventSystem2 = interface(IEventSystem)
    ['{99CC098F-A48A-4E9C-8E58-965C0AFC19D5}']
    procedure GetVersion(out pnVersion: SYSINT); safecall;
    procedure VerifyTransientSubscribers; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEventSystem2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {99CC098F-A48A-4E9C-8E58-965C0AFC19D5}
// *********************************************************************//
  IEventSystem2Disp = dispinterface
    ['{99CC098F-A48A-4E9C-8E58-965C0AFC19D5}']
    procedure GetVersion(out pnVersion: SYSINT); dispid 7;
    procedure VerifyTransientSubscribers; dispid 8;
    function Query(const progID: WideString; const queryCriteria: WideString; out errorIndex: SYSINT): IUnknown; dispid 1;
    procedure Store(const progID: WideString; const pInterface: IUnknown); dispid 2;
    procedure Remove(const progID: WideString; const queryCriteria: WideString; 
                     out errorIndex: SYSINT); dispid 3;
    property EventObjectChangeEventClassID: WideString readonly dispid 4;
    function QueryS(const progID: WideString; const queryCriteria: WideString): IUnknown; dispid 5;
    procedure RemoveS(const progID: WideString; const queryCriteria: WideString); dispid 6;
  end;

implementation

uses ComObj;

end.

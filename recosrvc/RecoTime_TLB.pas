unit RecoTime_TLB;

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
// File generated on 04.02.2012 14:01:09 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\GalimRu\Documents\RAD Studio\Projects\RecoTime\RecoTime.tlb (1)
// LIBID: {803FCC48-4CD9-45C3-879A-4FC9D30693E4}
// LCID: 0
// Helpfile: 
// HelpString: RecoTime Library
// DepndLst: 
//   (1) v2.0 SensEvents, (C:\Windows\System32\sens.dll)
//   (2) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, SensEvents_TLB, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  RecoTimeMajorVersion = 1;
  RecoTimeMinorVersion = 0;

  LIBID_RecoTime: TGUID = '{803FCC48-4CD9-45C3-879A-4FC9D30693E4}';

  CLASS_RecoLogon: TGUID = '{E1CCAF0C-8F30-48D3-88F9-1CC7E6536E14}';
type

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  RecoLogon = ISensLogon;


// *********************************************************************//
// The Class CoRecoLogon provides a Create and CreateRemote method to          
// create instances of the default interface ISensLogon exposed by              
// the CoClass RecoLogon. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRecoLogon = class
    class function Create: ISensLogon;
    class function CreateRemote(const MachineName: string): ISensLogon;
  end;

implementation

uses ComObj;

class function CoRecoLogon.Create: ISensLogon;
begin
  Result := CreateComObject(CLASS_RecoLogon) as ISensLogon;
end;

class function CoRecoLogon.CreateRemote(const MachineName: string): ISensLogon;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RecoLogon) as ISensLogon;
end;

end.

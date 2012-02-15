unit RecoService_TLB;

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
// File generated on 16.02.2012 0:51:42 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\recosrvc\RecoService.tlb (1)
// LIBID: {26B55A65-31A4-45A4-929E-F453A4280D27}
// LCID: 0
// Helpfile: 
// HelpString: RecoService Library
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
  RecoServiceMajorVersion = 1;
  RecoServiceMinorVersion = 0;

  LIBID_RecoService: TGUID = '{26B55A65-31A4-45A4-929E-F453A4280D27}';

  CLASS_RecoLogon: TGUID = '{BB3AF6C5-156A-48EE-903B-B2828C092459}';
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

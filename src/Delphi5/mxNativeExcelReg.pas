// ****************************************************************************
// * Native Excel Export component for Delphi.
// ****************************************************************************
// * Copyright 2001-2002, Lajos Farkas. All Rights Reserved.
// ****************************************************************************
// * This component can be freely used and distributed in commercial and
// * private environments, provied this notice is not modified in any way.
// ****************************************************************************
// * Feel free to contact me if you have any questions, comments or suggestions
// * at wmax@freemail.hu
// ****************************************************************************
// * PLEASE READ LICENCE.TXT FOR MORE INFORMATION
// ****************************************************************************
// * Web page: www.geocities.com/maxcomponents
// ****************************************************************************
// * Date last modified: 29.01.2002
// ****************************************************************************
// * TmxNativeExcel v1.22
// ****************************************************************************
// * Description:
// *
// * The TmxNativeExcel is a 100% native VCL component to create 
// * Excel BIFF files without any OLE objects..
// *
// ****************************************************************************

Unit mxNativeExcelReg;

Interface

{$I MAX.INC}

// *************************************************************************************
// ** Component registration
// *************************************************************************************

Procedure Register;

Implementation

{IFDEF DELPHI4_UP}
{R *.DCR}
{ENDIF}

// *************************************************************************************
// ** List of used units
// *************************************************************************************

Uses
     SysUtils,
     Classes,
{$IFDEF Delphi6_Up}
     DesignIntf, 
     DesignEditors,
{$ELSE}
     DsgnIntf,
     ExptIntf,
{$ENDIF}
     Forms,
//     mxNativeExcelAbout,
     mxNativeExcel;

Type

{$IFNDEF DELPHI4_UP}
     IDesigner = TDesigner;
{$ELSE}
  {$IFDEF Delphi6_Up}
     TFormDesigner = IDesigner;
  {$ELSE}
     TFormDesigner = IFormDesigner;
  {$ENDIF}
{$ENDIF}

     TDesigner = IDesigner;

// *************************************************************************************
// ** Component Editor
// *************************************************************************************

     TmxNativeExcelEditor = Class( TComponentEditor )

          Function GetVerbCount: integer; Override;
          Function GetVerb( Index: integer ): String; Override;
          Procedure ExecuteVerb( Index: integer ); Override;
     End;

// *************************************************************************************
// ** GetVerbCount
// *************************************************************************************

Function TmxNativeExcelEditor.GetVerbCount: integer;
Begin
     Result := 1;
End;

// *************************************************************************************
// ** GetVerb
// *************************************************************************************

Function TmxNativeExcelEditor.GetVerb( Index: integer ): String;
Begin
     Case Index Of
          0: Result := Format('%s (C) 2001-2002 Max', [ Component.ClassName ] );
     End;
End;

// *************************************************************************************
// ** ExecuteVerb
// *************************************************************************************

Procedure TmxNativeExcelEditor.ExecuteVerb( Index: integer );
Var
     ComponentDesigner: TFormDesigner;
Begin
     ComponentDesigner := Designer;

     Case Index Of
          0: // ShowAboutBox( Format('%s Component', [ Component.ClassName ] ) );
     End;

     ComponentDesigner.Modified;
End;

// *************************************************************************************
// ** Register, 4/5/01 11:46:42 AM
// *************************************************************************************

Procedure Register;
Begin
     RegisterComponents( 'AddEu', [ TmxNativeExcel ] );
     RegisterComponentEditor( TmxNativeExcel, TmxNativeExcelEditor );
End;

End.


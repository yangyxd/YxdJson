{
  Copyright (C) 2005 Fabio Almeida
  fabiorecife@yahoo.com.br

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

  Autor : Jose Fabio Nascimento de Almeida
  Data : 7/11/2005


Change Logs:
2013-11-04  By yangyxd
  增加parent, child支持。增加int64支持

2009-11-22  By creation_zy
  Can parse #10 #13 inside a string.
  JSONObject.quote method can deal with special character smaller than space.
  Value inside a _String object can Read/Write directly.

2011-09-02  By creation_zy
  Add _Object to store common Object.

2011-09-20  By creation_zy
  Add SafeFreeJObj.
  Add "inline" directive.

2011-12-15  By creation_zy
  Add SpaceStr function to optimize toString3.
}
unit uJSON;

interface

uses
  Windows,SysUtils, Classes,  TypInfo;

{$DEFINE J_OBJECT}  // store common Object
{$IF COMPILERVERSION>=18}{$DEFINE INLINE_OPT}{$IFEND}
{$DEFINE BACK_OPT}
{$DEFINE NEXT_OPT}


Type
  JSONArray = class ;
  JSONBase = class;
  JSONObject = class;

  TZAbstractObject = class (TObject)
    class procedure WriteChar(avOut: TStream; const avData: Char);
    class procedure WriteString(avOut: TStream; const avData: string);
    class procedure WriteText(avOut: TStream; const avData: string; len: Integer);

    function Equals(const Value: TZAbstractObject): Boolean; virtual;
    function Hash: LongInt;
    function Clone: TZAbstractObject; virtual;
    function toString: string; virtual;
    function toJSONObject: JSONObject;
    function toJSONArray: JSONArray;
    function instanceOf(const Value: TZAbstractObject): Boolean;
    procedure SaveToStream(stream: TStream); virtual;
    class function getInt(o: TZAbstractObject; DefaultValue: Integer):Integer;
    class function getInt64(o: TZAbstractObject; DefaultValue: Int64): Int64;
    class function getDouble(o: TZAbstractObject; DefaultValue: Double):Double;
    class function getBoolean(o: TZAbstractObject; DefaultValue: Boolean):Boolean;
    procedure Free; overload;  //2011-10-10  Call SafeFreeJObj
  end;

  ClassCastException = class (Exception) end;
  NoSuchElementException = class (Exception) end;
  NumberFormatException = class (Exception) end;
  NullPointerException = class (Exception) end;
  NotImplmentedFeature = class (Exception) end;
  _Number =  class ;
  _String = class;
  _Double = class;
  _NULL = class ;
{$IFDEF J_OBJECT}
  _Object = class; //2011-08-09
{$ENDIF}


  ParseException = class (Exception)
     constructor create (_message: string ; index: integer);
  end;
  JSONTokener = class  (TZAbstractObject)
  public
    constructor create (const s: string);
    procedure back();{$IFDEF INLINE_OPT}inline;{$ENDIF}
    class function dehexchar(c: char) :integer;
    function more :boolean;{$IFDEF INLINE_OPT}inline;{$ENDIF}
    function next(): char; overload ;{$IFDEF INLINE_OPT}inline;{$ENDIF}
    function next (c:char ): char; overload ;{$IFDEF INLINE_OPT}inline;{$ENDIF}
    function next (n:integer): string; overload ;{$IFDEF INLINE_OPT}inline;{$ENDIF}
    function nextClean (): char;//{$IFDEF INLINE_OPT}inline;{$ENDIF}
    function nextString (quote: char): string;//{$IFDEF INLINE_OPT}inline;{$ENDIF}
    function nextTo (d: char): string;  overload ;
    function nextTo (const delimiters: string): char;   overload ;
    function nextValue (parent: JSONBase): TZAbstractObject ;//{$IFDEF INLINE_OPT}inline;{$ENDIF}
    procedure skipPast (const _to: string ) ;
    function skipTo (_to: char ): char;
    function syntaxError (const _message: string): ParseException;
    function toString: string;  override;
    function unescape (const s: string): string;
  private
    myIndex, Len1: integer;
    mySource: string;
  end;

  // by yangyxd 2013.11.04
  JSONBase = class(TZAbstractObject)
  private
    FParent: JSONBase;
    FName: string;
  protected
    function GetCount: Integer; virtual;
    function GetChild(Index: Integer): TZAbstractObject; virtual;
    procedure SetChild(Index: Integer; const Value: TZAbstractObject); virtual;
  public
    constructor Create;
    function IndexOfObject(aobj: TObject): Integer; virtual;
    property Count: Integer read GetCount;
    property Parent: JSONBase read FParent write FParent;
    property Name: string read FName write FName;
    property Child[Index: Integer]: TZAbstractObject read GetChild write SetChild;
  end;

  JSONObject = class (JSONBase)
  private
    myHashMap: TStringList;
    function GetPropValues(const Key: String): String;
    procedure SetPropValues(const Key: String; const Value: String);
    procedure SetAsString(const Value: String);
    function GetKeyByIndex(index: Integer): String;
    procedure SetCascadeValueEx(const Value: String; const Keys: array of String;
      StartIdx: Integer);
    function GetValByIndex(index: Integer): String;
    procedure UpdateByTokener(x: JSONTokener);
    function GetValObjByIndex(index: Integer): TZAbstractObject;
  protected
    function GetCount: Integer; override;     // by yangyxd
    function GetChild(Index: Integer): TZAbstractObject; override;   // by yangyxd
    procedure SetChild(Index: Integer; const Value: TZAbstractObject); override;  // by yangyxd
  public
    constructor Create; overload;
    constructor Create  (jo: JSONObject; sa: array of string); overload;
    constructor Create (x: JSONTokener); overload;
    constructor Create (map: TStringList); overload;
    constructor Create (const s: string); overload;
    constructor CreateInArray(Ay: JSONArray);

    function IndexOfObject(aobj: TObject): Integer; override;  // by yangyxd

    procedure Clean;
    function Clone: TZAbstractObject; override;
    function Accumulate (const key: string; value: TZAbstractObject): JSONObject;
    function Get (const key: string): TZAbstractObject;
    function GetBoolean (const key: string): boolean;
    function GetDouble (const key: string): double;
    function GetInt (const key: string): integer;
    function GetInt64 (const key: string): Int64;
    function GetJSONArray (const key: string) :JSONArray;
    function GetJSONObject (const key: string): JSONObject;
    function GetString (const key: string): string;
    function Has (const key: string): boolean;
    function IsNull (const key: string): boolean;
    function Keys: TStringList ;
    function Length: integer;
    function Names: JSONArray;
    class function NumberToString (n: _Number): string;
    class function ValueToString(value: TZAbstractObject): string; overload;
    class procedure ValueToStream(value: TZAbstractObject; stream: TStream); overload; 
    class function ValueToString(value: TZAbstractObject;
      indentFactor, indent: integer): string; overload;

    function NextSibling: JSONObject;
    function UpSibling: JSONObject;

    function Opt (const key: string): TZAbstractObject;
    function OptBoolean (const key: string): boolean; overload;
    function OptBoolean (const key: string; defaultValue: boolean): boolean; overload;
    function OptDouble (const key: string): double; overload;
    function OptDouble (const key: string; defaultValue: double): double; overload;
    function OptInt (const key: string): integer; overload;
    function OptInt (const key: string; defaultValue: integer): integer; overload;
    function OptInt64 (const key: string): int64; overload;
    function OptInt64 (const key: string; defaultValue: int64): int64; overload;
    function OptString (const key: string): string; overload;
    function OptString (const key, defaultValue: string): string; overload;

    function OptJSONArray (const key: string): JSONArray; overload;
    function OptJSONObject (const key: string): JSONObject; overload;

    function Put (const key: string; value: boolean): JSONObject; overload;
    function Put (const key: string; value: double): JSONObject; overload;
    function Put (const key: string; value: integer): JSONObject; overload;
    function Put (const key: string; value: int64): JSONObject; overload;
    function Put (const key: string; const value: string): JSONObject; overload;
    function Put (const key: string; value: TZAbstractObject): JSONObject; overload;

    function PutOpt (const key: string; value: TZAbstractObject): JSONObject;
    class function quote (const s: string): string;
    class procedure quoteToStream (stream: TStream; const s: string);
    function Remove (const key: string): TZAbstractObject;
    procedure AssignTo(json: JSONObject);

    function ToJSONArray (names: JSONArray): JSONArray;
    function toString (): string ; overload; override;
    function toString2 (indentFactor: integer): string; overload;
    function toString3 (indentFactor, indent: integer): string; overload;

    procedure SaveToStream(stream: TStream); override;

    //Add by creation_zy  2008-10-21
    property PropValues[const Key: String]:String read GetPropValues write SetPropValues; default;
    property KeyByIndex[index: Integer]:String read GetKeyByIndex;
    property ValByIndex[index: Integer]:String read GetValByIndex;
    property ValObjByIndex[index: Integer]:TZAbstractObject read GetValObjByIndex;
    property AsString:String read ToString write SetAsString;
    procedure Assign(Source: JSONObject);
    function Opt2(key, key2: string): TZAbstractObject;
    function OptString2(key, key2: String; DefaultValue: String=''): String;
    function OptInt2(key, key2: String; DefaultValue: Integer=0): Integer;
    function GetCascadeValue(const Keys: array of String): String;
    procedure SetCascadeValue(const Value: String; const Keys: array of String);
    function GetCascadeValEx(const Keys: array of String): String;
    function GetCascadeValObj(const Keys: array of String): TZAbstractObject;
    function GetDiffFrom(Source: JSONObject; UseSrc: Boolean=true):JSONObject;
    procedure Delete(index: Integer);
    procedure RemoveByKeyHeader(const Header: String='~');
    function RemoveLastKey:TZAbstractObject;
    procedure CleanKey(const Key: String);
    function SetKey(idx: Integer; const Key: String):Boolean;
    function PropCount:Integer;
    function KeyByVal(const Value: String):String;
    function PartExtract(KeyNames: TStrings; DoRemove: Boolean):JSONObject;
    function ExtractAll:JSONObject;
    function TryNewJSONArray(const Key: String):JSONArray;
    function TryNewJSONObject(const Key: String):JSONObject;
    //Add by creation_zy  2011-08-09
  {$IFDEF J_OBJECT}
    function GetObject (const key: string): TObject;
    function OptObject (const key: string): TObject; overload;
    function OptObject (const key: string; defaultValue: TObject): TObject; overload;
    function Put (const key: string; value: TObject): JSONObject; overload;
  {$ENDIF}

    destructor Destroy;override;
    class function NULL: _NULL;
  end;

  JSONArray = class (JSONBase)
  public
    destructor Destroy ; override;
    constructor Create ; overload;
    constructor Create (collection: TList); overload;
    constructor Create (x: JSONTokener); overload;
    constructor Create (const s: string);  overload;

    procedure Clean;  //by creation_zy  2009-08-19
    function Clone: TZAbstractObject; override;  //by creation_zy  2008-10-05
    function get (index: integer): TZAbstractObject;
    function getBoolean (index: integer): boolean;
    function getDouble (index: integer): double;
    function getInt (index: integer): integer;
    function getInt64 (index: integer): int64;
    function getJSONArray (index: integer): JSONArray;
    function getJSONObject (index: integer): JSONObject;
    function getString (index: integer): string;
    function isNull (index: integer): boolean;
    function join (separator: string): string;
    function length: integer;
    function opt (index: integer): TZAbstractObject;
    function optBoolean ( index: integer): boolean; overload;
    function optBoolean ( index: integer; defaultValue: boolean): boolean; overload;
    function optDouble (index: integer): double; overload;
    function optDouble (index: integer; defaultValue :double ): double ; overload;
    function optInt (index: integer): integer; overload;
    function optInt (index: integer; defaultValue: integer): integer; overload;
    function OptInt64 (index: integer): int64; overload;
    function OptInt64 (index: integer; defaultValue: int64): int64; overload;
    function optJSONArray (index: integer): JSONArray ; overload;
    function optJSONObject (index: integer): JSONObject ; overload;
    function optString (index: integer): string; overload;
    function optString (index: integer; defaultValue: string): string; overload;
  {$IFDEF J_OBJECT}
    function optObject (index: integer): TObject; overload;
  {$ENDIF}
    function put ( value: boolean): JSONArray; overload ;
    function put ( value: double ): JSONArray;   overload ;
    function put ( value: integer): JSONArray;   overload ;
    function put ( value: TZAbstractObject): JSONArray;  overload ;
    function put ( value: string): JSONArray; overload;
  {$IFDEF J_OBJECT}
    function put ( value: TObject): JSONArray; overload;
  {$ENDIF}
    function put ( index: integer ; value: boolean): JSONArray;  overload ;
    function put ( index: integer ; value: double): JSONArray;  overload ;
    function put ( index: integer ; value: integer): JSONArray;  overload ;
    function put ( index: integer ; value: int64): JSONArray;  overload ;
    function put ( index: integer ; value: TZAbstractObject): JSONArray;  overload ;
    function put ( index: integer; value: string): JSONArray; overload;
  {$IFDEF J_OBJECT}
    function put ( index: integer ; value: TObject): JSONArray; overload;
  {$ENDIF}
    function LastItem: TZAbstractObject;
    function toJSONObject (names  :JSONArray ): JSONObject ;  overload ;
    function toString: string; overload; override;
    function toString2 (indentFactor: integer): string; overload;
    function toString3 (indentFactor, indent: integer): string; overload;
    function toList (): TList;
    function appendJSONArray( value: JSONArray): Integer ;  //2008-10-08
    procedure Assign( Source: JSONArray);

    function IndexOfObject(aobj: TObject): Integer; override; // by yangyxd
  private
    myArrayList: TList;
  protected
    function GetCount: Integer; override;   // by yangyxd
    function GetChild(Index: Integer): TZAbstractObject; override; // by yangyxd
    procedure SetChild(Index: Integer; const Value: TZAbstractObject); override;  // by yangyxd
  end;


  _Number =  class (TZAbstractObject)
  public
    function doubleValue: double; virtual; abstract;
    function intValue: integer; virtual; abstract;
    function int64Value: Int64; virtual; abstract;  // by yangyxd
  end;

  _Boolean = class (TZAbstractObject)
  public
    class function _TRUE (): _Boolean;
    class function _FALSE (): _Boolean;
    class function valueOf (b: boolean): _Boolean;
    constructor create (b: boolean);
    function boolValue: Boolean;  //By creation_zy  2008-10-06
    function toString (): string; override;
    function Clone :TZAbstractObject;  override;
  private
    fvalue: boolean;
  end;

  _Double = class (_Number)
    constructor create (const s: string); overload;
    constructor create (s: _String); overload;
    constructor create (d: double); overload;
    function doubleValue: double; override;
    function intValue: integer;  override;
    function int64Value: Int64; override;
    function toString (): string ; override;
    class function NaN: double;
    function Clone :TZAbstractObject; override;
  private
    fvalue: double;
  end; 

  _Integer = class (_Number)
    class function parseInt64 (const s: string): int64; overload;
    class function parseInt64 (s: _String): int64; overload;
    class function parseInt (const s: string; i: integer): integer; overload;
    class function parseInt (s: _String): integer; overload;
    class function toHexString (c: char): string;
    constructor create (i: integer); overload;
    constructor create (i: int64); overload;
    constructor create (const s: string); overload;
    function doubleValue: double; override;
    function intValue: integer;  override;
    function int64Value: Int64;  override;
    function toString (): string; override;
    function Clone :TZAbstractObject; override;
  private
    fvalue: int64;
  end;

  _String = class (TZAbstractObject)
  private
    function GetAsString: String;
    procedure SetAsString(const Value: String);
  public
    constructor create (const s: string);
    function equalsIgnoreCase (const s: string): boolean;
    function Equals(const Value: TZAbstractObject): Boolean; override;
    function toString(): string; override;
    function Clone :TZAbstractObject; override;
    property AsString: String read GetAsString write SetAsString;  //By creation_zy  2009-11-22
  private
    fvalue: string;
  end;

  _NULL = class (TZAbstractObject)
    function Equals(const Value: TZAbstractObject): Boolean; override;
    function toString(): string; override;
    function Clone :TZAbstractObject; override;  //By creation_zy  2009-12-11
  end;

{$IFDEF J_OBJECT}
  _Object = class (TZAbstractObject)
    function Equals(const Value: TZAbstractObject): Boolean; override;
    function toString(): string; override;
    function Clone :TZAbstractObject; override;
  private
    fvalue: TObject;
    constructor Create(value: TObject);
    procedure SetAsObject(const Value: TObject);
  public
    property AsObject: TObject read fvalue write SetAsObject;
  end;
{$ENDIF}

  TJObjTransFlag=(jtfDbQouteStr, jtfQouteStr, jtfOtherAsStr);
  TJObjTransFlags=set of TJObjTransFlag;

function HexToInt(const S: String):Integer;
function IsConstJSON(Z: TObject):Boolean;
procedure SafeFreeJObj(Z: TObject);{$IF COMPILERVERSION>=18}inline;{$IFEND}
function SpaceStr(ALen: Integer):String;
function StrToAbstractJObj(const Str: String; Flags: TJObjTransFlags=[jtfDbQouteStr, jtfQouteStr]):TZAbstractObject;

// by yangyxd 2013.11.06
function JsonGetAttribute(const JSON, Name: string): string;
function JsonGetAttributeAsInt(const JSON, Name: string): Integer;
function JsonGetAttributeAsDouble(const JSON, Name: string): double;

var
  gcLista: TList;
  CNULL: _NULL;
  //Set this var to ture to force unicode char (eg: Chinese...) output in the form of \uXXXX 
  UnicodeOutput: Boolean=false;
  SimpleJSON: Boolean=false;  //2012-08-03

implementation

//{$D-}

const
  CROTINA_NAO_IMPLEMENTADA :string = 'Not imp';
var
  CONST_FALSE: _Boolean;
  CONST_TRUE: _Boolean;

//By creation_zy
function IsSimpString(const Str:String):Boolean;
var
  i:Integer;
begin
  Result:=true;
  for i:=1 to Length(Str) do
  begin
    Result:=Str[i] in ['0'..'9','a'..'z','A'..'Z','_'];
    if not Result then exit;
  end;
end;

//By creation_zy
function SingleHZToJSONCode(const HZ:String):String;
var
  wstr:WideString;
begin
  if HZ='' then
  begin
    Result:='';
    exit;
  end;
  wstr:=WideString(HZ);
  Result:='\u'+IntToHex(PWord(@wstr[1])^,4);
end;

//By creation_zy  2009-11-21
function IsConstJSON(Z: TObject):Boolean;
begin
  Result:=(Z=CNULL) or (Z=CONST_FALSE) or (Z=CONST_TRUE);
end;

procedure SafeFreeJObj(Z: TObject);
begin
  if not IsConstJSON(Z) then
    Z.Free;
end;

function SpaceStr(ALen: Integer): string; {$IFDEF INLINE_OPT}inline;{$ENDIF}
begin
  if ALen > 0 then begin
    SetLength(Result, ALen);
    FillChar(Result[1], ALen, ' ');
  end else Result := '';
end;

procedure newNotImplmentedFeature () ;
begin
  raise NotImplmentedFeature.create (CROTINA_NAO_IMPLEMENTADA);
end;

function getFormatSettings: TFormatSettings ;
var
  f: TFormatSettings;
begin
 {$IFDEF MSWINDOWS}
  SysUtils.GetLocaleFormatSettings (Windows.GetThreadLocale,f);
 {$ELSE}
    newNotImplmentedFeature();
 {$ENDIF}
  Result:=f;
  Result.DecimalSeparator:='.';
  Result.ThousandSeparator:=',';
end;


function HexToInt(const S: String): Integer;
const HexMap:array [Char] of SmallInt =
  (
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
   -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
   );
var
  i, n, l: Integer;
begin
  Result:=0;
  l:=Length(S);
  if l=0 then exit;  
  if S[1]='$' then
    n:=2
  else if (l>=2) and (S[2] in ['x','X']) then
    n:=3
  else
    n:=1;
  for i:=n to l do
    Result:=Result*16+HexMap[S[i]];
end;

function StrToAbstractJObj(const Str: String; Flags: TJObjTransFlags):TZAbstractObject;
var
  i:Integer;
begin
  if Str<>'' then
  begin
    case Str[1] of
      '{':
      begin
        try
          Result:=JSONObject.Create(Str);
        except
          Result:=nil;
        end;
        exit;
      end;
      '[':
      begin  
        try
          Result:=JSONArray.Create(Str);
        except
          Result:=nil;
        end;
        exit;      
      end;
      '0'..'9','.','-':
      begin
        try
          i:=StrToInt(Str);
          Result:=_Integer.Create(i);
        except
          Result:=_Double.Create(StrToFloatDef(Str,0));
        end;
        exit;
      end;
      'n':
      begin
        if Str='null' then
        begin
          Result:=CNull;
          exit;
        end;
      end;
      't','T','F','f':
      begin
        if UpperCase(Str)='TRUE' then
        begin
          Result:=CONST_TRUE;
          exit;
        end
        else if UpperCase(Str)='FALSE' then
        begin
          Result:=CONST_FALSE;
          exit;
        end;
      end;
    end;
  end;
  Result:=_String.create(Str);
end;

function mLeftPos(const SrcStr: AnsiString; SubChar: Char; sPos: Integer): Integer;
var
  i: Integer;
begin
  for i := sPos to Length(SrcStr) do
    if SrcStr[i] = SubChar then begin
      Result := i; Exit;
    end;
  Result := -1;
end;

function mRightPos(const SrcStr: AnsiString; SubChar: Char; sPos: Integer): Integer;
var
  i: Integer;
begin
  for i := sPos downto 1 do
    if SrcStr[i] = SubChar then begin
      Result := i; Exit;
    end;
  Result := -1;
end;

function mMidStr(const SrcStr: AnsiString; sPos, sCount: Integer): AnsiString;
begin
  Result := Copy(SrcStr, sPos, sCount);
end;

function JsonGetAttribute(const JSON, Name: string): string;
var
  i, j: Integer;
begin
  i := Pos('"'+Name+'":"', JSON);
  if i > 0 then begin
    i := i + Length(Name) + 4;
    j := mLeftPos(JSON, '"', i);
    Result := Copy(JSON, i, j - i);
  end;
end;

function JsonGetAttributeAsInt(const JSON, Name: string): Integer;
var
  i, j: Integer;
begin
  Result := 0;
  i := Pos('"'+Name+'":', JSON);
  if i > 0 then begin
    i := i + Length(Name) + 3;
    j := mLeftPos(JSON, ',', i);
    if (j < 0) then
      j := mLeftPos(JSON, '}', i);
    if (j > 0) then begin
      if JSON[i] = '"' then i := i + 1;
      if JSON[j-1] = '"' then j := j - 1;      
      Result := StrToIntDef(Copy(JSON, i, j - i), 0);
    end;
  end;
end;

function JsonGetAttributeAsDouble(const JSON, Name: string): double;
var
  i, j: Integer;
begin
  Result := 0;
  i := Pos('"'+Name+'":', JSON);
  if i > 0 then begin
    i := i + Length(Name) + 3;
    j := mLeftPos(JSON, ',', i);
    if (j < 0) then
      j := mLeftPos(JSON, '}', i);
    if (j > 0) then begin
      if JSON[i] = '"' then i := i + 1;
      if JSON[j-1] = '"' then j := j - 1;
      Result := StrToFloatDef(Copy(JSON, i, j - i), 0);
    end;
  end;
end;

{ JSONTokener }

(**
     * Construct a JSONTokener from a string.
     *
     * @param s     A source string.
     *)
constructor JSONTokener.create(const s: string);
begin
  myIndex:=1;
  mySource:=s;
  Len1:=Length(mySource)+1;
end;

(**
     * Back up one character. This provides a sort of lookahead capability,
     * so that you can test for a digit or letter before attempting to parse
     * the next number or identifier.
*)
procedure JSONTokener.back;
begin
  if myIndex>1 then Dec(myIndex);
end;

(**
     * Get the hex value of a character (base16).
     * @param c A character between '0' and '9' or between 'A' and 'F' or
     * between 'a' and 'f'.
     * @return  An int between 0 and 15, or -1 if c was not a hex digit.
     *)
class function JSONTokener.dehexchar(c: char): integer;
begin
  if ((c >= '0') and (c <= '9')) then begin
      Result:= (ord(c) - ord('0'));
      exit;
  end;
  if ((c >= 'A') and (c <= 'F')) then begin
      Result:= (ord(c) + 10 - ord('A'));
      exit;
  end;
  if ((c >= 'a') and (c <= 'f')) then begin
      Result:=ord(c) + 10 - ord('a');
      exit;
  end;
  Result:=-1;
end;


(**
     * Determine if the source string still contains characters that next()
     * can consume.
     * @return true if not yet at the end of the source.
*)
function JSONTokener.more: boolean;
begin
  Result:=myIndex<=Len1{System.length(mySource)+1};
end;

function JSONTokener.next: char;
begin
  if {$IFDEF BACK_OPT}myIndex<=Len1{$ELSE}more(){$ENDIF} then
  begin
    Result:=mySource[myIndex];
    Inc(myIndex);
  end
  else
    Result:=chr(0);
end;


 (**
     * Consume the next character, and check that it matches a specified
     * character.
     * @param c The character to match.
     * @return The character.
     * @throws ParseException if the character does not match.
     *)
function JSONTokener.next(c: char): char;
begin
  Result:=next();
  if (Result <> c) then
    raise syntaxError('Expected ' + c + ' and instead saw ' + Result + '.');
end;


(**
     * Get the next n characters.
     *
     * @param n     The number of characters to take.
     * @return      A string of n characters.
     * @exception ParseException
     *   Substring bounds error if there are not
     *   n characters remaining in the source string.
     *)
function JSONTokener.next(n: integer): string;
var
 i,j: integer;
begin
  i:=self.myIndex;
  j:=i + n;
  if (j > System.length(self.mySource)) then begin
    raise syntaxError('Substring bounds error');
  end;
  self.myIndex:=self.myIndex + n;
  Result:=copy (self.mySource,i,n); //substring(i, j)
end;

 (**
     * Get the next char in the string, skipping whitespace
     * and comments (slashslash, slashstar, and hash).
     * @throws ParseException
     * @return  A character, or 0 if there are no more characters.
     *)
function JSONTokener.nextClean: char;
var
  c: char;
begin
  while true do
  begin
  {$IFDEF NEXT_OPT2}
    if myIndex<=Len1 then
    begin
      Result:=mySource[myIndex];
      Inc(myIndex);
    end
    else begin
      Result:=#0;
      exit;
    end;
  {$ELSE}
    Result:=next();
  {$ENDIF}
    if (Result = '/') then
    begin
      case (next()) of
      '/': begin
        repeat
          c:=next();
        until (not ((c <> #10) and (c <> #13) and (c <> #0)));
      end ;
      '*':
      begin
        while (true) do
        begin
          c:=next();
          if (c = #0) then
          begin
            raise syntaxError('Unclosed comment.');
          end;
          if (c = '*') then
          begin
            if (next() = '/') then break;
            {$IFDEF BACK_OPT}if myIndex>1 then Dec(myIndex);{$ELSE}back();{$ENDIF}
          end;
        end;
      end
      else begin
        {$IFDEF BACK_OPT}if myIndex>1 then Dec(myIndex);{$ELSE}back();{$ENDIF}
        Result:='/';
        exit;
      end;
    end;
    end
    else if (Result = '#') then
    begin
      repeat
        c:=next();
      until (not ((c <> #10) and (c <> #13) and (c <> #0)));
    end
    else if ((Result = #0) or (Result > ' ')) then
      exit;
  end; //while
end;


(**
     * Return the characters up to the next close quote character.
     * Backslash processing is done. The formal JSON format does not
     * allow strings in single quotes, but an implementation is allowed to
     * accept them.
     * @param quote The quoting character, either
     *      <code>"</code>&nbsp;<small>(double quote)</small> or
     *      <code>'</code>&nbsp;<small>(single quote)</small>.
     * @return      A String.
     * @exception ParseException Unterminated string.
     *)
function JSONTokener.nextString (quote: char): string;
var
  c: char;
  sb: string;
  WCh:WideChar;
begin
  sb:='';
  while (true) do
  begin
    c:=next();
    case (c) of
      #0, #10, #13:
      begin
        //Ignore #10 and #13 inside a string.  By creation_zy  2009-11-22
        if c=#0 then
          raise syntaxError('Unterminated string')
        else
          continue;
      end;
      '\':
      begin
        c:=next();
        case (c) of
          {'b': // ?o backspace = #8
            sb.append('\b');
            break;}
          'b':  //By creation_zy  2009-08-20
            sb:=sb + #8;
          't':
            sb:=sb + #9;
          'n':
            sb:=sb + #10;
          'f':
            sb:=sb + #12;
          'r':
            sb:=sb + #13;
          {case 'u':
            sb.append((char)Integer.parseInt(next(4), 16));
            break;
          case 'x':  \cx  	The control character corresponding to x
            sb.append((char) Integer.parseInt(next(2), 16));
            break;}
          'u':  //By creation_zy  2009-08-20
          begin
            PWord(@WCh)^:=Word(HexToInt(next(4)));
            sb:=sb+WCh;
          end;
          else
            sb:=sb + c
        end;
      end
      else  begin
        if (c = quote) then
        begin
          Result:=sb;
          exit;
        end;
        sb:=sb + c
      end;
    end;
  end;
end;

(**
     * Get the text up but not including the specified character or the
     * end of line, whichever comes first.
     * @param  d A delimiter character.
     * @return   A string.
     *)
function JSONTokener.nextTo(d: char): string;
var
  sb: string;
  c: char;
begin
  //c:=#0;
  sb:='';
  while (true) do
  begin
    c:=next();
    if ((c = d) or (c = #0) or (c = #10) or (c = #13)) then
    begin
      if (c <> #0) then
      begin
        {$IFDEF BACK_OPT}if myIndex>1 then Dec(myIndex);{$ELSE}back();{$ENDIF}
      end;
      Result:=trim (sb);
      exit;
    end;
    sb:=sb + c;
  end;
end;

(**
     * Get the text up but not including one of the specified delimeter
     * characters or the end of line, whichever comes first.
     * @param delimiters A set of delimiter characters.
     * @return A string, trimmed.
*)
function JSONTokener.nextTo(const delimiters: string): char;
var
  c: char;
  sb: string;
begin
  //c:=#0;
  Result:=#0;  //By creation_zy
  sb:='';
  while (true) do
  begin
    c:=next();
    if ((pos (c,delimiters) > 0) or (c = #0) or
      (c = #10) or (c = #13)) then
    begin
      if (c <> #0) then
      begin
        {$IFDEF BACK_OPT}if myIndex>1 then Dec(myIndex);{$ELSE}back();{$ENDIF}
      end;
      sb:=trim(sb);
      if (System.length(sb) > 0) then
        Result:=sb[1];
      exit;
    end;
    sb:=sb + c;
  end;
end;

(**
     * Get the next value. The value can be a Boolean, Double, Integer,
     * JSONArray, JSONObject, or String, or the JSONObject.NULL object.
     * @exception ParseException The source does not conform to JSON syntax.
     *
     * @return An object.
*)
function JSONTokener.nextValue(parent: JSONBase): TZAbstractObject;  // by yangyxd 添加 parent 参数
var
  c, b: char;
  s , sb: string;
  n:Integer;
begin
  c:=nextClean();

  case (c) of
    '"', #39: begin
        Result:=_String.create (nextString(c));
        exit;
    end;
    '{': begin
        {$IFDEF BACK_OPT}if myIndex>1 then Dec(myIndex);{$ELSE}back();{$ENDIF}
        Result:=JSONObject.create(self);
        JSONObject(Result).Parent := parent;
        exit;
    end;
    '[': begin
        {$IFDEF BACK_OPT}if myIndex>1 then Dec(myIndex);{$ELSE}back();{$ENDIF}
        Result:=JSONArray.create(self);
        JSONArray(Result).Parent := parent;
        exit;
    end;
  end;

  (*
   * Handle unquoted text. This could be the values true, false, or
   * null, or it can be a number. An implementation (such as this one)
   * is allowed to also accept non-standard forms.
   *
   * Accumulate characters until we reach the end of the text or a
   * formatting character.
   *)

  sb:='';
  b:=c;
  while ((ord(c) >= ord(' ')) and (pos (c,',:]}/\\\"[{;=#') = 0)) do begin
      sb:=sb + c;
      c:=next();
  end;
  {$IFDEF BACK_OPT}if myIndex>1 then Dec(myIndex);{$ELSE}back();{$ENDIF}

  (*
   * If it is true, false, or null, return the proper value.
   *)

  s:=trim (sb);
  n:=System.Length(s);
  if n=0 then
    raise syntaxError('Missing value.');
  if n in [4,5] then  //2009-09-14  Length limit before AnsiLowerCase.  By creation_zy
  begin
    sb:=AnsiLowerCase(s);
    if (sb = 'true') then
    begin
      Result:= _Boolean._TRUE;
      exit;
    end;

    if (sb = 'false') then
    begin
      Result:=_Boolean._FALSE;
      exit;
    end;
    if (sb = 'null') then
    begin
      Result:=JSONObject.NULL;
      exit;
    end;
  end;

  (*
   * If it might be a number, try converting it. We support the 0- and 0x-
   * conventions. If a number cannot be produced, then the value will just
   * be a string. Note that the 0-, 0x-, plus, and implied string
   * conventions are non-standard. A JSON parser is free to accept
   * non-JSON forms as long as it accepts all correct JSON forms.
   *)

  if ( ((b >= '0') and (b <= '9')) or (b = '.')
    or (b = '-') or (b = '+')) then
  begin
    if (b = '0') then begin
      if ( (System.length(s) > 2) and
        ((s[2] = 'x') or (s[2] = 'X') ) ) then
      begin
        try
          Result:=_Integer.create(_Integer.parseInt(copy(s,3,System.length(s)),16));
          exit;
        Except
          on e:Exception do begin
            ///* Ignore the error */
          end;
        end;
      end else begin
        try
          if (System.length(s) >= 2) and (s[2]='.') then  //2009-09-14  By creation_zy
            Result:=_Double.create(s)
          else
            Result:=_Integer.create(_Integer.parseInt(s,8));
          exit;
        Except
          on e:Exception do begin
            ///* Ignore the error */
          end;
        end;
      end;
    end;
    if Pos('.',s)=0 then  //2011-10-02  Bug fixed.  By creation_zy
      try
        Result:=_Integer.create(s);
        exit;
      Except
        on e:Exception do begin
          ///* Ignore the error */
        end;
      end;

    try
      Result:=_Double.create(s);
      exit;
    Except
      on e:Exception do begin
        ///* Ignore the error */
      end;
    end;
  end;
  Result:=_String.create(s);
end;

(**
     * Skip characters until the next character is the requested character.
     * If the requested character is not found, no characters are skipped.
     * @param to A character to skip to.
     * @return The requested character, or zero if the requested character
     * is not found.
     *)
function JSONTokener.skipTo(_to: char): char;
var
  c: char;
  index: integer;
begin
  index:=self.myIndex;
  repeat
    c:=next();
    if (c = #0) then
    begin
      self.myIndex:=index;
      Result:=c;
      exit;
    end;
  until c=_to;
  {$IFDEF BACK_OPT}if myIndex>1 then Dec(myIndex);{$ELSE}back();{$ENDIF}
  Result:=c;
  exit;
end;

(**
     * Skip characters until past the requested string.
     * If it is not found, we are left at the end of the source.
     * @param to A string to skip past.
     *)
procedure JSONTokener.skipPast(const _to: string);
begin
   self.myIndex:=pos (_to, copy(mySource, self.myIndex, System.length(mySource)));
        if (self.myIndex < 0) then begin
            self.myIndex:=System.length(self.mySource)+1;
        end else begin
            self.myIndex:=self.myIndex + System.length(_to);
        end;
end;



(**
     * Make a ParseException to signal a syntax error.
     *
     * @param message The error message.
     * @return  A ParseException object, suitable for throwing
     *)
function JSONTokener.syntaxError(const _message: string): ParseException;
begin
 Result:=ParseException.create (_message + toString()+' postion: ' //' pr髕imo a: '
 + copy (toString(),self.myIndex,10), self.myIndex);
end;

(**
     * Make a printable string of this JSONTokener.
     *
     * @return " at character [this.myIndex] of [this.mySource]"
     *)


function JSONTokener.toString: string;
begin
  Result:=' at character ' + intToStr(myIndex) + ' of ' + mySource;
end;


(**
     * Convert <code>%</code><i>hh</i> sequences to single characters, and
     * convert plus to space.
     * @param s A string that may contain
     *      <code>+</code>&nbsp;<small>(plus)</small> and
     *      <code>%</code><i>hh</i> sequences.
     * @return The unescaped string.
     *)
function JSONTokener.unescape(const s: string): string;
var
  len, i,d,e: integer;
  b: string;
  c: char;
begin
  len:=System.length(s);
  b:='';
  i:=1;
  while ( i <= len ) do begin
    c:=s[i];
    if (c = '+') then begin
      c:=' ';
    end
    else if ((c = '%') and ((i + 2) <= len)) then
    begin
      d:=dehexchar(s[i + 1]);
      e:=dehexchar(s[i + 2]);
      if ((d >= 0) and (e >= 0)) then
      begin
        c:=chr(d * 16 + e);
        i:=i + 2;
      end;
    end;
    b:=b + c;
    i:=i + 1;
  end;
  Result:=b ;
end;

{ JSONObject }

(**
* Construct an empty JSONObject.
*)
constructor JSONObject.create;
begin
  myHashMap:=TStringList.create;
  inherited Create;
end;


(**
     * Construct a JSONObject from a subset of another JSONObject.
     * An array of strings is used to identify the keys that should be copied.
     * Missing keys are ignored.
     * @param jo A JSONObject.
     * @param sa An array of strings.
     *)
constructor JSONObject.create(jo: JSONObject; sa: array of string);
var
 i: integer;
begin
  create();
  for i:=low(sa) to high(sa) do
    putOpt(sa[i], jo.opt(sa[i]).Clone);
end;

(**
     * Construct a JSONObject from a JSONTokener.
     * @param x A JSONTokener object containing the source string.
     * @throws ParseException if there is a syntax error in the source string.
     *)
constructor JSONObject.create(x: JSONTokener);
begin
  create ;
  UpdateByTokener(x);
end;

(**
     * Construct a JSONObject from a Map.
     * @param map A map object that can be used to initialize the contents of
     *  the JSONObject.
     *)
constructor JSONObject.create(map: TStringList);
var
 i: integer;
begin
  myHashMap:=TStringlist.create;
  for i:=0 to map.Count -1 do
    myHashMap.AddObject(map[i],map.Objects[i]);
end;

(**
     * Construct a JSONObject from a string.
     * This is the most commonly used JSONObject constructor.
     * @param string    A string beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     * @exception ParseException The string must be properly formatted.
     *)
constructor JSONObject.create(const s: string);
var
  token: JSOnTokener;
begin
  if s='' then  //Add by creation_zy  2008-10-21
  begin
    create();
    exit;
  end;
  token:=JSONTokener.create(s);
  try
    create(token);
  finally
    token.free;
  end;
end;


constructor JSONObject.CreateInArray(Ay: JSONArray);
begin
  create;
  if Ay<>nil then
    Ay.put(Self);
end;

(**
     * Accumulate values under a key. It is similar to the put method except
     * that if there is already an object stored under the key then a
     * JSONArray is stored under the key to hold all of the accumulated values.
     * If there is already a JSONArray, then the new value is appended to it.
     * In contrast, the put method replaces the previous value.
     * @param key   A key string.
     * @param value An object to be accumulated under the key.
     * @return this.
     * @throws NullPointerException if the key is null
     *)
function JSONObject.accumulate(const key: string; value: TZAbstractObject): JSONObject;
var
 a: JSONArray;
 o: TZAbstractObject;
begin
  o:=opt(key);
  if (o = nil) then
    put(key, value)
  else if (o is JSONArray) then
  begin
    a:=JSONArray(o);
    a.put(value);
  end
  else begin
    a:=JSONArray.create;
    a.put(o.Clone);
    a.put(value);
    put(key, a);
  end;
  Result:=self;
end;


(**
     * Get the value object associated with a key.
     *
     * @param key   A key string.
     * @return      The object associated with the key.
     * @exception NoSuchElementException if the key is not found.
     *)
function JSONObject.get(const key: string): TZAbstractObject;
var
 o: TZAbstractObject;
begin
  o:=opt(key);
  if (o = nil) then
    raise NoSuchElementException.create('JSONObject['+quote(key)+'] not found.');
  Result:=o;
end;


(**
     * Get the boolean value associated with a key.
     *
     * @param key   A key string.
     * @return      The truth.
     * @exception NoSuchElementException if the key is not found.
     * @exception ClassCastException
     *  if the value is not a Boolean or the String "true" or "false".
     *)
function JSONObject.getBoolean(const key: string): boolean;
var
 o: TZAbstractObject;
begin
  o:=get(key);
  if (o.equals(_Boolean._FALSE) or
          ((o is _String) and
          (_String(o)).equalsIgnoreCase('false'))) then begin
      Result:=false;
      exit;
  end
  else if (o.equals(_Boolean._TRUE) or
          ((o is _String) and
          (_String(o)).equalsIgnoreCase('true'))) then begin
      Result:=true;
      exit;
  end;
  raise ClassCastException.create('JSONObject[' +
      quote(key) + '] is not a Boolean.');
end;

function JSONObject.getDouble(const key: string): double;
var
  o: TZAbstractObject;
begin
  o:=get(key);
  if (o is _Number) then
  begin
    Result:=_Number (o).doubleValue();
    exit;
  end ;
  if (o is _String) then
  begin
    Result:=StrToFloat (_String(o).toString(), getFormatSettings());
    exit;
  end;
  raise NumberFormatException.create('JSONObject['+quote(key)+'] is not a number.');
end;


(**
     * Get the int value associated with a key.
     *
     * @param key   A key string.
     * @return      The integer value.
     * @exception NoSuchElementException if the key is not found
     * @exception NumberFormatException
     *  if the value cannot be converted to a number.
     *)
function JSONObject.getInt(const key: string): integer;
var
  o: TZAbstractObject;
begin
  o:=get(key);
  if (o is _Number) then
    Result:= _Number(o).intValue()
  else
    Result:= Round(getDouble(key));
end;


function JSONObject.GetInt64(const key: string): Int64;
var
  o: TZAbstractObject;
begin
  o:=get(key);
  if (o is _Number) then
    Result:= _Number(o).int64Value()
  else
    Result:= Round(getDouble(key));
end;

(**
     * Get the JSONArray value associated with a key.
     *
     * @param key   A key string.
     * @return      A JSONArray which is the value.
     * @exception NoSuchElementException if the key is not found or
     *  if the value is not a JSONArray.
     *)
function JSONObject.getJSONArray(const key: string): JSONArray;
var
 o: TZAbstractObject;
begin
  o:=get(key);
  if (o is JSONArray) then
    Result:=JSONArray(o)
  else
    raise  NoSuchElementException.create('JSONObject[' +
        quote(key) + '] is not a JSONArray.');
end;


(**
     * Get the JSONObject value associated with a key.
     *
     * @param key   A key string.
     * @return      A JSONObject which is the value.
     * @exception NoSuchElementException if the key is not found or
     *  if the value is not a JSONObject.
     *)
function JSONObject.getJSONObject(const key: string): JSONObject;
var
 o: TZAbstractObject;
begin
  o:=get(key);
  if (o is JSONObject) then
    Result:=JSONObject(o)
  else
    raise NoSuchElementException.create('JSONObject[' +
      quote(key) + '] is not a JSONObject.');
end;


(**
     * Get the string associated with a key.
     *
     * @param key   A key string.
     * @return      A string which is the value.
     * @exception NoSuchElementException if the key is not found.
*)
function JSONObject.getString(const key: string): string;
begin
  Result:=get(key).toString();
end;


(**
     * Determine if the JSONObject contains a specific key.
     * @param key   A key string.
     * @return      true if the key exists in the JSONObject.
     *)
function JSONObject.has(const key: string): boolean;
begin
  Result:=myHashMap.IndexOf(key)>=0;
end;

function JSONObject.IndexOfObject(aobj: TObject): Integer;
var
  i: Integer;
begin
  for i := 0 to myHashMap.Count - 1 do
      if myHashMap.Objects[i] = aobj then begin
        Result := I;
        Exit;
      end;
  Result := -1;
end;

(**
     * Determine if the value associated with the key is null or if there is
     *  no value.
     * @param key   A key string.
     * @return      true if there is no value associated with the key or if
     *  the value is the JSONObject.NULL object.
     *)  
function JSONObject.isNull(const key: string): boolean;
begin
  Result:=NULL.equals(opt(key));
end;

function JSONObject.keys: TStringList;
var
 i: integer;
begin
  Result:=TStringList.Create;
  for i:=0 to myHashMap.Count -1 do
    Result.add (myHashMap[i]);
end;

function JSONObject.length: integer;
begin
  Result:=myHashMap.Count;
end;


(**
     * Produce a JSONArray containing the names of the elements of this
     * JSONObject.
     * @return A JSONArray containing the key strings, or null if the JSONObject
     * is empty.
     *)
function JSONObject.names: JSONArray;
var
  i,c: integer;
  k: TStringList;
begin
  Result:=nil;
  k:=keys;
  try
    c:=k.Count;
    if c>0 then  //2013-05-04  Fix memory leak bug found by K.o.s
    begin
      Result:=JSONArray.create;
      for i:=0 to c-1 do
        Result.put(_String.create(k[i]));
    end;
  finally
    k.free;
  end;
end;

function JSONObject.NextSibling: JSONObject;
var
  i: Integer;
begin
  if not Assigned(Parent) then
    Result := nil
  else begin
    i := Parent.IndexOfObject(Self) + 1;
    if (i > 0) and (i < Parent.Count) then begin
      if Parent.Child[i] is JSONObject then
        Result := JSONObject(Parent.Child[i])
      else Result := nil;
    end else
      Result := nil;
  end;
end;

class function JSONObject.numberToString(n: _Number): string;
begin
  if (n = nil) then
    Result:=''
  else if (n is _Integer) then
    Result:=IntToStr(n.intValue)
  else
    Result:=FloatToStr(n.doubleValue, getFormatSettings());
end;


(**
     * Get an optional value associated with a key.
     * @param key   A key string.
     * @return      An object which is the value, or null if there is no value.
     * @exception NullPointerException  The key must not be null.
     *)
function JSONObject.opt(const key: string): TZAbstractObject;
var
  i:Integer;
begin
  i:=myHashMap.IndexOf(key);
  if i<0 then
    Result:=nil
  else
    Result:=TZAbstractObject(myHashMap.Objects[i]);
end;

function JSONObject.Opt2(key, key2: string): TZAbstractObject;
var
  i:Integer;
begin
  i:=myHashMap.IndexOf(key);
  if i<0 then
    i:=myHashMap.IndexOf(key2);
  if i<0 then
    Result:=nil
  else
    Result:=TZAbstractObject(myHashMap.Objects[i]);
end;

(**
     * Get an optional boolean associated with a key.
     * It returns false if there is no such key, or if the value is not
     * Boolean.TRUE or the String "true".
     *
     * @param key   A key string.
     * @return      The truth.
     *)
function JSONObject.optBoolean(const key: string): boolean;
begin
  Result:=optBoolean(key, false);
end;


(**
     * Get an optional boolean associated with a key.
     * It returns the defaultValue if there is no such key, or if it is not
     * a Boolean or the String "true" or "false" (case insensitive).
     *
     * @param key              A key string.
     * @param defaultValue     The default.
     * @return      The truth.
     *)
function JSONObject.optBoolean(const key: string;
  defaultValue: boolean): boolean;
var
  o: TZAbstractObject;
begin
  o:=opt(key);
  if (o <> nil) then
  begin
    if o.ClassType=_Boolean then  //2009-03-06  By creation_zy
    begin
      Result:=_Boolean(o).fvalue;
      exit;
    end
    else if //o.equals(_Boolean._FALSE) or
          ((o is _String) and
          (_String(o).equalsIgnoreCase('false'))) then begin
      Result:=false;
      exit;
    end
    else if //o.equals(_Boolean._TRUE) or
          ((o is _String) and
          (_String(o).equalsIgnoreCase('true'))) then begin
      Result:=true;
      exit;
    end;
  end;
  Result:=defaultValue;
end;


(**
     * Get an optional double associated with a key,
     * or NaN if there is no such key or if its value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A string which is the key.
     * @return      An object which is the value.
     *)
function JSONObject.optDouble(const key: string): double;
begin
  Result:=optDouble(key, _Double.NaN);
end;


(**
     * Get an optional double associated with a key, or the
     * defaultValue if there is no such key or if its value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      An object which is the value.
     *)
function JSONObject.optDouble(const key: string; defaultValue: double): double;
var
 o: TZAbstractObject;
begin
  o:=opt(key);
  if (o <> nil) then
  begin
    if (o is _Number) then
    begin
      Result:=(_Number(o)).doubleValue();
      exit;
    end;
    try
      Result:=_Double.create(_String(o)).doubleValue();
      exit;
    except
      on e:Exception do
      begin
        Result:=defaultValue;
        exit;
      end;
    end;
  end;
  Result:=defaultValue;
end;

(**
     * Get an optional int value associated with a key,
     * or zero if there is no such key or if the value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @return      An object which is the value.
     *)
function JSONObject.optInt(const key: string): integer;
begin
  Result:=optInt(key, 0);
end;


(**
     * Get an optional int value associated with a key,
     * or the default if there is no such key or if the value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      An object which is the value.
     *)
function JSONObject.optInt(const key: string; defaultValue: integer): integer;
var
  o: TZAbstractObject;
begin
  o:=opt(key);
  if (o <> null) and ( o <> nil ) then  //By creation_zy.  Add compare to nil
  begin
    if (o is _Number) then
    begin
      Result:=(_Number(o)).intValue();
      exit;
    end;
    try
      Result:=_Integer.parseInt(_String(o));
    except
      on e:Exception do
      begin
        Result:=defaultValue;
      end;
    end;
  end
  else  //By creation_zy
    Result:=defaultValue;
end;

function JSONObject.OptInt2(key, key2: String; DefaultValue: Integer): Integer;
var
  o:TZAbstractObject;
begin
  o:=Opt2(key,key2);
  if o<>nil then
    Result:=TZAbstractObject.getInt(o,DefaultValue)
  else
    Result:=DefaultValue;
end;       

function JSONObject.OptInt64(const key: string): int64;
begin
  Result:=optInt64(key, 0);
end;

function JSONObject.OptInt64(const key: string; defaultValue: int64): int64;
var
  o: TZAbstractObject;
begin
  o:=opt(key);
  if (o <> null) and ( o <> nil ) then  //By creation_zy.  Add compare to nil
  begin
    if (o is _Number) then
    begin
      Result:=(_Number(o)).int64Value();
      exit;
    end;
    try
      Result:=_Integer.parseInt64(_String(o));
    except
      on e:Exception do
      begin
        Result:=defaultValue;
      end;
    end;
  end
  else  //By creation_zy
    Result:=defaultValue;
end;

(**
     * Get an optional JSONArray associated with a key.
     * It returns null if there is no such key, or if its value is not a
     * JSONArray.
     *
     * @param key   A key string.
     * @return      A JSONArray which is the value.
     *)
function JSONObject.optJSONArray(const key: string): JSONArray;
var
 o: TZAbstractObject ;
begin
  o:=opt(key);
  if (o is JSONArray) then
    Result:=JSONArray(o)
  else
    Result:=nil;
end;


(**
     * Get an optional JSONObject associated with a key.
     * It returns null if there is no such key, or if its value is not a
     * JSONObject.
     *
     * @param key   A key string.
     * @return      A JSONObject which is the value.
     *)
function JSONObject.optJSONObject(const key: string): JSONObject;
var
  o: TZAbstractObject ;
begin
  o:=opt(key);
  if (o is JSONObject) then
    Result:=JSONObject(o)
  else
    Result:=nil;
end;

{$IFDEF J_OBJECT}
function JSONObject.OptObject(const key: string;
  defaultValue: TObject): TObject;
var
  o: TZAbstractObject ;
begin
  o:=opt(key);
  if (o is _Object) then
    Result:=_Object(o).AsObject
  else
    Result:=defaultValue;
end;

function JSONObject.OptObject(const key: string): TObject;
var
  o: TZAbstractObject ;
begin
  o:=opt(key);
  if (o is _Object) then
    Result:=_Object(o).AsObject
  else
    Result:=nil;
end;
{$ENDIF}

(**
     * Get an optional string associated with a key.
     * It returns an empty string if there is no such key. If the value is not
     * a string and is not null, then it is coverted to a string.
     *
     * @param key   A key string.
     * @return      A string which is the value.
     *)
function JSONObject.optString(const key: string): string;
var
  o: TZAbstractObject ;
  i:Integer;
begin
  i:=myHashMap.IndexOf(key);
  if i<0 then
    Result:=''
  else begin
    o:=TZAbstractObject(myHashMap.Objects[i]);
    if (o <> nil) then
      Result:=o.toString()
    else
      Result:='';
  end;
end;

(**
     * Get an optional string associated with a key.
     * It returns the defaultValue if there is no such key.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      A string which is the value.
     *)
function JSONObject.optString(const key, defaultValue: string): string;
var
  o: TZAbstractObject ;
begin
  o:=Opt(key);
  if (o <> nil) then
    Result:=o.toString()
  else
    Result:=defaultValue;
end;

function JSONObject.OptString2(key, key2: String; DefaultValue: String): String;
var
  o:TZAbstractObject;
begin
  o:=Opt2(key,key2);
  if o<>nil then
    Result:=o.toString()
  else
    Result:=DefaultValue;
end;

(**
     * Put a key/boolean pair in the JSONObject.
     *
     * @param key   A key string.
     * @param value A boolean which is the value.
     * @return this.
     *)
function JSONObject.put(const key: string; value: boolean): JSONObject;
begin
   put(key, _Boolean.valueOf(value));
   Result:=self;
end;

(**
     * Put a key/double pair in the JSONObject.
     *
     * @param key   A key string.
     * @param value A double which is the value.
     * @return this.
     *)
function JSONObject.put(const key: string; value: double): JSONObject;
begin
   put(key, _Double.create(value));
   Result:=self;
end;


(**
     * Put a key/int pair in the JSONObject.
     *
     * @param key   A key string.
     * @param value An int which is the value.
     * @return this.
     *)
function JSONObject.put(const key: string; value: integer): JSONObject;
begin
   put(key, _Integer.create(value));
   Result:=self;
end;


(**
     * Put a key/value pair in the JSONObject. If the value is null,
     * then the key will be removed from the JSONObject if it is present.
     * @param key   A key string.
     * @param value An object which is the value. It should be of one of these
     *  types: Boolean, Double, Integer, JSONArray, JSONObject, String, or the
     *  JSONObject.NULL object.
     * @return this.
     * @exception NullPointerException The key must be non-null.
     *)
function JSONObject.put(const key: string; value: TZAbstractObject): JSONObject;
var
  temp: TObject;
  i: integer;
begin
  if (key = '') then
  begin
    raise NullPointerException.create('Null key.');
  end ;
  if (value <> nil) then      {$D+}
  begin
    i:=myHashMap.IndexOf(key);
    if ( i >= 0) then
    begin
      temp:=myHashMap.Objects [i];
      myHashMap.Objects[i]:=value;
      if (temp<>CNULL) and (temp<>CONST_FALSE) and (temp<>CONST_TRUE) then  //Prevent to free const obj.  By craetion_zy  2009-11-21
        temp.free;
    end
    else
      myHashMap.AddObject(key, value);
  end
  else begin
    temp:=remove(key);
    if (temp<>nil) and (temp<>CNULL) and (temp<>CONST_FALSE) and (temp<>CONST_TRUE) then  //Prevent to free const obj.  By craetion_zy  2009-11-21
      temp.free;
  end;
  Result:=self;
end;

function JSONObject.put(const key, value: string): JSONObject;
begin
  put(key, _String.create(value));
  Result:=self;
end;

{$IFDEF J_OBJECT}
function JSONObject.Put(const key: string; value: TObject): JSONObject;
begin
  put(key, _Object.create(value));
  Result:=self;
end;
function JSONObject.Put(const key: string; value: int64): JSONObject;
begin
   put(key, _Integer.create(value));
   Result:=self;
end;

{$ENDIF}

(**
     * Put a key/value pair in the JSONObject, but only if the
     * value is non-null.
     * @param key   A key string.
     * @param value An object which is the value. It should be of one of these
     *  types: Boolean, Double, Integer, JSONArray, JSONObject, String, or the
     *  JSONObject.NULL object.
     * @return this.
     * @exception NullPointerException The key must be non-null.
     *)
function JSONObject.putOpt(const key: string; value: TZAbstractObject): JSONObject;
begin
  if (value <> nil) then
    put(key, value);
  Result:=self;
end;


(**
     * Produce a string in double quotes with backslash sequences in all the
     * right places.
     * @param string A String
     * @return  A String correctly formatted for insertion in a JSON message.
     *)
class function JSONObject.quote(const s: string): string;
var
   b,c: char;
   i, len: integer;
   sb, t: string;
begin
  if ((s = '') or (System.Length(s) = 0)) then
  begin
    Result:= '""';
    exit;
  end;

  //b:=#0;
  c:=#0;
  len:=System.length(s);
  //SetLength (s, len+4);
  t:='';

  sb:=sb +'"';
  i:=1;
  while i<=len do
  begin
    b:=c;
    c:=s[i];
    case (c) of
      '\', '"':
      begin
        sb:=sb + '\';
        sb:=sb + c;
      end;
      '/':
      begin
        if (b = '<') then
        begin
          sb:=sb + '\';
        end;
        sb:=sb + c;
      end;
      {#8, #9, #10, #12, #13:
      begin
        sb:=sb + c;
      end;}
      //Output special character smaller than space.  By creation_zy  2009-11-22
      #0: sb:=sb + '\u0000';
      #1..#7: sb:=sb + '\u000'+Char(Byte('0')+Byte(c));
      #8: sb:=sb + '\b';
      #9: sb:=sb + '\t';
      #10: sb:=sb + '\n';
      #12: sb:=sb + '\f';
      #13: sb:=sb + '\r';
      else
      begin
        if (c < ' ') then
        begin
          t:='000' + _Integer.toHexString(c);
          sb:=sb + '\u' + copy (t,System.length(t)-3,4);
        end
        else if UnicodeOutput and (c>#128) and (i<len) then   //Unicode output  By creation_zy
        begin
          Inc(i);
          sb:=sb+SingleHZToJSONCode(c+s[i]);
        end
        else begin
          sb:=sb + c;
        end;
      end;
    end;
    Inc(i);
  end;
  sb:=sb + '"';
  Result:=sb;
end;

class procedure JSONObject.quoteToStream(stream: TStream; const s: string);
var
   b,c: char;
   i, len: integer;
   t: string;
begin
  if ((s = '') or (System.Length(s) = 0)) then
  begin
    WriteString(stream, '""');
    exit;
  end;

  //b:=#0;
  c:=#0;
  len:=System.length(s);
  //SetLength (s, len+4);
  t:='';
  WriteChar(stream, '"');
  i:=1;
  while i<=len do
  begin
    b:=c;
    c:=s[i];
    case (c) of
      '\', '"':
      begin
        WriteChar(stream, '\');
        WriteChar(stream, c);
      end;
      '/':
      begin
        if (b = '<') then
        begin
          WriteChar(stream, '\');
        end;
        WriteChar(stream, c);
      end;
      {#8, #9, #10, #12, #13:
      begin
        sb:=sb + c;
      end;}
      //Output special character smaller than space.  By creation_zy  2009-11-22
      #0: WriteString(stream, '\u0000');
      #1..#7:
        begin
          WriteString(stream, '\u000');
          WriteChar(stream, Char(Byte('0')+Byte(c)));
        end;
      #8: WriteString(stream, '\b');
      #9: WriteString(stream, '\t');
      #10: WriteString(stream, '\n');
      #12: WriteString(stream, '\f');
      #13: WriteString(stream, '\r');
      else
      begin
        if (c < ' ') then
        begin
          t:='000' + _Integer.toHexString(c);
          WriteString(stream, '\u');
          WriteString(stream,  copy (t,System.length(t)-3,4));
        end
        else if UnicodeOutput and (c>#128) and (i<len) then   //Unicode output  By creation_zy
        begin
          Inc(i);
          WriteString(stream, SingleHZToJSONCode(c+s[i]));
        end
        else begin
          WriteChar(stream, c);
        end;
      end;
    end;
    Inc(i);
  end;
  WriteChar(stream, '"');
end;

(**
     * Remove a name and its value, if present.
     * @param key The name to be removed.
     * @return The value that was associated with the name,
     * or null if there was no value.
     *)
function JSONObject.Remove(const key: string): TZAbstractObject;
var
  i:Integer;
begin
  i:=myHashMap.IndexOf(key);
  if i<0 then
    Result:=nil
  else begin
    Result:=TZAbstractObject(myHashMap.Objects[i]);
    myHashMap.delete(i);
  end;
end;

(**
     * Produce a JSONArray containing the values of the members of this
     * JSONObject.
     * @param names A JSONArray containing a list of key strings. This
     * determines the sequence of the values in the Result.
     * @return A JSONArray of values.
     *)
function JSONObject.toJSONArray(names: JSONArray): JSONArray;
var
  i: integer;
begin
  if ((names = nil) or (names.length() = 0)) then
  begin
    Result:=nil;
    exit;
  end;
  Result:=JSONArray.create;
  for i:=0 to names.length -1 do
    Result.put(self.opt(names.getString(i)));
end;


(**
     * Make an JSON external form string of this JSONObject. For compactness, no
     * unnecessary whitespace is added.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     *
     * @return a printable, displayable, portable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
function JSONObject.toString: string;
var
  _keys: TStringList;
  o, sb: string;
  i :integer;
begin
  _keys:=keys();
  try
    sb:='{';

    for i:=0 to _keys.count -1 do
    begin
      if (System.length(sb) > 1) then
      begin
        sb:= sb + ',';
      end;
      o:=_keys[i];
      if SimpleJSON and IsSimpString(o) then //By creation_zy
        sb:=sb + o
      else
        sb:=sb + quote(o);
      sb:=sb + ':';
      sb:= sb + valueToString(TZAbstractObject(myHashMap.Objects[myHashMap.IndexOf(o)]));
    end;
    sb:=sb + '}';
    Result:=sb;
  finally
    _keys.free;
  end;
end;


(**
     * Make a prettyprinted JSON external form string of this JSONObject.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @return a printable, displayable, portable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
procedure JSONObject.SaveToStream(stream: TStream);
var
  _keys: TStringList;
  o: string;
  i, j :integer;
begin
  _keys:=keys();
  try
    WriteChar(stream, '{');
    j := 1;
    for i:=0 to _keys.count -1 do
    begin
      if (j > 1) then
        WriteChar(stream, ',');
      o:=_keys[i];
      if SimpleJSON and IsSimpString(o) then //By creation_zy
        WriteString(stream, o)
      else
        quoteToStream(stream, o);
      WriteChar(stream, ':');
      ValueToStream(TZAbstractObject(myHashMap.Objects[myHashMap.IndexOf(o)]), stream);
      Inc(j);
    end;
    WriteChar(stream, '}');
  finally
    _keys.free;
  end;
end;

function JSONObject.toString2(indentFactor: integer): string;
begin
  Result:=toString3(indentFactor, 0);
end;

(**
     * Make a prettyprinted JSON string of this JSONObject.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @param indent The indentation of the top level.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
function JSONObject.toString3(indentFactor, indent: integer): string;
var
  j , n , newindent: integer;
  _keys: TStringList;
  o, sb: string;
begin
  //i:=0;
  n:=length();
  if (n = 0) then begin
    Result:='{}';
    exit;
  end;
  _keys:=keys();
  try
    sb:=sb + '{';
    newindent:=indent + indentFactor;
    if (n = 1) then
    begin
      o:=_keys[0];
      sb:= sb + quote(o);
      sb:= sb + ': ';
      sb:= sb + valueToString(TZAbstractObject(myHashMap
      .Objects[myHashMap.IndexOf(o)])
      , indentFactor, indent);
    end
    else begin
      for j:=0 to _keys.count -1 do
      begin
        o:=_keys[j];
        if (System.length(sb) > 1) then
        begin
          sb:=sb + ','+ #10;
        end
        else begin
          sb:= sb + #10;
        end;
        sb:= sb + SpaceStr(newindent) + quote(o) + ': ';
        sb:= sb + valueToString(TZAbstractObject(myHashMap.Objects[myHashMap.IndexOf(o)])
          , indentFactor, newindent);
      end;
      if (System.length(sb) > 1) then
      begin
        sb:=sb + #10;
        sb:= sb + SpaceStr(indent);
      end;
    end;
    sb:= sb + '}';
    Result:=sb;
  finally
    _keys.Free;   //Memory leak fixed.  By creation_zy  2009-08-03
  end;
end;

class function JSONObject.NULL: _NULL;
begin
  Result:=CNULL;
end;

(**
     * Make JSON string of an object value.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param value The value to be serialized.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
class function JSONObject.valueToString(value: TZAbstractObject): string;
begin
  if ((value = nil) or (value.equals(null))) then begin
      Result:='null';
      exit;
  end;
  if (value is _Number) then begin
      Result:=numberToString(_Number(value));
      exit;
  end;
  if ((value is _Boolean) or (value is JSONObject) or
          (value is JSONArray)) then begin
      Result:=value.toString();
      exit;
  end;
  Result:=quote(value.toString());
end;

class procedure JSONObject.ValueToStream(value: TZAbstractObject;
  stream: TStream);
var
  m: TStringStream;
begin
  if ((value = nil) or (value.equals(null))) then begin
      WriteString(stream, 'null');
      exit;
  end;
  if (value is _Number) then begin
      WriteString(stream, numberToString(_Number(value)));
      exit;
  end;
  if ((value is _Boolean) or (value is JSONObject) or
          (value is JSONArray)) then begin
      value.SaveToStream(stream);
      exit;
  end;
  m := TStringStream.Create('');
  try
    value.SaveToStream(m);
    quoteToStream(stream, m.DataString);
    //WriteString(stream, quote(m.DataString));
  finally
    m.Free;
  end;
end;



(**
     * Make a prettyprinted JSON string of an object value.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param value The value to be serialized.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @param indent The indentation of the top level.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
class function JSONObject.valueToString(value: TZAbstractObject;
  indentFactor, indent: integer): string;
begin
   if ((value = nil) or (value.equals(nil))) then begin
        Result:='null';
        exit;
    end;
    if (value is _Number) then begin
        Result:=numberToString(_Number(value));
        exit;
    end;
    if (value is _Boolean) then begin
        Result:= value.toString();
        exit;
    end;
    if (value is JSONObject) then begin
        Result:=((JSONObject(value)).toString3(indentFactor, indent));
        exit;
    end;
    if (value is JSONArray) then begin
        Result:=((JSONArray(value)).toString3(indentFactor, indent));
        exit;
    end;
    Result:=quote(value.toString());
end;

procedure JSONObject.clean;
var
  i: integer;
  MyObj:TObject;
begin
  for i:=Pred(myHashMap.Count) downto 0 do
  begin
    MyObj:=myHashMap.Objects[i];
    if (MyObj <> CONST_FALSE) and (MyObj <> CONST_TRUE) and (MyObj <> CNULL) then
      MyObj.Free;
  end;
  myHashMap.Clear;
end;


(**
* Assign the values to other json Object.
* @param JSONObject  objeto to assign Values
*)
procedure JSONObject.assignTo (json: JSONObject) ;
var
 _keys: TStringList;
 i: integer;
begin
  _keys:=keys;
  try
    for i:=0 to _keys.Count -1 do
    begin
      json.put (_keys[i],get(_keys[i]).Clone);
    end;
  finally
   _keys.free;
  end;
end;

function JSONObject.Clone: TZAbstractObject;
begin
  Result:=JSONObject.create(self.toString());
end;

function JSONObject.GetPropValues(const Key: String): String;
begin
  Result:=OptString(Key);
end;

procedure JSONObject.SetPropValues(const Key: String; const Value: String);
begin
  Put(Key, Value);
end;

function JSONObject.GetCascadeValue(const Keys: array of String): String;
var
  i:Integer;
  TmpProp:JSONObject;
begin
  Result:='';
  TmpProp:=Self;
  for i:=Low(Keys) to High(Keys) do
  begin
    if i=High(Keys) then
    begin
      Result:=TmpProp.PropValues[Keys[i]];
      exit;
    end;
    TmpProp:=TmpProp.OptJSONObject(Keys[i]);
    if TmpProp=nil then exit;
  end;
end;

function JSONObject.GetChild(Index: Integer): TZAbstractObject;
begin
  Result := JSONObject(myHashMap.Objects[index]);
end;

function JSONObject.GetCount: Integer;
begin
  Result := myHashMap.Count;
end;

function JSONObject.GetCascadeValEx(const Keys: array of String): String;
var
  i:Integer;
  TmpProp,p:JSONObject;
begin
  Result:='';
  TmpProp:=Self;
  for i:=Low(Keys) to High(Keys) do
  begin
    if i=High(Keys) then
    begin
      Result:=TmpProp.PropValues[Keys[i]];
      exit;
    end;
    p:=TmpProp.OptJSONObject(Keys[i]);
    if p=nil then
    begin
      Result:=TmpProp.OptString(Keys[i]);
      exit;
    end;
    TmpProp:=p;
  end;
end;

function JSONObject.GetCascadeValObj(
  const Keys: array of String): TZAbstractObject;
var
  i:Integer;
  TmpProp:JSONObject;
begin
  Result:=nil;
  TmpProp:=Self;
  for i:=Low(Keys) to High(Keys) do
  begin
    if i=High(Keys) then
    begin
      Result:=TmpProp.Opt(Keys[i]);
      exit;
    end;
    TmpProp:=TmpProp.OptJSONObject(Keys[i]);
    if TmpProp=nil then exit;
  end;
end;

procedure JSONObject.SetAsString(const Value: String);
var
  token:JSOnTokener;
begin
  Clean;
  if System.Length(Value)<=2 then exit;
  token:=JSONTokener.create(Value);
  try
    UpdateByTokener(token);
  finally
    token.free;
  end;
end;

function JSONObject.GetDiffFrom(Source: JSONObject; UseSrc: Boolean): JSONObject;
var
  sl:TStrings;
  i:Integer;
  mstr:String;
  z,sz:TZAbstractObject;
begin
  Result:=JSONObject.Create;
  if UseSrc then
    sl:=Source.Keys
  else
    sl:=Keys;
  with sl do
  begin
    for i:=0 to Pred(Count) do
    begin
      mstr:=Strings[i];
      if UseSrc then
      begin
        z:=Self.Opt(mstr);
        sz:=Source.ValObjByIndex[i];
        if z=nil then
        begin
          Result.Put(mstr,sz.Clone);
          continue;
        end;
      end
      else begin
        sz:=Source.Opt(mstr);
        z:=Self.ValObjByIndex[i];  
        if sz=nil then
        begin
          Result.Put(mstr,z.Clone);
          continue;
        end;    
      end;
      if sz.ClassType=z.ClassType then
      begin
        if sz.toString=z.toString then continue;
        if sz.ClassType=JSONObject then
        begin
          Result.Put(mstr,JSONObject(z).GetDiffFrom(JSONObject(sz),UseSrc));
          continue;
        end;
      end;
      if UseSrc then
        Result.Put(mstr,sz.Clone)
      else if z<>nil then  //应当考虑数组的情况...         
        Result.Put(mstr,z.Clone);
    end;
    Free;
  end;
end;

procedure JSONObject.Delete(index: Integer);
begin
  SafeFreeJObj(myHashMap.Objects[index]);
  self.myHashMap.delete(index);
end;

procedure JSONObject.RemoveByKeyHeader(const Header: String);
var
  i:Integer;
begin
  with Keys do
  begin
    for i:=Pred(Count) downto 0 do
    begin
      if Pos(Header,Strings[i])=1 then
        CleanKey(Strings[i]);
    end;
    Free;
  end;
end;

function JSONObject.RemoveLastKey: TZAbstractObject;
var
  i:Integer;
begin
  with myHashMap do
  begin
    i:=length-1;
    if i<0 then
    begin
      Result:=nil;
      exit;
    end;
    Result:=TZAbstractObject(Objects[i]);
    delete(i);
  end;
end;

function JSONObject.PropCount: Integer;
begin
  Result:=myHashMap.Count;
end;

function JSONObject.KeyByVal(const Value: String): String;
var
  i:Integer;
begin
  for i:=0 to Pred(myHashMap.Count) do
  begin
    with TZAbstractObject(myHashMap.Objects[i]) do
    begin
      if toString=Value then
      begin
        Result:=myHashMap[i];
        exit;
      end;
    end;
  end;
  Result:='';
end;

function JSONObject.PartExtract(KeyNames: TStrings;
  DoRemove: Boolean): JSONObject;
var
  i:Integer;
  KeyName:String;
begin
  Result:=nil;
  if KeyNames=nil then exit;
  Result:=JSONObject.Create;
  for i:=Pred(Length) downto 0 do
  begin
    KeyName:=KeyByIndex[i];
    if KeyNames.IndexOf(KeyName)<0 then continue;
    if DoRemove then
      Result.Put(KeyName,Remove(KeyByIndex[i]))
    else
      Result.Put(KeyName,ValObjByIndex[i].Clone);
  end;
end;

function JSONObject.ExtractAll: JSONObject;
var
  i:Integer;
  KeyName:String;
begin
  Result:=JSONObject.Create;
  for i:=Pred(Length) downto 0 do
  begin
    KeyName:=KeyByIndex[i];
    Result.Put(KeyName,Remove(KeyByIndex[i]))
  end;
end;

function JSONObject.TryNewJSONArray(const Key: String): JSONArray;
begin
  Result:=OptJSONArray(Key);
  if Result=nil then
  begin
    Result:=JSONArray.create;
    Result.Parent := Self;
    Put(Key,Result);
  end;
end;

function JSONObject.TryNewJSONObject(const Key: String): JSONObject;
begin
  Result:=OptJSONObject(Key);
  if Result=nil then
  begin
    Result:=JSONObject.create;
    Result.Parent := Self;
    Put(Key,Result);
  end;
end;

procedure JSONObject.Assign(Source: JSONObject);
begin
  if Source=nil then
    Clean
  else begin
    AsString:=Source.AsString;
  end;
end;

function JSONObject.GetKeyByIndex(index: Integer): String;
begin
  Result:=myHashMap[index];
end;

function JSONObject.GetObject(const key: string): TObject;
begin
  Result:=OptObject(Key);
end;

procedure JSONObject.SetCascadeValue(const Value: String;
  const Keys: array of String);
begin
  SetCascadeValueEx(Value,Keys,0);
end;

procedure JSONObject.SetCascadeValueEx(const Value: String;
  const Keys: array of String; StartIdx: Integer);
var
  JObj:JSONObject;
begin
  if High(Keys)<StartIdx then exit;
  if High(Keys)=StartIdx then
  begin
    Self.Put(Keys[StartIdx],Value);
    exit;
  end;
  JObj:=OptJSONObject(Keys[StartIdx]);
  if JObj=nil then
  begin
    JObj:=JSONObject.Create;
    Self.Put(Keys[StartIdx],JObj);
  end;
  JObj.SetCascadeValueEx(Value,Keys,StartIdx+1);
end;

procedure JSONObject.SetChild(Index: Integer; const Value: TZAbstractObject);
var
  temp: TObject;
begin
  temp := myHashMap.Objects[Index];
  myHashMap.Objects[Index] := Value;
  if (temp<>CNULL) and (temp<>CONST_FALSE) and (temp<>CONST_TRUE) and (temp <> nil) then  //Prevent to free const obj.  By craetion_zy  2009-11-21
    temp.free;
end;

function JSONObject.SetKey(idx: Integer; const Key: String): Boolean;
begin
  Result:=myHashMap.IndexOf(Key)<0;
  if not Result or (idx<0) or (idx>=myHashMap.Count) then exit;
  myHashMap.Strings[idx]:=Key;
end;

function JSONObject.GetValByIndex(index: Integer): String;
begin
  Result:=TZAbstractObject(myHashMap.Objects[index]).toString;
end;

function JSONObject.GetValObjByIndex(index: Integer): TZAbstractObject;
begin
  Result:=TZAbstractObject(myHashMap.Objects[index]);
end;

procedure JSONObject.CleanKey(const Key: String);
var
  i:Integer;
begin
  i:=myHashMap.IndexOf(key);
  if i<0 then exit;
  SafeFreeJObj(myHashMap.Objects[i]);
  myHashMap.delete(i);
end;

procedure JSONObject.UpdateByTokener(x: JSONTokener);
var
  c: char;
begin
  FName:='';  // by yangyxd

  if (x.nextClean() <> '{') then
    raise x.syntaxError('A JSONObject must begin with "{"');
  while (true) do
  begin
    c:=x.nextClean();
    case (c) of
    #0:
        raise x.syntaxError('A JSONObject must end with "}"');
    '}': begin
        exit;
    end
    else begin
        {$IFDEF BACK_OPT}if x.myIndex>1 then Dec(x.myIndex);{$ELSE}x.back();{$ENDIF}
        //key:=x.nextValue().toString();
        with x.nextValue(self) do
        begin
          FName:=toString();  // by yangyxd
          Free;  //Fix memory leak. By creation_zy  2008-08-07
        end;
    end
    end; //fim do case

    (*
     * The key is followed by ':'. We will also tolerate '=' or '=>'.
     *)

    c:=x.nextClean();
    if (c = '=') then begin
        if (x.next() <> '>') then begin
            {$IFDEF BACK_OPT}if x.myIndex>1 then Dec(x.myIndex);{$ELSE}x.back();{$ENDIF}
        end;
    end else if (c <> ':') then begin
        raise x.syntaxError('Expected a ":" after a key');
    end;
    self.myHashMap.AddObject(FName, x.nextValue(self)); // by yangyxd

    (*
     * Pairs are separated by ','. We will also tolerate ';'.
     *)

    case (x.nextClean()) of
    ';', ',': begin
        if (x.nextClean() = '}') then begin
            exit;
        end;
        {$IFDEF BACK_OPT}if x.myIndex>1 then Dec(x.myIndex);{$ELSE}x.back();{$ENDIF}
    end;
    '}': begin
        exit;
    end
    else begin
        raise x.syntaxError('Expected a "," or "}"');
    end
    end;
  end; //while
end;

function JSONObject.UpSibling: JSONObject;
var
  i: Integer;
begin
  if not Assigned(Parent) then
    Result := nil
  else begin
    i := Parent.IndexOfObject(Self) - 1;
    if (i > -1) and (i < Parent.Count - 1) and (Parent.Child[i] is JSONObject) then begin
      Result := JSONObject(Parent.Child[i])
    end else
      Result := nil;
  end;
end;

{ _Boolean }

function _Boolean.boolValue: Boolean;
begin
  Result:=fvalue;
end;

function _Boolean.Clone: TZAbstractObject;
begin
  Result:=_Boolean.create(Self.fvalue);
end;

constructor _Boolean.create(b: boolean);
begin
   fvalue:=b;
end;

function _Boolean.toString: string;
begin
  if fvalue then
    Result:='true'
  else
    Result:='false';
end;

class function _Boolean.valueOf(b: boolean): _Boolean;
begin
  if (b) then
    Result:=_TRUE
  else
    Result:=_FALSE;
end;

class function _Boolean._FALSE: _Boolean;
begin
  Result:=CONST_FALSE;
end;

class function _Boolean._TRUE: _Boolean;
begin
  Result:=CONST_TRUE;
end;

{ _String }

function _String.Clone: TZAbstractObject;
begin
  Result:=_String.create (self.fvalue);
end;

constructor _String.create(const s: string);
begin
  fvalue:=s;
end;


function _String.equals(const Value: TZAbstractObject): Boolean;
begin
    Result:=(value is _String) and (_String (value).fvalue = fvalue);
end;

function _String.equalsIgnoreCase(const s: string): boolean;
begin
   Result:=AnsiLowerCase (s) = AnsiLowerCase (fvalue);
end;

function _String.GetAsString: String;
begin
  Result:=fvalue;
end;

procedure _String.SetAsString(const Value: String);
begin
  fvalue:=Value;
end;

function _String.toString: string;
begin
  Result:=fvalue;
end;

{ ParseException }

constructor ParseException.create(_message: string; index: integer);
begin
   inherited createFmt(_message+#10#13' erro no caracter: %d',[index]);
end;

{ _Integer }

constructor _Integer.create(i: integer);
begin
  fvalue:=i;
end;

function _Integer.Clone: TZAbstractObject;
begin
  Result:=_Integer.create(self.fvalue);
end;

constructor _Integer.create(const s: string);
begin
  fvalue:=strToInt64(s);
end;

constructor _Integer.create(i: int64);
begin
  fvalue := i;
end;

function _Integer.doubleValue: double;
begin
  Result:=fvalue;
end;

function _Integer.int64Value: Int64;
begin
  Result := fvalue;
end;

function _Integer.intValue: integer;
begin
  Result:=fvalue;
end;



class function _Integer.parseInt(const s: string; i: integer): integer;
begin
  Result:=0;  //By creation_zy
  case i of
    10: Result:=strToInt(s);
    16: Result:=hexToInt(s);
    8:
    begin
      if s='0' then exit;  //By creation_zy
      newNotImplmentedFeature() ;
    end;
    else newNotImplmentedFeature() ;  //By creation_zy
  end;
end;

class function _Integer.parseInt(s: _String): integer;
begin
  Result:=_Integer.parseInt(s.toString, 10);
end;

class function _Integer.parseInt64(s: _String): int64;
begin
  Result:=_Integer.parseInt64(s.toString);
end;

class function _Integer.parseInt64(const s: string): int64;
begin
  Result := strToInt64(s);
end;

class function _Integer.toHexString(c: char): string;
begin
  Result:=IntToHex(ord(c),2);
end;

function _Integer.toString: string;
begin
  Result:=intToStr(fvalue);
end;


{ _Double }

constructor _Double.create(const s: string);
begin
  fvalue:=StrToFloat(s, getFormatSettings);
end;

constructor _Double.create(s: _String);
begin
  create (s.toString);
end;


function _Double.Clone: TZAbstractObject;
begin
  Result:=_Double.create(Self.fvalue);
end;

constructor _Double.create(d: double);
begin
  fvalue:=d;
end;

function _Double.doubleValue: double;
begin
  Result:=fvalue;
end;

function _Double.int64Value: Int64;
begin
  Result := Trunc(fvalue);
end;

function _Double.intValue: integer;
begin
  Result:=trunc(fvalue);
end;

class function _Double.NaN: double;
begin
  Result:=3.6e-4951;
end;

function _Double.toString: string;
begin
  Result:=floatToStr(fvalue, getFormatSettings);
end;

{ JSONArray }

(**
     * Construct a JSONArray from a JSONTokener.
     * @param x A JSONTokener
     * @exception ParseException A JSONArray must start with '['
     * @exception ParseException Expected a ',' or ']'
     *)
constructor JSONArray.create(x: JSONTokener);
var
  Ch:Char;
begin
  create;
  if (x.nextClean() <> '[') then
    raise x.syntaxError('A JSONArray must start with "["');
  //if (x.nextClean() = ']') then exit;
  //{$IFDEF BACK_OPT}if x.myIndex>1 then Dec(x.myIndex);{$ELSE}x.back();{$ENDIF}
  Ch:=x.nextClean();
  if Ch=']' then exit;  
  while true do
  begin
    if (Ch = ',') then begin
        {$IFDEF BACK_OPT}if x.myIndex>1 then Dec(x.myIndex);{$ELSE}x.back();{$ENDIF}
        myArrayList.add(nil);
    end
    else begin
        {$IFDEF BACK_OPT}if x.myIndex>1 then Dec(x.myIndex);{$ELSE}x.back();{$ENDIF}
        myArrayList.add(x.nextValue(self));
    end;
    case x.nextClean() of
      ';',',':
      begin
        if (x.nextClean() = ']') then exit;
        {$IFDEF BACK_OPT}if x.myIndex>1 then Dec(x.myIndex);{$ELSE}x.back();{$ENDIF}
      end;
      ']': exit;
      else raise x.syntaxError('Expected a "," or "]"');
    end;
    Ch:=x.nextClean();
  end;
end;

destructor JSONObject.destroy;
var
  i :integer;
  MyObj:TObject;
begin
  for i:=Pred(myHashMap.Count) downto 0 do
  begin
    MyObj:=myHashMap.Objects[i];
    SafeFreeJObj(MyObj);
  end;
  myHashMap.Free;
  inherited;
end;

(**
     * Construct a JSONArray from a Collection.
     * @param collection     A Collection.
     *)
constructor JSONArray.create(collection: TList);
var
  i: integer;
begin
  inherited Create;
  myArrayList:=TList.create ();
  for i:=0 to collection.count -1 do begin
     myArrayList.add (collection[i]);
  end;
end;

(**
 * Construct an empty JSONArray.
*)
constructor JSONArray.create;
begin
   inherited Create;
   myArrayList:=TList.create;
end;


(**
     * Construct a JSONArray from a source string.
     * @param string     A string that begins with
     * <code>[</code>&nbsp;<small>(left bracket)</small>
     *  and ends with <code>]</code>&nbsp;<small>(right bracket)</small>.
     *  @exception ParseException The string must conform to JSON syntax.
     *)
constructor JSONArray.create(const s: string);
var
  token:JSOnTokener;
begin
  token:=JSONTokener.create(s);
  try
    create(token);
  finally
    token.free;
  end;
end;

destructor JSONArray.destroy;
var
  i: integer;
begin
  for i:=Pred(myArrayList.Count) downto 0 do
    SafeFreeJObj(myArrayList[i]);
  myArrayList.Free;
  inherited;
end;

procedure JSONArray.Assign(Source: JSONArray);
begin
  Clean;
  appendJSONArray(Source);
end;

procedure JSONArray.Clean;
var
  i: integer;
begin
  for i:=Pred(myArrayList.Count) downto 0 do
    SafeFreeJObj(myArrayList[i]);
  myArrayList.Clear;  //2009-12-10  By creation_zy
end;

function JSONArray.Clone: TZAbstractObject;
begin
  Result:=JSONArray.create(Self.toString);
end;

function JSONArray.appendJSONArray(value: JSONArray): Integer;
var
  i:Integer;
begin
  if value=nil then
  begin
    Result:=0;
    exit;
  end;
  Result:=value.length;
  for i:=0 to Pred(Result) do
    put(value.get(i).Clone);
end;

(**
     * Get the object value associated with an index.
     * @param index
     *  The index must be between 0 and length() - 1.
     * @return An object value.
     * @exception NoSuchElementException
     *)
function JSONArray.get(index: integer): TZAbstractObject;
var
  o: TZAbstractObject;
begin
  o:=opt(index);
  if (o = nil) then
    raise NoSuchElementException.create('JSONArray[' + intToStr(index)
      + '] not found.');
  Result:=o;
end;


(**
     * Get the boolean value associated with an index.
     * The string values "true" and "false" are converted to boolean.
     *
     * @param index The index must be between 0 and length() - 1.
     * @return      The truth.
     * @exception NoSuchElementException if the index is not found
     * @exception ClassCastException
     *)
function JSONArray.getBoolean(index: integer): boolean;
var
  o: TZAbstractObject;
begin
  o:=get(index);
  if ((o.equals(_Boolean._FALSE) or
          ((o is _String) and
          (_String(o)).equalsIgnoreCase('false')))) then begin
      Result:=false;
      exit;
  end else if ((o.equals(_Boolean._TRUE) or
          ((o is _String) and
          (_String(o)).equalsIgnoreCase('true')))) then begin
      Result:=true;
      exit;
  end;
  raise ClassCastException.create('JSONArray[' + intToStr(index) +
      '] not a Boolean.');
end;

function JSONArray.GetChild(Index: Integer): TZAbstractObject;
begin
  Result:=opt(index);
end;

function JSONArray.GetCount: Integer;
begin
  Result := myArrayList.Count;
end;

(**
     * Get the double value associated with an index.
     *
     * @param index The index must be between 0 and length() - 1.
     * @return      The value.
     * @exception NoSuchElementException if the key is not found
     * @exception NumberFormatException
     *  if the value cannot be converted to a number.
     *)
function JSONArray.getDouble(index: integer): double;
var
  o: TZAbstractObject;
  d: _Double;
begin
  o:=get(index);
  if (o is _Number) then
  begin
    Result:=(_Number(o)).doubleValue();
    exit;
  end;
  if (o is _String) then
  begin
    d:= _Double.create(_String(o));
    try
      Result:=d.doubleValue();
      exit;
    finally
      d.Free;
    end;
  end;
  raise NumberFormatException.create('JSONObject['
     + intToStr(index) + '] is not a number.');
end;


(**
     * Get the int value associated with an index.
     *
     * @param index The index must be between 0 and length() - 1.
     * @return      The value.
     * @exception NoSuchElementException if the key is not found
     * @exception NumberFormatException
     *  if the value cannot be converted to a number.
     *)
function JSONArray.getInt(index: integer): integer;
var
  o: TZAbstractObject;
begin
  o:=get(index);
  if (o is _Number) then
    Result:=_Number(o).intValue()
  else
    Result:=trunc(getDouble(index));
end;


function JSONArray.getInt64(index: integer): int64;
var
  o: TZAbstractObject;
begin
  o:=get(index);
  if (o is _Number) then
    Result:=_Number(o).int64Value()
  else
    Result:=trunc(getDouble(index));
end;

(**
     * Get the JSONArray associated with an index.
     * @param index The index must be between 0 and length() - 1.
     * @return      A JSONArray value.
     * @exception NoSuchElementException if the index is not found or if the
     * value is not a JSONArray
     *)
function JSONArray.getJSONArray(index: integer): JSONArray;
var
 o: TZAbstractObject;
begin
  o:=get(index);
  if (o is JSONArray) then
  begin
    Result:=JSONArray(o);
    exit;
  end;
  raise NoSuchElementException.create('JSONArray[' + intToStr(index) +
    '] is not a JSONArray.');
end;


(**
     * Get the JSONObject associated with an index.
     * @param index subscript
     * @return      A JSONObject value.
     * @exception NoSuchElementException if the index is not found or if the
     * value is not a JSONObject
     *)
function JSONArray.getJSONObject(index: integer): JSONObject;
var
  o: TZAbstractObject;
  s: string;
begin
  o:=get(index);
  if (o is JSONObject) then
    Result:=JSONObject(o)
  else begin
    if o <> nil then
      s:=o.ClassName
    else
      s:='nil';
    raise NoSuchElementException.create('JSONArray[' + intToStr(index) +
      '] is not a JSONObject is ' + s);
  end;
end;

(**
     * Get the string associated with an index.
     * @param index The index must be between 0 and length() - 1.
     * @return      A string value.
     * @exception NoSuchElementException
     *)
function JSONArray.getString(index: integer): string;
begin
  Result:=get(index).toString();
end;

function JSONArray.IndexOfObject(aobj: TObject): Integer;
var i: Integer;
begin
  for i := 0 to myArrayList.Count - 1 do
    if opt(i) = aobj then begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

(**
 * Determine if the value is null.
 * @param index The index must be between 0 and length() - 1.
 * @return true if the value at the index is null, or if there is no value.
 *)

function JSONArray.isNull(index: integer): boolean;
var
 o: TZAbstractObject;
begin
    o:=opt(index);
    Result:=(o = nil) or (o.equals(nil));
end;

(**
 * Make a string from the contents of this JSONArray. The separator string
 * is inserted between each element.
 * Warning: This method assumes that the data structure is acyclical.
 * @param separator A string that will be inserted between the elements.
 * @return a string.
 *)
function JSONArray.join(separator: string): string;
var
  len, i: integer;
  sb: string ;
begin
  len:=length();
  sb:='';
  for i:=0 to len -1 do
  begin
    if (i > 0) then
      sb:=sb + separator;
    sb:= sb + JSONObject.valueToString(TZAbstractObject(myArrayList[i]));
  end;
  Result:=sb;
end;

function JSONArray.LastItem: TZAbstractObject;
var
  Len:Integer;
begin
  Len:=length();
  if Len=0 then
    Result:=nil
  else
    Result:=TZAbstractObject(TZAbstractObject(myArrayList[Len-1]));
end;

(**
 * Get the length of the JSONArray.
 *
 * @return The length (or size).
 *)
function JSONArray.length: integer;
begin
  Result:=myArrayList.Count;
end;

 (**
     * Get the optional object value associated with an index.
     * @param index The index must be between 0 and length() - 1.
     * @return      An object value, or null if there is no
     *              object at that index.
     *)
function JSONArray.opt(index: integer): TZAbstractObject;
begin
  if ((index < 0) or (index >= length()) ) then
    Result:=nil
  else
    Result:=TZAbstractObject (myArrayList[index]);
end;

(**
     * Get the optional boolean value associated with an index.
     * It returns false if there is no value at that index,
     * or if the value is not Boolean.TRUE or the String "true".
     *
     * @param index The index must be between 0 and length() - 1.
     * @return      The truth.
     *)
function JSONArray.optBoolean(index: integer): boolean;
begin
  Result:=optBoolean(index, false);
end;

(**
     * Get the optional boolean value associated with an index.
     * It returns the defaultValue if there is no value at that index or if it is not
     * a Boolean or the String "true" or "false" (case insensitive).
     *
     * @param index The index must be between 0 and length() - 1.
     * @param defaultValue     A boolean default.
     * @return      The truth.
     *)
function JSONArray.optBoolean(index: integer;
  defaultValue: boolean): boolean;
var
 o: TZAbstractObject;
begin
  o:=opt(index);
  if (o <> nil) then
  begin
    if ((o.equals(_Boolean._FALSE) or
            ((o is _String) and
            (_String(o)).equalsIgnoreCase('false')))) then begin
        Result:=false;
        exit;
    end
    else if ((o.equals(_Boolean._TRUE) or
            ((o is _String) and
            (_String(o)).equalsIgnoreCase('true')))) then begin
        Result:=true;
        exit;
    end;
  end;
  Result:=defaultValue;
end;


(**
 * Get the optional double value associated with an index.
 * NaN is returned if the index is not found,
 * or if the value is not a number and cannot be converted to a number.
 *
 * @param index The index must be between 0 and length() - 1.
 * @return      The value.
 *)
function JSONArray.optDouble(index: integer): double;
begin
  Result:=optDouble(index, _Double.NaN);
end;

(**
 * Get the optional double value associated with an index.
 * The defaultValue is returned if the index is not found,
 * or if the value is not a number and cannot be converted to a number.
 *
 * @param index subscript
 * @param defaultValue     The default value.
 * @return      The value.
 *)
function JSONArray.optDouble(index: integer; defaultValue :double): double;
var
 o: TZAbstractObject;
 d: _Double;
begin
  o:=opt(index);
  if (o <> nil) then
  begin
    if (o is _Number) then
    begin
      Result:=(_Number(o)).doubleValue();
      exit;
    end;
    try
      d:=_Double.create (_String (o));
      Result:=d.doubleValue ;
      d.Free;
      exit;
    except
      on e:Exception do
      begin
        Result:=defaultValue;
        exit;
      end;
    end;
  end;
  Result:=defaultValue;
end;

(**
 * Get the optional int value associated with an index.
 * Zero is returned if the index is not found,
 * or if the value is not a number and cannot be converted to a number.
 *
 * @param index The index must be between 0 and length() - 1.
 * @return      The value.
 *)
function JSONArray.optInt(index: integer): integer;
begin
  Result:=optInt(index, 0);
end;


(**
 * Get the optional int value associated with an index.
 * The defaultValue is returned if the index is not found,
 * or if the value is not a number and cannot be converted to a number.
 * @param index The index must be between 0 and length() - 1.
 * @param defaultValue     The default value.
 * @return      The value.
 *)
function JSONArray.optInt(index, defaultValue: integer): integer;
var
  o: TZAbstractObject;
begin
  o:=opt(index);
  if (o <> nil) then
  begin
    if (o is _Number) then
    begin
      Result:=(_Number(o)).intValue();
      exit; //By creation_zy
    end;
    try
      Result:=_Integer.parseInt(_String(o));
      exit;
    except
      on e: exception do
      begin
        Result:=defaultValue;
        exit;
      end;
    end;
  end;
  Result:=defaultValue;
end;


function JSONArray.OptInt64(index: integer): int64;
begin
  Result := OptInt64(index, 0);
end;

function JSONArray.OptInt64(index: integer; defaultValue: int64): int64;
var
  o: TZAbstractObject;
begin
  o:=opt(index);
  if (o <> nil) then
  begin
    if (o is _Number) then
    begin
      Result:=(_Number(o)).int64Value();
      exit; //By creation_zy
    end;
    try
      Result:=_Integer.parseInt64(_String(o));
      exit;
    except
      on e: exception do
      begin
        Result:=defaultValue;
        exit;
      end;
    end;
  end;
  Result:=defaultValue;
end;

(**
 * Get the optional JSONArray associated with an index.
 * @param index subscript
 * @return      A JSONArray value, or null if the index has no value,
 * or if the value is not a JSONArray.
 *)
function JSONArray.optJSONArray(index: integer): JSONArray;
var
 o: TZAbstractObject;
begin
  o:=opt(index);
  if (o is JSONArray) then
    Result:=JSONArray(o)
  else
    Result:=nil;
end;

(**
 * Get the optional JSONObject associated with an index.
 * Null is returned if the key is not found, or null if the index has
 * no value, or if the value is not a JSONObject.
 *
 * @param index The index must be between 0 and length() - 1.
 * @return      A JSONObject value.
 *)
function JSONArray.optJSONObject(index: integer): JSONObject;
var
  o: TZAbstractObject;
begin
  o:=opt(index);
  if o is JSONObject then
    Result:=JSONObject(o)
  else
    Result:=nil;
end;

{$IFDEF J_OBJECT}
function JSONArray.optObject(index: integer): TObject;
var
  o: TZAbstractObject;
begin
  o:=opt(index);
  if o is _Object then
    Result:=_Object(o).fvalue
  else
    Result:=nil;
end;
{$ENDIF}

(**
 * Get the optional string value associated with an index. It returns an
 * empty string if there is no value at that index. If the value
 * is not a string and is not null, then it is coverted to a string.
 *
 * @param index The index must be between 0 and length() - 1.
 * @return      A String value.
 *)
function JSONArray.optString(index: integer): string;
begin
  Result:=optString(index, '');
end;

(**
 * Get the optional string associated with an index.
 * The defaultValue is returned if the key is not found.
 *
 * @param index The index must be between 0 and length() - 1.
 * @param defaultValue     The default value.
 * @return      A String value.
 *)
function JSONArray.optString(index: integer; defaultValue: string): string;
var
  o: TZAbstractObject;
begin
  o:=opt(index);
  if (o <> nil) then
    Result:=o.toString()
  else
    Result:=defaultValue;
end;

(**
 * Append a boolean value.
 *
 * @param value A boolean value.
 * @return this.
 *)
function JSONArray.put(value: boolean): JSONArray;
begin
  put(_Boolean.valueOf(value));
  Result:= self;
end;

(**
 * Append a double value.
 *
 * @param value A double value.
 * @return this.
 *)
function JSONArray.put(value: double): JSONArray;
begin
  put(_Double.create(value));
  Result:=self;
end;

(**
 * Append an int value.
 *
 * @param value An int value.
 * @return this.
 *)
function JSONArray.put(value: integer): JSONArray;
begin
  put(_Integer.create(value));
  Result:=self;
end;


function JSONArray.put(value: string): JSONArray;
begin
  put (_String.create (value));
  Result:=self;
end;

{$IFDEF J_OBJECT}
function JSONArray.put ( value: TObject): JSONArray;
begin
  put (_Object.create (value));
  Result:=self;
end;
{$ENDIF}

(**
 * Append an object value.
 * @param value An object value.  The value should be a
 *  Boolean, Double, Integer, JSONArray, JSObject, or String, or the
 *  JSONObject.NULL object.
 * @return this.
 *)
function JSONArray.put(value: TZAbstractObject): JSONArray;
begin
  myArrayList.add(value);
  Result:=self;
end;

(**
 * Put or replace a boolean value in the JSONArray.
 * @param index subscript The subscript. If the index is greater than the length of
 *  the JSONArray, then null elements will be added as necessary to pad
 *  it out.
 * @param value A boolean value.
 * @return this.
 * @exception NoSuchElementException The index must not be negative.
 *)
function JSONArray.put(index: integer; value: boolean): JSONArray;
begin
  put(index, _Boolean.valueOf(value));
  Result:=self;
end;

function JSONArray.put(index, value: integer): JSONArray;
begin
  put(index, _Integer.create(value));
  Result:=self;
end;


function JSONArray.put(index: integer; value: double): JSONArray;
begin
  put(index, _Double.create(value));
  Result:=self;
end;

function JSONArray.put(index: integer; value: string): JSONArray;
begin
  put (index,_String.create (value));
  Result:=self;
end;

(**
     * Put or replace an object value in the JSONArray.
     * @param index The subscript. If the index is greater than the length of
     *  the JSONArray, then null elements will be added as necessary to pad
     *  it out.
     * @param value An object value.
     * @return this.
     * @exception NoSuchElementException The index must not be negative.
     * @exception NullPointerException   The index must not be null.
     *)
function JSONArray.put(index: integer; value: TZAbstractObject): JSONArray;
begin
  if (index < 0) then
    raise NoSuchElementException.create('JSONArray['+intToStr(index)+'] not found.')
  else if (value = nil) then
    raise NullPointerException.create('')
  else if (index < length()) then
    myArrayList[index]:=value
  else begin
    while (index<>length()) do put(nil);
    put(value);
  end;
  Result:=self;
end;

{$IFDEF J_OBJECT}
function JSONArray.put(index: integer; value: TObject): JSONArray;
begin
  put (index,_Object.create(value));
  Result:=self;
end;

function JSONArray.put(index: integer; value: int64): JSONArray;
begin
  put(index, _Integer.create(value));
  Result:=self;
end;

procedure JSONArray.SetChild(Index: Integer; const Value: TZAbstractObject);
begin
  put(index, Value);
end;

{$ENDIF}

(**
 * Produce a JSONObject by combining a JSONArray of names with the values
 * of this JSONArray.
 * @param names A JSONArray containing a list of key strings. These will be
 * paired with the values.
 * @return A JSONObject, or null if there are no names or if this JSONArray
 * has no values.
 *)
function JSONArray.toJSONObject(names :JSONArray): JSONObject;
var
  i: integer;
begin
  if ((names = nil) or (names.length() = 0) or (length() = 0)) then
  begin
    Result:=nil;
    exit;  //By creation_zy
  end;
  Result:=JSONObject.create();
  for i:=0 to names.length() do
    Result.put(names.getString(i), self.opt(i));
end;


(**
 * Make an JSON external form string of this JSONArray. For compactness, no
 * unnecessary whitespace is added.
 * Warning: This method assumes that the data structure is acyclical.
 *
 * @return a printable, displayable, transmittable
 *  representation of the array.
 *)
function JSONArray.toString: string;
begin
  Result:='[' + join(',') + ']';
end;

(**
     * Make a prettyprinted JSON string of this JSONArray.
     * Warning: This method assumes that the data structure is non-cyclical.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>[</code>&nbsp;<small>(left bracket)</small> and ending
     *  with <code>]</code>&nbsp;<small>(right bracket)</small>.
     *)
function JSONArray.toString2(indentFactor: integer): string;
begin
  Result:=toString3(indentFactor, 0);
end;

(**
     * Make a prettyprinted string of this JSONArray.
     * Warning: This method assumes that the data structure is non-cyclical.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @param indent The indention of the top level.
     * @return a printable, displayable, transmittable
     *  representation of the array.
     *)
function JSONArray.toList: TList;
begin
  Result:=TList.create ;
  Result.Assign(myArrayList,laCopy);
end;

function JSONArray.toString3(indentFactor, indent: integer): string;
var
  len, i, newindent: integer;
  sb: string;
begin
  len:=length();
  if (len = 0) then
  begin
    Result:='[]';
    exit;
  end;
  sb:='[';
  if (len = 1) then
  begin
    sb:=sb + JSONObject
      .valueToString(TZAbstractObject( myArrayList[0]),indentFactor, indent);
  end
  else begin
    newindent:=indent + indentFactor;
    sb:=sb + #10 ;
    for i:=0 to len -1 do
    begin
      if i > 0 then
        sb:=sb +',' + #10;
      sb:=sb + SpaceStr(newindent) + (JSONObject.valueToString(TZAbstractObject(myArrayList[i]),
        indentFactor, newindent));
    end;
    sb:=sb + #10 + SpaceStr(indent);
  end;
  sb:=sb + ']';
  Result:=sb;
end;


{ _NULL }

function _NULL.Clone: TZAbstractObject;
begin
  Result:=CNULL;
end;

function _NULL.Equals(const Value: TZAbstractObject): Boolean;
begin
  if (value = nil) then
    Result:=true
  else
    Result:=(value is _NULL);
end;

function _NULL.toString: string;
begin
  Result:='null';
end;


{ TZAbstractObject }

class procedure TZAbstractObject.WriteChar(avOut: TStream; const avData: Char);
begin
  avOut.WriteBuffer(avData, SizeOf(Char));
end;

class procedure TZAbstractObject.WriteString(avOut: TStream; const avData: string);
var
  l: Cardinal;
begin
  l := Length(avData);
  if l > 0 then
    avOut.WriteBuffer(avData[1], l);
end;

class procedure TZAbstractObject.WriteText(avOut: TStream; const avData: string;
  len: Integer);
begin
  if len > 0 then
    avOut.WriteBuffer(avData[1], len);
end;

function TZAbstractObject.Clone: TZAbstractObject;
begin
  Result:=nil;
  newNotImplmentedFeature();
end;

function TZAbstractObject.Equals(const Value: TZAbstractObject): Boolean;
begin
  Result:=(value <> nil) and (value = self);
end;

procedure TZAbstractObject.Free;
begin
  SafeFreeJObj(Self);
end;

class function TZAbstractObject.getBoolean(o: TZAbstractObject; DefaultValue: Boolean): Boolean;
begin
  if (o<>CNULL) and (o<>nil) then
  begin
    if o.ClassType=_Boolean then  //2009-03-06  By creation_zy
    begin
      Result:=_Boolean(o).fvalue;
      exit;
    end
    else if ((o is _String) and (_String(o).equalsIgnoreCase('false'))) then
    begin
      Result:=false;
      exit;
    end
    else if ((o is _String) and (_String(o).equalsIgnoreCase('true'))) then
    begin
      Result:=true;
      exit;
    end;
  end;
  Result:=DefaultValue;
end;

class function TZAbstractObject.getDouble(o: TZAbstractObject; DefaultValue: Double): Double;
begin
  if (o<>CNULL) and ( o <> nil ) then
  begin
    if (o is _Number) then
    begin
      Result:= _Number(o).doubleValue();
      exit;
    end;
    if o.ClassType=_String then
      Result:=StrToFloatDef(o.toString,DefaultValue)
    else
      Result:=defaultValue;
  end
  else  //By creation_zy
    Result:=defaultValue;
end;

class function TZAbstractObject.getInt(o: TZAbstractObject; DefaultValue: Integer): Integer;
begin
  if (o<>CNULL) and ( o <> nil ) then
  begin
    if (o is _Number) then
    begin
      Result:=_Number(o).intValue();
      exit;
    end;
    if o.ClassType<>_String then
      Result:=defaultValue
    else
      try
        Result:=_Integer.parseInt(_String(o));
      except
        Result:=defaultValue;
      end;
  end
  else  //By creation_zy
    Result:=defaultValue;
end;

class function TZAbstractObject.getInt64(o: TZAbstractObject;
  DefaultValue: Int64): Int64;
begin
  if (o<>CNULL) and ( o <> nil ) then
  begin
    if (o is _Number) then
    begin
      Result:=_Number(o).int64Value();
      exit;
    end;
    if o.ClassType<>_String then
      Result:=defaultValue
    else
      try
        Result:=_Integer.parseInt64(_String(o));
      except
        Result:=defaultValue;
      end;
  end
  else  //By creation_zy
    Result:=defaultValue;
end;

function TZAbstractObject.Hash: LongInt;
begin
  Result:=integer(addr(self));
end;

function TZAbstractObject.InstanceOf(
  const Value: TZAbstractObject): Boolean;
begin
  Result:=value is TZAbstractObject;
end;

procedure TZAbstractObject.SaveToStream(stream: TStream);
begin
  WriteString(stream, Format('%s <%p>', [ClassName, addr(Self)]));
end;

function TZAbstractObject.toJSONArray: JSONArray;
begin
  if Self is JSONArray then
    Result := JSONArray(Self)
  else
    Result := nil;
end;

function TZAbstractObject.toJSONObject: JSONObject;
begin
  if Self is JSONObject then
    Result := JSONObject(Self)
  else
    Result := nil;
end;

function TZAbstractObject.ToString: string;
begin
  Result:=Format('%s <%p>', [ClassName, addr(Self)]);
end;

{$IFDEF J_OBJECT}
{ _Object }

function _Object.Clone: TZAbstractObject;
begin
  Result:=_Object.Create(fvalue);
end;

constructor _Object.Create(value: TObject);
begin
  fvalue:=value;
end;

function _Object.Equals(const Value: TZAbstractObject): Boolean;
begin
  Result:=(Value is _Object) and (_Object(Value).AsObject=AsObject);
end;

procedure _Object.SetAsObject(const Value: TObject);
begin
  fvalue:=Value;
end;

function _Object.toString: string;
begin
  if fvalue=nil then
    Result:=''
  else
    Result:=fvalue.ClassName+'::'+IntToHex(Integer(fvalue),8);
end;
{$ENDIF}

{ JSONBase }

constructor JSONBase.Create;
begin
  FParent := nil;
end;

function JSONBase.GetChild(Index: Integer): TZAbstractObject;
begin
  Result := nil;
end;

function JSONBase.GetCount: Integer;
begin
  Result := 0;
end;

function JSONBase.IndexOfObject(aobj: TObject): Integer;
begin
  Result := -1;
end;

procedure JSONBase.SetChild(Index: Integer; const Value: TZAbstractObject);
begin
end;

initialization
  CONST_FALSE:=_Boolean.Create(false);
  CONST_TRUE:=_Boolean.Create(true);
  CNULL:=_NULL.Create;

finalization
  TObject(CONST_FALSE).Free;
  TObject(CONST_TRUE).Free;
  TObject(CNULL).Free;

end.

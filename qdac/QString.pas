unit qstring;
{$I 'qdac.inc'}

interface

{
  本源码来自QDAC项目，版权归swish(QQ:109867294)所有。
  (1)、使用许可及限制
  您可以自由复制、分发、修改本源码，但您的修改应该反馈给作者，并允许作者在必要时，
  合并到本项目中以供使用，合并后的源码同样遵循QDAC版权声明限制。
  您的产品的关于中，应包含以下的版本声明:
  本产品使用的JSON解析器来自QDAC项目中的QJSON，版权归作者所有。
  (2)、技术支持
  有技术问题，您可以加入QDAC官方QQ群250530692共同探讨。
  (3)、赞助
  您可以自由使用本源码而不需要支付任何费用。如果您觉得本源码对您有帮助，您可以赞
  助本项目（非强制），以使作者不为生活所迫，有更多的精力为您呈现更好的作品：
  赞助方式：
  支付宝： guansonghuan@sina.com 姓名：管耸寰
  建设银行：
  户名：管耸寰
  账号：4367 4209 4324 0179 731
  开户行：建设银行长春团风储蓄所
}

{ 修订日志
  2015.7.15
  =========
  * 根据 qsl 的哈希测试结果，将 HashOf 函数算法改为 BKDR 并在Windows平台下使用汇编
  以提升效率（感谢qsl）
  2015.6.6
  =========
  * 修正了 Utf8Decode 时对0x10000+范围的字符解码时移位错误（感谢qsl）
  2015.5.29
  =========
  * 修正了 TQPagedStream 在低版本的IDE中无法编译的问题

  2015.5.25
  =========
  + TQPagedStream 加入，以在写入大内存流数据时替代TMemoryStream

  2015.5.22
  =========
  * 修正了 ParseNumeric 和 ParseInt 时，对溢出表示范围的数值处理方式
  2015.5.21
  =========
  * 修正了 StringReplaceWithW 在 AWithTag 为 True 时结果不正确的问题（麦子仲肥报告）
  * 修正了 StringReplaceWithW 在替换的结果字符串为空时，访问无效地址的问题（麦子仲肥报告）
  2015.5.20
  =========
  + StringReplaceW 函数的一个重载，用于替换字符串中的某一部分为特定字符，一般用于部分敏感内容的隐藏
  * 移除一个Hint
  2015.5.8
  =========
  * 修改 TQPtr 的实现，将匿名释放事件和普通的事件使用同一个变量
  + DecodeText 函数从内存中直接检测编码并返回Unicode编码的字符串

  2015.4.17
  =========
  * 优化了UTFEncode是占用内存过多的问题
  2015.4.8
  =========
  * 修正了ParseNumeric 在解析 -0.xx 这样的数字符号出错的问题（感谢YZ报告）
  2015.4.1
  =========
  * 修正了TQStringCatHelper记算需要的缓冲区长度时判断错误的问题（感谢etarelecca报告）
  2015.3.9
  =========
  * 修改 NaturalCompareW 函数，增加是否忽略掉空白字符选项，在忽略时A 10 和 A10 将被视为一致的结果
  2015.3.5
  =========
  + 新增 PosW（等价于系统的Pos） 和按自然规则排序函数 NaturalCompareW
  2015.2.9
  =========
  + 新增 FilterCharW 和 FilterNoNumberW 两个函数

  2015.1.27
  =========
  * 修正了TQPtr.Bind 几个函数由于代码没有保存的问题

  2015.1.26
  ==========
  + TQPtr 新增几个 Bind 函数的重载
  + 加入全局变量 IsFMXApp 来检测当前是否是 FMX 类应用程序

  2014.11.10
  =========
  * 修正了XE3编译时TSystemTimes定义无效的问题

  2014.11.5
  =========
  * QStringA的From函数修改返回值类型并加入一个重载
  + QStringA加入Cat函数
  + CharCodeA/CharCodeU/CharCodeW来获得指定位置的字符编码值

  2014.9.26
  =========
  * 将TThreadId类型定义由QWorker移入本单元
  2014.9.11
  =========
  * 修正了LoadTextA/LoadTextW加载带有BOM头的空的Utf8流时出错的问题
  2014.8.20
  =========
  + StringReplaceWithW函数，用于替换一块标签中的内容（天地弦）
  2014.8.15
  =========
  * 清理并验证了TQBytesCatHelper引起的2007编译无法通过的问题(秋风起逸以凉报告并验证)
  + PQStringA类型定义

  2014.8.14
  =========
  * 修正了TQBytesCatHelper.NeedSize函数在Delphi2007下无法编译的问题(音儿小白报告并提供修改)
  2014.8.5
  ========
  * BinToHex加入ALowerCase参数，以支持使用小写的十六进制表示方式
  2014.8.1
  =========
  + 新增函数SameCharsA/U/W计算相同的字符数，EndWithA/U/W判断是符以指定的字符串结尾
  2014.7.17
  =========
  + 新增BinaryCmp函数，用于等价于C中的memcmp函数
  2014.7.16
  =========
  + 新增MemScan函数用于在指定的内存区域中查找指定的字节序列
  2014.7.12
  =========
  * 修正了DecodeLineU中递归调用自己的错误(音儿小白报告)
  * 修正了CharCountU检查字符宽度时对双字节Utf8编码的检测错误
  2014.7.10
  =========
  + 新增以下函数：StringReplicateW,NameOfW,ValueOfW,IndexOfNameW,IndexOfValueW

  2014.6.26
  =========
  * 加入HPPEMIT默认链接本单元(麦子仲肥 建议)
  2014.6.21
  ==========
  * 修正了C++ Builder中编译的问题
  2014.6.19
  ==========
  * 修正了QuotedStr对于长度为0的字符串编码出错的问题
}
uses classes, sysutils, types{$IF RTLVersion>=21},
  Rtti{$IFEND >=XE10}{$IFNDEF MSWINDOWS},
  syncobjs{$ENDIF}
{$IFDEF POSIX}
    , Posix.String_
{$ENDIF}
    ;
{$HPPEMIT '#pragma link "qstring"'}

type
{$IFDEF UNICODE}
  QStringW = UnicodeString;
{$ELSE}
  QStringW = WideString;
{$ENDIF UNICODE}
{$IF RTLVersion>=21}
  TValueArray = array of TValue;
{$IFEND >=2010}
{$IF RTLVersion<25}
  IntPtr = Integer;
  IntUPtr = Cardinal;
{$IFEND IntPtr}
{$IF RTLVersion<18.5}
  DWORD_PTR = DWORD;
  ULONGLONG = Int64;
{$IFEND}
{$IF RTLVersion<22}
  TThreadId = Longword;
{$IFEND}
  PIntPtr = ^IntPtr;
  QCharA = Byte;
  QCharW = WideChar;
  PQCharA = ^QCharA;
  PPQCharA = ^PQCharA;
  PQStringA = ^QStringA;
  PQCharW = PWideChar;
  PPQCharW = ^PQCharW;
  PQStringW = ^QStringW;
  TTextEncoding = (teUnknown, { 未知的编码 }
    teAuto, { 自动检测 }
    teAnsi, { Ansi编码 }
    teUnicode16LE, { Unicode LE 编码 }
    teUnicode16BE, { Unicode BE 编码 }
    teUTF8 { UTF8编码 }
    );
{$HPPEMIT '#define DELPHI_ANON(AType,Code,AVar) \'}
{$HPPEMIT '  class AType##AVar:public TCppInterfacedObject<AType>\'}
(*$HPPEMIT '  {\'*)
{$HPPEMIT '  public:\'}
{$HPPEMIT '    void __fastcall Invoke##Code\'}
(*$HPPEMIT '  } *AVar=new AType##AVar'*)

  // 从A结尾的为Ansi编码支持的函数，以U结尾的是Utf8编码支持的函数，以W结尾的为UCS2
  QStringA = record
  private
    FValue: TBytes;
    function GetChars(AIndex: Integer): QCharA;
    procedure SetChars(AIndex: Integer; const Value: QCharA);
    function GetLength: Integer;
    procedure SetLength(const Value: Integer);
    function GetIsUtf8: Boolean;
    function GetData: PByte;
  public
    class operator Implicit(const S: QStringW): QStringA;
    class operator Implicit(const S: QStringA): Pointer;
    class operator Implicit(const S: QStringA): TBytes;
    class operator Implicit(const ABytes: TBytes): QStringA;
    class operator Implicit(const S: QStringA): QStringW;
    class operator Implicit(const S: PQCharA): QStringA;
{$IFNDEF NEXTGEN}
    class operator Implicit(const S: AnsiString): QStringA;
    class operator Implicit(const S: QStringA): AnsiString;
{$ENDIF}
    // 字符串比较
    function From(p: PQCharA; AOffset, ALen: Integer): PQStringA; overload;
    function From(const S: QStringA; AOffset: Integer = 0): PQStringA; overload;
    function Cat(p: PQCharA; ALen: Integer): PQStringA; overload;
    function Cat(const S: QStringA): PQStringA; overload;
    property Chars[AIndex: Integer]: QCharA read GetChars
      write SetChars; default;
    property Length: Integer read GetLength write SetLength;
    property IsUtf8: Boolean read GetIsUtf8;
    property Data: PByte read GetData;
  end;

  QException = class(Exception)

  end;

  // 字符串拼接类
  TQStringCatHelperW = class
  private
    FValue: array of QCharW;
    FStart, FDest: PQCharW;
    FBlockSize: Integer;
{$IFDEF DEBUG}
    FAllocTimes: Integer;
{$ENDIF}
    FSize: Integer;
    function GetValue: QStringW;
    function GetPosition: Integer; inline;
    procedure SetPosition(const Value: Integer);
    procedure NeedSize(ASize: Integer);
    function GetChars(AIndex: Integer): QCharW;
  public
    constructor Create; overload;
    constructor Create(ASize: Integer); overload;
    procedure LoadFromFile(const AFileName: QStringW);
    procedure LoadFromStream(const AStream: TStream);
    function Cat(p: PQCharW; len: Integer): TQStringCatHelperW; overload;
    function Cat(const S: QStringW): TQStringCatHelperW; overload;
    function Cat(c: QCharW): TQStringCatHelperW; overload;
    function Cat(const V: Int64): TQStringCatHelperW; overload;
    function Cat(const V: Double): TQStringCatHelperW; overload;
    function Cat(const V: Boolean): TQStringCatHelperW; overload;
    function Cat(const V: Currency): TQStringCatHelperW; overload;
    function Cat(const V: TGuid): TQStringCatHelperW; overload;
    function Cat(const V: Variant): TQStringCatHelperW; overload;
    function Replicate(const S: QStringW; count: Integer): TQStringCatHelperW;
    function Back(ALen: Integer): TQStringCatHelperW;
    function BackIf(const S: PQCharW): TQStringCatHelperW;
    procedure TrimRight;
    procedure Reset;
    property Value: QStringW read GetValue;
    property Chars[AIndex: Integer]: QCharW read GetChars;
    property Start: PQCharW read FStart;
    property Current: PQCharW read FDest;
    property Position: Integer read GetPosition write SetPosition;
  end;

  TQBytesCatHelper = class
  private
    FValue: TBytes;
    FStart, FDest: PByte;
    FBlockSize: Integer;
    FSize: Integer;
    function GetBytes(AIndex: Integer): Byte;
    function GetPosition: Integer;
    procedure SetPosition(const Value: Integer);
    procedure NeedSize(ASize: Integer);
    procedure SetCapacity(const Value: Integer);
  public
    constructor Create; overload;
    constructor Create(ASize: Integer); overload;
    function Cat(const V: Byte): TQBytesCatHelper; overload;
    function Cat(const V: Shortint): TQBytesCatHelper; overload;
    function Cat(const V: Word): TQBytesCatHelper; overload;
    function Cat(const V: Smallint): TQBytesCatHelper; overload;
    function Cat(const V: Cardinal): TQBytesCatHelper; overload;
    function Cat(const V: Integer): TQBytesCatHelper; overload;
    function Cat(const V: Int64): TQBytesCatHelper; overload;
{$IFNDEF NEXTGEN}
    function Cat(const V: AnsiChar): TQBytesCatHelper; overload;
    function Cat(const V: AnsiString): TQBytesCatHelper; overload;
{$ENDIF}
    function Cat(const V: QStringA; ACStyle: Boolean = False)
      : TQBytesCatHelper; overload;
    function Cat(const c: QCharW): TQBytesCatHelper; overload;
    function Cat(const S: QStringW): TQBytesCatHelper; overload;
    function Cat(const ABytes: TBytes): TQBytesCatHelper; overload;
    function Cat(const AData: Pointer; const ALen: Integer)
      : TQBytesCatHelper; overload;
    function Cat(const V: Single): TQBytesCatHelper; overload;
    function Cat(const V: Double): TQBytesCatHelper; overload;
    function Cat(const V: Boolean): TQBytesCatHelper; overload;
    function Cat(const V: Currency): TQBytesCatHelper; overload;
    function Cat(const V: TGuid): TQBytesCatHelper; overload;
    function Cat(const V: Variant): TQBytesCatHelper; overload;
    function Replicate(const ABytes: TBytes; ACount: Integer): TQBytesCatHelper;
    function Back(ALen: Integer): TQBytesCatHelper;
    procedure Reset;
    property Value: TBytes read FValue;
    property Bytes[AIndex: Integer]: Byte read GetBytes;
    property Start: PByte read FStart;
    property Current: PByte read FDest;
    property Position: Integer read GetPosition write SetPosition;
    property Capacity: Integer read FSize write SetCapacity;
  end;

  IQPtr = interface(IInterface)
    function Get: Pointer;
  end;

  TQPtrFreeEvent = procedure(AData: Pointer) of object;
  PQPtrFreeEvent = ^TQPtrFreeEvent;
  TQPtrFreeEventG = procedure(AData: Pointer);
{$IFDEF UNICODE}
  TQPtrFreeEventA = reference to procedure(AData: Pointer);
{$ENDIF}

  TQPtrFreeEvents = record
    case Integer of
      0:
        (Method: TMethod);
      1:
        (OnFree: {$IFNDEF NEXTGEN}TQPtrFreeEvent{$ELSE}Pointer{$ENDIF});
      2:
        (OnFreeG: TQPtrFreeEventG);
      3:
        (OnFreeA: Pointer);
  end;

  TQPtr = class(TInterfacedObject, IQPtr)
  private
    FObject: Pointer;
    FOnFree: TQPtrFreeEvents;
  public
    constructor Create(AObject: Pointer); overload;
    destructor Destroy; override;
    class function Bind(AObject: TObject): IQPtr; overload;
    class function Bind(AData: Pointer; AOnFree: TQPtrFreeEvent)
      : IQPtr; overload;
    class function Bind(AData: Pointer; AOnFree: TQPtrFreeEventG)
      : IQPtr; overload;
{$IFDEF UNICODE}
    class function Bind(AData: Pointer; AOnFree: TQPtrFreeEventA)
      : IQPtr; overload;
{$ENDIF}
    function Get: Pointer;
  end;
{$IF RTLVersion<=23}

  TDirection = (FromBeginning, FromEnd);
  TPointerList = array of Pointer;
{$ELSE}
  // TDirection = System.Types.TDirection;
{$IFEND}

  // TQPagedList - 分页式列表，将来用于记录列表
  TQListPage = class
  protected
    FStartIndex: Integer; // 起始索引
    FUsedCount: Integer; // 使用的页面计数
    FItems: array of Pointer;
  public
    constructor Create(APageSize: Integer);
  end;

  TQPagedListSortCompare = procedure(p1, p2: Pointer; var AResult: Integer)
    of object;
  TQPagedListSortCompareG = procedure(p1, p2: Pointer; var AResult: Integer);
{$IFDEF UNICODE}
  TQPagedListSortCompareA = reference to procedure(p1, p2: Pointer;
    var AResult: Integer);
{$ENDIF}
  TQPagedList = class;

  TQPagedListEnumerator = class
  private
    FIndex: Integer;
    FList: TQPagedList;
  public
    constructor Create(AList: TQPagedList);
    function GetCurrent: Pointer; inline;
    function MoveNext: Boolean;
    property Current: Pointer read GetCurrent;
  end;

  TQPagedList = class
  private
    procedure InternalInsert(AIndex: Integer; const p: Pointer);
  protected
    FPages: array of TQListPage; // 页面列表
    FPageSize: Integer; // 每页大小
    FCount: Integer; // 数量
    FLastUsedPage: Integer;
    FFirstDirtyPage: Integer; // 首个索引脏的页面
    FOnCompare: TQPagedListSortCompare; // 内容比较函数
    function DoCompare(p1, p2: Pointer): Integer; inline;
    function GetItems(AIndex: Integer): Pointer;
    procedure SetItems(AIndex: Integer; const Value: Pointer);
    procedure DoDelete(const p: Pointer);
    function FindPage(AIndex: Integer): Integer;
    procedure Dirty(APage: Integer); inline;
    procedure Notify(Ptr: Pointer; Action: TListNotification); virtual;
    function GetCapacity: Integer;
    procedure SetCapacity(const Value: Integer);
    function GetList: TPointerList;
    procedure SetOnCompare(const Value: TQPagedListSortCompare);
    procedure CheckLastPage;
  public
    /// <summary>
    /// 默认构造函数，由于未指定页面大小，使用默认大小4096
    /// </summary>
    constructor Create; overload;
    /// <summary>构造函数</summary>
    /// <param name="APageSize">每页项数，如果小于等于0则使用默认值</param>
    constructor Create(APageSize: Integer); overload;
    /// <summary>析构函数</summary>
    destructor Destroy; override;
{$IF RTLVersion<26}
    /// <summary>拷贝函数，参考TList.Assign</summary>
    procedure Assign(ListA: TList; AOperator: TListAssignOp = laCopy;
      ListB: TList = nil); overload;
{$IFEND}
    /// <summary>拷贝函数，参考TList.Assign</summary>
    procedure Assign(ListA: TQPagedList; AOperator: TListAssignOp = laCopy;
      ListB: TQPagedList = nil); overload;
    /// <summary>添加一个元素</summary>
    /// <param name="p">要添加的元素</param>
    /// <returns>返回新元素的索引值</returns>
    function Add(const p: Pointer): Integer;
    /// <summary>在指定的位置插入一个新元素</summary>
    /// <param name="AIndex">要插入的位置，如果小于等于0，插入起始位置，如果大于等于Count，则插入末尾</param>
    /// <param name="p">要插入的元素</param>
    /// <remarks>如果指定的排序规则，则AIndex参数被忽略</remarks>
    procedure Insert(AIndex: Integer; const p: Pointer);
    /// <summary>交换两个元素的位置</summary>
    /// <param name="AIndex1">第一个元素的位置索引</param>
    /// <param name="AIndex2">第二个元素的位置索引</param>
    procedure Exchange(AIndex1, AIndex2: Integer);
    /// <summary>将指定位置的元素移动到新位置</summary>
    /// <param name="AFrom">起始位置索引</param>
    /// <param name="ATo">目标位置索引</param>
    procedure MoveTo(AFrom, ATo: Integer);
    /// <summary>实际直接调用MoveTo</summary>
    procedure Move(AFrom, ATo: Integer); inline;
    /// <summary>删除指定的元素</summary>
    procedure Delete(AIndex: Integer);
    /// <summary>移除指定的元素</summary>
    procedure Remove(AIndex: Integer); overload;
    /// <summary>移除指定的元素</summary>
    function Remove(Item: Pointer): Integer; overload; inline;
    /// <summary>从指定的方向开始查找并移除元素</summary>
    function RemoveItem(Item: Pointer; Direction: TDirection): Integer;
    /// <summary>查找指定元素的索引</summary>
    /// <param name="p">要查找的元素</param>
    /// <param name="AIdx">找到的元素索引</param>
    /// <returns>如果找到，返回True,否则返回False，AIdx为目标应出现的位置</returns>
    function Find(const p: Pointer; var AIdx: Integer): Boolean;
    /// <summary>清除所有元素</summary>
    procedure Clear;
    /// <summary>收缩列表为最少的页数</summary>
    procedure Pack;
    /// <summary>按照OnCompare规定的规则排序</summary>
    /// <remarks>一旦指定OnCompare规则，则添加元素时会自动排序，Insert时指定的索引位置将会被忽略</remarks>
    procedure Sort; overload;
{$IFDEF UNICODE}
    /// <summary>按照AOnCompare参数规定的规则排序</summary>
    /// <remarks>一旦指定OnCompare规则，则添加元素时会自动排序，Insert时指定的索引位置将会被忽略</remarks>
    procedure Sort(AOnCompare: TQPagedListSortCompareA); overload;
{$ENDIF}
    /// <summary>按照AOnCompare参数规定的规则排序</summary>
    /// <remarks>一旦指定OnCompare规则，则添加元素时会自动排序，Insert时指定的索引位置将会被忽略</remarks>
    procedure Sort(AOnCompare: TQPagedListSortCompareG); overload;
    /// <summary> for .. in 支持</summary>
    function GetEnumerator: TQPagedListEnumerator;
    /// <summary>仅为兼容 TList 添加，对 TQPagedList 无意义</summary>
    function Expand: TQPagedList;
    /// <summary>移除指定的项目</summary>
    function Extract(Item: Pointer): Pointer; inline;
    /// <summary>移除指定的项目</summary>
    function ExtractItem(Item: Pointer; Direction: TDirection): Pointer;
    /// <summary>首个元素</summary>
    function First: Pointer; inline;
    /// <summary>最后一个元素</summary>
    function Last: Pointer; inline;
    /// <summary>获取指定元素的首次出现位置</summary>
    function IndexOf(Item: Pointer): Integer;
    /// <summary>按指定的方向查找元素首次出现的位置</summary>
    function IndexOfItem(Item: Pointer; Direction: TDirection): Integer;
    /// <summary>元素个数</summary>
    property count: Integer read FCount;
    /// <summary>元素列表</summary>
    property Items[AIndex: Integer]: Pointer read GetItems
      write SetItems; default;
    /// <summary>元素比较规则，如果指定，则元素自动排序</summary>
    property OnCompare: TQPagedListSortCompare read FOnCompare
      write SetOnCompare;
    /// <summary>兼容TList设置，对 TQPagedList 无意义</summary>
    property Capacity: Integer read GetCapacity write SetCapacity;
    /// <summary>获取所有的元素值数组</summary>
    property List: TPointerList read GetList;
  end;

  TQPagedStream = class(TStream)
  private
    procedure SetCapacity(Value: Int64);
    function GetBytes(AIndex: Int64): Byte;
    procedure SetBytes(AIndex: Int64; const Value: Byte);
    procedure SetAsBytes(const Value: TBytes);
    function GetAsBytes: TBytes;
  protected
    FPages: array of PByte;
    FPageSize: Integer;
    FSize: Int64;
    FPosition: Int64;
    FCapacity: Int64;
    function ActivePage: Integer; inline;
    function ActiveOffset: Integer; inline;
    procedure PageNeeded(APageIndex: Integer);
    function GetSize: Int64; override;
  public
    constructor Create; overload;
    constructor Create(APageSize: Integer); overload;
    destructor Destroy; override;
    procedure Clear;
    function Read(var Buffer; count: Longint): Longint; overload; override;
    function Read(Buffer: TBytes; Offset, count: Longint): Longint;
{$IF RTLVersion>23} override{$ELSE}reintroduce;
    overload{$IFEND};
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    procedure SaveToStream(Stream: TStream); virtual;
    procedure SaveToFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure LoadFromFile(const FileName: string);
    procedure SetSize(const NewSize: Int64); override;
    procedure SetSize(NewSize: Longint); override;
    function Write(const Buffer; count: Longint): Longint; overload; override;
    function Write(const Buffer: TBytes; Offset, count: Longint): Longint;
{$IF RTLVersion>23} override{$ELSE}reintroduce;
    overload{$IFEND};
    property Capacity: Int64 read FCapacity write SetCapacity;
    property Bytes[AIndex: Int64]: Byte read GetBytes write SetBytes;
    property AsBytes: TBytes read GetAsBytes write SetAsBytes;
  end;

  TQBits = record
  private
    FBits: TBytes;
    function GetSize: Integer;
    procedure SetSize(const Value: Integer);
    function GetIsSet(AIndex: Integer): Boolean;
    procedure SetIsSet(AIndex: Integer; const Value: Boolean);
  public
    property Size: Integer read GetSize write SetSize;
    property IsSet[AIndex: Integer]: Boolean read GetIsSet
      write SetIsSet; default;
    property Bytes: TBytes read FBits write FBits;
  end;

  TQFilterCharEvent = procedure(const AChar, AIndex: Cardinal;
    var Accept: Boolean; ATag: Pointer) of object;
{$IFDEF UNICODE}
  TQFilterCharEventA = reference to procedure(const c, AIndex: Cardinal;
    var Accept: Boolean; ATag: Pointer);
{$ENDIF}
  TQNumberType = (nftFloat, nftHexPrec, nftDelphiHex, nftCHex, nftBasicHex,
    nftNegative, nftPositive);
  TQNumberTypes = set of TQNumberType;

  TPasswordStrongLevel = (pslLowest, pslLower, pslNormal, pslHigher,
    pslHighest);
  TPasswordRule = (prIncNumber, prIncLowerCase, prIncUpperCase, prIncChart,
    prIncUnicode, prRepeat, prSimpleOrder);
  TPasswordRules = set of TPasswordRule;

  // UTF8编码与Unicode编码转换函数，使用自己的实现
function Utf8Decode(p: PQCharA; l: Integer): QStringW; overload;
function Utf8Decode(const p: QStringA): QStringW; overload;
function Utf8Encode(p: PQCharW; l: Integer): QStringA; overload;
function Utf8Encode(const p: QStringW): QStringA; overload;
// Ansi编码与Unicode编码转换函数，使用系统的TEncoding实现
function AnsiEncode(p: PQCharW; l: Integer): QStringA; overload;
function AnsiEncode(const p: QStringW): QStringA; overload;
function AnsiDecode(p: PQCharA; l: Integer): QStringW; overload;
function AnsiDecode(const p: QStringA): QStringW; overload;

function CNSpellChars(S: QStringA; AIgnoreEnChars: Boolean): QStringW; overload;
function CNSpellChars(S: QStringW; AIgnoreEnChars: Boolean): QStringW; overload;

// 计算当前字符的长度
function CharSizeA(c: PQCharA): Integer;
function CharSizeU(c: PQCharA): Integer;
function CharSizeW(c: PQCharW): Integer;
// 计算字符数函数，CharCountW重写以包括UCS2扩展区字符处理
function CharCountA(const source: QStringA): Integer;
function CharCountW(const S: QStringW): Integer;
function CharCountU(const source: QStringA): Integer;
function CharCodeA(c: PQCharA): Cardinal;
function CharCodeU(c: PQCharA): Cardinal;
function CharCodeW(c: PQCharW): Cardinal;
// 检查字符是否在指定的列表中
function CharInA(const c: PQCharA; const List: array of QCharA;
  ACharLen: PInteger = nil): Boolean;
function CharInW(const c: PQCharW; const List: array of QCharW;
  ACharLen: PInteger = nil): Boolean; overload;
function CharInW(const c, List: PQCharW; ACharLen: PInteger = nil)
  : Boolean; overload;
function CharInU(const c: PQCharA; const List: array of QCharA;
  ACharLen: PInteger = nil): Boolean;

// 检查是否是空白字符
function IsSpaceA(const c: PQCharA; ASpaceSize: PInteger = nil): Boolean;
function IsSpaceW(const c: PQCharW; ASpaceSize: PInteger = nil): Boolean;
function IsSpaceU(const c: PQCharA; ASpaceSize: PInteger = nil): Boolean;

// 全角半角转换
function CNFullToHalf(const S: QStringW): QStringW;
function CNHalfToFull(const S: QStringW): QStringW;

// 引号处理
function QuotedStrA(const S: QStringA; const AQuoter: QCharA = $27): QStringA;
function QuotedStrW(const S: QStringW; const AQuoter: QCharW = #$27): QStringW;
function SQLQuoted(const S: QStringW): QStringW;
function DequotedStrA(const S: QStringA; const AQuoter: QCharA = $27): QStringA;
function DequotedStrW(const S: QStringW; const AQuoter: QCharW = #$27)
  : QStringW;

// 跳过列表中的字符
function SkipCharA(var p: PQCharA; const List: array of QCharA): Integer;
function SkipCharU(var p: PQCharA; const List: array of QCharA): Integer;
function SkipCharW(var p: PQCharW; const List: array of QCharA)
  : Integer; overload;
function SkipCharW(var p: PQCharW; const List: PQCharW): Integer; overload;

// 跳过空白字符，对于 Ansi编码，跳过的是#9#10#13#161#161，对于UCS编码，跳过的是#9#10#13#$3000
function SkipSpaceA(var p: PQCharA): Integer;
function SkipSpaceU(var p: PQCharA): Integer;
function SkipSpaceW(var p: PQCharW): Integer;
// 跳过一行,以#10为行结尾
function SkipLineA(var p: PQCharA): Integer;
function SkipLineU(var p: PQCharA): Integer;
function SkipLineW(var p: PQCharW): Integer;
// 跳过直接遇到指定的字符
function SkipUntilA(var p: PQCharA; AExpects: array of QCharA;
  AQuoter: QCharA = 0): Integer;
function SkipUntilU(var p: PQCharA; AExpects: array of QCharA;
  AQuoter: QCharA = 0): Integer;
function SkipUntilW(var p: PQCharW; AExpects: array of QCharW;
  AQuoter: QCharW = #0): Integer; overload;
function SkipUntilW(var p: PQCharW; AExpects: PQCharW; AQuoter: QCharW = #0)
  : Integer; overload;
// 查找字符所在行列号，返回行的起始地址
function StrPosA(Start, Current: PQCharA; var ACol, ARow: Integer): PQCharA;
function StrPosU(Start, Current: PQCharA; var ACol, ARow: Integer): PQCharA;
function StrPosW(Start, Current: PQCharW; var ACol, ARow: Integer): PQCharW;

// 字符串分解
function DecodeTokenA(var p: PQCharA; ADelimiters: array of QCharA;
  AQuoter: QCharA; AIgnoreSpace: Boolean): QStringA;
function DecodeTokenU(var p: PQCharA; ADelimiters: array of QCharA;
  AQuoter: QCharA; AIgnoreSpace: Boolean): QStringA;
function DecodeTokenW(var p: PQCharW; ADelimiters: array of QCharW;
  AQuoter: QCharW; AIgnoreSpace: Boolean; ASkipDelimiters: Boolean = True)
  : QStringW; overload;
function DecodeTokenW(var p: PQCharW; ADelimiters: PQCharW; AQuoter: QCharW;
  AIgnoreSpace: Boolean; ASkipDelimiters: Boolean = True): QStringW; overload;
function DecodeTokenW(var S: QStringW; ADelimiters: PQCharW; AQuoter: QCharW;
  AIgnoreCase, ARemove: Boolean; ASkipDelimiters: Boolean = True)
  : QStringW; overload;
function SplitTokenW(AList: TStrings; p: PQCharW; ADelimiters: PQCharW;
  AQuoter: QCharW; AIgnoreSpace: Boolean): Integer; overload;
function SplitTokenW(AList: TStrings; const S: QStringW; ADelimiters: PQCharW;
  AQuoter: QCharW; AIgnoreSpace: Boolean): Integer; overload;

function LeftStrW(const S: QStringW; AMaxCount: Integer; ACheckExt: Boolean)
  : QStringW;
function RightStrW(const S: QStringW; AMaxCount: Integer; ACheckExt: Boolean)
  : QStringW;
function StrBetween(var S: PQCharW; AStartTag, AEndTag: QStringW;
  AIgnoreCase: Boolean): QStringW;
function TokenWithIndex(var S: PQCharW; AIndex: Integer; ADelimiters: PQCharW;
  AQuoter: QCharW; AIgnoreSapce: Boolean): QStringW;
function UpperFirstW(const S: QStringW): QStringW;
// 获取一行
function DecodeLineA(var p: PQCharA; ASkipEmpty: Boolean = True): QStringA;
function DecodeLineU(var p: PQCharA; ASkipEmpty: Boolean = True): QStringA;
function DecodeLineW(var p: PQCharW; ASkipEmpty: Boolean = True): QStringW;

// 判断是否是以指定的字符串开始
function CharUpperA(c: QCharA): QCharA;
function CharUpperW(c: QCharW): QCharW;
function CharLowerA(c: QCharA): QCharA;
function CharLowerW(c: QCharW): QCharW;
function StartWithA(S, startby: PQCharA; AIgnoreCase: Boolean): Boolean;
function StartWithU(S, startby: PQCharA; AIgnoreCase: Boolean): Boolean;
function StartWithW(S, startby: PQCharW; AIgnoreCase: Boolean): Boolean;
function EndWithA(const S, endby: QStringA; AIgnoreCase: Boolean): Boolean;
function EndWithU(const S, endby: QStringA; AIgnoreCase: Boolean): Boolean;
function EndWithW(const S, endby: QStringW; AIgnoreCase: Boolean): Boolean;
function SameCharsA(s1, s2: PQCharA; AIgnoreCase: Boolean): Integer;
function SameCharsU(s1, s2: PQCharA; AIgnoreCase: Boolean): Integer;
function SameCharsW(s1, s2: PQCharW; AIgnoreCase: Boolean): Integer;
// 加载文本
function LoadTextA(AFileName: String; AEncoding: TTextEncoding = teUnknown)
  : QStringA; overload;
function LoadTextA(AStream: TStream; AEncoding: TTextEncoding = teUnknown)
  : QStringA; overload;
function LoadTextU(AFileName: String; AEncoding: TTextEncoding = teUnknown)
  : QStringA; overload;
function LoadTextU(AStream: TStream; AEncoding: TTextEncoding = teUnknown)
  : QStringA; overload;
function LoadTextW(AFileName: String; AEncoding: TTextEncoding = teUnknown)
  : QStringW; overload;
function LoadTextW(AStream: TStream; AEncoding: TTextEncoding = teUnknown)
  : QStringW; overload;
// 检测文本编码并加载文本内容，注意对于没有BOM的文本的检测不是100%，尤其在没有BOM
// 时难以区分Unicode和Ansi编码的字符
function DecodeText(p: Pointer; ASize: Integer;
  AEncoding: TTextEncoding = teUnknown): QStringW;
// 保存文本
procedure SaveTextA(AFileName: String; const S: QStringA); overload;
procedure SaveTextA(AStream: TStream; const S: QStringA); overload;
procedure SaveTextU(AFileName: String; const S: QStringA;
  AWriteBom: Boolean = True); overload;
procedure SaveTextU(AFileName: String; const S: QStringW;
  AWriteBom: Boolean = True); overload;
procedure SaveTextU(AStream: TStream; const S: QStringA;
  AWriteBom: Boolean = True); overload;
procedure SaveTextU(AStream: TStream; const S: QStringW;
  AWriteBom: Boolean = True); overload;
procedure SaveTextW(AFileName: String; const S: QStringW;
  AWriteBom: Boolean = True); overload;
procedure SaveTextW(AStream: TStream; const S: QStringW;
  AWriteBom: Boolean = True); overload;
procedure SaveTextWBE(AStream: TStream; const S: QStringW;
  AWriteBom: Boolean = True); overload;

function StrStrA(s1, s2: PQCharA): PQCharA;
function StrIStrA(s1, s2: PQCharA): PQCharA;
function StrStrU(s1, s2: PQCharA): PQCharA;
function StrIStrU(s1, s2: PQCharA): PQCharA;
function StrStrW(s1, s2: PQCharW): PQCharW;
function StrIStrW(s1, s2: PQCharW): PQCharW;
function StrLikeW(S, pat: PQCharW; AIgnoreCase: Boolean): Boolean; overload;
/// <summary>Pos函数的增强版本实现</summary>
/// <param name="sub">要查找的子字符串</param>
/// <param name="S">用来查找的原字符串</param>
/// <param name="AIgnoreCase">是否忽略大小写</param>
/// <param name="AStartPos">起始位置，第一个字符位置为1</param>
/// <returns>找到，返回子串的起始位置，失败，返回0<returns>
function PosW(sub, S: PQCharW; AIgnoreCase: Boolean; AStartPos: Integer = 1)
  : Integer; overload;
/// <param name="sub">要查找的子字符串</param>
/// <param name="S">用来查找的原字符串</param>
/// <param name="AIgnoreCase">是否忽略大小写</param>
/// <param name="AStartPos">起始位置，第一个字符位置为1</param>
/// <returns>找到，返回子串的起始位置，失败，返回0<returns>
function PosW(sub, S: QStringW; AIgnoreCase: Boolean; AStartPos: Integer = 1)
  : Integer; overload;
function StrDupX(const S: PQCharW; ACount: Integer): QStringW;
function StrDupW(const S: PQCharW; AOffset: Integer;
  const ACount: Integer = MaxInt): QStringW;
procedure StrCpyW(d: PQCharW; S: PQCharW; ACount: Integer = -1);
function StrCmpA(const s1, s2: PQCharA; AIgnoreCase: Boolean): Integer;
function StrCmpW(const s1, s2: PQCharW; AIgnoreCase: Boolean): Integer;
function StrNCmpW(const s1, s2: PQCharW; AIgnoreCase: Boolean;
  ALength: Integer): Integer;
function NaturalCompareW(s1, s2: PQCharW; AIgnoreCase: Boolean;
  AIgnoreSpace: Boolean = True): Integer;
function IsHexChar(c: QCharW): Boolean; inline;
function HexValue(c: QCharW): Integer;
function HexChar(V: Byte): QCharW;
function TryStrToGuid(const S: QStringW; var AGuid: TGuid): Boolean;
function TryStrToIPV4(const S: QStringW; var AIPV4:
{$IFDEF MSWINDOWS}Integer{$ELSE}Cardinal{$ENDIF}): Boolean;
function StringReplaceW(const S, Old, New: QStringW; AFlags: TReplaceFlags)
  : QStringW; overload;
/// <summary>替换指定范围内的字符为指定的字符</summary>
/// <param name="AChar">占位字符</param>
/// <param name="AFrom">开始位置，从0开始</param>
/// <param name="ACount">替换数量</param>
/// <returns>返回替换后的字符串</returns>
function StringReplaceW(const S: QStringW; const AChar: QCharW;
  AFrom, ACount: Integer): QStringW; overload;
/// <summary>使用指定的内容替换AStartTag和EndTag之间的内容</summary>
/// <params>
/// <param name="S">要查找替换的字符串</param>
/// <param name="AStartTag">开始的标签名称</param>
/// <param name="AEndTag">结束的标签名称</param>
/// <param name="AReplaced">替换的结果</param>
/// <param name="AWithTag">是否连同AStartTag和AEndTag标签一起替换掉</param>
/// <param name="AIgnoreCase">比较标签名称时是否忽略大小</param>
/// <param name="AMaxTimes">最大替换次数，默认为1</param>
/// </params>
/// <returns>返回替换后的内容</returns>
function StringReplaceWithW(const S, AStartTag, AEndTag, AReplaced: QStringW;
  AWithTag, AIgnoreCase: Boolean; AMaxTimes: Cardinal = 1): QStringW;

function StringReplicateW(const S: QStringW; ACount: Integer): QStringW;

/// <summary>过滤掉字符串内容中不需要的字符</summary>
/// <param name="S">要过滤的字符串</param>
/// <param name="AcceptChars">允许的字符列表</param>
/// <returns>返回过滤后的结果</returns>
function FilterCharW(const S: QStringW; AcceptChars: QStringW)
  : QStringW; overload;
/// <summary>过滤掉字符串内容中不需要的字符</summary>
/// <param name="S">要过滤的字符串</param>
/// <param name="AOnValidate">用于过滤的回调函数</param>
/// <param name="ATag">用户自定义的附加参数，会传递给AOnValidate事件</param>
/// <returns>返回过滤后的结果</returns>
function FilterCharW(const S: QStringW; AOnValidate: TQFilterCharEvent;
  ATag: Pointer = nil): QStringW; overload;
{$IFDEF UNICODE}
/// <summary>过滤掉字符串内容中不需要的字符</summary>
/// <param name="S">要过滤的字符串</param>
/// <param name="AOnValidate">用于过滤的回调函数</param>
/// <param name="ATag">用户自定义的附加参数，会传递给AOnValidate事件</param>
/// <returns>返回过滤后的结果</returns>
function FilterCharW(const S: QStringW; AOnValidate: TQFilterCharEventA;
  ATag: Pointer = nil): QStringW; overload;
{$ENDIF}
/// <summary>过滤掉所有非数值类型的字符，从而将其格式化一个相对标准的浮点数</summary>
/// <param name="S">要过滤的字符串</param>
/// <param name="Accepts">过滤条件组件</param>
/// <returns>返回过滤后的结果</returns>
/// <remarks>
/// FilterNoNumberW 过滤后的结果可以使用 ParseNumeric 解析为数组，大部分情况下也
/// 可以被StrToFloat解析（但StrToFloat不支持有些特殊格式）

function FilterNoNumberW(const S: QStringW; Accepts: TQNumberTypes): QStringW;

function MemScan(S: Pointer; len_s: Integer; sub: Pointer;
  len_sub: Integer): Pointer;
function BinaryCmp(const p1, p2: Pointer; len: Integer): Integer;
// 下面的函数只能Unicode版本，没有Ansi和UTF-8版本，如果需要，再加入
function NameOfW(const S: QStringW; ASpliter: QCharW): QStringW;
function ValueOfW(const S: QStringW; ASpliter: QCharW): QStringW;
function IndexOfNameW(AList: TStrings; const AName: QStringW;
  ASpliter: QCharW): Integer;
function IndexOfValueW(AList: TStrings; const AValue: QStringW;
  ASpliter: QCharW): Integer;
function DeleteCharW(const ASource, ADeletes: QStringW): QStringW;
function DeleteRightW(const S, ADelete: QStringW; AIgnoreCase: Boolean = False;
  ACount: Integer = MaxInt): QStringW;
function DeleteLeftW(const S, ADelete: QStringW; AIgnoreCase: Boolean = False;
  ACount: Integer = MaxInt): QStringW;
function ContainsCharW(const S, ACharList: QStringW): Boolean;
function HtmlEscape(const S: QStringW): QStringW;
function HtmlUnescape(const S: QStringW): QStringW;
function HtmlTrimText(const S: QStringW): QStringW;
function LeftStrCount(const S: QStringW; const sub: QStringW;
  AIgnoreCase: Boolean): Integer;
function RightStrCount(const S: QStringW; const sub: QStringW;
  AIgnoreCase: Boolean): Integer;
// 下面是一些辅助函数
function ParseInt(var S: PQCharW; var ANum: Int64): Integer;
function ParseHex(var p: PQCharW; var Value: Int64): Integer;
function ParseNumeric(var S: PQCharW; var ANum: Extended): Boolean;
function ParseDateTime(S: PWideChar; var AResult: TDateTime): Boolean;
function ParseWebTime(p: PWideChar; var AResult: TDateTime): Boolean;
function RollupSize(ASize: Int64): QStringW;
function RollupTime(ASeconds: Int64; AHideZero: Boolean = True): QStringW;
function DetectTextEncoding(const p: Pointer; l: Integer; var b: Boolean)
  : TTextEncoding;
procedure ExchangeByteOrder(p: PQCharA; l: Integer); overload;
function ExchangeByteOrder(V: Smallint): Smallint; overload; inline;
function ExchangeByteOrder(V: Word): Word; overload; inline;
function ExchangeByteOrder(V: Integer): Integer; overload; inline;
function ExchangeByteOrder(V: Cardinal): Cardinal; overload; inline;
function ExchangeByteOrder(V: Int64): Int64; overload; inline;
function ExchangeByteOrder(V: Single): Single; overload; inline;
function ExchangeByteOrder(V: Double): Double; overload; inline;

procedure FreeObject(AObject: TObject); inline;
// 原子操作函数
function AtomicAnd(var Dest: Integer; const AMask: Integer): Integer;
function AtomicOr(var Dest: Integer; const AMask: Integer): Integer;
{$IF RTLVersion<24}
// 为与XE6兼容，InterlockedCompareExchange等价
function AtomicCmpExchange(var Target: Integer; Value: Integer;
  Comparand: Integer): Integer; inline; overload;
function AtomicCmpExchange(var Target: Pointer; Value: Pointer;
  Comparand: Pointer): Pointer; inline; overload;
// 等价于InterlockedExchanged
function AtomicExchange(var Target: Integer; Value: Integer): Integer;
  inline; overload;
function AtomicExchange(var Target: Pointer; Value: Pointer): Pointer;
  inline; overload;

function AtomicIncrement(var Target: Integer; const Value: Integer = 1)
  : Integer; inline;
function AtomicDecrement(var Target: Integer): Integer; inline;
{$IFEND <XE5}
//
function BinToHex(p: Pointer; l: Integer; ALowerCase: Boolean = False)
  : QStringW; overload;
function BinToHex(const ABytes: TBytes; ALowerCase: Boolean = False)
  : QStringW; overload;
function HexToBin(const S: QStringW): TBytes; overload;
procedure HexToBin(const S: QStringW; var AResult: TBytes); overload;
// 计算指定内容的哈希值
function HashOf(p: Pointer; l: Integer): Cardinal;
function NewId: TGuid;
function SameId(const V1, V2: TGuid): Boolean;

/// <summary>计算指定内容的密码强度</summary>
/// <param name="S">密码</param>
/// <returns>返回一个>=0的密码强度值</returns>
function PasswordScale(const S: QStringW): Integer;
/// <summary>将指定的密码强度系数转换为强度等级</summary>
/// <param name="AScale">通过PasswordScale得到的强度等级</param>
/// <returns>返回转换后的强度等级</returns>
function CheckPassword(const AScale: Integer): TPasswordStrongLevel; overload;
/// <summary>计算指定内容的密码的强度等级</summary>
/// <param name="S">密码</param>
/// <returns>返回计算得到的强度等级</returns>
function CheckPassword(const S: QStringW): TPasswordStrongLevel; overload;

var
  JavaFormatUtf8: Boolean;
  IsFMXApp: Boolean;

const
  SLineBreak: PQCharW = {$IFDEF MSWINDOWS}#13#10{$ELSE}#10{$ENDIF};
  DefaultNumberSet = [nftFloat, nftDelphiHex, nftCHex, nftBasicHex, nftHexPrec,
    nftNegative, nftPositive];

implementation

uses dateutils, math, variants
{$IFDEF MSWINDOWS}
    , windows
{$ENDIF}
{$IF (RTLVersion>=25) and (not Defined(NEXTGEN))}
    , AnsiStrings
{$IFEND >=XE4}
    ;

resourcestring
  SBadUnicodeChar = '无效的Unicode字符:%d';
  SBadUtf8Char = '无效的UTF8字符:%d';
  SOutOfIndex = '索引越界，值 %d 不在[%d..%d]的范围内。';
  SDayName = '天';
  SHourName = '小时';
  SMinuteName = '分钟';
  SSecondName = '秒';
  SCharNeeded = '当前位置应该是 "%s" ，而不是 "%s"。';
  SRangeEndNeeded = '字符范围边界结束字符未指定。';

type
  TGBKCharSpell = record
    SpellChar: QCharW;
    StartChar, EndChar: Word;
  end;

  TStrStrFunction = function(s1, s2: PQCharW): PQCharW;
{$IF RTLVersion>=21}
  TIntArray = TArray<Integer>;
{$ELSE}
  TIntArray = array of Integer;
{$IFEND >=2010}
{$IFDEF MSWINDOWS}
  TMSVCStrStr = function(s1, s2: PQCharA): PQCharA; cdecl;
  TMSVCStrStrW = function(s1, s2: PQCharW): PQCharW; cdecl;
  TMSVCMemCmp = function(s1, s2: Pointer; len: Integer): Integer; cdecl;
{$ENDIF}

var
  // GBK汉字拼音首字母表
  GBKSpells: array [0 .. 22] of TGBKCharSpell = (
    (
      SpellChar: 'A'; StartChar: $B0A1; EndChar: $B0C4;
    ), (SpellChar: 'B'; StartChar: $B0C5; EndChar: $B2C0;
    ), (SpellChar: 'C'; StartChar: $B2C1; EndChar: $B4ED;
    ), (SpellChar: 'D'; StartChar: $B4EE; EndChar: $B6E9;
    ), (SpellChar: 'E'; StartChar: $B6EA; EndChar: $B7A1;
    ), (SpellChar: 'F'; StartChar: $B7A2; EndChar: $B8C0;
    ), (SpellChar: 'G'; StartChar: $B8C1; EndChar: $B9FD;
    ), (SpellChar: 'H'; StartChar: $B9FE; EndChar: $BBF6;
    ), (SpellChar: 'J'; StartChar: $BBF7; EndChar: $BFA5;
    ), (SpellChar: 'K'; StartChar: $BFA6; EndChar: $C0AB;
    ), (SpellChar: 'L'; StartChar: $C0AC; EndChar: $C2E7;
    ), (SpellChar: 'M'; StartChar: $C2E8; EndChar: $C4C2;
    ), (SpellChar: 'N'; StartChar: $C4C3; EndChar: $C5B5;
    ), (SpellChar: 'O'; StartChar: $C5B6; EndChar: $C5BD;
    ), (SpellChar: 'P'; StartChar: $C5BE; EndChar: $C6D9;
    ), (SpellChar: 'Q'; StartChar: $C6DA; EndChar: $C8BA;
    ), (SpellChar: 'R'; StartChar: $C8BB; EndChar: $C8F5;
    ), (SpellChar: 'S'; StartChar: $C8F6; EndChar: $CBF0;
    ), (SpellChar: 'T'; StartChar: $CBFA; EndChar: $CDD9;
    ), (SpellChar: 'W'; StartChar: $CDDA; EndChar: $CEF3;
    ), (SpellChar: 'X'; StartChar: $CEF4; EndChar: $D188;
    ), (SpellChar: 'Y'; StartChar: $D1B9; EndChar: $D4D0;
    ), (SpellChar: 'Z'; StartChar: $D4D1; EndChar: $D7F9;));
{$IFDEF MSWINDOWS}
  hMsvcrtl: HMODULE;
  VCStrStr: TMSVCStrStr;
  VCStrStrW: TMSVCStrStrW;
  VCMemCmp: TMSVCMemCmp;
{$ENDIF}

const
  HtmlEscapeChars: array [0 .. 185] of QStringW = (QCharW(32), '&nbsp;',
    QCharW(34), '&quot;', QCharW(38), '&amp;', QCharW(39), '&apos;', QCharW(60),
    '&lt;', QCharW(62), '&gt;', QCharW(161), '&iexcl;', QCharW(162), '&cent;',
    QCharW(163), '&pound;', QCharW(164), '&curren;', QCharW(165), '&yen;',
    QCharW(166), '&brvbar;', QCharW(167), '&sect;', QCharW(168), '&uml;',
    QCharW(169), '&copy;', QCharW(170), '&ordf;', QCharW(171), '&laquo;',
    QCharW(172), '&not;', QCharW(173), '&shy;', QCharW(174), '&reg;',
    QCharW(175), '&macr;', QCharW(176), '&deg;', QCharW(177), '&plusmn;',
    QCharW(180), '&acute;', QCharW(181), '&micro;', QCharW(182), '&para;',
    QCharW(183), '&middot;', QCharW(184), '&cedil;', QCharW(186), '&ordm;',
    QCharW(187), '&raquo;', QCharW(191), '&iquest;', QCharW(192), '&Agrave;',
    QCharW(193), '&Aacute;', QCharW(194), '&circ;', QCharW(195), '&Atilde;',
    QCharW(197), '&ring;', QCharW(198), '&AElig;', QCharW(199), '&Ccedil;',
    QCharW(200), '&Egrave;', QCharW(201), '&Eacute;', QCharW(202), '&Ecirc;',
    QCharW(203), '&Euml;', QCharW(204), '&Igrave;', QCharW(205), '&Iacute;',
    QCharW(206), '&Icirc;', QCharW(207), '&Iuml;', QCharW(208), '&ETH;',
    QCharW(209), '&Ntilde;', QCharW(210), '&Ograve;', QCharW(211), '&Oacute;',
    QCharW(212), '&Ocirc;', QCharW(213), '&Otilde;', QCharW(214), '&Ouml;',
    QCharW(215), '&times;', QCharW(216), '&Oslash;', QCharW(217), '&Ugrave;',
    QCharW(218), '&Uacute;', QCharW(219), '&Ucirc;', QCharW(220), '&Uuml;',
    QCharW(221), '&Yacute;', QCharW(222), '&THORN;', QCharW(223), '&szlig;',
    QCharW(224), '&agrave;', QCharW(225), '&aacute;', QCharW(227), '&atilde;',
    QCharW(228), '&auml;', QCharW(229), '&aring;', QCharW(230), '&aelig;',
    QCharW(231), '&ccedil;', QCharW(232), '&egrave;', QCharW(233), '&eacute;',
    QCharW(234), '&ecirc;', QCharW(235), '&euml;', QCharW(236), '&igrave;',
    QCharW(237), '&iacute;', QCharW(238), '&icirc;', QCharW(239), '&iuml;',
    QCharW(240), '&ieth;', QCharW(241), '&ntilde;', QCharW(242), '&ograve;',
    QCharW(243), '&oacute;', QCharW(244), '&ocirc;', QCharW(245), '&otilde;',
    QCharW(246), '&ouml;', QCharW(247), '&divide;', QCharW(248), '&oslash;',
    QCharW(249), '&ugrave;', QCharW(250), '&uacute;', QCharW(251), '&ucirc;',
    QCharW(252), '&uuml;', QCharW(253), '&yacute;', QCharW(254), '&thorn;',
    QCharW(255), '&yuml;');
  // QString函数

function Utf8Decode(const p: QStringA): QStringW;
begin
  if p.IsUtf8 then
    Result := Utf8Decode(PQCharA(p), p.Length)
  else if p.Length > 0 then
    Result := AnsiDecode(p)
  else
    SetLength(Result, 0);
end;

function Utf8Encode(const p: QStringW): QStringA;
var
  l: NativeInt;
begin
  l := Length(p);
  if l > 0 then
    Result := Utf8Encode(PQCharW(p), l)
  else
  begin
    Result.Length := 0;
    Result.FValue[0] := 1;
  end;
end;

function Utf8Decode(p: PQCharA; l: Integer; var AResult: QStringW;
  var ABadAt: PQCharA): Boolean; overload;
var
  ps, pe: PByte;
  pd, pds: PWord;
  c: Cardinal;
begin
  if l <= 0 then
  begin
    ps := PByte(p);
    while ps^ <> 0 do
      Inc(ps);
    l := IntPtr(ps) - IntPtr(p);
  end;
  ps := PByte(p);
  pe := ps;
  Inc(pe, l);
  System.SetLength(AResult, l);
  pd := PWord(PQCharW(AResult));
  pds := pd;
  Result := True;
  while IntPtr(ps) < IntPtr(pe) do
  begin
    if (ps^ and $80) <> 0 then
    begin
      if (ps^ and $FC) = $FC then // 4000000+
      begin
        c := (ps^ and $03) shl 30;
        Inc(ps);
        c := c or ((ps^ and $3F) shl 24);
        Inc(ps);
        c := c or ((ps^ and $3F) shl 18);
        Inc(ps);
        c := c or ((ps^ and $3F) shl 12);
        Inc(ps);
        c := c or ((ps^ and $3F) shl 6);
        Inc(ps);
        c := c or (ps^ and $3F);
        Inc(ps);
        c := c - $10000;
        pd^ := $D800 + ((c shr 10) and $3FF);
        Inc(pd);
        pd^ := $DC00 + (c and $3FF);
        Inc(pd);
      end
      else if (ps^ and $F8) = $F8 then // 200000-3FFFFFF
      begin
        c := (ps^ and $07) shl 24;
        Inc(ps);
        c := c or ((ps^ and $3F) shl 18);
        Inc(ps);
        c := c or ((ps^ and $3F) shl 12);
        Inc(ps);
        c := c or ((ps^ and $3F) shl 6);
        Inc(ps);
        c := c or (ps^ and $3F);
        Inc(ps);
        c := c - $10000;
        pd^ := $D800 + ((c shr 10) and $3FF);
        Inc(pd);
        pd^ := $DC00 + (c and $3FF);
        Inc(pd);
      end
      else if (ps^ and $F0) = $F0 then // 10000-1FFFFF
      begin
        c := (ps^ and $0F) shl 18;
        Inc(ps);
        c := c or ((ps^ and $3F) shl 12);
        Inc(ps);
        c := c or ((ps^ and $3F) shl 6);
        Inc(ps);
        c := c or (ps^ and $3F);
        Inc(ps);
        c := c - $10000;
        pd^ := $D800 + ((c shr 10) and $3FF);
        Inc(pd);
        pd^ := $DC00 + (c and $3FF);
        Inc(pd);
      end
      else if (ps^ and $E0) = $E0 then // 800-FFFF
      begin
        c := (ps^ and $1F) shl 12;
        Inc(ps);
        c := c or ((ps^ and $3F) shl 6);
        Inc(ps);
        c := c or (ps^ and $3F);
        Inc(ps);
        pd^ := c;
        Inc(pd);
      end
      else if (ps^ and $C0) = $C0 then // 80-7FF
      begin
        pd^ := (ps^ and $3F) shl 6;
        Inc(ps);
        pd^ := pd^ or (ps^ and $3F);
        Inc(pd);
        Inc(ps);
      end
      else
      begin
        ABadAt := PQCharA(ps);
        Result := False;
        Exit;
      end;
    end
    else
    begin
      pd^ := ps^;
      Inc(ps);
      Inc(pd);
    end;
  end;
  System.SetLength(AResult, (IntPtr(pd) - IntPtr(pds)) shr 1);

end;

function Utf8Decode(p: PQCharA; l: Integer): QStringW;
var
  ABadChar: PQCharA;
begin
  if not Utf8Decode(p, l, Result, ABadChar) then
    raise Exception.Create(Format(SBadUtf8Char, [ABadChar^]));
end;

function WideCharUtf8Size(c: Integer): Integer;
begin
  if c < $7F then
    Result := 1
  else if c < $7FF then
    Result := 2
  else if c < $FFFF then
    Result := 3
  else if c < $1FFFFF then
    Result := 4
  else if c < $3FFFFFF then
    Result := 5
  else
    Result := 6;
end;

function Utf8BufferSize(p: PQCharW; var l: Integer): Integer;
var
  c: Cardinal;
  t: Integer;
begin
  Result := 0;
  if l < 0 then
  begin
    l := 0;
    while p^ <> #0 do
    begin
      if (p^ >= #$D800) and (p^ <= #$DFFF) then // Unicode 扩展区字符
      begin
        c := (Word(p^) - $D800);
        Inc(p);
        if (p^ >= #$DC00) and (p^ <= #$DFFF) then
        begin
          c := $10000 + (c shl 10) + Word(p^) - $DC00;
          Inc(p);
        end;
        Inc(Result, WideCharUtf8Size(c));
      end
      else
        Inc(Result, WideCharUtf8Size(Word(p^)));
      Inc(p);
      Inc(l);
    end;
  end
  else
  begin
    t := l;
    while t > 0 do
    begin
      if (p^ >= #$D800) and (p^ <= #$DFFF) then // Unicode 扩展区字符
      begin
        c := (Word(p^) - $D800);
        Inc(p);
        if (p^ >= #$DC00) and (p^ <= #$DFFF) then
        begin
          c := $10000 + (c shl 10) + Word(p^) - $DC00;
          Inc(p);
        end;
        Inc(Result, WideCharUtf8Size(c));
      end
      else
        Inc(Result, WideCharUtf8Size(Word(p^)));
      Inc(p);
      Dec(t);
    end;
  end;
end;

function Utf8Encode(p: PQCharW; l: Integer): QStringA;
var
  ps: PQCharW;
  pd, pds: PQCharA;
  c: Cardinal;
begin
  if p = nil then
  begin
    Result.Length := 0;
    Result.FValue[0] := 1;
  end
  else
  begin
    Result.Length := Utf8BufferSize(p, l);
    if l > 0 then
    begin
      Result.FValue[0] := 1;
      ps := p;
      pd := PQCharA(Result);
      pds := pd;
      while l > 0 do
      begin
        c := Cardinal(ps^);
        Inc(ps);
        if (c >= $D800) and (c <= $DFFF) then // Unicode 扩展区字符
        begin
          c := (c - $D800);
          if (ps^ >= #$DC00) and (ps^ <= #$DFFF) then
          begin
            c := $10000 + ((c shl 10) + (Cardinal(ps^) - $DC00));
            Inc(ps);
            Dec(l);
          end
          else
            raise Exception.Create(Format(SBadUnicodeChar, [IntPtr(ps^)]));
        end;
        Dec(l);
        if c = $0 then
        begin
          if JavaFormatUtf8 then // 按照Java格式编码，将#$0字符编码为#$C080
          begin
            pd^ := $C0;
            Inc(pd);
            pd^ := $80;
            Inc(pd);
          end
          else
          begin
            pd^ := c;
            Inc(pd);
          end;
        end
        else if c <= $7F then // 1B
        begin
          pd^ := c;
          Inc(pd);
        end
        else if c <= $7FF then // $80-$7FF,2B
        begin
          pd^ := $C0 or (c shr 6);
          Inc(pd);
          pd^ := $80 or (c and $3F);
          Inc(pd);
        end
        else if c <= $FFFF then // $8000 - $FFFF,3B
        begin
          pd^ := $E0 or (c shr 12);
          Inc(pd);
          pd^ := $80 or ((c shr 6) and $3F);
          Inc(pd);
          pd^ := $80 or (c and $3F);
          Inc(pd);
        end
        else if c <= $1FFFFF then // $01 0000-$1F FFFF,4B
        begin
          pd^ := $F0 or (c shr 18); // 1111 0xxx
          Inc(pd);
          pd^ := $80 or ((c shr 12) and $3F); // 10 xxxxxx
          Inc(pd);
          pd^ := $80 or ((c shr 6) and $3F); // 10 xxxxxx
          Inc(pd);
          pd^ := $80 or (c and $3F); // 10 xxxxxx
          Inc(pd);
        end
        else if c <= $3FFFFFF then // $20 0000 - $3FF FFFF,5B
        begin
          pd^ := $F8 or (c shr 24); // 1111 10xx
          Inc(pd);
          pd^ := $F0 or ((c shr 18) and $3F); // 10 xxxxxx
          Inc(pd);
          pd^ := $80 or ((c shr 12) and $3F); // 10 xxxxxx
          Inc(pd);
          pd^ := $80 or ((c shr 6) and $3F); // 10 xxxxxx
          Inc(pd);
          pd^ := $80 or (c and $3F); // 10 xxxxxx
          Inc(pd);
        end
        else if c <= $7FFFFFFF then // $0400 0000-$7FFF FFFF,6B
        begin
          pd^ := $FC or (c shr 30); // 1111 11xx
          Inc(pd);
          pd^ := $F8 or ((c shr 24) and $3F); // 10 xxxxxx
          Inc(pd);
          pd^ := $F0 or ((c shr 18) and $3F); // 10 xxxxxx
          Inc(pd);
          pd^ := $80 or ((c shr 12) and $3F); // 10 xxxxxx
          Inc(pd);
          pd^ := $80 or ((c shr 6) and $3F); // 10 xxxxxx
          Inc(pd);
          pd^ := $80 or (c and $3F); // 10 xxxxxx
          Inc(pd);
        end;
      end;
      pd^ := 0;
      Result.Length := IntPtr(pd) - IntPtr(pds);
    end;
  end;
end;

function AnsiEncode(p: PQCharW; l: Integer): QStringA;
var
  ps: PQCharW;
begin
  if l <= 0 then
  begin
    ps := p;
    while ps^ <> #0 do
      Inc(ps);
    l := ps - p;
  end;
  if l > 0 then
  begin
{$IFDEF MSWINDOWS}
    Result.Length := WideCharToMultiByte(CP_ACP, 0, p, l, nil, 0, nil, nil);
    WideCharToMultiByte(CP_ACP, 0, p, l, PAnsiChar(PQCharA(Result)),
      Result.Length, nil, nil);
{$ELSE}
    Result.Length := l shl 1;
    Result.FValue[0] := 0;
    Move(p^, PQCharA(Result)^, l shl 1);
    Result := TEncoding.Convert(TEncoding.Unicode, TEncoding.ANSI,
      Result.FValue, 1, l shl 1);
{$ENDIF}
  end
  else
    Result.Length := 0;
end;

function AnsiEncode(const p: QStringW): QStringA;
var
  l: NativeInt;
begin
  l := Length(p);
  if l > 0 then
    Result := AnsiEncode(PQCharW(p), l)
  else
    Result.Length := 0;
end;

function AnsiDecode(p: PQCharA; l: Integer): QStringW;
var
  ps: PQCharA;
{$IFNDEF MSWINDOWS}
  ABytes: TBytes;
{$ENDIF}
begin
  if l <= 0 then
  begin
    ps := p;
    while ps^ <> 0 do
      Inc(ps);
    l := IntPtr(ps) - IntPtr(p);
  end;
  if l > 0 then
  begin
{$IFDEF MSWINDOWS}
    System.SetLength(Result, MultiByteToWideChar(CP_ACP, 0, PAnsiChar(p),
      l, nil, 0));
    MultiByteToWideChar(CP_ACP, 0, PAnsiChar(p), l, PWideChar(Result),
      Length(Result));
{$ELSE}
    System.SetLength(ABytes, l);
    Move(p^, PByte(@ABytes[0])^, l);
    Result := TEncoding.ANSI.GetString(ABytes);
{$ENDIF}
  end
  else
    System.SetLength(Result, 0);
end;

function AnsiDecode(const p: QStringA): QStringW;
begin
  if p.IsUtf8 then
    Result := Utf8Decode(p)
  else if p.Length > 0 then
  begin
{$IFDEF MSWINDOWS}
    Result := AnsiDecode(PQCharA(p), p.Length);
{$ELSE}
    Result := TEncoding.ANSI.GetString(p.FValue, 1, p.Length);
{$ENDIF}
  end
  else
    SetLength(Result, 0);
end;

function CNSpellChars(S: QStringA; AIgnoreEnChars: Boolean): QStringW;
var
  p: PQCharA;
  pd, pds: PQCharW;
  function SpellOfChar: QCharW;
  var
    I: Integer;
    w: Word;
  begin
    w := p^ shl 8;
    Inc(p);
    w := w or p^;
    Inc(p);
    Result := #0;
    for I := 0 to 22 do
    begin
      if (w >= GBKSpells[I].StartChar) and (w <= GBKSpells[I].EndChar) then
      begin
        Result := GBKSpells[I].SpellChar;
        Break;
      end;
    end;
  end;

begin
  if S.Length > 0 then
  begin
    p := PQCharA(S);
    System.SetLength(Result, S.Length);
    pd := PQCharW(Result);
    pds := pd;
    while p^ <> 0 do
    begin
      if p^ in [1 .. 127] then
      begin
        if not AIgnoreEnChars then
        begin
          pd^ := QCharW(p^);
          Inc(pd);
        end;
        Inc(p);
      end
      else
      begin
        pd^ := SpellOfChar;
        if pd^ <> #0 then
          Inc(pd);
      end;
    end;
    System.SetLength(Result, pd - pds);
  end
  else
    System.SetLength(Result, 0);
end;

function CNSpellChars(S: QStringW; AIgnoreEnChars: Boolean): QStringW;
begin
  Result := CNSpellChars(AnsiEncode(S), AIgnoreEnChars);
end;

function CharSizeA(c: PQCharA): Integer;
begin
  { GB18030,兼容GBK和GB2312
    单字节，其值从0到0x7F。
    双字节，第一个字节的值从0x81到0xFE，第二个字节的值从0x40到0xFE（不包括0x7F）。
    四字节，第一个字节的值从0x81到0xFE，第二个字节的值从0x30到0x39，第三个字节从0x81到0xFE，第四个字节从0x30到0x39。
  }
{$IFDEF MSWINDOWS}
  if GetACP = 936 then
{$ELSE}
  if TEncoding.ANSI.CodePage = 936 then
{$ENDIF}
  begin
    Result := 1;
    if (c^ >= $81) and (c^ <= $FE) then
    begin
      Inc(c);
      if (c^ >= $40) and (c^ <= $FE) and (c^ <> $7F) then
        Result := 2
      else if (c^ >= $30) and (c^ <= $39) then
      begin
        Inc(c);
        if (c^ >= $81) and (c^ <= $FE) then
        begin
          Inc(c);
          if (c^ >= $30) and (c^ <= $39) then
            Result := 4;
        end;
      end;
    end;
  end
  else
{$IFDEF QDAC_ANSISTRINGS}
    Result := AnsiStrings.StrCharLength(PAnsiChar(c));
{$ELSE}
{$IFDEF NEXTGEN}
    if TEncoding.ANSI.CodePage = CP_UTF8 then
      Result := CharSizeU(c)
    else if (c^ < 128) or (TEncoding.ANSI.CodePage = 437) then
      Result := 1
    else
      Result := 2;
{$ELSE}
{$IF RTLVersion>=25}
    Result := AnsiStrings.StrCharLength(PAnsiChar(c));
{$ELSE}
    Result := sysutils.StrCharLength(PAnsiChar(c));
{$IFEND}
{$ENDIF}
{$ENDIF !QDAC_ANSISTRINGS}
end;

function CharSizeU(c: PQCharA): Integer;
begin
  if (c^ and $80) = 0 then
    Result := 1
  else
  begin
    if (c^ and $FC) = $FC then // 4000000+
      Result := 6
    else if (c^ and $F8) = $F8 then // 200000-3FFFFFF
      Result := 5
    else if (c^ and $F0) = $F0 then // 10000-1FFFFF
      Result := 4
    else if (c^ and $E0) = $E0 then // 800-FFFF
      Result := 3
    else if (c^ and $C0) = $C0 then // 80-7FF
      Result := 2
    else
      Result := 1;
  end
end;

function CharSizeW(c: PQCharW): Integer;
begin
  if (c[0] >= #$D800) and (c[0] <= #$DBFF) and (c[1] >= #$DC00) and
    (c[1] <= #$DFFF) then
    Result := 2
  else
    Result := 1;
end;

function CharCodeA(c: PQCharA): Cardinal;
var
  t: QStringA;
begin
  t := AnsiDecode(c, CharSizeA(c));
  Result := CharCodeW(PQCharW(t));
end;

function CharCodeU(c: PQCharA): Cardinal;
begin
  if (c^ and $80) <> 0 then
  begin
    if (c^ and $FC) = $FC then // 4000000+
    begin
      Result := (c^ and $03) shl 30;
      Inc(c);
      Result := Result or ((c^ and $3F) shl 24);
      Inc(c);
      Result := Result or ((c^ and $3F) shl 18);
      Inc(c);
      Result := Result or ((c^ and $3F) shl 12);
      Inc(c);
      Result := Result or ((c^ and $3F) shl 6);
      Inc(c);
      Result := Result or (c^ and $3F);
    end
    else if (c^ and $F8) = $F8 then // 200000-3FFFFFF
    begin
      Result := (c^ and $07) shl 24;
      Inc(c);
      Result := Result or ((c^ and $3F) shl 18);
      Inc(c);
      Result := Result or ((c^ and $3F) shl 12);
      Inc(c);
      Result := Result or ((c^ and $3F) shl 6);
      Inc(c);
      Result := Result or (c^ and $3F);
    end
    else if (c^ and $F0) = $F0 then // 10000-1FFFFF
    begin
      Result := (c^ and $0F) shr 18;
      Inc(c);
      Result := Result or ((c^ and $3F) shl 12);
      Inc(c);
      Result := Result or ((c^ and $3F) shl 6);
      Inc(c);
      Result := Result or (c^ and $3F);
    end
    else if (c^ and $E0) = $E0 then // 800-FFFF
    begin
      Result := (c^ and $1F) shl 12;
      Inc(c);
      Result := Result or ((c^ and $3F) shl 6);
      Inc(c);
      Result := Result or (c^ and $3F);
    end
    else if (c^ and $C0) = $C0 then // 80-7FF
    begin
      Result := (c^ and $3F) shl 6;
      Inc(c);
      Result := Result or (c^ and $3F);
    end
    else
      raise Exception.Create(Format(SBadUtf8Char, [IntPtr(c^)]));
  end
  else
    Result := c^;
end;

function CharCodeW(c: PQCharW): Cardinal;
begin
  if (c^ >= #$D800) and (c^ <= #$DFFF) then // Unicode 扩展区字符
  begin
    Result := (Ord(c^) - $D800);
    Inc(c);
    if (c^ >= #$DC00) and (c^ <= #$DFFF) then
    begin
      Result := $10000 + ((Result shl 10) + (Cardinal(Ord(c^)) - $DC00));
    end
    else
      Result := 0
  end
  else
    Result := Ord(c^);
end;

function CharCountA(const source: QStringA): Integer;
var
  p: PQCharA;
  l, ASize: Integer;
begin
  p := PQCharA(source);
  l := source.Length;
  Result := 0;
  while l > 0 do
  begin
    ASize := CharSizeA(p);
    Dec(l, ASize);
    Inc(p, ASize);
    Inc(Result);
  end;
  // Result:=TEncoding.ANSI.GetCharCount(source);
end;

function CharCountW(const S: QStringW): Integer;
var
  p, pe: PWord;
  ALen: Integer;
  procedure CountChar;
  begin
    if (p^ > $D800) and (p^ < $DFFF) then
    begin
      Inc(p);
      if (p^ >= $DC00) and (p^ < $DFFF) then
      begin
        Inc(p);
        Inc(Result);
      end
      else
        Result := -1;
    end
    else
    begin
      Inc(Result);
      Inc(p);
    end;
  end;

begin
  Result := 0;
  p := PWord(S);
  ALen := Length(S);
  pe := PWord(IntPtr(p) + (ALen shl 1));
  while IntPtr(p) < IntPtr(pe) do
    CountChar;
end;

function CharCountU(const source: QStringA): Integer;
var
  p, pe: PQCharA;
  procedure CountChar;
  begin
    if (p^ and $80) = 0 then
    begin
      Inc(Result);
      Inc(p);
    end
    else if (p^ and $FC) = $FC then
    begin
      Inc(Result);
      Inc(p, 6);
    end
    else if (p^ and $F8) = $F8 then
    begin
      Inc(Result);
      Inc(p, 5);
    end
    else if (p^ and $F0) = $F0 then
    begin
      Inc(Result);
      Inc(p, 4);
    end
    else if (p^ and $E0) = $E0 then
    begin
      Inc(Result);
      Inc(p, 3);
    end
    else if (p^ and $C0) = $C0 then
    begin
      Inc(Result);
      Inc(p, 2);
    end
    else
      Result := -1;
  end;

begin
  Result := 0;
  p := PQCharA(source);
  pe := PQCharA(IntPtr(p) + source.Length);
  while (IntPtr(p) < IntPtr(pe)) and (Result >= 0) do
    CountChar;
end;

procedure CalcCharLengthA(var Lens: TIntArray; const List: array of QCharA);
var
  I, l: Integer;
begin
  I := Low(List);
  System.SetLength(Lens, Length(List));
  while I <= High(List) do
  begin
    l := CharSizeA(@List[I]);
    Lens[I] := l;
    Inc(I, l);
  end;
end;

function CharInA(const c: PQCharA; const List: array of QCharA;
  ACharLen: PInteger): Boolean;
var
  I, count: Integer;
  Lens: TIntArray;
begin
  count := High(List) + 1;
  Result := False;
  CalcCharLengthA(Lens, List);
  I := Low(List);
  while I < count do
  begin
    if CompareMem(c, @List[I], Lens[I]) then
    begin
      if ACharLen <> nil then
        ACharLen^ := Lens[I];
      Result := True;
      Break;
    end
    else
      Inc(I, Lens[I]);
  end;
end;

procedure CalcCharLengthW(var Lens: TIntArray; const List: array of QCharW);
var
  I, l: Integer;
begin
  I := Low(List);
  System.SetLength(Lens, Length(List));
  while I <= High(List) do
  begin
    l := CharSizeW(@List[I]);
    Lens[I] := l;
    Inc(I, l);
  end;
end;

function CharInW(const c: PQCharW; const List: array of QCharW;
  ACharLen: PInteger): Boolean;
var
  I, count: Integer;
  Lens: TIntArray;
begin
  count := High(List) + 1;
  Result := False;
  CalcCharLengthW(Lens, List);
  I := Low(List);
  while I < count do
  begin
    if c^ = List[I] then
    begin
      if Lens[I] = 2 then
      begin
        Result := c[1] = List[I + 1];
        if Assigned(ACharLen) and Result then
          ACharLen^ := 2;
        if Result then
          Break;
      end
      else
      begin
        Result := True;
        if Assigned(ACharLen) then
          ACharLen^ := 1;
        Break;
      end;
    end;
    Inc(I, Lens[I]);
  end;
end;

function CharInW(const c, List: PQCharW; ACharLen: PInteger): Boolean;
var
  p: PQCharW;
begin
  Result := False;
  p := List;
  while p^ <> #0 do
  begin
    if p^ = c^ then
    begin
      if (p[0] >= #$D800) and (p[0] <= #$DBFF) then
      begin
        // (p[1] >= #$DC00) and (p[1] <= #$DFFF)
        if p[1] = c[1] then
        begin
          Result := True;
          if ACharLen <> nil then
            ACharLen^ := 2;
          Break;
        end;
      end
      else
      begin
        Result := True;
        if ACharLen <> nil then
          ACharLen^ := 1;
        Break;
      end;
    end;
    Inc(p);
  end;
end;

procedure CalcCharLengthU(var Lens: TIntArray; const List: array of QCharA);
var
  I, l: Integer;
begin
  I := Low(List);
  System.SetLength(Lens, Length(List));
  while I <= High(List) do
  begin
    l := CharSizeU(@List[I]);
    Lens[I] := l;
    Inc(I, l);
  end;
end;

function CharInU(const c: PQCharA; const List: array of QCharA;
  ACharLen: PInteger): Boolean;
var
  I, count: Integer;
  Lens: TIntArray;
begin
  count := High(List) + 1;
  Result := False;
  CalcCharLengthU(Lens, List);
  I := Low(List);
  while I < count do
  begin
    if CompareMem(c, @List[I], Lens[I]) then
    begin
      if ACharLen <> nil then
        ACharLen^ := Lens[I];
      Result := True;
      Break;
    end
    else
      Inc(I, Lens[I]);
  end;
end;

function IsSpaceA(const c: PQCharA; ASpaceSize: PInteger): Boolean;
begin
  if c^ in [9, 10, 13, 32] then
  begin
    Result := True;
    if Assigned(ASpaceSize) then
      ASpaceSize^ := 1;
  end
  else if (c^ = 161) and (PQCharA(IntPtr(c) + 1)^ = 161) then
  begin
    Result := True;
    if Assigned(ASpaceSize) then
      ASpaceSize^ := 2;
  end
  else
    Result := False;
end;

function IsSpaceW(const c: PQCharW; ASpaceSize: PInteger): Boolean;
begin
  Result := (c^ = #9) or (c^ = #10) or (c^ = #13) or (c^ = #32) or
    (c^ = #$3000);
  if Result and Assigned(ASpaceSize) then
    ASpaceSize^ := 1;
end;

function IsSpaceU(const c: PQCharA; ASpaceSize: PInteger): Boolean;
begin
  // 全角空格$3000的UTF-8编码是227,128,128
  if c^ in [9, 10, 13, 32] then
  begin
    Result := True;
    if Assigned(ASpaceSize) then
      ASpaceSize^ := 1;
  end
  else if (c^ = 227) and (PQCharA(IntPtr(c) + 1)^ = 128) and
    (PQCharA(IntPtr(c) + 2)^ = 128) then
  begin
    Result := True;
    if Assigned(ASpaceSize) then
      ASpaceSize^ := 3;
  end
  else
    Result := False;
end;

function CNFullToHalf(const S: QStringW): QStringW;
var
  p, pd: PWord;
  l: Integer;
begin
  l := Length(S);
  if l > 0 then
  begin
    System.SetLength(Result, l);
    p := PWord(PQCharW(S));
    pd := PWord(PQCharW(Result));
    while l > 0 do
    begin
      if (p^ = $3000) then // 全角空格'　'
        pd^ := $20
      else if (p^ >= $FF01) and (p^ <= $FF5E) then
        pd^ := $21 + (p^ - $FF01)
      else
        pd^ := p^;
      Dec(l);
      Inc(p);
      Inc(pd);
    end;
  end
  else
    System.SetLength(Result, 0);
end;

function CNHalfToFull(const S: QStringW): QStringW;
var
  p, pd: PWord;
  l: Integer;
begin
  l := Length(S);
  if l > 0 then
  begin
    System.SetLength(Result, l);
    p := PWord(PQCharW(S));
    pd := PWord(PQCharW(Result));
    while l > 0 do
    begin
      if p^ = $20 then // 全角空格'　'
        pd^ := $3000
      else if (p^ >= $21) and (p^ <= $7E) then
        pd^ := $FF01 + (p^ - $21)
      else
        pd^ := p^;
      Dec(l);
      Inc(p);
      Inc(pd);
    end;
  end
  else
    System.SetLength(Result, 0);
end;

function QuotedStrA(const S: QStringA; const AQuoter: QCharA): QStringA;
var
  p, pe, pd, pds: PQCharA;
begin
  p := PQCharA(S);
  Result.Length := S.Length shl 1;
  pe := p;
  Inc(pe, S.Length);
  pd := PQCharA(Result);
  pds := pd;
  pd^ := AQuoter;
  Inc(pd);
  while IntPtr(p) < IntPtr(pe) do
  begin
    if p^ = AQuoter then
    begin
      pd^ := AQuoter;
      Inc(pd);
      pd^ := AQuoter;
    end
    else
      pd^ := p^;
    Inc(pd);
    Inc(p);
  end;
  pd^ := AQuoter;
  Result.Length := IntPtr(pd) - IntPtr(pds) + 1;
end;

function QuotedStrW(const S: QStringW; const AQuoter: QCharW): QStringW;
var
  p, pe, pd, pds: PQCharW;
  l: Integer;
begin
  if AQuoter <> #0 then
  begin
    l := System.Length(S);
    p := PQCharW(S);
    SetLength(Result, (l + 1) shl 1);
    pe := p;
    Inc(pe, l);
    pd := PQCharW(Result);
    pds := pd;
    pd^ := AQuoter;
    Inc(pd);
    while IntPtr(p) < IntPtr(pe) do
    begin
      if p^ = AQuoter then
      begin
        pd^ := AQuoter;
        Inc(pd);
        pd^ := AQuoter;
      end
      else
        pd^ := p^;
      Inc(pd);
      Inc(p);
    end;
    pd^ := AQuoter;
    SetLength(Result, ((IntPtr(pd) - IntPtr(pds)) shr 1) + 1);
  end
  else
    Result := S;
end;

function SQLQuoted(const S: QStringW): QStringW;
begin
  Result := QuotedStrW(S);
end;

function DequotedStrA(const S: QStringA; const AQuoter: QCharA): QStringA;
var
  p, pe, pd, pds: PQCharA;
begin
  if (S.Length > 0) and (S[0] = AQuoter) and (S[S.Length - 1] = AQuoter) then
  begin
    p := PQCharA(S);
    pe := p;
    Inc(pe, S.Length);
    Inc(p);
    Result.Length := S.Length;
    pd := PQCharA(Result);
    pds := pd;
    while IntPtr(p) < IntPtr(pe) do
    begin
      if p^ = AQuoter then
      begin
        Inc(p);
        if p^ = AQuoter then
        begin
          pd^ := AQuoter;
        end
        else if IntPtr(p) < IntPtr(pe) then // 后面不是单引号,错误的字符串，直接拷贝内容
        begin
          pd^ := AQuoter;
          Inc(pd);
          pd^ := p^;
        end
        else
          Break;
      end
      else
        pd^ := p^;
      Inc(p);
      Inc(pd);
    end;
    Result.Length := IntPtr(pd) - IntPtr(pds);
  end
  else
    Result := S;
end;

function DequotedStrW(const S: QStringW; const AQuoter: QCharW): QStringW;
var
  p, pe, pd, pds: PQCharW;
begin
  if (Length(S) > 0) and (PQCharW(S)[0] = AQuoter) and
    (PQCharW(S)[Length(S) - 1] = AQuoter) then
  begin
    p := PQCharW(S);
    pe := p;
    Inc(pe, Length(S));
    Inc(p);
    SetLength(Result, Length(S));
    pd := PQCharW(Result);
    pds := pd;
    while IntPtr(p) < IntPtr(pe) do
    begin
      if p^ = AQuoter then
      begin
        Inc(p);
        if p^ = AQuoter then
        begin
          pd^ := AQuoter;
        end
        else if IntPtr(p) < IntPtr(pe) then // 后面不是单引号,错误的字符串，直接拷贝内容
        begin
          pd^ := AQuoter;
          Inc(pd);
          pd^ := p^;
        end
        else
          Break;
      end
      else
        pd^ := p^;
      Inc(p);
      Inc(pd);
    end;
    SetLength(Result, (IntPtr(pd) - IntPtr(pds)) shr 1);
  end
  else
    Result := S;
end;

function SkipCharA(var p: PQCharA; const List: array of QCharA): Integer;
var
  I, count: Integer;
  Lens: TIntArray;
  AFound: Boolean;
  ps: PQCharA;
begin
  count := High(List) + 1;
  Result := 0;
  if count > 0 then
  begin
    CalcCharLengthA(Lens, List);
    ps := p;
    while p^ <> 0 do
    begin
      I := Low(List);
      AFound := False;
      while I < count do
      begin
        if CompareMem(p, @List[I], Lens[I]) then
        begin
          AFound := True;
          Inc(p, Lens[I]);
          Break;
        end
        else
          Inc(I, Lens[I]);
      end;
      if not AFound then
      begin
        Result := IntPtr(p) - IntPtr(ps);
        Break;
      end;
    end;
  end;
end;

function SkipCharU(var p: PQCharA; const List: array of QCharA): Integer;
var
  I, count: Integer;
  Lens: TIntArray;
  AFound: Boolean;
  ps: PQCharA;
begin
  count := High(List) + 1;
  Result := 0;
  if count > 0 then
  begin
    CalcCharLengthU(Lens, List);
    ps := p;
    while p^ <> 0 do
    begin
      I := Low(List);
      AFound := False;
      while I < count do
      begin
        if CompareMem(p, @List[I], Lens[I]) then
        begin
          AFound := True;
          Inc(p, Lens[I]);
          Break;
        end
        else
          Inc(I, Lens[I]);
      end;
      if not AFound then
      begin
        Result := IntPtr(p) - IntPtr(ps);
        Break;
      end;
    end;
  end;
end;

function SkipCharW(var p: PQCharW; const List: array of QCharA): Integer;
var
  I, count: Integer;
  Lens: TIntArray;
  AFound: Boolean;
  ps: PQCharW;
begin
  count := High(List) + 1;
  Result := 0;
  if count > 0 then
  begin
    CalcCharLengthA(Lens, List);
    ps := p;
    while p^ <> #0 do
    begin
      I := Low(List);
      AFound := False;
      while I < count do
      begin
        if CompareMem(p, @List[I], Lens[I] shl 1) then
        begin
          AFound := True;
          Break;
        end
        else
          Inc(I, Lens[I]);
      end;
      if AFound then
        Inc(p)
      else
      begin
        Result := IntPtr(p) - IntPtr(ps);
        Break;
      end;
    end;
  end;
end;

function SkipCharW(var p: PQCharW; const List: PQCharW): Integer;
var
  l: Integer;
  ps: PQCharW;
begin
  Result := 0;
  if (List <> nil) and (List^ <> #0) then
  begin
    ps := p;
    while p^ <> #0 do
    begin
      if CharInW(p, List, @l) then
        Inc(p, l)
      else
      begin
        Result := IntPtr(p) - IntPtr(ps);
        Break;
      end;
    end;
  end;
end;

function SkipSpaceA(var p: PQCharA): Integer;
var
  ps: PQCharA;
  l: Integer;
begin
  ps := p;
  while p^ <> 0 do
  begin
    if IsSpaceA(p, @l) then
      Inc(p, l)
    else
      Break;
  end;
  Result := IntPtr(p) - IntPtr(ps);
end;

function SkipSpaceU(var p: PQCharA): Integer;
var
  ps: PQCharA;
  l: Integer;
begin
  ps := p;
  while p^ <> 0 do
  begin
    if IsSpaceU(p, @l) then
      Inc(p, l)
    else
      Break;
  end;
  Result := IntPtr(p) - IntPtr(ps);
end;

function SkipSpaceW(var p: PQCharW): Integer;
var
  ps: PQCharW;
  l: Integer;
begin
  ps := p;
  while p^ <> #0 do
  begin
    if IsSpaceW(p, @l) then
      Inc(p, l)
    else
      Break;
  end;
  Result := IntPtr(p) - IntPtr(ps);
end;

// 跳过一行,以#10为行结尾
function SkipLineA(var p: PQCharA): Integer;
var
  ps: PQCharA;
begin
  ps := p;
  while p^ <> 0 do
  begin
    if p^ = 10 then
    begin
      Inc(p);
      Break;
    end
    else
      Inc(p);
  end;
  Result := IntPtr(p) - IntPtr(ps);
end;

function SkipLineU(var p: PQCharA): Integer;
begin
  Result := SkipLineA(p);
end;

function SkipLineW(var p: PQCharW): Integer;
var
  ps: PQCharW;
begin
  ps := p;
  while p^ <> #0 do
  begin
    if p^ = #10 then
    begin
      Inc(p);
      Break;
    end
    else
      Inc(p);
  end;
  Result := IntPtr(p) - IntPtr(ps);
end;

function StrPosA(Start, Current: PQCharA; var ACol, ARow: Integer): PQCharA;
begin
  ACol := 1;
  ARow := 1;
  Result := Start;
  while IntPtr(Start) < IntPtr(Current) do
  begin
    if Start^ = 10 then
    begin
      Inc(ARow);
      ACol := 1;
      Inc(Start);
      Result := Start;
    end
    else
    begin
      Inc(Start, CharSizeA(Start));
      Inc(ACol);
    end;
  end;
end;

function StrPosU(Start, Current: PQCharA; var ACol, ARow: Integer): PQCharA;
begin
  ACol := 1;
  ARow := 1;
  Result := Start;
  while IntPtr(Start) < IntPtr(Current) do
  begin
    if Start^ = 10 then
    begin
      Inc(ARow);
      ACol := 1;
      Inc(Start);
      Result := Start;
    end
    else
    begin
      Inc(Start, CharSizeU(Start));
      Inc(ACol);
    end;
  end;
end;

function StrPosW(Start, Current: PQCharW; var ACol, ARow: Integer): PQCharW;
begin
  ACol := 1;
  ARow := 1;
  Result := Start;
  while Start < Current do
  begin
    if Start^ = #10 then
    begin
      Inc(ARow);
      ACol := 1;
      Inc(Start);
      Result := Start;
    end
    else
    begin
      Inc(Start, CharSizeW(Start));
      Inc(ACol);
    end;
  end;
end;

function DecodeTokenA(var p: PQCharA; ADelimiters: array of QCharA;
  AQuoter: QCharA; AIgnoreSpace: Boolean): QStringA;
var
  S: PQCharA;
  l: Integer;
begin
  if AIgnoreSpace then
    SkipSpaceA(p);
  S := p;
  while p^ <> 0 do
  begin
    if p^ = AQuoter then // 引用的内容不拆分
    begin
      Inc(p);
      while p^ <> 0 do
      begin
        if p^ = $5C then
        begin
          Inc(p);
          if p^ <> 0 then
            Inc(p);
        end
        else if p^ = AQuoter then
        begin
          Inc(p);
          if p^ = AQuoter then
            Inc(p)
          else
            Break;
        end
        else
          Inc(p);
      end;
    end
    else if CharInA(p, ADelimiters, @l) then
      Break
    else // \",\',"",''分别解析转义
      Inc(p);
  end;
  l := IntPtr(p) - IntPtr(S);
  Result.Length := l;
  Move(S^, PQCharA(Result)^, l);
  while CharInA(p, ADelimiters, @l) do
    Inc(p, l);
end;

function DecodeTokenU(var p: PQCharA; ADelimiters: array of QCharA;
  AQuoter: QCharA; AIgnoreSpace: Boolean): QStringA;
var
  S: PQCharA;
  l: Integer;
begin
  if AIgnoreSpace then
    SkipSpaceU(p);
  S := p;
  while p^ <> 0 do
  begin
    if p^ = AQuoter then // 引用的内容不拆分
    begin
      Inc(p);
      while p^ <> 0 do
      begin
        if p^ = $5C then
        begin
          Inc(p);
          if p^ <> 0 then
            Inc(p);
        end
        else if p^ = AQuoter then
        begin
          Inc(p);
          if p^ = AQuoter then
            Inc(p)
          else
            Break;
        end
        else
          Inc(p);
      end;
    end
    else if CharInU(p, ADelimiters, @l) then
      Break
    else // \",\',"",''分别解析转义
      Inc(p);
  end;
  l := IntPtr(p) - IntPtr(S);
  Result.Length := l;
  Move(S^, PQCharA(Result)^, l);
  while CharInU(p, ADelimiters, @l) do
    Inc(p, l);
end;

function DecodeTokenW(var p: PQCharW; ADelimiters: array of QCharW;
  AQuoter: QCharW; AIgnoreSpace: Boolean; ASkipDelimiters: Boolean): QStringW;
var
  S: PQCharW;
  l: Integer;
begin
  if AIgnoreSpace then
    SkipSpaceW(p);
  S := p;
  while p^ <> #0 do
  begin
    if p^ = AQuoter then // 引用的内容不拆分
    begin
      Inc(p);
      while p^ <> #0 do
      begin
        if p^ = #$5C then
        begin
          Inc(p);
          if p^ <> #0 then
            Inc(p);
        end
        else if p^ = AQuoter then
        begin
          Inc(p);
          if p^ = AQuoter then
            Inc(p)
          else
            Break;
        end
        else
          Inc(p);
      end;
    end
    else if CharInW(p, ADelimiters, @l) then
      Break
    else // \",\',"",''分别解析转义
      Inc(p);
  end;
  l := p - S;
  SetLength(Result, l);
  Move(S^, PQCharW(Result)^, l shl 1);
  if ASkipDelimiters then
  begin
    while CharInW(p, ADelimiters, @l) do
      Inc(p, l);
  end;
  if AIgnoreSpace then
    SkipSpaceW(p);
end;

function DecodeTokenW(var p: PQCharW; ADelimiters: PQCharW; AQuoter: QCharW;
  AIgnoreSpace: Boolean; ASkipDelimiters: Boolean): QStringW;
var
  S: PQCharW;
  l: Integer;
begin
  if AIgnoreSpace then
    SkipSpaceW(p);
  S := p;
  while p^ <> #0 do
  begin
    if p^ = AQuoter then // 引用的内容不拆分
    begin
      Inc(p);
      while p^ <> #0 do
      begin
        if p^ = #$5C then
        begin
          Inc(p);
          if p^ <> #0 then
            Inc(p);
        end
        else if p^ = AQuoter then
        begin
          Inc(p);
          if p^ = AQuoter then
            Inc(p)
          else
            Break;
        end
        else
          Inc(p);
      end;
    end
    else if CharInW(p, ADelimiters, @l) then
      Break
    else // \",\',"",''分别解析转义
      Inc(p);
  end;
  l := p - S;
  SetLength(Result, l);
  Move(S^, PQCharW(Result)^, l shl 1);
  if ASkipDelimiters then
  begin
    while CharInW(p, ADelimiters, @l) do
      Inc(p, l);
  end;
  if AIgnoreSpace then
    SkipSpaceW(p);
end;

function DecodeTokenW(var S: QStringW; ADelimiters: PQCharW; AQuoter: QCharW;
  AIgnoreCase, ARemove, ASkipDelimiters: Boolean): QStringW;
var
  p: PQCharW;
begin
  p := PQCharW(S);
  Result := DecodeTokenW(p, ADelimiters, AQuoter, AIgnoreCase);
  if ARemove then
    S := StrDupX(p, Length(S) - (p - PQCharW(S)));
end;

function SplitTokenW(AList: TStrings; p: PQCharW; ADelimiters: PQCharW;
  AQuoter: QCharW; AIgnoreSpace: Boolean): Integer;
begin
  Result := 0;
  AList.BeginUpdate;
  try
    while p^ <> #0 do
    begin
      AList.Add(DecodeTokenW(p, ADelimiters, AQuoter, AIgnoreSpace, True));
      Inc(Result);
    end;
  finally
    AList.EndUpdate;
  end;
end;

function SplitTokenW(AList: TStrings; const S: QStringW; ADelimiters: PQCharW;
  AQuoter: QCharW; AIgnoreSpace: Boolean): Integer;
begin
  Result := SplitTokenW(AList, PQCharW(S), ADelimiters, AQuoter, AIgnoreSpace);
end;

function UpperFirstW(const S: QStringW): QStringW;
var
  p, pd: PQCharW;
begin
  if Length(S) > 0 then
  begin
    p := PQCharW(S);
    SetLength(Result, Length(S));
    pd := PQCharW(Result);
    pd^ := CharUpperW(p^);
    Inc(p);
    Inc(pd);
    while p^ <> #0 do
    begin
      pd^ := CharLowerW(p^);
      Inc(p);
      Inc(pd);
    end;
  end
  else
    Result := S;
end;

function DecodeLineA(var p: PQCharA; ASkipEmpty: Boolean): QStringA;
var
  ps: PQCharA;
begin
  ps := p;
  while p^ <> 0 do
  begin
    if ((p^ = 13) and (PQCharA(IntPtr(p) + 1)^ = 10)) or (p^ = 10) then
    begin
      if ps = p then
      begin
        if ASkipEmpty then
        begin
          if p^ = 13 then
            Inc(p, 2)
          else
            Inc(p);
          ps := p;
        end
        else
        begin
          Result.Length := 0;
          Exit;
        end;
      end
      else
      begin
        Result.Length := IntPtr(p) - IntPtr(ps);
        Move(ps^, PQCharA(Result)^, IntPtr(p) - IntPtr(ps));
        if p^ = 13 then
          Inc(p, 2)
        else
          Inc(p);
        Exit;
      end;
    end
    else
      Inc(p);
  end;
  if ps = p then
    Result.Length := 0
  else
  begin
    Result.Length := IntPtr(p) - IntPtr(ps);
    Move(ps^, PQCharA(Result)^, IntPtr(p) - IntPtr(ps));
  end;
end;

function DecodeLineU(var p: PQCharA; ASkipEmpty: Boolean): QStringA;
begin
  Result := DecodeLineA(p, ASkipEmpty);
  if Result.Length > 0 then
    Result.FValue[0] := 1;
end;

function DecodeLineW(var p: PQCharW; ASkipEmpty: Boolean): QStringW;
var
  ps: PQCharW;
begin
  ps := p;
  while p^ <> #0 do
  begin
    if ((p[0] = #13) and (p[1] = #10)) or (p[0] = #10) then
    begin
      if ps = p then
      begin
        if ASkipEmpty then
        begin
          if p^ = #13 then
            Inc(p, 2)
          else
            Inc(p);
          ps := p;
        end
        else
        begin
          SetLength(Result, 0);
          Exit;
        end;
      end
      else
      begin
        SetLength(Result, p - ps);
        Move(ps^, PQCharW(Result)^, IntPtr(p) - IntPtr(ps));
        if p^ = #13 then
          Inc(p, 2)
        else
          Inc(p);
        Exit;
      end;
    end
    else
      Inc(p);
  end;
  if ps = p then
    SetLength(Result, 0)
  else
  begin
    SetLength(Result, p - ps);
    Move(ps^, PQCharW(Result)^, IntPtr(p) - IntPtr(ps));
  end;
end;

function LeftStrW(const S: QStringW; AMaxCount: Integer; ACheckExt: Boolean)
  : QStringW;
var
  ps, p: PQCharW;
  l: Integer;
begin
  l := Length(S);
  if AMaxCount > l then
    Result := S
  else if AMaxCount > 0 then
  begin
    ps := PQCharW(S);
    if ACheckExt then
    begin
      p := ps;
      while (p^ <> #0) and (AMaxCount > 0) do
      begin
        if (p^ >= #$D800) and (p^ <= #$DBFF) then
        begin
          Inc(p);
          if (p^ >= #$DC00) and (p^ <= #$DFFF) then
            Inc(p);
          // else 无效的扩展区字符，仍然循环保留
        end
        else
          Inc(p);
        Dec(AMaxCount);
      end;
      l := p - ps;
      SetLength(Result, l);
      Move(ps^, PQCharW(Result)^, l shl 1);
    end
    else
    begin
      SetLength(Result, AMaxCount);
      Move(ps^, PQCharW(Result)^, AMaxCount shl 1);
    end;
  end
  else
    SetLength(Result, 0);
end;

function RightStrW(const S: QStringW; AMaxCount: Integer; ACheckExt: Boolean)
  : QStringW;
var
  ps, p: PQCharW;
  l: Integer;
begin
  l := Length(S);
  if AMaxCount > l then
    Result := S
  else if AMaxCount > 0 then
  begin
    ps := PQCharW(S);
    if ACheckExt then
    begin
      p := ps + l - 1;
      while (p > ps) and (AMaxCount > 0) do
      begin
        if (p^ >= #$DC00) and (p^ <= #$DFFF) then
        begin
          Dec(p);
          if (p^ >= #$D800) and (p^ <= #$DBFF) then
            Dec(p)
            // else 无效的扩展区字符，仍然循环保留
        end
        else
          Dec(p);
        Dec(AMaxCount);
      end;
      Inc(p);
      l := l - (p - ps);
      SetLength(Result, l);
      Move(p^, PQCharW(Result)^, l shl 1);
    end
    else
    begin
      Inc(ps, l - AMaxCount);
      SetLength(Result, AMaxCount);
      Move(ps^, PQCharW(Result)^, AMaxCount shl 1);
    end;
  end
  else
    SetLength(Result, 0);
end;

function StrBetween(var S: PQCharW; AStartTag, AEndTag: QStringW;
  AIgnoreCase: Boolean): QStringW;
var
  ps, pe: PQCharW;
  l: Integer;
begin
  if AIgnoreCase then
  begin
    ps := StrIStrW(S, PQCharW(AStartTag));
    if ps <> nil then
    begin
      Inc(ps, Length(AStartTag));
      pe := StrIStrW(ps, PQCharW(AEndTag));
      if pe <> nil then
      begin
        l := pe - ps;
        SetLength(Result, l);
        Move(ps^, PQCharW(Result)^, l shl 1);
        Inc(pe, Length(AEndTag));
        S := pe;
      end
      else
        SetLength(Result, 0);
    end
    else
      SetLength(Result, 0);
  end
  else
  begin
    ps := StrStrW(S, PQCharW(AStartTag));
    if ps <> nil then
    begin
      Inc(ps, Length(AStartTag));
      pe := StrStrW(ps, PQCharW(AEndTag));
      if pe <> nil then
      begin
        l := pe - ps;
        SetLength(Result, l);
        Move(ps, PQCharW(Result)^, l shl 1);
        Inc(pe, Length(AEndTag));
        S := pe;
      end
      else
        SetLength(Result, 0);
    end
    else
      SetLength(Result, 0);
  end;
end;

function TokenWithIndex(var S: PQCharW; AIndex: Integer; ADelimiters: PQCharW;
  AQuoter: QCharW; AIgnoreSapce: Boolean): QStringW;
begin
  while (AIndex >= 0) and (S^ <> #0) do
  begin
    if AIndex <> 0 then
      DecodeTokenW(S, ADelimiters, AQuoter, AIgnoreSapce)
    else
    begin
      Result := DecodeTokenW(S, ADelimiters, AQuoter, AIgnoreSapce);
      Break;
    end;
    Dec(AIndex);
  end;
end;

function SkipUntilA(var p: PQCharA; AExpects: array of QCharA;
  AQuoter: QCharA): Integer;
var
  ps: PQCharA;
begin
  ps := p;
  while p^ <> 0 do
  begin
    if (p^ = AQuoter) then
    begin
      Inc(p);
      while p^ <> 0 do
      begin
        if p^ = $5C then
        begin
          Inc(p);
          if p^ <> 0 then
            Inc(p);
        end
        else if p^ = AQuoter then
        begin
          Inc(p);
          if p^ = AQuoter then
            Inc(p)
          else
            Break;
        end
        else
          Inc(p);
      end;
    end
    else if CharInA(p, AExpects) then
      Break
    else
      Inc(p, CharSizeA(p));
  end;
  Result := IntPtr(p) - IntPtr(ps);
end;

function SkipUntilU(var p: PQCharA; AExpects: array of QCharA;
  AQuoter: QCharA): Integer;
var
  ps: PQCharA;
begin
  ps := p;
  while p^ <> 0 do
  begin
    if (p^ = AQuoter) then
    begin
      Inc(p);
      while p^ <> 0 do
      begin
        if p^ = $5C then
        begin
          Inc(p);
          if p^ <> 0 then
            Inc(p);
        end
        else if p^ = AQuoter then
        begin
          Inc(p);
          if p^ = AQuoter then
            Inc(p)
          else
            Break;
        end
        else
          Inc(p);
      end;
    end
    else if CharInU(p, AExpects) then
      Break
    else
      Inc(p, CharSizeU(p));
  end;
  Result := IntPtr(p) - IntPtr(ps);
end;

function SkipUntilW(var p: PQCharW; AExpects: array of QCharW;
  AQuoter: QCharW): Integer;
var
  ps: PQCharW;
begin
  ps := p;
  while p^ <> #0 do
  begin
    if (p^ = AQuoter) then
    begin
      Inc(p);
      while p^ <> #0 do
      begin
        if p^ = #$5C then
        begin
          Inc(p);
          if p^ <> #0 then
            Inc(p);
        end
        else if p^ = AQuoter then
        begin
          Inc(p);
          if p^ = AQuoter then
            Inc(p)
          else
            Break;
        end
        else
          Inc(p);
      end;
    end
    else if CharInW(p, AExpects) then
      Break
    else
      Inc(p, CharSizeW(p));
  end;
  Result := IntPtr(p) - IntPtr(ps);
end;

function SkipUntilW(var p: PQCharW; AExpects: PQCharW; AQuoter: QCharW)
  : Integer;
var
  ps: PQCharW;
begin
  ps := p;
  while p^ <> #0 do
  begin
    if (p^ = AQuoter) then
    begin
      Inc(p);
      while p^ <> #0 do
      begin
        if p^ = #$5C then
        begin
          Inc(p);
          if p^ <> #0 then
            Inc(p);
        end
        else if p^ = AQuoter then
        begin
          Inc(p);
          if p^ = AQuoter then
            Inc(p)
          else
            Break;
        end
        else
          Inc(p);
      end;
    end
    else if CharInW(p, AExpects) then
      Break
    else
      Inc(p, CharSizeW(p));
  end;
  Result := (IntPtr(p) - IntPtr(ps)) shr 1;
end;

function CharUpperA(c: QCharA): QCharA;
begin
  if (c >= $61) and (c <= $7A) then
    Result := c xor $20
  else
    Result := c;
end;

function CharUpperW(c: QCharW): QCharW;
begin
  if (c >= #$61) and (c <= #$7A) then
    Result := QCharW(PWord(@c)^ xor $20)
  else
    Result := c;
end;

function CharLowerA(c: QCharA): QCharA;
begin
  if (c >= Ord('A')) and (c <= Ord('Z')) then
    Result := Ord('a') + Ord(c) - Ord('A')
  else
    Result := c;
end;

function CharLowerW(c: QCharW): QCharW;
begin
  if (c >= 'A') and (c <= 'Z') then
    Result := QCharW(Ord('a') + Ord(c) - Ord('A'))
  else
    Result := c;
end;

function StartWithA(S, startby: PQCharA; AIgnoreCase: Boolean): Boolean;
begin
  while (S^ <> 0) and (startby^ <> 0) do
  begin
    if AIgnoreCase then
    begin
      if CharUpperA(S^) <> CharUpperA(startby^) then
        Break;
    end
    else if S^ <> startby^ then
      Break;
    Inc(S);
    Inc(startby);
  end;
  Result := (startby^ = 0);
end;

function StartWithU(S, startby: PQCharA; AIgnoreCase: Boolean): Boolean;
begin
  Result := StartWithA(S, startby, AIgnoreCase);
end;

function StartWithW(S, startby: PQCharW; AIgnoreCase: Boolean): Boolean;
begin
  if AIgnoreCase then
  begin
    while (S^ <> #0) and (startby^ <> #0) do
    begin
      if CharUpperW(S^) <> CharUpperW(startby^) then
        Break;
      Inc(S);
      Inc(startby);
    end;
  end
  else
  begin
    while (S^ <> #0) and (S^ = startby^) do
    begin
      Inc(S);
      Inc(startby);
    end;
  end;
  Result := (startby^ = #0);
end;

function EndWithA(const S, endby: QStringA; AIgnoreCase: Boolean): Boolean;
var
  p: PQCharA;
begin
  if S.Length < endby.Length then
    Result := False
  else
  begin
    p := PQCharA(S);
    Inc(p, S.Length - endby.Length);
    if AIgnoreCase then
      Result := (StrIStrA(p, PQCharA(endby)) = p)
    else
      Result := (StrStrA(p, PQCharA(endby)) = p);
  end;
end;

function EndWithU(const S, endby: QStringA; AIgnoreCase: Boolean): Boolean;
begin
  Result := EndWithA(S, endby, AIgnoreCase);
end;

function EndWithW(const S, endby: QStringW; AIgnoreCase: Boolean): Boolean;
var
  p: PQCharW;
begin
  if System.Length(S) < System.Length(endby) then
    Result := False
  else
  begin
    p := PQCharW(S);
    Inc(p, System.Length(S) - System.Length(endby));
    if AIgnoreCase then
      Result := (StrIStrW(p, PQCharW(endby)) = p)
    else
      Result := (StrStrW(p, PQCharW(endby)) = p);
  end;
end;

function SameCharsA(s1, s2: PQCharA; AIgnoreCase: Boolean): Integer;
begin
  Result := 0;
  if (s1 <> nil) and (s2 <> nil) then
  begin
    if AIgnoreCase then
    begin
      while (s1^ <> 0) and (s2^ <> 0) and
        ((s1^ = s2^) or (CharUpperA(s1^) = CharUpperA(s2^))) do
        Inc(Result);
    end
    else
    begin
      while (s1^ <> 0) and (s2^ <> 0) and (s1^ = s2^) do
        Inc(Result);
    end;
  end;
end;

function SameCharsU(s1, s2: PQCharA; AIgnoreCase: Boolean): Integer;
  function CompareSubSeq: Boolean;
  var
    ACharSize1, ACharSize2: Integer;
  begin
    ACharSize1 := CharSizeU(s1) - 1;
    ACharSize2 := CharSizeU(s2) - 1;
    Result := ACharSize1 = ACharSize2;
    if Result then
    begin
      Inc(s1);
      Inc(s2);
      while (ACharSize1 > 0) and (s1^ = s2^) do
      begin
        Inc(s1);
        Inc(s2);
      end;
      Result := (ACharSize1 = 0);
    end;
  end;

begin
  Result := 0;
  if (s1 <> nil) and (s2 <> nil) then
  begin
    if AIgnoreCase then
    begin
      while (s1^ <> 0) and (s2^ <> 0) and
        ((s1^ = s2^) or (CharUpperA(s1^) = CharUpperA(s2^))) do
      begin
        if CompareSubSeq then
          Inc(Result)
        else
          Break;
      end;
    end
    else
    begin
      while (s1^ <> 0) and (s2^ <> 0) and (s1^ = s2^) do
      begin
        if CompareSubSeq then
          Inc(Result)
        else
          Break;
      end;
    end;
  end;
end;

function SameCharsW(s1, s2: PQCharW; AIgnoreCase: Boolean): Integer;
begin
  Result := 0;
  if (s1 <> nil) and (s2 <> nil) then
  begin
    if AIgnoreCase then
    begin
      while (s1^ <> #0) and (s2^ <> #0) and
        ((s1^ = s2^) or (CharUpperW(s1^) = CharUpperW(s2^))) do
        Inc(Result);
    end
    else
    begin
      while (s1^ <> #0) and (s2^ <> #0) and (s1^ = s2^) do
        Inc(Result);
    end;
  end;
end;

function DetectTextEncoding(const p: Pointer; l: Integer; var b: Boolean)
  : TTextEncoding;
var
  pAnsi: PByte;
  pWide: PWideChar;
  I, AUtf8CharSize: Integer;
const
  NoUtf8Char: array [0 .. 3] of Byte = ($C1, $AA, $CD, $A8); // ANSI编码的联通
  function IsUtf8Order(var ACharSize: Integer): Boolean;
  var
    I: Integer;
    ps: PByte;
  const
    Utf8Masks: array [0 .. 4] of Byte = ($C0, $E0, $F0, $F8, $FC);
  begin
    ps := pAnsi;
    ACharSize := CharSizeU(PQCharA(ps));
    Result := False;
    if ACharSize > 1 then
    begin
      I := ACharSize - 2;
      if ((Utf8Masks[I] and ps^) = Utf8Masks[I]) then
      begin
        Inc(ps);
        Result := True;
        for I := 1 to ACharSize - 1 do
        begin
          if (ps^ and $80) <> $80 then
          begin
            Result := False;
            Break;
          end;
          Inc(ps);
        end;
      end;
    end;
  end;

begin
  Result := teAnsi;
  b := False;
  if l >= 2 then
  begin
    pAnsi := PByte(p);
    pWide := PWideChar(p);
    b := True;
    if pWide^ = #$FEFF then
      Result := teUnicode16LE
    else if pWide^ = #$FFFE then
      Result := teUnicode16BE
    else if l >= 3 then
    begin
      if (pAnsi^ = $EF) and (PByte(IntPtr(pAnsi) + 1)^ = $BB) and
        (PByte(IntPtr(pAnsi) + 2)^ = $BF) then // UTF-8编码
        Result := teUTF8
      else // 检测字符中是否有符合UFT-8编码规则的字符，11...
      begin
        b := False;
        Result := teUnknown; // 假设为UTF8编码，然后检测是否有不符合UTF-8编码的序列
        I := 0;
        Dec(l, 2);
        while I <= l do
        begin
          if (pAnsi^ and $80) <> 0 then // 高位为1
          begin
            if (l - I >= 4) then
            begin
              if CompareMem(pAnsi, @NoUtf8Char[0], 4) then
              // 联通？是则忽略掉，不做UTF-8编码的判断依据
              begin
                Inc(pAnsi, 4);
                Inc(I, 4);
                Result := teAnsi;
                continue;
              end;
            end;
            if IsUtf8Order(AUtf8CharSize) then
            begin
              Inc(pAnsi, AUtf8CharSize);
              Result := teUTF8;
              Break;
            end
            else
            begin
              Result := teAnsi;
              Break;
            end;
          end
          else
          begin
            if pAnsi^ = 0 then // 00 xx (xx<128) 高位在前，是BE编码
            begin
              if PByte(IntPtr(pAnsi) + 1)^ < 128 then
              begin
                Result := teUnicode16BE;
                Break;
              end;
            end
            else if PByte(IntPtr(pAnsi) + 1)^ = 0 then // xx 00 低位在前，是LE编码
            begin
              Result := teUnicode16LE;
              Break;
            end;
            Inc(pAnsi);
            Inc(I);
          end;
          if Result = teUnknown then
            Result := teAnsi;
        end;
      end;
    end;
  end;
end;

function LoadTextA(AFileName: String; AEncoding: TTextEncoding): QStringA;
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Result := LoadTextA(AStream, AEncoding);
  finally
    AStream.Free;
  end;
end;

procedure ExchangeByteOrder(p: PQCharA; l: Integer);
var
  pe: PQCharA;
  c: QCharA;
begin
  pe := p;
  Inc(pe, l);
  while IntPtr(p) < IntPtr(pe) do
  begin
    c := p^;
    p^ := PQCharA(IntPtr(p) + 1)^;
    PQCharA(IntPtr(p) + 1)^ := c;
    Inc(p, 2);
  end;
end;

function ExchangeByteOrder(V: Smallint): Smallint;
var
  pv: array [0 .. 1] of Byte absolute V;
  pd: array [0 .. 1] of Byte absolute Result;
begin
  pd[0] := pv[1];
  pd[1] := pv[0];
end;

function ExchangeByteOrder(V: Word): Word;
var
  pv: array [0 .. 1] of Byte absolute V;
  pd: array [0 .. 1] of Byte absolute Result;
begin
  pd[0] := pv[1];
  pd[1] := pv[0];
end;

function ExchangeByteOrder(V: Integer): Integer;
var
  pv: array [0 .. 3] of Byte absolute V;
  pd: array [0 .. 3] of Byte absolute Result;
begin
  pd[0] := pv[3];
  pd[1] := pv[2];
  pd[2] := pv[1];
  pd[3] := pv[0];
end;

function ExchangeByteOrder(V: Cardinal): Cardinal;
var
  pv: array [0 .. 3] of Byte absolute V;
  pd: array [0 .. 3] of Byte absolute Result;
begin
  pd[0] := pv[3];
  pd[1] := pv[2];
  pd[2] := pv[1];
  pd[3] := pv[0];
end;

function ExchangeByteOrder(V: Int64): Int64;
var
  pv: array [0 .. 7] of Byte absolute V;
  pd: array [0 .. 7] of Byte absolute Result;
begin
  pd[0] := pv[7];
  pd[1] := pv[6];
  pd[2] := pv[5];
  pd[3] := pv[4];
  pd[4] := pv[3];
  pd[5] := pv[2];
  pd[6] := pv[1];
  pd[7] := pv[0];
end;

function ExchangeByteOrder(V: Single): Single;
var
  pv: array [0 .. 3] of Byte absolute V;
  pd: array [0 .. 3] of Byte absolute Result;
begin
  pd[0] := pv[3];
  pd[1] := pv[2];
  pd[2] := pv[1];
  pd[3] := pv[0];
end;

function ExchangeByteOrder(V: Double): Double;
var
  pv: array [0 .. 7] of Byte absolute V;
  pd: array [0 .. 7] of Byte absolute Result;
begin
  pd[0] := pv[7];
  pd[1] := pv[6];
  pd[2] := pv[5];
  pd[3] := pv[4];
  pd[4] := pv[3];
  pd[5] := pv[2];
  pd[6] := pv[1];
  pd[7] := pv[0];
end;

function LoadTextA(AStream: TStream; AEncoding: TTextEncoding): QStringA;
var
  ASize: Integer;
  ABuffer: TBytes;
  ABomExists: Boolean;
begin
  ASize := AStream.Size - AStream.Position;
  if ASize > 0 then
  begin
    SetLength(ABuffer, ASize);
    AStream.ReadBuffer((@ABuffer[0])^, ASize);
    if AEncoding in [teUnknown, teAuto] then
      AEncoding := DetectTextEncoding(@ABuffer[0], ASize, ABomExists)
    else if ASize >= 2 then
    begin
      case AEncoding of
        teUnicode16LE:
          ABomExists := (ABuffer[0] = $FF) and (ABuffer[1] = $FE);
        teUnicode16BE:
          ABomExists := (ABuffer[1] = $FE) and (ABuffer[1] = $FF);
        teUTF8:
          begin
            if ASize >= 3 then
              ABomExists := (ABuffer[0] = $EF) and (ABuffer[1] = $BB) and
                (ABuffer[2] = $BF)
            else
              ABomExists := False;
          end;
      end;
    end
    else
      ABomExists := False;
    if AEncoding = teAnsi then
      Result := ABuffer
    else if AEncoding = teUTF8 then
    begin
      if ABomExists then
      begin
        if ASize > 3 then
          Result := AnsiEncode(Utf8Decode(@ABuffer[3], ASize - 3))
        else
          Result.Length := 0;
      end
      else
        Result := AnsiEncode(Utf8Decode(@ABuffer[0], ASize));
    end
    else
    begin
      if AEncoding = teUnicode16BE then
        ExchangeByteOrder(@ABuffer[0], ASize);
      if ABomExists then
        Result := AnsiEncode(PQCharW(@ABuffer[2]), (ASize - 2) shr 1)
      else
        Result := AnsiEncode(PQCharW(@ABuffer[0]), ASize shr 1);
    end;
  end
  else
    Result.Length := 0;
end;

function LoadTextU(AFileName: String; AEncoding: TTextEncoding): QStringA;
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Result := LoadTextU(AStream, AEncoding);
  finally
    AStream.Free;
  end;
end;

function LoadTextU(AStream: TStream; AEncoding: TTextEncoding): QStringA;
var
  ASize: Integer;
  ABuffer: TBytes;
  ABomExists: Boolean;
begin
  ASize := AStream.Size - AStream.Position;
  if ASize > 0 then
  begin
    SetLength(ABuffer, ASize);
    AStream.ReadBuffer((@ABuffer[0])^, ASize);
    if AEncoding in [teUnknown, teAuto] then
      AEncoding := DetectTextEncoding(@ABuffer[0], ASize, ABomExists)
    else if ASize >= 2 then
    begin
      case AEncoding of
        teUnicode16LE:
          ABomExists := (ABuffer[0] = $FF) and (ABuffer[1] = $FE);
        teUnicode16BE:
          ABomExists := (ABuffer[1] = $FE) and (ABuffer[1] = $FF);
        teUTF8:
          begin
            if ASize > 3 then
              ABomExists := (ABuffer[0] = $EF) and (ABuffer[1] = $BB) and
                (ABuffer[2] = $BF)
            else
              ABomExists := False;
          end;
      end;
    end
    else
      ABomExists := False;
    if AEncoding = teAnsi then
      Result := qstring.Utf8Encode(AnsiDecode(@ABuffer[0], ASize))
    else if AEncoding = teUTF8 then
    begin
      if ABomExists then
      begin
        Dec(ASize, 3);
        Result.From(@ABuffer[0], 3, ASize);
      end
      else
        Result := ABuffer;
      if ASize > 0 then
        Result.FValue[0] := 1; // UTF-8
    end
    else
    begin
      if AEncoding = teUnicode16BE then
        ExchangeByteOrder(@ABuffer[0], ASize);
      if ABomExists then
        Result := qstring.Utf8Encode(PQCharW(@ABuffer[2]), (ASize - 2) shr 1)
      else
        Result := qstring.Utf8Encode(PQCharW(@ABuffer[0]), ASize shr 1);
    end;
  end
  else
  begin
    Result.Length := 0;
    Result.FValue[0] := 1;
  end;
end;

function LoadTextW(AFileName: String; AEncoding: TTextEncoding): QStringW;
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Result := LoadTextW(AStream, AEncoding);
  finally
    AStream.Free;
  end;
end;

function DecodeText(p: Pointer; ASize: Integer; AEncoding: TTextEncoding)
  : QStringW;
var
  ABomExists: Boolean;
  pb: PByte;
  pe: PQCharA;
  function ByteOf(AOffset: Integer): Byte;
  begin
    Result := PByte(IntPtr(pb) + AOffset)^;
  end;

begin
  pb := p;
  if ASize >= 2 then
  begin
    // 不管是否指定编码，强制检测BOM头，避免由于编码指定不符造成问题
    if (ByteOf(0) = $FF) and (ByteOf(1) = $FE) then
    begin
      AEncoding := teUnicode16LE;
      Inc(pb, 2);
      Dec(ASize, 2);
    end
    else if (ByteOf(0) = $FE) and (ByteOf(1) = $FF) then
    begin
      AEncoding := teUnicode16BE;
      Inc(pb, 2);
      Dec(ASize, 2);
    end
    else if (ASize > 2) and (ByteOf(0) = $EF) and (ByteOf(1) = $BB) and
      (ByteOf(2) = $BF) then
    begin
      AEncoding := teUTF8;
      Inc(pb, 3);
      Dec(ASize, 3);
    end
    else if AEncoding in [teUnknown, teAuto] then // No BOM
      AEncoding := DetectTextEncoding(pb, ASize, ABomExists);
    if AEncoding = teAnsi then
      Result := AnsiDecode(PQCharA(pb), ASize)
    else if AEncoding = teUTF8 then
    begin
      if not Utf8Decode(PQCharA(pb), ASize, Result, pe) then
        Result := AnsiDecode(PQCharA(pb), ASize);
    end
    else
    begin
      if AEncoding = teUnicode16BE then
        ExchangeByteOrder(PQCharA(pb), ASize);
      SetLength(Result, ASize shr 1);
      Move(pb^, PQCharW(Result)^, ASize);
    end;
  end
  else if ASize > 0 then
    Result := WideChar(pb^)
  else
    SetLength(Result, 0);
end;

function LoadTextW(AStream: TStream; AEncoding: TTextEncoding)
  : QStringW; overload;
var
  ASize: Integer;
  ABuffer: TBytes;
begin
  ASize := AStream.Size - AStream.Position;
  if ASize > 0 then
  begin
    SetLength(ABuffer, ASize);
    AStream.ReadBuffer((@ABuffer[0])^, ASize);
    Result := DecodeText(@ABuffer[0], ASize, AEncoding);
  end
  else
    SetLength(Result, 0);
end;

procedure SaveTextA(AFileName: String; const S: QStringA);
var
  AStream: TFileStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveTextA(AStream, S);
  finally
    AStream.Free;
  end;
end;

procedure SaveTextA(AStream: TStream; const S: QStringA);
  procedure Utf8Save;
  var
    t: QStringA;
  begin
    t := AnsiEncode(Utf8Decode(S));
    AStream.WriteBuffer(PQCharA(t)^, t.Length);
  end;

begin
  if not S.IsUtf8 then
    AStream.WriteBuffer(PQCharA(S)^, S.Length)
  else
    Utf8Save;
end;

procedure SaveTextU(AFileName: String; const S: QStringA; AWriteBom: Boolean);
var
  AStream: TFileStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveTextU(AStream, S, AWriteBom);
  finally
    AStream.Free;
  end;
end;

procedure SaveTextU(AFileName: String; const S: QStringW;
  AWriteBom: Boolean); overload;
begin
  SaveTextU(AFileName, qstring.Utf8Encode(S), AWriteBom);
end;

procedure SaveTextU(AStream: TStream; const S: QStringA; AWriteBom: Boolean);
  procedure WriteBom;
  var
    ABom: TBytes;
  begin
    SetLength(ABom, 3);
    ABom[0] := $EF;
    ABom[1] := $BB;
    ABom[2] := $BF;
    AStream.WriteBuffer(ABom[0], 3);
  end;
  procedure SaveAnsi;
  var
    t: QStringA;
  begin
    t := qstring.Utf8Encode(AnsiDecode(S));
    AStream.WriteBuffer(PQCharA(t)^, t.Length);
  end;

begin
  if AWriteBom then
    WriteBom;
  if S.IsUtf8 then
    AStream.WriteBuffer(PQCharA(S)^, S.Length)
  else
    SaveAnsi;
end;

procedure SaveTextU(AStream: TStream; const S: QStringW;
  AWriteBom: Boolean); overload;
begin
  SaveTextU(AStream, qstring.Utf8Encode(S), AWriteBom);
end;

procedure SaveTextW(AFileName: String; const S: QStringW; AWriteBom: Boolean);
var
  AStream: TFileStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveTextW(AStream, S, AWriteBom);
  finally
    AStream.Free;
  end;
end;

procedure SaveTextW(AStream: TStream; const S: QStringW; AWriteBom: Boolean);
  procedure WriteBom;
  var
    bom: Word;
  begin
    bom := $FEFF;
    AStream.WriteBuffer(bom, 2);
  end;

begin
  if AWriteBom then
    WriteBom;
  AStream.WriteBuffer(PQCharW(S)^, System.Length(S) shl 1);
end;

procedure SaveTextWBE(AStream: TStream; const S: QStringW; AWriteBom: Boolean);
var
  pw, pe: PWord;
  w: Word;
  ABuilder: TQStringCatHelperW;
begin
  pw := PWord(PQCharW(S));
  pe := pw;
  Inc(pe, Length(S));
  ABuilder := TQStringCatHelperW.Create(IntPtr(pe) - IntPtr(pw));
  try
    while IntPtr(pw) < IntPtr(pe) do
    begin
      w := (pw^ shr 8) or (pw^ shl 8);
      ABuilder.Cat(@w, 1);
      Inc(pw);
    end;
    if AWriteBom then
      AStream.WriteBuffer(#$FE#$FF, 2);
    AStream.WriteBuffer(ABuilder.FStart^, Length(S) shl 1);
  finally
    FreeObject(ABuilder);
  end;
end;

function StrStrA(s1, s2: PQCharA): PQCharA;
  function DoSearch: PQCharA;
  var
    ps1, ps2: PQCharA;
  begin
    ps1 := s1;
    ps2 := s2;
    Inc(ps1);
    Inc(ps2);
    while ps2^ <> 0 do
    begin
      if ps1^ = ps2^ then
      begin
        Inc(ps1);
        Inc(ps2);
      end
      else
        Break;
    end;
    if ps2^ = 0 then
      Result := s1
    else
      Result := nil;
  end;

begin
{$IFDEF MSWINDOWS}
  if Assigned(VCStrStr) then
  begin
    Result := VCStrStr(s1, s2);
    Exit;
  end;
{$ENDIF}
  Result := nil;
  if (s1 <> nil) and (s2 <> nil) then
  begin
    while s1^ <> 0 do
    begin
      if s1^ = s2^ then
      begin
        Result := DoSearch;
        if Result <> nil then
          Exit;
      end;
      Inc(s1);
    end;
  end;
end;

function StrIStrA(s1, s2: PQCharA): PQCharA;
  function DoSearch: PQCharA;
  var
    ps1, ps2: PQCharA;
  begin
    ps1 := s1;
    ps2 := s2;
    Inc(ps1);
    Inc(ps2);
    while ps2^ <> 0 do
    begin
      if CharUpperA(ps1^) = ps2^ then
      begin
        Inc(ps1);
        Inc(ps2);
      end
      else
        Break;
    end;
    if ps2^ = 0 then
      Result := s1
    else
      Result := nil;
  end;

begin
  Result := nil;
  if (s1 <> nil) and (s2 <> nil) then
  begin
    while s1^ <> 0 do
    begin
      if s1^ = s2^ then
      begin
        Result := DoSearch;
        if Result <> nil then
          Exit;
      end;
      Inc(s1);
    end;
  end;
end;

function StrStrU(s1, s2: PQCharA): PQCharA;
begin
  Result := StrStrA(s1, s2);
end;

function StrIStrU(s1, s2: PQCharA): PQCharA;
begin
  Result := StrIStrA(s1, s2);
end;

function StrStrW(s1, s2: PQCharW): PQCharW;
var
  I: Integer;
begin
{$IFDEF MSWINDOWS}
  if Assigned(VCStrStrW) then
  begin
    Result := VCStrStrW(s1, s2);
    Exit;
  end;
{$ENDIF}
  if (s2 = nil) or (s2^ = #0) then
    Result := s1
  else
  begin
    Result := nil;
    while s1^ <> #0 do
    begin
      if s1^ = s2^ then
      begin
        I := 1;
        while s2[I] <> #0 do
        begin
          if s1[I] = s2[I] then
            Inc(I)
          else
            Break;
        end;
        if s2[I] = #0 then
        begin
          Result := s1;
          Break;
        end;
      end;
      Inc(s1);
    end;
  end;
end;

function StrIStrW(s1, s2: PQCharW): PQCharW;
var
  I: Integer;
  ws2: QStringW;
begin
  Result := nil;
  if (s1 = nil) or (s2 = nil) then
    Exit;
  ws2 := UpperCase(s2);
  s2 := PWideChar(ws2);
  while s1^ <> #0 do
  begin
    if CharUpperW(s1^) = s2^ then
    begin
      I := 1;
      while s2[I] <> #0 do
      begin
        if CharUpperW(s1[I]) = s2[I] then
          Inc(I)
        else
          Break;
      end;
      if s2[I] = #0 then
      begin
        Result := s1;
        Break;
      end;
    end;
    Inc(s1);
  end;
end;

function PosW(sub, S: PQCharW; AIgnoreCase: Boolean;
  AStartPos: Integer): Integer;
begin
  if AStartPos > 0 then
    Inc(S, AStartPos - 1);
  if AIgnoreCase then
    sub := StrIStrW(S, sub)
  else
    sub := StrStrW(S, sub);
  if Assigned(sub) then
    Result := ((IntPtr(sub) - IntPtr(S)) shr 1) + 1
  else
    Result := 0;
end;

function PosW(sub, S: QStringW; AIgnoreCase: Boolean; AStartPos: Integer)
  : Integer; overload;
begin
  Result := PosW(PQCharW(sub), PQCharW(S), AIgnoreCase);
end;

function StrDupX(const S: PQCharW; ACount: Integer): QStringW;
begin
  SetLength(Result, ACount);
  Move(S^, PQCharW(Result)^, ACount shl 1);
end;

function StrDupW(const S: PQCharW; AOffset: Integer; const ACount: Integer)
  : QStringW;
var
  c, ACharSize: Integer;
  p, pds, pd: PQCharW;
begin
  c := 0;
  p := S + AOffset;
  SetLength(Result, 16384);
  pd := PQCharW(Result);
  pds := pd;
  while (p^ <> #0) and (c < ACount) do
  begin
    ACharSize := CharSizeW(p);
    AOffset := pd - pds;
    if AOffset + ACharSize = Length(Result) then
    begin
      SetLength(Result, Length(Result) shl 1);
      pds := PQCharW(Result);
      pd := pds + AOffset;
    end;
    Inc(c);
    pd^ := p^;
    if ACharSize = 2 then
      pd[1] := p[1];
    Inc(pd, ACharSize);
    Inc(p, ACharSize);
  end;
  SetLength(Result, pd - pds);
end;

function StrCmpA(const s1, s2: PQCharA; AIgnoreCase: Boolean): Integer;
var
  p1, p2: PQCharA;
  c1, c2: QCharA;
begin
  p1 := s1;
  p2 := s2;
  if AIgnoreCase then
  begin
    while (p1^ <> 0) and (p2^ <> 0) do
    begin
      if p1^ <> p2^ then
      begin
        if (p1^ >= Ord('a')) and (p1^ <= Ord('z')) then
          c1 := p1^ xor $20
        else
          c1 := p1^;
        if (p2^ >= Ord('a')) and (p2^ <= Ord('z')) then
          c2 := p2^ xor $20
        else
          c2 := p2^;
        Result := Ord(c1) - Ord(c2);
        if Result <> 0 then
          Exit;
      end;
      Inc(p1);
      Inc(p2);
    end;
    Result := Ord(p1^) - Ord(p2^);
  end
  else
  begin
    while (p1^ <> 0) and (p2^ <> 0) do
    begin
      Result := p1^ - p2^;
      if Result <> 0 then
        Exit;
      Inc(p1);
      Inc(p2);
    end;
    Result := Ord(p1^) - Ord(p2^);
  end;
end;

function StrCmpW(const s1, s2: PQCharW; AIgnoreCase: Boolean): Integer;
var
  p1, p2: PQCharW;
  c1, c2: QCharW;
begin
  p1 := s1;
  p2 := s2;
  if AIgnoreCase then
  begin
    while (p1^ <> #0) and (p2^ <> #0) do
    begin
      if p1^ <> p2^ then
      begin
        if (p1^ >= 'a') and (p1^ <= 'z') then
          c1 := WideChar(Word(p1^) xor $20)
        else
          c1 := p1^;
        if (p2^ >= 'a') and (p2^ <= 'z') then
          c2 := WideChar(Word(p2^) xor $20)
        else
          c2 := p2^;
        Result := Ord(c1) - Ord(c2);
        if Result <> 0 then
          Exit;
      end;
      Inc(p1);
      Inc(p2);
    end;
    Result := Ord(p1^) - Ord(p2^);
  end
  else
  begin
    while (p1^ <> #0) and (p2^ <> #0) do
    begin
      if p1^ <> p2^ then
      begin
        Result := Ord(p1^) - Ord(p2^);
        if Result <> 0 then
          Exit;
      end;
      Inc(p1);
      Inc(p2);
    end;
    Result := Ord(p1^) - Ord(p2^);
  end;
end;

function StrNCmpW(const s1, s2: PQCharW; AIgnoreCase: Boolean;
  ALength: Integer): Integer;
var
  p1, p2: PQCharW;
  c1, c2: QCharW;
begin
  p1 := s1;
  p2 := s2;
  if AIgnoreCase then
  begin
    while ALength > 0 do
    begin
      if p1^ <> p2^ then
      begin
        if (p1^ >= 'a') and (p1^ <= 'z') then
          c1 := WideChar(Word(p1^) xor $20)
        else
          c1 := p1^;
        if (p2^ >= 'a') and (p2^ <= 'z') then
          c2 := WideChar(Word(p2^) xor $20)
        else
          c2 := p2^;
        Result := Ord(c1) - Ord(c2);
        if Result <> 0 then
          Exit;
      end;
      Inc(p1);
      Inc(p2);
      Dec(ALength);
    end;
  end
  else
  begin
    while ALength > 0 do
    begin
      if p1^ <> p2^ then
      begin
        Result := Ord(p1^) - Ord(p2^);
        if Result <> 0 then
          Exit;
      end;
      Inc(p1);
      Inc(p2);
      Dec(ALength);
    end;
  end;
  if ALength = 0 then
    Result := 0
  else
    Result := Ord(p1^) - Ord(p2^);
end;

/// <summary>使用自然语言规则比较字符串</summary>
/// <param name="s1">第一个要比较的字符串</param>
/// <param name="s2">第二个要比较的字符串</param>
/// <param name="AIgnoreCase">比较时是否忽略大小写</param>
/// <param name="AIgnoreSpace">比较时是否忽略空白字符</param>
/// <remarks>本比较考虑中文全角的情况，认为中文全角符号和对应的半角符号是相等的值</remarks>
function NaturalCompareW(s1, s2: PQCharW;
  AIgnoreCase, AIgnoreSpace: Boolean): Integer;
var
  N1, N2: Int64;
  L1, L2: Integer;
  c1, c2: QCharW;
  function FetchNumeric(p: PQCharW; var AResult: Int64;
    var ALen: Integer): Boolean;
  var
    ps: PQCharW;
  const
    Full0: WideChar = #65296; // 全角0
    Full9: WideChar = #65305; // 全角9
  begin
    AResult := 0;
    ps := p;
    while p^ <> #0 do
    begin
      while IsSpaceW(p) do
        Inc(p);
      if (p^ >= '0') and (p^ <= '9') then // 半角数字
        AResult := AResult * 10 + Ord(p^) - Ord('0')
      else if (p^ >= Full0) and (p^ <= Full9) then // 全角数字
        AResult := AResult * 10 + Ord(p^) - Ord(Full0)
      else
        Break;
      Inc(p);
    end;
    Result := ps <> p;
    ALen := (IntPtr(p) - IntPtr(ps)) shr 1;
  end;
  function FullToHalfChar(c: Word): QCharW;
  begin
    if (c = $3000) then // 全角空格'　'
      Result := QCharW($20)
    else if (c >= $FF01) and (c <= $FF5E) then
      Result := QCharW($21 + (c - $FF01))
    else
      Result := QCharW(c);
  end;
  function CompareChar: Integer;
  begin
    if AIgnoreCase then
    begin
      c1 := CharUpperW(FullToHalfChar(Ord(s1^)));
      c2 := CharUpperW(FullToHalfChar(Ord(s2^)));
    end
    else
    begin
      c1 := FullToHalfChar(Ord(s1^));
      c2 := FullToHalfChar(Ord(s2^));
    end;
    Result := Ord(c1) - Ord(c2);
  end;

begin
  if Assigned(s1) then
  begin
    if not Assigned(s2) then
    begin
      Result := 1;
      Exit;
    end;
    while (s1^ <> #0) and (s2^ <> #0) do
    begin
      if s1^ <> s2^ then
      begin
        while IsSpaceW(s1) do
          Inc(s1);
        while IsSpaceW(s1) do
          Inc(s2);
        // 检查是否是数字
        L1 := 0;
        L2 := 0;
        if FetchNumeric(s1, N1, L1) and FetchNumeric(s2, N2, L2) then
        begin
          Result := N1 - N2;
          if Result <> 0 then
            Exit
          else
          begin
            Inc(s1, L1);
            Inc(s2, L2);
          end;
        end
        else
        begin
          Result := CompareChar;
          if Result = 0 then
          begin
            Inc(s1);
            Inc(s2);
          end
          else
            Exit;
        end;
      end
      else // 如果想等，即使是数字，肯定也是相等的
      begin
        Inc(s1);
        Inc(s2);
      end;
    end;
    Result := CompareChar;
  end
  else if Assigned(s2) then
    Result := -1
  else
    Result := 0;
end;

function IsHexChar(c: QCharW): Boolean; inline;
begin
  Result := ((c >= '0') and (c <= '9')) or ((c >= 'a') and (c <= 'f')) or
    ((c >= 'A') and (c <= 'F'));
end;

function HexValue(c: QCharW): Integer;
begin
  if (c >= '0') and (c <= '9') then
    Result := Ord(c) - Ord('0')
  else if (c >= 'a') and (c <= 'f') then
    Result := 10 + Ord(c) - Ord('a')
  else
    Result := 10 + Ord(c) - Ord('A');
end;

function HexChar(V: Byte): QCharW;
begin
  if V < 10 then
    Result := QCharW(V + Ord('0'))
  else
    Result := QCharW(V - 10 + Ord('A'));
end;

function TryStrToGuid(const S: QStringW; var AGuid: TGuid): Boolean;
var
  p, ps: PQCharW;
  l: Int64;
begin
  l := Length(S);
  p := PWideChar(S);
  if (l = 38) or (l = 36) then
  begin
    // {0BCBAAFF-15E6-451D-A8E8-0D98AC48C364}
    ps := p;
    if p^ = '{' then
      Inc(p);
    if (ParseHex(p, l) <> 8) or (p^ <> '-') then
    begin
      Result := False;
      Exit;
    end;
    AGuid.D1 := l;
    Inc(p);
    if (ParseHex(p, l) <> 4) or (p^ <> '-') then
    begin
      Result := False;
      Exit;
    end;
    AGuid.D2 := l;
    Inc(p);
    if (ParseHex(p, l) <> 4) or (p^ <> '-') then
    begin
      Result := False;
      Exit;
    end;
    AGuid.D3 := l;
    Inc(p);
    // 0102-030405060708
    // 剩下的16个字符
    l := 0;
    while IsHexChar(p[0]) do
    begin
      if IsHexChar(p[1]) then
      begin
        AGuid.D4[l] := (HexValue(p[0]) shl 4) + HexValue(p[1]);
        Inc(l);
        Inc(p, 2);
      end
      else
      begin
        Result := False;
        Exit;
      end;
    end;
    if (l <> 2) or (p^ <> '-') then
    begin
      Result := False;
      Exit;
    end;
    Inc(p);
    while IsHexChar(p[0]) do
    begin
      if IsHexChar(p[1]) then
      begin
        AGuid.D4[l] := (HexValue(p[0]) shl 4) + HexValue(p[1]);
        Inc(l);
        Inc(p, 2);
      end
      else
      begin
        Result := False;
        Exit;
      end;
    end;
    if (l = 8) then
    begin
      if ps^ = '{' then
        Result := (p[0] = '}') and (p[1] = #0)
      else
        Result := (p[0] = #0);
    end
    else
      Result := False;
  end
  else
    Result := False;
end;

function TryStrToIPV4(const S: QStringW; var AIPV4:
{$IFDEF MSWINDOWS}Integer{$ELSE}Cardinal{$ENDIF}): Boolean;
var
  p: PQCharW;
  dc: Integer;
  pd: PByte;
begin
  dc := 0;
  AIPV4 := 0;
  p := PQCharW(S);
  pd := PByte(@AIPV4);
  while p^ <> #0 do
  begin
    if (p^ >= '0') and (p^ <= '9') then
      pd^ := pd^ * 10 + Ord(p^) - Ord('0')
    else if p^ = '.' then
    begin
      Inc(dc);
      if dc > 3 then
        Break;
      Inc(pd);
    end
    else
      Break;
    Inc(p);
  end;
  Result := (dc = 3) and (p^ = #0);
end;

function StringReplaceW(const S, Old, New: QStringW; AFlags: TReplaceFlags)
  : QStringW;
var
  ps, pse, pds, pr, pd, po, pn: PQCharW;
  l, LO, LN, LS, LR: Integer;
  AReplaceOnce: Boolean;
begin
  LO := Length(Old);
  LN := Length(New);
  LS := Length(S);
  if (LO > 0) and (LS >= LO) then
  begin
    AReplaceOnce := not(rfReplaceAll in AFlags);
    // LO=LN，则不变LR=LS，假设全替换，也不过是原长度
    // LO<LN，则LR=LS+(LS*LN)/LO，假设全替换的长度
    // LO>LN，则LR=LS，假设一次都不替换，也不过是原长度
    if LO >= LN then
      LR := LS
    else if AReplaceOnce then
      LR := LS + (LN - LO)
    else
      LR := LS + 1 + LS * LN div LO;
    SetLength(Result, LR);
    ps := PQCharW(S);
    pse := ps + LS;
    pd := PQCharW(Result);
    pds := pd;
    po := PQCharW(Old);
    pn := PQCharW(New);
    repeat
      if rfIgnoreCase in AFlags then
        pr := StrIStrW(ps, po)
      else
        pr := StrStrW(ps, po);
      if pr <> nil then
      begin
        l := IntPtr(pr) - IntPtr(ps);
        Move(ps^, pd^, l);
        Inc(pd, l shr 1);
        Inc(pr, LO);
        Move(pn^, pd^, LN shl 1);
        Inc(pd, LN);
        ps := pr;
      end;
    until (pr = nil) or AReplaceOnce;
    // 将剩余部分合并到目标
    l := IntPtr(pse) - IntPtr(ps);
    Move(ps^, pd^, l);
    Inc(pd, l shr 1);
    SetLength(Result, pd - pds);
  end
  else
    Result := S;
end;

function StringReplaceW(const S: QStringW; const AChar: QCharW;
  AFrom, ACount: Integer): QStringW;
var
  p, pd: PQCharW;
  l: Integer;
begin
  l := Length(S);
  SetLength(Result, l);
  if (l > 0) and (l > AFrom + 1) then
  begin
    p := PQCharW(S);
    pd := PQCharW(Result);
    while (p^ <> #0) and (AFrom > 0) do
    begin
      pd^ := p^;
      if (p^ > #$D800) and (p^ <= #$DFFF) then
      begin
        Inc(pd);
        Inc(p);
        pd^ := p^;
      end;
      Inc(p);
      Inc(pd);
      Dec(AFrom);
    end;
    while (p^ <> #0) and (ACount > 0) do
    begin
      pd^ := AChar;
      if (p^ > #$D800) and (p^ <= #$DFFF) then
        Inc(p);
      Inc(p);
      Inc(pd);
      Dec(ACount);
    end;
    while p^ <> #0 do
    begin
      pd^ := p^;
      Inc(p);
      Inc(pd);
    end;
  end;
end;

function StringReplaceWithW(const S, AStartTag, AEndTag, AReplaced: QStringW;
  AWithTag, AIgnoreCase: Boolean; AMaxTimes: Cardinal): QStringW;
var
  po, pe, pws, pwe, pd, pStart, pEnd, pReplaced: PQCharW;
  l, DL, LS, LE, LR: Integer;
  StrStrFunc: TStrStrFunction;
begin
  l := Length(S);
  LS := Length(AStartTag);
  LE := Length(AEndTag);
  if (l >= LS + LE) and (AMaxTimes > 0) then
  begin
    LR := Length(AReplaced);
    po := PQCharW(S);
    pe := po + l;
    pStart := PQCharW(AStartTag);
    pEnd := PQCharW(AEndTag);
    pReplaced := PQCharW(AReplaced);
    if LR > l then
      SetLength(Result, l * LR) // 最糟糕的情况，每个都被替换为目标,当然这不可能
    else
      SetLength(Result, l);
    pd := PQCharW(Result);
    if AIgnoreCase then
      StrStrFunc := StrIStrW
    else
      StrStrFunc := StrStrW;
    repeat
      pws := StrStrFunc(po, pStart);
      if pws = nil then
      begin
        DL := (pe - po);
        Move(po^, pd^, DL shl 1);
        SetLength(Result, pd - PQCharW(Result) + DL);
        Exit;
      end
      else
      begin
        pwe := StrStrFunc(pws + LS, pEnd);
        if pwe = nil then // 没找到结尾
        begin
          DL := pe - po;
          Move(po^, pd^, DL shl 1);
          SetLength(Result, pd - PQCharW(Result) + DL);
          Exit;
        end
        else
        begin
          DL := pws - po;
          if AWithTag then
          begin
            Move(po^, pd^, (LS + DL) shl 1);
            Inc(pd, LS + DL);
            Move(pReplaced^, pd^, LR shl 1);
            Inc(pd, LR);
            Move(pwe^, pd^, LE shl 1);
            Inc(pd, LE);
          end
          else
          begin
            Move(po^, pd^, DL shl 1);
            Inc(pd, DL);
            Move(pReplaced^, pd^, LR shl 1);
            Inc(pd, LR);
          end;
          po := pwe + LE;
          Dec(AMaxTimes);
        end;
      end;
    until (AMaxTimes = 0) and (IntPtr(po) < IntPtr(pe));
    if IntPtr(po) < IntPtr(pe) then
    begin
      DL := pe - po;
      Move(po^, pd^, DL shl 1);
      Inc(pd, DL);
      SetLength(Result, pd - PQCharW(Result));
    end;
  end
  else
    Result := S;
end;

function StringReplicateW(const S: QStringW; ACount: Integer): QStringW;
var
  l: Integer;
  p, ps, pd: PQCharW;
begin
  l := Length(S);
  if (l > 0) and (ACount > 0) then
  begin
    SetLength(Result, ACount * l);
    ps := PQCharW(S);
    pd := PQCharW(Result);
    for l := 0 to ACount - 1 do
    begin
      p := ps;
      while p^ <> #0 do
      begin
        pd^ := p^;
        Inc(pd);
        Inc(p);
      end;
    end;
  end
  else
    SetLength(Result, 0);
end;

function FilterCharW(const S: QStringW; AcceptChars: QStringW)
  : QStringW; overload;
var
  ps, pd, pc, pds: PQCharW;
  l: Integer;
begin
  SetLength(Result, Length(S));
  if Length(S) > 0 then
  begin
    ps := PQCharW(S);
    pd := PQCharW(Result);
    pds := pd;
    pc := PQCharW(AcceptChars);
    while ps^ <> #0 do
    begin
      if CharInW(ps, pc, @l) then
      begin
        pd^ := ps^;
        Inc(ps);
        Inc(pd);
        if l > 1 then
        begin
          pd^ := ps^;
          Inc(ps);
          Inc(pd);
        end;
      end
      else
        Inc(ps);
    end;
    SetLength(Result, (IntPtr(pd) - IntPtr(pds)) shr 1);
  end;
end;

function FilterCharW(const S: QStringW; AOnValidate: TQFilterCharEvent;
  ATag: Pointer): QStringW; overload;
var
  ps, pd, pds: PQCharW;
  l, I: Integer;
  Accept: Boolean;
begin
  if (Length(S) > 0) and Assigned(AOnValidate) then
  begin
    SetLength(Result, Length(S));
    ps := PQCharW(S);
    pd := PQCharW(Result);
    pds := pd;
    I := 0;
    while ps^ <> #0 do
    begin
      Accept := True;
      if CharSizeW(ps) = 2 then
      begin
        l := Ord(ps^);
        Inc(ps);
        l := (l shl 16) or Ord(ps^);
        AOnValidate(l, I, Accept, ATag);
      end
      else
        AOnValidate(Ord(ps^), I, Accept, ATag);
      if Accept then
      begin
        pd^ := ps^;
        Inc(pd);
      end;
      Inc(ps);
      Inc(I);
    end;
    SetLength(Result, (IntPtr(pd) - IntPtr(pds)) shr 1);
  end
  else
    SetLength(Result, 0);
end;
{$IFDEF UNICODE}

function FilterCharW(const S: QStringW; AOnValidate: TQFilterCharEventA;
  ATag: Pointer): QStringW; overload;
var
  ps, pd, pds: PQCharW;
  l, I: Integer;
  Accept: Boolean;
begin
  if (Length(S) > 0) and Assigned(AOnValidate) then
  begin
    SetLength(Result, Length(S));
    ps := PQCharW(S);
    pd := PQCharW(Result);
    pds := pd;
    I := 0;
    while ps^ <> #0 do
    begin
      Accept := True;
      if CharSizeW(ps) = 2 then
      begin
        l := Ord(ps^);
        Inc(ps);
        l := (l shl 16) or Ord(ps^);
        AOnValidate(l, I, Accept, ATag);
      end
      else
        AOnValidate(Ord(ps^), I, Accept, ATag);
      Inc(I);
      if Accept then
      begin
        pd^ := ps^;
        Inc(pd);
      end;
      Inc(ps);
    end;
    SetLength(Result, (IntPtr(pd) - IntPtr(pds)) shr 1);
  end
  else
    SetLength(Result, 0);
end;
{$ENDIF}

function FilterNoNumberW(const S: QStringW; Accepts: TQNumberTypes): QStringW;
var
  p, pd, pds: PQCharW;
  d, e: Integer;
  AIsHex: Boolean;
  procedure NegPosCheck;
  begin
    if ((p^ = '+') and (nftPositive in Accepts)) or
      ((p^ = '-') and (nftNegative in Accepts)) then
    begin
      pd^ := p^;
      Inc(p);
      Inc(pd);
    end;
  end;

begin
  SetLength(Result, Length(S));
  p := PQCharW(S);
  pd := PQCharW(Result);
  pds := pd;
  AIsHex := False;
  NegPosCheck;
  if nftHexPrec in Accepts then // Check Hex prec
  begin
    if (p^ = '0') and (nftCHex in Accepts) then // C Style
    begin
      Inc(p);
      if (p^ = 'x') or (p^ = 'X') then
      begin
        pd^ := '0';
        Inc(pd);
        pd^ := p^;
        Inc(pd);
        Inc(p);
        AIsHex := True;
      end
      else
        Dec(p);
    end
    else if (p^ = '$') and (nftDelphiHex in Accepts) then
    begin
      pd^ := p^;
      Inc(p);
      Inc(pd);
      AIsHex := True;
    end
    else if (p^ = '&') and (nftBasicHex in Accepts) then
    begin
      Inc(p);
      if Ord(p^) in [Ord('h'), Ord('H')] then
      begin
        pd^ := '&';
        Inc(pd);
        pd^ := p^;
        Inc(pd);
        Inc(p);
        AIsHex := True;
      end
      else
        Dec(p);
    end;
  end;
  d := 0;
  e := 0;
  while p^ <> #0 do
  begin
    if Ord(p^) in [Ord('0') .. Ord('9')] then
    begin
      pd^ := p^;
      Inc(pd);
    end
    else if (p^ = '.') and (not AIsHex) then
    begin
      Inc(d);
      if (d = 1) and (nftFloat in Accepts) then
      begin
        pd^ := p^;
        Inc(pd);
      end;
    end
    else if (Ord(p^) in [Ord('e'), Ord('E')]) and (not AIsHex) then
    begin
      Inc(e);
      if (e = 1) and (nftFloat in Accepts) then
      begin
        if d <= 1 then
        begin
          pd^ := p^;
          Inc(pd);
          d := 0;
          NegPosCheck;
        end;
      end;
    end
    else if AIsHex and ((Ord(p^) in [Ord('a') .. Ord('f')]) or
      (Ord(p^) in [Ord('A') .. Ord('F')])) then
    begin
      pd^ := p^;
      Inc(pd);
    end;
    Inc(p);
  end;
  SetLength(Result, (IntPtr(pd) - IntPtr(pds)) shr 1);
end;

function MemScan(S: Pointer; len_s: Integer; sub: Pointer;
  len_sub: Integer): Pointer;
var
  pb_s, pb_sub, pc_sub, pc_s: PByte;
  remain: Integer;
begin
  if len_s > len_sub then
  begin
    pb_s := S;
    pb_sub := sub;
    Result := nil;
    while len_s >= len_sub do
    begin
      if pb_s^ = pb_sub^ then
      begin
        remain := len_sub - 1;
        pc_sub := pb_sub;
        pc_s := pb_s;
        Inc(pc_s);
        Inc(pc_sub);
        if BinaryCmp(pc_s, pc_sub, remain) = 0 then
        begin
          Result := pb_s;
          Break;
        end;
      end;
      Inc(pb_s);
    end;
  end
  else if len_s = len_sub then
  begin
    if CompareMem(S, sub, len_s) then
      Result := S
    else
      Result := nil;
  end
  else
    Result := nil;
end;

function BinaryCmp(const p1, p2: Pointer; len: Integer): Integer;
  function CompareByByte: Integer;
  var
    b1, b2: PByte;
  begin
    if (len <= 0) or (p1 = p2) then
      Result := 0
    else
    begin
      b1 := p1;
      b2 := p2;
      Result := 0;
      while len > 0 do
      begin
        if b1^ <> b2^ then
        begin
          Result := b1^ - b2^;
          Exit;
        end;
        Inc(b1);
        Inc(b2);
      end;
    end;
  end;

begin
{$IFDEF MSWINDOWS}
  if Assigned(VCMemCmp) then
    Result := VCMemCmp(p1, p2, len)
  else
    Result := CompareByByte;
{$ELSE}
  Result := memcmp(p1, p2, len);
{$ENDIF}
end;

procedure SkipHex(var S: PQCharW);
begin
  while ((S^ >= '0') and (S^ <= '9')) or ((S^ >= 'a') and (S^ <= 'f')) or
    ((S^ >= 'A') and (S^ <= 'F')) do
    Inc(S);
end;

procedure SkipDec(var S: PQCharW);
begin
  while (S^ >= '0') and (S^ <= '9') do
    Inc(S);
end;

function ParseHex(var p: PQCharW; var Value: Int64): Integer;
var
  ps: PQCharW;
begin
  Value := 0;
  ps := p;
  while IsHexChar(p^) do
  begin
    Value := (Value shl 4) + HexValue(p^);
    Inc(p);
  end;
  Result := p - ps;
end;

function LeftStrCount(const S: QStringW; const sub: QStringW;
  AIgnoreCase: Boolean): Integer;
var
  ps, psub: PQCharW;
  l: Integer;
begin
  l := Length(sub);
  Result := 0;
  if (l > 0) and (Length(S) >= l) then
  begin
    ps := PQCharW(S);
    psub := PQCharW(sub);
    if AIgnoreCase then
    begin
      repeat
        ps := StrIStrW(ps, psub);
        if ps <> nil then
        begin
          Inc(Result);
          Inc(ps, l);
        end;
      until ps = nil;
    end
    else
    begin
      repeat
        ps := StrStrW(ps, psub);
        if ps <> nil then
        begin
          Inc(Result);
          Inc(ps, l);
        end;
      until ps = nil;
    end;
  end;
end;

function RightStrCount(const S: QStringW; const sub: QStringW;
  AIgnoreCase: Boolean): Integer;
var
  ps, pe, psub: PQCharW;
  l: Integer;
begin
  l := Length(sub);
  Result := 0;
  if Length(S) > l then
  begin
    ps := PQCharW(S);
    pe := ps + Length(S) - 1;
    psub := PQCharW(sub);
    while pe >= ps do
    begin
      if StartWithW(pe, psub, AIgnoreCase) then
      begin
        Inc(Result);
        Dec(pe, l);
      end
      else
        Dec(pe);
    end;
  end;
end;

function ParseInt(var S: PQCharW; var ANum: Int64): Integer;
var
  ps: PQCharW;
  ANeg: Boolean;
begin
  ps := S;
  // 跳过16进制开始字符
  if S[0] = '$' then
  begin
    Inc(S);
    Result := ParseHex(S, ANum);
  end
  else if (S[0] = '0') and ((S[1] = 'x') or (S[1] = 'X')) then
  begin
    Inc(S, 2);
    Result := ParseHex(S, ANum);
  end
  else
  begin
    if (S^ = '-') then
    begin
      ANeg := True;
      Inc(S);
    end
    else
    begin
      ANeg := False;
      if S^ = '+' then
        Inc(S);
    end;
    ANum := 0;
    while (S^ >= '0') and (S^ <= '9') do
    begin
      ANum := ANum * 10 + Ord(S^) - Ord('0');
      if ANum < 0 then // 溢出？
      begin
        Result := 0;
        S := ps;
        Exit;
      end;
      Inc(S);
    end;
    if ANeg then
      ANum := -ANum;
    Result := S - ps;
  end;
end;

function ParseNumeric(var S: PQCharW; var ANum: Extended): Boolean;
var
  ps: PQCharW;
  function ParseHexInt: Boolean;
  var
    iVal: Int64;
  begin
    iVal := 0;
    while IsHexChar(S^) do
    begin
      iVal := (iVal shl 4) + HexValue(S^);
      Inc(S);
    end;
    Result := (S <> ps);
    ANum := iVal;
  end;

  function ParseDec: Boolean;
  var
    ACount: Integer;
    iVal: Int64;
    APow: Extended;
    ANeg: Boolean;
  begin
    try
      ANeg := S^ = '-';
      if ANeg then
        Inc(S);
      Result := ParseInt(S, iVal) > 0;
      if not Result then
        Exit;
      if ANeg then
        ANum := -iVal
      else
        ANum := iVal;
      if S^ = '.' then // 小数部分
      begin
        Inc(S);
        ACount := ParseInt(S, iVal);
        if ACount > 0 then
        begin
          if (ANum < 0) or ANeg then
            ANum := ANum - iVal / IntPower(10, ACount)
          else
            ANum := ANum + iVal / IntPower(10, ACount);
        end;
      end;
      if (S^ = 'e') or (S^ = 'E') then
      begin
        Inc(S);
        if ParseNumeric(S, APow) then
        begin
          ANum := ANum * Power(10, APow);

        end;
      end;
      Result := (S <> ps);
    except
      on e: EOverflow do
        Result := False;
    end;
  end;

begin
  ps := S;
  if (S^ = '$') or (S^ = '&') then
  begin
    Inc(S);
    Result := ParseHexInt;
    Exit;
  end
  else if (S[0] = '0') and ((S[1] = 'x') or (S[1] = 'X')) then
  begin
    Inc(S, 2);
    Result := ParseHexInt;
    Exit;
  end
  else
    Result := ParseDec;
  if not Result then
    S := ps;
end;

function NameOfW(const S: QStringW; ASpliter: QCharW): QStringW;
var
  p: PQCharW;
begin
  p := PQCharW(S);
  Result := DecodeTokenW(p, [ASpliter], WideChar(0), False);
end;

function ValueOfW(const S: QStringW; ASpliter: QCharW): QStringW;
var
  p: PQCharW;
  l: Integer;
begin
  p := PQCharW(S);
  if p^ = ASpliter then
  begin
    l := Length(S);
    Dec(l);
    SetLength(Result, l);
    Inc(p);
    Move(p^, PQCharW(Result)^, l shl 1);
  end
  else
  begin
    DecodeTokenW(p, [ASpliter], WideChar(0), False);
    if p^ <> #0 then
      Result := p
    else
      Result := S;
  end;
end;

function IndexOfNameW(AList: TStrings; const AName: QStringW;
  ASpliter: QCharW): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to AList.count - 1 do
  begin
    if NameOfW(AList[I], ASpliter) = AName then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function IndexOfValueW(AList: TStrings; const AValue: QStringW;
  ASpliter: QCharW): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to AList.count - 1 do
  begin
    if ValueOfW(AList[I], ASpliter) = AValue then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function DeleteCharW(const ASource, ADeletes: QStringW): QStringW;
var
  ps, pd: PQCharW;
  l, ACharLen: Integer;
begin
  l := Length(ASource);
  if (l > 0) and (Length(ADeletes) > 0) then
  begin
    SetLength(Result, l);
    ps := PQCharW(ASource);
    pd := PQCharW(Result);
    while l > 0 do
    begin
      if not CharInW(ps, PQCharW(ADeletes), @ACharLen) then
      begin
        pd^ := ps^;
        Inc(pd);
        ACharLen := CharSizeW(ps);
      end;
      Inc(ps, ACharLen);
      Dec(l, ACharLen);
    end;
    SetLength(Result, pd - PQCharW(Result));
  end
  else
    Result := ASource;
end;

function DeleteRightW(const S, ADelete: QStringW; AIgnoreCase: Boolean = False;
  ACount: Integer = MaxInt): QStringW;
var
  ps, pd, pe: PQCharW;
  LS, LD: Integer;
begin
  LS := Length(S);
  LD := Length(ADelete);
  if LS < LD then
    Result := S
  else
  begin
    pe := PQCharW(S) + Length(S);
    pd := PQCharW(ADelete);
    if AIgnoreCase then
    begin
      while LS >= LD do
      begin
        ps := pe - LD;
        if StrIStrW(ps, pd) = ps then
        begin
          pe := ps;
          Dec(LS, LD);
        end
        else
          Break;
      end;
    end
    else
    begin
      while LS >= LD do
      begin
        ps := pe - LD;
        if CompareMem(ps, pd, LD shl 1) then
        begin
          pe := ps;
          Dec(LS, LD);
        end
        else
          Break;
      end;
    end;
    SetLength(Result, LS);
    if LS > 0 then
      Move(PWideChar(S)^, PQCharW(Result)^, LS shl 1);
  end;
end;

function DeleteLeftW(const S, ADelete: QStringW; AIgnoreCase: Boolean = False;
  ACount: Integer = MaxInt): QStringW;
var
  ps, pd: PQCharW;
  LS, LD: Integer;
begin
  LS := Length(S);
  LD := Length(ADelete);
  if LS < LD then
    Result := S
  else
  begin
    ps := PQCharW(S);
    pd := PQCharW(ADelete);
    if AIgnoreCase then
    begin
      while LS >= LD do
      begin
        if StartWithW(ps, pd, True) then
        begin
          Inc(ps, LD);
          Dec(LS, LD);
        end
        else
          Break;
      end;
    end
    else
    begin
      while LS >= LD do
      begin
        if CompareMem(ps, pd, LD shl 1) then
        begin
          Inc(ps, LD);
          Dec(LS, LD);
        end
        else
          Break;
      end;
    end;
    SetLength(Result, LS);
    if LS > 0 then
      Move(ps^, PQCharW(Result)^, LS shl 1);
  end;
end;

function ContainsCharW(const S, ACharList: QStringW): Boolean;
var
  ps: PQCharW;
  l: Integer;
begin
  l := Length(S);
  Result := False;
  if (l > 0) then
  begin
    if Length(ACharList) > 0 then
    begin
      ps := PQCharW(S);
      while l > 0 do
      begin
        if CharInW(ps, PQCharW(ACharList)) then
        begin
          Result := True;
          Break;
        end;
        Inc(ps);
        Dec(l);
      end;
    end;
  end;
end;

procedure StrCpyW(d: PQCharW; S: PQCharW; ACount: Integer);
begin
  while (S^ <> #0) and (ACount <> 0) do
  begin
    d^ := S^;
    Inc(d);
    Inc(S);
    Dec(ACount);
  end;
end;

function HtmlEscape(const S: QStringW): QStringW;
var
  p, pd: PQCharW;
  AFound: Boolean;
  I: Integer;
begin
  if Length(S) > 0 then
  begin
    System.SetLength(Result, Length(S) shl 3); // 转义串最长不超过8个字符，长度*8肯定够了
    p := PWideChar(S);
    pd := PWideChar(Result);
    while p^ <> #0 do
    begin
      AFound := False;
      for I := 0 to 92 do
      begin
        if HtmlEscapeChars[I shl 1] = p^ then
        begin
          AFound := True;
          StrCpyW(pd, PQCharW(HtmlEscapeChars[(I shl 1) + 1]));
          Break;
        end;
      end; // end for
      if not AFound then
      begin
        pd^ := p^;
        Inc(pd);
      end; // end if
      Inc(p);
    end; // end while
    SetLength(Result, pd - PQCharW(Result));
  end // end if
  else
    Result := '';
end;

function HtmlUnescape(const S: QStringW): QStringW;
var
  p, pd, ps: PQCharW;
  AFound: Boolean;
  I, l: Integer;
begin
  if Length(S) > 0 then
  begin
    System.SetLength(Result, Length(S));
    p := PQCharW(S);
    pd := PQCharW(Result);
    while p^ <> #0 do
    begin
      if p^ = '&' then
      begin
        if p[1] = '#' then
        begin
          ps := p;
          Inc(p, 2);
          l := 0;
          if p^ = 'x' then
          begin
            Inc(p);
            while IsHexChar(p^) do
            begin
              l := l shl 4 + HexValue(p^);
              Inc(p);
            end;
          end
          else
          begin
            while (p^ >= '0') and (p^ <= '9') do
            begin
              l := l * 10 + Ord(p^) - Ord('0');
              Inc(p);
            end;
          end;
          if p^ = ';' then
          begin
            pd^ := QCharW(l);
            Inc(pd);
          end
          else
          begin
            pd^ := ps^;
            Inc(pd);
            p := ps;
          end;
        end
        else
        begin
          AFound := False;
          for I := 0 to 91 do
          begin
            if StrStrW(p, PWideChar(HtmlEscapeChars[I shl 1 + 1])) = p then
            begin
              AFound := True;
              StrCpyW(pd, PQCharW(HtmlEscapeChars[(I shl 1)]));
              Break;
            end;
          end; // end for
          if AFound then
          begin
            Inc(p, Length(HtmlEscapeChars[I shl 1 + 1]));
            continue;
          end
          else
          begin
            pd^ := p^;
            Inc(pd);
          end; // end if
        end; // end else
      end // end else
      else
      begin
        pd^ := p^;
        Inc(pd);
      end;
      Inc(p);
    end; // end while
    SetLength(Result, pd - PWideChar(Result));
  end // end if
  else
    Result := '';
end;

function HtmlTrimText(const S: QStringW): QStringW;
var
  ps, pe: PQCharW;
  l: Integer;
begin
  if Length(S) > 0 then
  begin
    ps := PQCharW(S);
    pe := ps + System.Length(S) - 1;
    while IsSpaceW(ps) do
      Inc(ps);
    while IsSpaceW(pe) do
      Dec(pe);
    l := pe - ps + 1;
    SetLength(Result, l);
    Move(ps^, PQCharW(Result)^, l shl 1);
  end
  else
    Result := '';
end;

// 下面是一些辅助函数
function ParseDateTime(S: PWideChar; var AResult: TDateTime): Boolean;
var
  Y, M, d, H, N, Sec, MS: Word;
  AQuoter: WideChar;
  ADate: TDateTime;
  function ParseNum(var N: Word): Boolean;
  var
    neg: Boolean;
    ps: PQCharW;
  begin
    N := 0;
    ps := S;
    if S^ = '-' then
    begin
      neg := True;
      Inc(S);
    end
    else
      neg := False;
    while S^ <> #0 do
    begin
      if (S^ >= '0') and (S^ <= '9') then
      begin
        N := N * 10 + Ord(S^) - 48;
        Inc(S);
      end
      else
        Break;
    end;
    if neg then
      N := -N;
    Result := ps <> S;
  end;

begin
  if (S^ = '"') or (S^ = '''') then
  begin
    AQuoter := S^;
    Inc(S);
  end
  else
    AQuoter := #0;
  Result := ParseNum(Y);
  if not Result then
    Exit;
  if (S^ = '-') or (S^ = '/') then
  begin
    Inc(S);
    Result := ParseNum(M);
    if (not Result) or ((S^ <> '-') and (S^ <> '/')) then
      Exit;
    Inc(S);
    Result := ParseNum(d);
    if (not Result) or ((S^ <> 'T') and (S^ <> ' ') and (S^ <> #0)) then
      Exit;
    if S^ <> #0 then
      Inc(S);
    if d > 31 then // D -> Y
    begin
      if M > 12 then // M/D/Y M -> D, D->Y, Y->M
        Result := TryEncodeDate(d, Y, M, ADate)
      else // D/M/Y
        Result := TryEncodeDate(d, M, Y, ADate);
    end
    else
      Result := TryEncodeDate(Y, M, d, ADate);
    if not Result then
      Exit;
    SkipSpaceW(S);
    if S^ <> #0 then
    begin
      if not ParseNum(H) then // 没跟时间值
      begin
        AResult := ADate;
        Exit;
      end;
      if S^ <> ':' then
      begin
        if H in [0 .. 23] then
          AResult := ADate + EncodeTime(H, 0, 0, 0)
        else
          Result := False;
        Exit;
      end;
      Inc(S);
    end
    else
    begin
      AResult := ADate;
      Exit;
    end;
  end
  else if S^ = ':' then
  begin
    ADate := 0;
    H := Y;
    Inc(S);
  end
  else
  begin
    Result := False;
    Exit;
  end;
  if H > 23 then
  begin
    Result := False;
    Exit;
  end;
  if not ParseNum(N) then
  begin
    if AQuoter <> #0 then
    begin
      if S^ = AQuoter then
        AResult := ADate + EncodeTime(H, 0, 0, 0)
      else
        Result := False;
    end
    else
      AResult := ADate + EncodeTime(H, 0, 0, 0);
    Exit;
  end
  else if N > 59 then
  begin
    Result := False;
    Exit;
  end;
  Sec := 0;
  MS := 0;
  if S^ = ':' then
  begin
    Inc(S);
    if not ParseNum(Sec) then
    begin
      if AQuoter <> #0 then
      begin
        if S^ = AQuoter then
          AResult := ADate + EncodeTime(H, N, 0, 0)
        else
          Result := False;
      end
      else
        AResult := ADate + EncodeTime(H, N, 0, 0);
      Exit;
    end
    else if Sec > 59 then
    begin
      Result := False;
      Exit;
    end;
    if S^ = '.' then
    begin
      Inc(S);
      if not ParseNum(MS) then
      begin
        if AQuoter <> #0 then
        begin
          if AQuoter = S^ then
            AResult := ADate + EncodeTime(H, N, Sec, 0)
          else
            Result := False;
        end
        else
          AResult := ADate + EncodeTime(H, N, Sec, 0);
        Exit;
      end
      else if MS >= 1000 then // 超过1000是以微秒为单位计时的，转换为毫秒
      begin
        while MS >= 1000 do
          MS := MS div 10;
      end;
      if AQuoter <> #0 then
      begin
        if AQuoter = S^ then
          AResult := ADate + EncodeTime(H, N, Sec, MS)
        else
          Result := False;
        Exit;
      end
      else
        AResult := ADate + EncodeTime(H, N, Sec, MS);
    end
    else
    begin
      if AQuoter <> #0 then
      begin
        if AQuoter = S^ then
          AResult := ADate + EncodeTime(H, N, Sec, 0)
        else
          Result := False;
      end
      else
        AResult := ADate + EncodeTime(H, N, Sec, 0)
    end;
  end
  else
  begin
    if AQuoter <> #0 then
    begin
      if AQuoter = S^ then
        AResult := ADate + EncodeTime(H, N, 0, 0)
      else
        Result := False;
    end
    else
      AResult := ADate + EncodeTime(H, N, 0, 0);
  end;
end;

function ParseWebTime(p: PWideChar; var AResult: TDateTime): Boolean;
var
  I: Integer;
  Y, M, d, H, N, S: Integer;
const
  MonthNames: array [0 .. 11] of QStringW = ('Jan', 'Feb', 'Mar', 'Apr', 'May',
    'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
  Comma: PWideChar = ',';
  Digits: PWideChar = '0123456789';
begin
  // 跳过星期，这个可以直接通过日期计算出来，不需要
  SkipUntilW(p, Comma, WideChar(0));
  if p^ = #0 then
  begin
    Result := False;
    Exit;
  end
  else
    Inc(p);
  SkipUntilW(p, Digits, WideChar(0));
  d := 0;
  // 日期
  while (p^ >= '0') and (p^ <= '9') do
  begin
    d := d * 10 + Ord(p^) - Ord('0');
    Inc(p);
  end;
  if (d < 1) or (d > 31) then
  begin
    Result := False;
    Exit;
  end;
  SkipSpaceW(p);
  M := 0;
  for I := 0 to 11 do
  begin
    if StartWithW(p, PWideChar(MonthNames[I]), True) then
    begin
      M := I + 1;
      Break;
    end;
  end;
  if (M < 1) or (M > 12) then
  begin
    Result := False;
    Exit;
  end;
  while (p^ <> #0) and ((p^ < '0') or (p^ > '9')) do
    Inc(p);
  Y := 0;
  while (p^ >= '0') and (p^ <= '9') do
  begin
    Y := Y * 10 + Ord(p^) - Ord('0');
    Inc(p);
  end;
  while p^ = ' ' do
    Inc(p);
  H := 0;
  while (p^ >= '0') and (p^ <= '9') do
  begin
    H := H * 10 + Ord(p^) - Ord('0');
    Inc(p);
  end;
  while p^ = ':' do
    Inc(p);
  N := 0;
  while (p^ >= '0') and (p^ <= '9') do
  begin
    N := N * 10 + Ord(p^) - Ord('0');
    Inc(p);
  end;
  while p^ = ':' do
    Inc(p);
  S := 0;
  while (p^ >= '0') and (p^ <= '9') do
  begin
    S := S * 10 + Ord(p^) - Ord('0');
    Inc(p);
  end;
  while p^ = ':' do
    Inc(p);
  Result := TryEncodeDateTime(Y, M, d, H, N, S, 0, AResult);
end;

function RollupSize(ASize: Int64): QStringW;
var
  AIdx, R1, s1: Int64;
  AIsNeg: Boolean;
const
  Units: array [0 .. 3] of QStringW = ('GB', 'MB', 'KB', 'B');
begin
  AIsNeg := (ASize < 0);
  AIdx := 3;
  R1 := 0;
  if AIsNeg then
    ASize := -ASize;
  Result := '';
  while (AIdx >= 0) do
  begin
    s1 := ASize mod 1024;
    ASize := ASize shr 10;
    if (ASize = 0) or (AIdx = 0) then
    begin
      R1 := R1 * 100 div 1024;
      if R1 > 0 then
      begin
        if R1 >= 10 then
          Result := IntToStr(s1) + '.' + IntToStr(R1) + Units[AIdx]
        else
          Result := IntToStr(s1) + '.' + '0' + IntToStr(R1) + Units[AIdx];
      end
      else
        Result := IntToStr(s1) + Units[AIdx];
      Break;
    end;
    R1 := s1;
    Dec(AIdx);
  end;
  if AIsNeg then
    Result := '-' + Result;
end;

function RollupTime(ASeconds: Int64; AHideZero: Boolean): QStringW;
var
  H, N, d: Integer;
begin
  if ASeconds = 0 then
  begin
    if AHideZero then
      Result := ''
    else
      Result := '0' + SSecondName;
  end
  else
  begin
    Result := '';
    d := ASeconds div 86400;
    ASeconds := ASeconds mod 86400;
    H := ASeconds div 3600;
    ASeconds := ASeconds mod 3600;
    N := ASeconds div 60;
    ASeconds := ASeconds mod 60;
    if d > 0 then
      Result := IntToStr(d) + SDayName
    else
      Result := '';
    if H > 0 then
      Result := Result + IntToStr(H) + SHourName;
    if N > 0 then
      Result := Result + IntToStr(N) + SMinuteName;
    if ASeconds > 0 then
      Result := Result + IntToStr(ASeconds) + SSecondName;
  end;
end;
{ QStringA }

function QStringA.From(p: PQCharA; AOffset, ALen: Integer): PQStringA;
begin
  SetLength(ALen);
  Inc(p, AOffset);
  Move(p^, PQCharA(@FValue[1])^, ALen);
  Result := @Self;
end;

function QStringA.From(const S: QStringA; AOffset: Integer): PQStringA;
begin
  Result := From(PQCharA(S), AOffset, S.Length);
end;

function QStringA.GetChars(AIndex: Integer): QCharA;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise Exception.CreateFmt(SOutOfIndex, [AIndex, 0, Length - 1]);
  Result := FValue[AIndex + 1];
end;

function QStringA.GetData: PByte;
begin
  Result := @FValue[1];
end;

class operator QStringA.Implicit(const S: QStringW): QStringA;
begin
  Result := qstring.AnsiEncode(S);
end;

class operator QStringA.Implicit(const S: QStringA): Pointer;
begin
  Result := PQCharA(@S.FValue[1]);
end;

function QStringA.GetIsUtf8: Boolean;
begin
  if System.Length(FValue) > 0 then
    Result := (FValue[0] = 1)
  else
    Result := False;
end;

function QStringA.GetLength: Integer;
begin
  // QStringA.FValue[0]存贮编码类型，0-ANSI,1-UTF8，末尾存贮字符串的\0结束符
  Result := System.Length(FValue);
  if Result >= 2 then
    Dec(Result, 2)
  else
    Result := 0;
end;

class operator QStringA.Implicit(const S: QStringA): TBytes;
var
  l: Integer;
begin
  l := System.Length(S.FValue) - 1;
  System.SetLength(Result, l);
  if l > 0 then
    Move(S.FValue[1], Result[0], l);
end;

procedure QStringA.SetChars(AIndex: Integer; const Value: QCharA);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise Exception.CreateFmt(SOutOfIndex, [AIndex, 0, Length - 1]);
  FValue[AIndex + 1] := Value;
end;

procedure QStringA.SetLength(const Value: Integer);
begin
  if Value < 0 then
  begin
    if System.Length(FValue) > 0 then
      System.SetLength(FValue, 1)
    else
    begin
      System.SetLength(FValue, 1);
      FValue[0] := 0; // ANSI
    end;
  end
  else
  begin
    System.SetLength(FValue, Value + 2);
    FValue[Value + 1] := 0;
  end;
end;

class operator QStringA.Implicit(const ABytes: TBytes): QStringA;
var
  l: Integer;
begin
  l := System.Length(ABytes);
  Result.Length := l;
  if l > 0 then
    Move(ABytes[0], Result.FValue[1], l);
end;

class operator QStringA.Implicit(const S: QStringA): QStringW;
begin
  Result := AnsiDecode(S);
end;

function BinToHex(p: Pointer; l: Integer; ALowerCase: Boolean): QStringW;
const
  B2HConvert: array [0 .. 15] of QCharW = ('0', '1', '2', '3', '4', '5', '6',
    '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
  B2HConvertL: array [0 .. 15] of QCharW = ('0', '1', '2', '3', '4', '5', '6',
    '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
var
  pd: PQCharW;
  pb: PByte;
begin
  SetLength(Result, l shl 1);
  pd := PQCharW(Result);
  pb := p;
  if ALowerCase then
  begin
    while l > 0 do
    begin
      pd^ := B2HConvertL[pb^ shr 4];
      Inc(pd);
      pd^ := B2HConvertL[pb^ and $0F];
      Inc(pd);
      Inc(pb);
      Dec(l);
    end;
  end
  else
  begin
    while l > 0 do
    begin
      pd^ := B2HConvert[pb^ shr 4];
      Inc(pd);
      pd^ := B2HConvert[pb^ and $0F];
      Inc(pd);
      Inc(pb);
      Dec(l);
    end;
  end;
end;

function BinToHex(const ABytes: TBytes; ALowerCase: Boolean): QStringW;
begin
  Result := BinToHex(@ABytes[0], Length(ABytes), ALowerCase);
end;

procedure HexToBin(const S: QStringW; var AResult: TBytes);
var
  l: Integer;
  p, ps: PQCharW;
  pd: PByte;
begin
  l := System.Length(S);
  SetLength(AResult, l shr 1);
  p := PQCharW(S);
  ps := p;
  pd := @AResult[0];
  while p - ps < l do
  begin
    if IsHexChar(p[0]) and IsHexChar(p[1]) then
    begin
      pd^ := (HexValue(p[0]) shl 4) + HexValue(p[1]);
      Inc(pd);
      Inc(p, 2);
    end
    else
    begin
      SetLength(AResult, 0);
      Exit;
    end;
  end;
end;

function HexToBin(const S: QStringW): TBytes;
begin
  HexToBin(S, Result);
end;

procedure FreeObject(AObject: TObject);
begin
{$IFDEF AUTOREFCOUNT}
  AObject.DisposeOf;
{$ELSE}
  AObject.Free;
{$ENDIF}
end;

function HashOf(p: Pointer; l: Integer): Cardinal;
{$IFDEF WIN32}
label A00;
begin
  asm
    push ebx
    xor    eax, eax
    mov    edx, p
    mov    ebx,edx
    add    ebx,l
    A00:
    imul   eax,131
    movzx  ecx, BYTE ptr [edx]
    inc    edx
    add    eax, ecx
    cmp   ebx, edx
    jne    A00
    pop ebx
    mov Result,eax
  end;
{$ELSE}
var
  pe: PByte;
  ps: PByte absolute p;
const
  seed = 131; // 31 131 1313 13131 131313 etc..
begin
  pe := p;
  Inc(pe, l);
  Result := 0;
  while IntPtr(ps) < IntPtr(pe) do
  begin
    Result := Result * seed + ps^;
    Inc(ps);
  end;
  Result := Result and $7FFFFFFF;
{$ENDIF}
end;

class operator QStringA.Implicit(const S: PQCharA): QStringA;
var
  p: PQCharA;
begin
  if S <> nil then
  begin
    p := S;
    while p^ <> 0 do
      Inc(p);
    Result.Length := IntPtr(p) - IntPtr(S);
    Move(S^, PQCharA(Result)^, Result.Length);
  end
  else
    Result.Length := 0;
end;
{$IFNDEF NEXTGEN}

class operator QStringA.Implicit(const S: AnsiString): QStringA;
begin
  Result.From(PQCharA(S), 0, System.Length(S));
end;

class operator QStringA.Implicit(const S: QStringA): AnsiString;
begin
  System.SetLength(Result, S.Length);
  if S.Length > 0 then
    Move(PQCharA(S)^, PAnsiChar(Result)^, S.Length);
end;
{$ENDIF}

function QStringA.Cat(p: PQCharA; ALen: Integer): PQStringA;
var
  l: Integer;
begin
  l := Length;
  SetLength(l + ALen);
  Move(p^, FValue[1 + l], ALen);
  Result := @Self;
end;

function QStringA.Cat(const S: QStringA): PQStringA;
begin
  Result := Cat(PQCharA(S), S.Length);
end;

{ TQStringCatHelperW }

function TQStringCatHelperW.Back(ALen: Integer): TQStringCatHelperW;
begin
  Result := Self;
  Dec(FDest, ALen);
  if FDest < FStart then
    FDest := FStart;
end;

function TQStringCatHelperW.BackIf(const S: PQCharW): TQStringCatHelperW;
var
  ps: PQCharW;
begin
  Result := Self;
  ps := FStart;
  while FDest > ps do
  begin
    if (FDest[-1] >= #$DC00) and (FDest[-1] <= #$DFFF) then
    begin
      if CharInW(FDest - 2, S) then
        Dec(FDest, 2)
      else
        Break;
    end
    else if CharInW(FDest - 1, S) then
      Dec(FDest)
    else
      Break;
  end;
end;

function TQStringCatHelperW.Cat(const S: QStringW): TQStringCatHelperW;
begin
  Result := Cat(PQCharW(S), Length(S));
end;

function TQStringCatHelperW.Cat(p: PQCharW; len: Integer): TQStringCatHelperW;
begin
  Result := Self;
  if len < 0 then
  begin
    while p^ <> #0 do
    begin
      if Position >= FSize then
        NeedSize(FSize + FBlockSize);
      FDest^ := p^;
      Inc(p);
      Inc(FDest);
    end;
  end
  else
  begin
    NeedSize(-len);
    Move(p^, FDest^, len shl 1);
    Inc(FDest, len);
  end;
end;

function TQStringCatHelperW.Cat(c: QCharW): TQStringCatHelperW;
begin
  if Position >= FSize then
    NeedSize(-1);
  FDest^ := c;
  Inc(FDest);
  Result := Self;
end;

function TQStringCatHelperW.Cat(const V: Double): TQStringCatHelperW;
begin
  Result := Cat(FloatToStr(V));
end;

function TQStringCatHelperW.Cat(const V: Int64): TQStringCatHelperW;
begin
  Result := Cat(IntToStr(V));
end;

function TQStringCatHelperW.Cat(const V: Boolean): TQStringCatHelperW;
begin
  Result := Cat(BoolToStr(V, True));
end;

function TQStringCatHelperW.Cat(const V: TGuid): TQStringCatHelperW;
begin
  Result := Cat(GuidToString(V));
end;

function TQStringCatHelperW.Cat(const V: Currency): TQStringCatHelperW;
begin
  Result := Cat(CurrToStr(V));
end;

constructor TQStringCatHelperW.Create(ASize: Integer);
begin
  inherited Create;
  if ASize < 8192 then
    ASize := 8192
  else if (ASize and $3FF) <> 0 then
    ASize := ((ASize shr 10) + 1) shr 1;
  FBlockSize := ASize;
  NeedSize(FBlockSize);
end;

constructor TQStringCatHelperW.Create;
begin
  inherited Create;
  FBlockSize := 8192;
  NeedSize(FBlockSize);
end;

function TQStringCatHelperW.GetChars(AIndex: Integer): QCharW;
begin
  Result := FStart[AIndex];
end;

function TQStringCatHelperW.GetPosition: Integer;
begin
  Result := FDest - FStart;
end;

function TQStringCatHelperW.GetValue: QStringW;
var
  l: Integer;
begin
  l := Position;
  SetLength(Result, l);
  Move(FStart^, PQCharW(Result)^, l shl 1);
end;

procedure TQStringCatHelperW.LoadFromFile(const AFileName: QStringW);
begin
  Reset;
  Cat(LoadTextW(AFileName));
end;

procedure TQStringCatHelperW.LoadFromStream(const AStream: TStream);
begin
  Reset;
  Cat(LoadTextW(AStream));
end;

procedure TQStringCatHelperW.NeedSize(ASize: Integer);
var
  Offset: Integer;
begin
  Offset := FDest - FStart;
  if ASize < 0 then
    ASize := Offset - ASize;
  if ASize > FSize then
  begin
{$IFDEF DEBUG}
    Inc(FAllocTimes);
{$ENDIF}
    FSize := ((ASize + FBlockSize) div FBlockSize) * FBlockSize;
    SetLength(FValue, FSize);
    FStart := PQCharW(@FValue[0]);
    FDest := FStart + Offset;
  end;
end;

function TQStringCatHelperW.Replicate(const S: QStringW; count: Integer)
  : TQStringCatHelperW;
var
  ps: PQCharW;
  l: Integer;
begin
  Result := Self;
  if count > 0 then
  begin
    ps := PQCharW(S);
    l := Length(S);
    while count > 0 do
    begin
      Cat(ps, l);
      Dec(count);
    end;
  end;
end;

procedure TQStringCatHelperW.Reset;
begin
  FDest := FStart;
end;

procedure TQStringCatHelperW.SetPosition(const Value: Integer);
begin
  if Value <= 0 then
    FDest := FStart
  else if Value > Length(FValue) then
  begin
    NeedSize(Value);
    FDest := FStart + Value;
  end
  else
    FDest := FStart + Value;
end;

procedure TQStringCatHelperW.TrimRight;
var
  pd: PQCharW;
begin
  pd := FDest;
  Dec(pd);
  while FStart < pd do
  begin
    if IsSpaceW(pd) then
      Dec(pd)
    else
      Break;
  end;
  Inc(pd);
  FDest := pd;
end;

function TQStringCatHelperW.Cat(const V: Variant): TQStringCatHelperW;
begin
  Result := Cat(VarToStr(V));
end;

{ TQPtr }

class function TQPtr.Bind(AObject: TObject): IQPtr;
begin
  Result := TQPtr.Create(AObject);
end;

class function TQPtr.Bind(AData: Pointer; AOnFree: TQPtrFreeEventG): IQPtr;
var
  ATemp: TQPtr;
begin
  ATemp := TQPtr.Create(AData);
  ATemp.FOnFree.Method.Data := nil;
  ATemp.FOnFree.OnFreeG := AOnFree;
  Result := ATemp;
end;

class function TQPtr.Bind(AData: Pointer; AOnFree: TQPtrFreeEvent): IQPtr;
var
  ATemp: TQPtr;
begin
  ATemp := TQPtr.Create(AData);
{$IFDEF NEXTGEN}
  PQPtrFreeEvent(@ATemp.FOnFree.OnFree)^ := AOnFree;
{$ELSE}
  ATemp.FOnFree.OnFree := AOnFree;
{$ENDIF}
  Result := ATemp;
end;

{$IFDEF UNICODE}

class function TQPtr.Bind(AData: Pointer; AOnFree: TQPtrFreeEventA): IQPtr;
var
  ATemp: TQPtr;
begin
  ATemp := TQPtr.Create(AData);
  ATemp.FOnFree.Method.Data := Pointer(-1);
  TQPtrFreeEventA(ATemp.FOnFree.OnFreeA) := AOnFree;
  Result := ATemp;
end;
{$ENDIF}

constructor TQPtr.Create(AObject: Pointer);
begin
  inherited Create;
  FObject := AObject;
end;

destructor TQPtr.Destroy;
begin
  if Assigned(FObject) then
  begin
    if Assigned(FOnFree.OnFree) then
    begin
      if FOnFree.Method.Data = nil then
        FOnFree.OnFreeG(FObject)
{$IFDEF UNICODE}
      else if FOnFree.Method.Data = Pointer(-1) then
        TQPtrFreeEventA(FOnFree.OnFreeA)(FObject)
{$ENDIF}
      else
{$IFDEF NEXTGEN}
      begin
        PQPtrFreeEvent(FOnFree.OnFree)^(FObject);
        PQPtrFreeEvent(FOnFree.OnFree)^ := nil;
      end;
{$ELSE}
      FOnFree.OnFree(FObject);
{$ENDIF}
    end
    else
      FreeAndNil(FObject);
  end;
  inherited;
end;

function TQPtr.Get: Pointer;
begin
  Result := FObject;
end;

// 兼容2007版的原子操作接口
{$IF RTLVersion<24}

function AtomicCmpExchange(var Target: Integer; Value: Integer;
  Comparand: Integer): Integer; inline;
begin
{$IFDEF MSWINDOWS}
  Result := InterlockedCompareExchange(Target, Value, Comparand);
{$ELSE}
  Result := TInterlocked.CompareExchange(Target, Value, Comparand);
{$ENDIF}
end;

function AtomicCmpExchange(var Target: Pointer; Value: Pointer;
  Comparand: Pointer): Pointer; inline;
begin
{$IFDEF MSWINDOWS}
  Result := Pointer(InterlockedCompareExchange(PInteger(Target)^,
    Integer(Value), Integer(Comparand)));
{$ELSE}
  Result := TInterlocked.CompareExchange(Target, Value, Comparand);
{$ENDIF}
end;

function AtomicIncrement(var Target: Integer; const Value: Integer)
  : Integer; inline;
begin
{$IFDEF MSWINDOWS}
  if Value = 1 then
    Result := InterlockedIncrement(Target)
  else if Value = -1 then
    Result := InterlockedDecrement(Target)
  else
    Result := InterlockedExchangeAdd(Target, Value);
{$ELSE}
  if Value = 1 then
    Result := TInterlocked.Increment(Target)
  else if Value = -1 then
    Result := TInterlocked.Decrement(Target)
  else
    Result := TInterlocked.Add(Target, Value);
{$ENDIF}
end;

function AtomicDecrement(var Target: Integer): Integer; inline;
begin
  // Result := InterlockedDecrement(Target);
  Result := AtomicIncrement(Target, -1);
end;

function AtomicExchange(var Target: Integer; Value: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := InterlockedExchange(Target, Value);
{$ELSE}
  Result := TInterlocked.Exchange(Target, Value);
{$ENDIF}
end;

function AtomicExchange(var Target: Pointer; Value: Pointer): Pointer;
begin
{$IFDEF MSWINDOWS}
{$IF RTLVersion>19}
  Result := InterlockedExchangePointer(Target, Value);
{$ELSE}
  Result := Pointer(IntPtr(InterlockedExchange(IntPtr(Target), IntPtr(Value))));
{$IFEND}
{$ELSE}
  Result := TInterlocked.Exchange(Target, Value);
{$ENDIF}
end;
{$IFEND <XE5}

// 位与，返回原值
function AtomicAnd(var Dest: Integer; const AMask: Integer): Integer; inline;
var
  I: Integer;
begin
  repeat
    Result := Dest;
    I := Result and AMask;
  until AtomicCmpExchange(Dest, I, Result) = Result;
end;

// 位或，返回原值
function AtomicOr(var Dest: Integer; const AMask: Integer): Integer; inline;
var
  I: Integer;
begin
  repeat
    Result := Dest;
    I := Result or AMask;
  until AtomicCmpExchange(Dest, I, Result) = Result;
end;

{ TQBytesCatHelper }

function TQBytesCatHelper.Back(ALen: Integer): TQBytesCatHelper;
begin
  Result := Self;
  Dec(FDest, ALen);
  if IntPtr(FDest) < IntPtr(FStart) then
    FDest := FStart;
end;

function TQBytesCatHelper.Cat(const V: Double): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Double));
end;

function TQBytesCatHelper.Cat(const V: Currency): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Currency));
end;

function TQBytesCatHelper.Cat(const V: Boolean): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Boolean));
end;

function TQBytesCatHelper.Cat(const S: QStringW): TQBytesCatHelper;
begin
  Result := Cat(PQCharW(S), System.Length(S) shl 1);
end;

function TQBytesCatHelper.Cat(const V: Byte): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Byte));
end;

function TQBytesCatHelper.Cat(const V: Int64): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Int64));
end;

function TQBytesCatHelper.Cat(const c: QCharW): TQBytesCatHelper;
begin
  Result := Cat(@c, SizeOf(QCharW));
end;

function TQBytesCatHelper.Cat(const V: Variant): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Variant));
end;

function TQBytesCatHelper.Cat(const V: QStringA; ACStyle: Boolean)
  : TQBytesCatHelper;
begin
  if ACStyle then
    Result := Cat(PQCharA(V), V.Length + 1)
  else
    Result := Cat(PQCharA(V), V.Length);
end;

{$IFNDEF NEXTGEN}

function TQBytesCatHelper.Cat(const V: AnsiChar): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(AnsiChar));
end;

function TQBytesCatHelper.Cat(const V: AnsiString): TQBytesCatHelper;
begin
  Result := Cat(PAnsiChar(V), System.Length(V));
end;
{$ENDIF}

function TQBytesCatHelper.Cat(const V: Single): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Single));
end;

function TQBytesCatHelper.Cat(const V: Cardinal): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Cardinal));
end;

function TQBytesCatHelper.Cat(const V: Smallint): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Smallint));
end;

function TQBytesCatHelper.Cat(const V: Word): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Word));
end;

function TQBytesCatHelper.Cat(const V: Shortint): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Shortint));
end;

function TQBytesCatHelper.Cat(const V: Integer): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(Integer));
end;

function TQBytesCatHelper.Cat(const ABytes: TBytes): TQBytesCatHelper;
begin
  if Length(ABytes) > 0 then
    Result := Cat(@ABytes[0], Length(ABytes))
  else
    Result := Self;
end;

function TQBytesCatHelper.Cat(const AData: Pointer; const ALen: Integer)
  : TQBytesCatHelper;
begin
  Result := Self;
  NeedSize(-ALen);
  Move(AData^, FDest^, ALen);
  Inc(FDest, ALen);
end;

function TQBytesCatHelper.Cat(const V: TGuid): TQBytesCatHelper;
begin
  Result := Cat(@V, SizeOf(TGuid));
end;

constructor TQBytesCatHelper.Create(ASize: Integer);
begin
  inherited Create;
  FBlockSize := ASize;
  NeedSize(FBlockSize);
end;

constructor TQBytesCatHelper.Create;
begin
  inherited Create;
  FBlockSize := 8192;
  NeedSize(FBlockSize);
end;

function TQBytesCatHelper.GetBytes(AIndex: Integer): Byte;
begin
  Result := FValue[AIndex];
end;

function TQBytesCatHelper.GetPosition: Integer;
begin
  Result := IntPtr(FDest) - IntPtr(FStart);
end;

procedure TQBytesCatHelper.NeedSize(ASize: Integer);
var
  Offset: Integer;
begin
  Offset := IntPtr(FDest) - IntPtr(FStart);
  if ASize < 0 then
    ASize := Offset - ASize;
  if ASize > FSize then
  begin
    FSize := ((ASize + FBlockSize) div FBlockSize) * FBlockSize;
    SetLength(FValue, FSize);
    FStart := @FValue[0];
    FDest := PByte(IntPtr(FStart) + Offset);
  end;
end;

function TQBytesCatHelper.Replicate(const ABytes: TBytes; ACount: Integer)
  : TQBytesCatHelper;
var
  l: Integer;
begin
  Result := Self;
  l := Length(ABytes);
  if l > 0 then
  begin
    NeedSize(-l * ACount);
    while ACount > 0 do
    begin
      Move(ABytes[0], FDest^, l);
      Inc(FDest, l);
      Dec(ACount);
    end;
  end;
end;

procedure TQBytesCatHelper.Reset;
begin
  FDest := FStart;
end;

procedure TQBytesCatHelper.SetCapacity(const Value: Integer);
begin
  if FSize <> Value then
    NeedSize(Value);
end;

procedure TQBytesCatHelper.SetPosition(const Value: Integer);
begin
  if Value <= 0 then
    FDest := FStart
  else if Value > Length(FValue) then
  begin
    NeedSize(Value);
    FDest := Pointer(IntPtr(FStart) + Value);
  end
  else
    FDest := Pointer(IntPtr(FStart) + Value);
end;

function NewId: TGuid;
begin
  CreateGUID(Result);
end;

function SameId(const V1, V2: TGuid): Boolean;
var
  I1: array [0 .. 1] of Int64 absolute V1;
  I2: array [0 .. 1] of Int64 absolute V2;
begin
  Result := (I1[0] = I2[0]) and (I1[1] = I2[1]);
end;

function StrLikeX(var S: PQCharW; pat: PQCharW; AIgnoreCase: Boolean): PQCharW;
const
  CHAR_DIGITS = -1;
  CHAR_NODIGITS = -2;
  CHAR_SPACES = -3;
  CHAR_NOSPACES = -4;
var
  Accept: Boolean;
  ACharCode, AEndCode: Integer;
  AToken: QStringW;
  ps, pt, os: PQCharW;
  // >0 正常的字符编码
  // <0 特殊范围
  function Unescape(var t: PQCharW): Integer;
  begin
    if t^ = '\' then
    begin
      Inc(t);
      case t^ of
        'b':
          begin
            Inc(t);
            Result := 7;
          end;
        'd':
          begin
            Inc(t);
            Result := CHAR_DIGITS;
          end;
        'D':
          begin
            Inc(t);
            Result := CHAR_NODIGITS;
          end;
        'r':
          begin
            Inc(t);
            Result := 13;
          end;
        'n':
          begin
            Inc(t);
            Result := 10;
          end;
        't':
          begin
            Inc(t);
            Result := 9;
          end;
        'f': // \f
          begin
            Inc(t);
            Result := 12;
          end;
        'v': // \v
          begin
            Inc(t);
            Result := 11;
          end;
        's': // 空白字符
          begin
            Inc(t);
            Result := CHAR_SPACES;
          end;
        'S': // 非空白
          begin
            Inc(t);
            Result := CHAR_NOSPACES;
          end;
        'u': // Unicode字符
          begin
            if IsHexChar(t[1]) and IsHexChar(t[2]) and IsHexChar(t[3]) and
              IsHexChar(t[4]) then
            begin
              Result := (HexValue(t[1]) shl 12) or (HexValue(t[2]) shl 8) or
                (HexValue(t[3]) shl 4) or HexValue(t[4]);
              Inc(t, 5);
            end
            else
              raise Exception.CreateFmt(SCharNeeded,
                ['0-9A-Fa-f', StrDupW(t, 0, 4)]);
          end
      else
        begin
          Inc(t);
          Result := Ord(S^);
        end;
      end;
    end
    else
    begin
      Result := Ord(t^);
    end
  end;

  function IsDigit: Boolean;
  begin
    Result := ((S^ >= '0') and (S^ <= '9')) or
      ((S^ >= #65296) and (S^ <= #65305));
  end;
  function IsMatch(AStart, AEnd: Integer): Boolean;
  var
    ACode: Integer;
  begin
    case AStart of
      CHAR_DIGITS:
        Result := IsDigit;
      CHAR_NODIGITS:
        Result := not IsDigit;
      CHAR_SPACES:
        Result := IsSpaceW(S);
      CHAR_NOSPACES:
        Result := not IsSpaceW(S)
    else
      begin
        ACode := Ord(S^);
        Result := (ACode >= AStart) and (ACode <= AEnd);
        if (not Result) and AIgnoreCase then
        begin
          ACode := Ord(CharUpperW(S^));
          Result := (ACode >= AStart) and (ACode <= AEnd);
        end;
        // 如果是扩展区字符，需要两个连续的转义
        if Result and ((ACode >= $D800) and (ACode <= $DFFF)) then
        begin
          Inc(S);
          if pat^ = '\' then
          begin
            ACode := Unescape(pat);
            Result := Ord(S^) = ACode;
          end
          else
            Result := False;
        end;
      end;
    end;
  end;

  function IsIn: Boolean;
  const
    SetEndChar: PQCharW = ']';
  begin
    Result := False;
    while (pat^ <> #0) and (pat^ <> ']') do
    begin
      ACharCode := Unescape(pat);
      if pat^ = '-' then // a-z这种范围
      begin
        Inc(pat);
        if pat^ <> ']' then
          AEndCode := Unescape(pat)
        else
        begin
          raise Exception.Create(SRangeEndNeeded);
        end;
      end
      else
        AEndCode := ACharCode;
      Result := IsMatch(ACharCode, AEndCode);
      if Result then // 在其中的话，忽略掉后面的判定
      begin
        Inc(S);
        SkipUntilW(pat, SetEndChar);
        if pat^ <> ']' then
          raise Exception.CreateFmt(SCharNeeded, [']']);
      end
      else
        Inc(pat);
    end;
  end;

begin
  // SQL Like 语法：
  // _ 代表一个字符
  // % * 代表任意字符
  // [字符列表] 列表中任意字符
  // [^字符列表]/[!字符列表] 非列表中任意字符
  // 以下为QDAC扩展
  // \ 转义
  // \d 数字（全角和半角）
  // \D 非数字（含全角）
  // \s 空白字符
  // \S 非空白字符
  os := S;
  Result := nil;
  while (pat^ <> #0) and (S^ <> #0) do
  begin
    case pat^ of
      '_':
        begin
          Inc(S, CharSizeW(S));
          Inc(pat);
        end;
      '[': // 字符列表
        begin
          Inc(pat);
          if (pat^ = '!') or (pat^ = '^') then
          begin
            Inc(pat);
            Accept := not IsIn;
          end
          else
            Accept := IsIn;
          if pat^ = ']' then
          begin
            Inc(pat);
          end;
          if not Accept then
            Exit;
        end;
      '\':
        begin
          ACharCode := Unescape(pat);
          if not IsMatch(ACharCode, ACharCode) then
            Exit
          else
            Inc(S);
        end;
      '*', '%':
        begin
          Inc(pat);
          // 匹配任意长度的任意字符
          if pat^ = #0 then
          begin
            Result := os;
            while S^ <> #0 do
              Inc(S);
            Exit;
          end
          else
          begin
            // 多个连续的*或%号视为
            while (pat^ = '%') or (pat^ = '*') do
              Inc(pat);
            ps := pat;
            // 找到下一个任意匹配规则边界
            while (pat^ <> #0) and (pat^ <> '*') do
              Inc(pat);
            // 匹配子串及剩余部分
            AToken := StrDupX(ps, (IntPtr(pat) - IntPtr(ps)) shr 1);
            repeat
              pt := S;
              ps := StrLikeX(S, PQCharW(AToken), AIgnoreCase);
              if ps <> nil then
              begin
                if (pat^ <> #0) and (StrLikeX(S, pat, AIgnoreCase) = nil) then
                begin
                  Inc(pt);
                  S := pt;
                end
                else
                begin
                  Result := os;
                  while S^ <> #0 do
                    Inc(S);
                  Exit;
                end;
              end
              else
              begin
                Inc(pt);
                S := pt;
              end;
            until (S^ = #0);
            // 如果上面没有匹配到，说明失败了
            Exit;
          end;
        end
    else // 普通字符的比较
      begin
        if not IsMatch(Ord(pat^), Ord(pat^)) then
          Exit;
        Inc(S);
        Inc(pat);
      end;
    end;
  end;
  if (pat^ = '%') or (pat^ = '*') then // 模式匹配
    Inc(pat);
  if pat^ = #0 then
    Result := os;
end;

function StrLikeW(S, pat: PQCharW; AIgnoreCase: Boolean): Boolean;
var
  ps: PQCharW;
begin
  ps := S;
  Result := (StrLikeX(S, pat, AIgnoreCase) = ps) and (S^ = #0);
end;

{ TQPagedList }

function TQPagedList.Add(const p: Pointer): Integer;
begin
  if Assigned(FOnCompare) then
  begin
    Find(p, Result);
    Insert(Result, p);
  end
  else
  begin
    Result := FCount;
    Insert(FCount, p);
  end;
end;
{$IF RTLVersion<26}

procedure TQPagedList.Assign(ListA: TList; AOperator: TListAssignOp;
  ListB: TList);
var
  I: Integer;
  LTemp: TQPagedList;
  LSource: TList;
begin
  // ListB given?
  if ListB <> nil then
  begin
    LSource := ListB;
    Assign(ListA);
  end
  else
    LSource := ListA;

  // on with the show
  case AOperator of

    // 12345, 346 = 346 : only those in the new list
    laCopy:
      begin
        Clear;
        for I := 0 to LSource.count - 1 do
          Add(LSource[I]);
      end;

    // 12345, 346 = 34 : intersection of the two lists
    laAnd:
      for I := count - 1 downto 0 do
        if LSource.IndexOf(Items[I]) = -1 then
          Delete(I);

    // 12345, 346 = 123456 : union of the two lists
    laOr:
      for I := 0 to LSource.count - 1 do
        if IndexOf(LSource[I]) = -1 then
          Add(LSource[I]);

    // 12345, 346 = 1256 : only those not in both lists
    laXor:
      begin
        LTemp := TQPagedList.Create; // Temp holder of 4 byte values
        try
          for I := 0 to LSource.count - 1 do
            if IndexOf(LSource[I]) = -1 then
              LTemp.Add(LSource[I]);
          for I := count - 1 downto 0 do
            if LSource.IndexOf(Items[I]) <> -1 then
              Delete(I);
          I := count + LTemp.count;
          if Capacity < I then
            Capacity := I;
          for I := 0 to LTemp.count - 1 do
            Add(LTemp[I]);
        finally
          LTemp.Free;
        end;
      end;

    // 12345, 346 = 125 : only those unique to source
    laSrcUnique:
      for I := count - 1 downto 0 do
        if LSource.IndexOf(Items[I]) <> -1 then
          Delete(I);

    // 12345, 346 = 6 : only those unique to dest
    laDestUnique:
      begin
        LTemp := TQPagedList.Create;
        try
          for I := LSource.count - 1 downto 0 do
            if IndexOf(LSource[I]) = -1 then
              LTemp.Add(LSource[I]);
          Assign(LTemp);
        finally
          LTemp.Free;
        end;
      end;
  end;
end;
{$IFEND}

procedure TQPagedList.Assign(ListA: TQPagedList; AOperator: TListAssignOp;
  ListB: TQPagedList);
var
  I: Integer;
  LTemp, LSource: TQPagedList;
begin
  // ListB given?
  if ListB <> nil then
  begin
    LSource := ListB;
    Assign(ListA);
  end
  else
    LSource := ListA;
  case AOperator of
    // 12345, 346 = 346 : only those in the new list
    laCopy:
      begin
        Clear;
        for I := 0 to LSource.count - 1 do
          Add(LSource[I]);
      end;
    // 12345, 346 = 34 : intersection of the two lists
    laAnd:
      for I := count - 1 downto 0 do
        if LSource.IndexOf(Items[I]) = -1 then
          Delete(I);
    // 12345, 346 = 123456 : union of the two lists
    laOr:
      for I := 0 to LSource.count - 1 do
        if IndexOf(LSource[I]) = -1 then
          Add(LSource[I]);
    // 12345, 346 = 1256 : only those not in both lists
    laXor:
      begin
        LTemp := TQPagedList.Create; // Temp holder of 4 byte values
        try
          for I := 0 to LSource.count - 1 do
            if IndexOf(LSource[I]) = -1 then
              LTemp.Add(LSource[I]);
          for I := count - 1 downto 0 do
            if LSource.IndexOf(Items[I]) <> -1 then
              Delete(I);
          I := count + LTemp.count;
          if Capacity < I then
            Capacity := I;
          for I := 0 to LTemp.count - 1 do
            Add(LTemp[I]);
        finally
          LTemp.Free;
        end;
      end;

    // 12345, 346 = 125 : only those unique to source
    laSrcUnique:
      for I := count - 1 downto 0 do
        if LSource.IndexOf(Items[I]) <> -1 then
          Delete(I);

    // 12345, 346 = 6 : only those unique to dest
    laDestUnique:
      begin
        LTemp := TQPagedList.Create;
        try
          for I := LSource.count - 1 downto 0 do
            if IndexOf(LSource[I]) = -1 then
              LTemp.Add(LSource[I]);
          Assign(LTemp);
        finally
          LTemp.Free;
        end;
      end;
  end;
end;

procedure TQPagedList.CheckLastPage;
begin
  while (FLastUsedPage > 0) and (FPages[FLastUsedPage].FUsedCount = 0) do
    Dec(FLastUsedPage);
end;

procedure TQPagedList.Clear;
var
  I: Integer;
  J: Integer;
begin
  for I := 0 to High(FPages) do
  begin
    for J := 0 to FPages[I].FUsedCount - 1 do
      DoDelete(FPages[I].FItems[J]);
    FPages[I].FUsedCount := 0;
  end;
  FFirstDirtyPage := 1;
  if Length(FPages) > 0 then
    FLastUsedPage := 0
  else
    FLastUsedPage := -1;
  FCount := 0;
end;

procedure TQPagedList.Pack;
var
  ASource, ADest, AToMove: Integer;
  procedure PackPages(AStartPage: Integer);
  var
    I: Integer;
  begin
    for I := AStartPage to High(FPages) do
      FreeAndNil(FPages[I]);
    SetLength(FPages, AStartPage);
    FLastUsedPage := High(FPages);
  end;

begin
  if count > 0 then
  begin
    if Length(FPages) = 1 then // 只有1页，不需要收缩
      Exit;
    ADest := 0;
    for ASource := 1 to High(FPages) do
    begin
      if FPages[ADest].FUsedCount < FPageSize then
      begin
        AToMove := FPages[ASource].FUsedCount;
        if AToMove > FPageSize - FPages[ADest].FUsedCount then
          AToMove := FPageSize - FPages[ADest].FUsedCount;
        if AToMove > 0 then
        begin
          System.Move(FPages[ASource].FItems[0],
            FPages[ADest].FItems[FPages[ADest].FUsedCount],
            AToMove * SizeOf(Pointer));
          Inc(FPages[ADest].FUsedCount, AToMove);
          if FPages[ASource].FUsedCount > AToMove then
            System.Move(FPages[ASource].FItems[AToMove],
              FPages[ASource].FItems[0], (FPages[ASource].FUsedCount - AToMove)
              * SizeOf(Pointer));
          Dec(FPages[ASource].FUsedCount, AToMove);
          FPages[ASource].FStartIndex := FPages[ADest].FStartIndex +
            FPages[ADest].FUsedCount;
          Inc(ADest);
        end;
      end;
    end;
    if FPages[ADest].FUsedCount = 0 then
      PackPages(ADest)
    else
      PackPages(ADest + 1);
  end
  else
    PackPages(0);
end;

constructor TQPagedList.Create(APageSize: Integer);
begin
  inherited Create;
  if APageSize <= 0 then
    APageSize := 4096;
  FPageSize := APageSize;
  FLastUsedPage := -1;
end;

constructor TQPagedList.Create;
begin
  Create(4096);
end;

procedure TQPagedList.Delete(AIndex: Integer);
var
  APage: Integer;
begin
  APage := FindPage(AIndex);
  if APage >= 0 then
  begin
    Dec(AIndex, FPages[APage].FStartIndex);
    DoDelete(FPages[APage].FItems[AIndex]);
    System.Move(FPages[APage].FItems[AIndex + 1], FPages[APage].FItems[AIndex],
      SizeOf(Pointer) * (FPages[APage].FUsedCount - AIndex - 1));
    Dec(FPages[APage].FUsedCount);
    CheckLastPage;
    Dec(FCount);
    Dirty(APage + 1);
  end;
end;

destructor TQPagedList.Destroy;
var
  I: Integer;
begin
  Clear;
  for I := 0 to High(FPages) do
    FreeObject(FPages[I]);
{$IFDEF UNICODE}
  if Assigned(FOnCompare) and (TMethod(FOnCompare).Data = Pointer(-1)) then
    TQPagedListSortCompareA(TMethod(FOnCompare).Code) := nil;
{$ENDIF}
  inherited;
end;

procedure TQPagedList.Dirty(APage: Integer);
begin
  if APage < FFirstDirtyPage then
    FFirstDirtyPage := APage;
end;

function TQPagedList.DoCompare(p1, p2: Pointer): Integer;
begin
  case IntPtr(TMethod(FOnCompare).Data) of
    0: // 全局函数
      TQPagedListSortCompareG(TMethod(FOnCompare).Code)(p1, p2, Result);
{$IFDEF UNICODE}
    -1: // 匿名函数
      TQPagedListSortCompareA(TMethod(FOnCompare).Code)(p1, p2, Result)
{$ENDIF}
  else
    FOnCompare(p1, p2, Result);
  end;
end;

procedure TQPagedList.DoDelete(const p: Pointer);
begin
  if (p <> nil) and (ClassType <> TQPagedList) then
    Notify(p, lnDeleted);
end;

procedure TQPagedList.Exchange(AIndex1, AIndex2: Integer);
var
  p1, p2: Integer;
  t: Pointer;
begin
  p1 := FindPage(AIndex1);
  p2 := FindPage(AIndex2);
  if (p1 <> -1) and (p2 <> -1) then
  begin
    Dec(AIndex1, FPages[p1].FStartIndex);
    Dec(AIndex2, FPages[p2].FStartIndex);
    t := FPages[p1].FItems[AIndex1];
    FPages[p1].FItems[AIndex1] := FPages[p2].FItems[AIndex2];
    FPages[p2].FItems[AIndex2] := t;
  end;
end;

function TQPagedList.Expand: TQPagedList;
begin
  // 这个函数只是为兼容TList接口保留，TQPagedList不需要
  Result := Self;
end;

function TQPagedList.Extract(Item: Pointer): Pointer;
begin
  Result := ExtractItem(Item, FromBeginning);
end;

function TQPagedList.ExtractItem(Item: Pointer; Direction: TDirection): Pointer;
var
  I: Integer;
begin
  Result := nil;
  I := IndexOfItem(Item, Direction);
  if I >= 0 then
  begin
    Result := Item;
    Remove(I);
    if ClassType <> TQPagedList then
      Notify(Result, lnExtracted);
  end;
end;

function TQPagedList.Find(const p: Pointer; var AIdx: Integer): Boolean;
var
  l, H, I, c: Integer;
begin
  Result := False;
  l := 0;
  H := FCount - 1;
  while l <= H do
  begin
    I := (l + H) shr 1;
    c := DoCompare(Items[I], p);
    if c < 0 then
      l := I + 1
    else
    begin
      H := I - 1;
      if c = 0 then
        Result := True;
    end;
  end;
  AIdx := l;
end;

function TQPagedList.FindPage(AIndex: Integer): Integer;
var
  l, H, I, AMax: Integer;
begin
  l := 0;
  if (FFirstDirtyPage < Length(FPages)) and
    (AIndex >= FPages[FFirstDirtyPage - 1].FStartIndex +
    FPages[FFirstDirtyPage - 1].FUsedCount) then
  begin
    for I := FFirstDirtyPage to High(FPages) do
    begin
      FPages[I].FStartIndex := FPages[I - 1].FStartIndex + FPages[I - 1]
        .FUsedCount;
      if FPages[I].FStartIndex > AIndex then
      begin
        Result := I - 1;
        FFirstDirtyPage := I + 1;
        Exit;
      end
      else if FPages[I].FStartIndex = AIndex then
      begin
        Result := I;
        FFirstDirtyPage := I + 1;
        Exit;
      end;
    end;
    H := High(FPages);
  end
  else
    H := FFirstDirtyPage - 1;
  while l <= H do
  begin
    I := (l + H) shr 1;
    AMax := FPages[I].FStartIndex + FPages[I].FUsedCount - 1; // 最大的索引号
    if AIndex > AMax then
      l := I + 1
    else
    begin
      H := I - 1;
      if (AIndex >= FPages[I].FStartIndex) and (AIndex <= AMax) then
      begin
        Result := I;
        Exit;
      end;
    end;
  end;
  Result := -1;
end;

function TQPagedList.First: Pointer;
begin
  Result := Items[0];
end;

function TQPagedList.GetCapacity: Integer;
begin
  Result := Length(FPages) * FPageSize;
end;

function TQPagedList.GetEnumerator: TQPagedListEnumerator;
begin
  Result := TQPagedListEnumerator.Create(Self);
end;

function TQPagedList.GetItems(AIndex: Integer): Pointer;
var
  p: Integer;
begin
  p := FindPage(AIndex);
  if p <> -1 then
  begin
    Dec(AIndex, FPages[p].FStartIndex);
    Result := FPages[p].FItems[AIndex];
  end
  else
    raise Exception.Create('索引越界:' + IntToStr(AIndex));
end;

function TQPagedList.GetList: TPointerList;
var
  I, J, K: Integer;
begin
  SetLength(Result, count);
  K := 0;
  for I := 0 to High(FPages) do
  begin
    for J := 0 to FPages[I].FUsedCount - 1 do
    begin
      Result[K] := FPages[I].FItems[J];
      Inc(K);
    end;
  end;
end;

function TQPagedList.IndexOf(Item: Pointer): Integer;
var
  I, J: Integer;
begin
  Result := -1;
  for I := 0 to High(FPages) do
  begin
    for J := 0 to FPages[I].FUsedCount do
    begin
      if FPages[I].FItems[J] = Item then
      begin
        Result := FPages[I].FStartIndex + J;
        Exit;
      end;
    end;
  end;
end;

function TQPagedList.IndexOfItem(Item: Pointer; Direction: TDirection): Integer;
var
  I, J: Integer;
begin
  if Direction = FromBeginning then
    Result := IndexOf(Item)
  else
  begin
    Result := -1;
    for I := High(FPages) downto 0 do
    begin
      for J := FPages[I].FUsedCount - 1 downto 0 do
      begin
        if FPages[I].FItems[J] = Item then
        begin
          Result := FPages[I].FStartIndex + J;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TQPagedList.Insert(AIndex: Integer; const p: Pointer);
begin
  if Assigned(FOnCompare) then
    Find(p, AIndex);
  InternalInsert(AIndex, p)
end;

procedure TQPagedList.InternalInsert(AIndex: Integer; const p: Pointer);
var
  APage, ANewPage, AMoved: Integer;
begin
  if AIndex >= count then // 插入末尾
  begin
    APage := FLastUsedPage;
    if (APage < 0) or (FPages[APage].FUsedCount = FPageSize) then
    begin
      Inc(APage);
      if APage >= Length(FPages) then
      begin
        SetLength(FPages, Length(FPages) + 1);
        FPages[APage] := TQListPage.Create(FPageSize);
        FPages[APage].FStartIndex := count;
      end;
      Inc(FLastUsedPage);
      if APage = 0 then
        FFirstDirtyPage := 1;
    end;
    FPages[APage].FItems[FPages[APage].FUsedCount] := p;
    Inc(FPages[APage].FUsedCount);
  end
  else if AIndex <= 0 then
  begin
    if FPages[0].FUsedCount < FPageSize then
    begin
      System.Move(FPages[0].FItems[0], FPages[0].FItems[1],
        FPages[0].FUsedCount * SizeOf(Pointer));
      FPages[0].FItems[0] := p;
      Inc(FPages[0].FUsedCount);
    end
    else // 当前页满了，需要分配新页
    begin
      SetLength(FPages, Length(FPages) + 1);
      FLastUsedPage := High(FPages);
      System.Move(FPages[0], FPages[1], SizeOf(TQListPage) * High(FPages));
      FPages[0] := TQListPage.Create(FPageSize);
      FPages[0].FUsedCount := 1;
      FPages[0].FItems[0] := p;
    end;
    Dirty(1);
  end
  else
  begin;
    APage := FindPage(AIndex);
    if (FPages[APage].FUsedCount = FPageSize) then
    begin
      if (High(FPages) = APage) or (FPages[APage + 1].FUsedCount = FPageSize)
      then
      // 下一页也满了
      begin
        SetLength(FPages, Length(FPages) + 1);
        FLastUsedPage := High(FPages);
        ANewPage := APage + 1;
        System.Move(FPages[ANewPage], FPages[ANewPage + 1],
          SizeOf(TQListPage) * (High(FPages) - ANewPage));
        FPages[ANewPage] := TQListPage.Create(FPageSize);
        FPages[ANewPage].FStartIndex := AIndex + 1;
        Dec(AIndex, FPages[APage].FStartIndex);
        AMoved := FPages[APage].FUsedCount - AIndex;
        System.Move(FPages[APage].FItems[AIndex], FPages[ANewPage].FItems[0],
          AMoved * SizeOf(Pointer));
        FPages[ANewPage].FUsedCount := AMoved;
        Dec(FPages[APage].FUsedCount, AMoved - 1);
        FPages[APage].FItems[AIndex] := p;
        Dirty(ANewPage + 1);
      end
      else // 将当前页的内容移入下一页
      begin
        ANewPage := APage + 1;
        System.Move(FPages[ANewPage].FItems[0], FPages[ANewPage].FItems[1],
          FPages[ANewPage].FUsedCount * SizeOf(Pointer));
        FPages[ANewPage].FItems[0] := FPages[APage].FItems[FPageSize - 1];
        Inc(FPages[ANewPage].FUsedCount);
        Dirty(ANewPage + 1);
        Dec(AIndex, FPages[APage].FStartIndex);
        AMoved := (FPages[APage].FUsedCount - AIndex);
        System.Move(FPages[APage].FItems[AIndex],
          FPages[APage].FItems[AIndex + 1], AMoved * SizeOf(Pointer));
        FPages[APage].FItems[AIndex] := p;
      end;
    end
    else
    begin
      Dec(AIndex, FPages[APage].FStartIndex);
      if AIndex >= FPages[APage].FUsedCount then
        FPages[APage].FItems[AIndex] := p
      else
      begin
        AMoved := (FPages[APage].FUsedCount - AIndex);
        System.Move(FPages[APage].FItems[AIndex],
          FPages[APage].FItems[AIndex + 1], AMoved * SizeOf(TQListPage));
        FPages[APage].FItems[AIndex] := p;
      end;
      Inc(FPages[APage].FUsedCount);
      Dirty(APage + 1);
    end;
  end;
  Inc(FCount);
  if (p <> nil) and (ClassType <> TQPagedList) then
    Notify(p, lnAdded);
end;

function TQPagedList.Last: Pointer;
begin
  Result := Items[count - 1];
end;

procedure TQPagedList.Move(AFrom, ATo: Integer);
begin
  MoveTo(AFrom, ATo);
end;

procedure TQPagedList.MoveTo(AFrom, ATo: Integer);
var
  ATemp: Pointer;
begin
  if AFrom <> ATo then
  begin
    ATemp := Items[AFrom];
    Remove(AFrom);
    Insert(ATo, ATemp);
  end;
end;

procedure TQPagedList.Notify(Ptr: Pointer; Action: TListNotification);
begin

end;

function TQPagedList.Remove(Item: Pointer): Integer;
begin
  Result := RemoveItem(Item, FromBeginning);
end;

procedure TQPagedList.Remove(AIndex: Integer);
var
  APage: Integer;
begin
  APage := FindPage(AIndex);
  if APage >= 0 then
  begin
    Dec(AIndex, FPages[APage].FStartIndex);
    System.Move(FPages[APage].FItems[AIndex + 1], FPages[APage].FItems[AIndex],
      SizeOf(Pointer) * (FPages[APage].FUsedCount - AIndex - 1));
    Dec(FPages[APage].FUsedCount);
    CheckLastPage;
    Assert(FPages[APage].FUsedCount >= 0);
    Dirty(APage + 1);
  end;
end;
{$IFDEF UNICODE}

procedure TQPagedList.Sort(AOnCompare: TQPagedListSortCompareA);
begin
  TQPagedListSortCompareA(TMethod(FOnCompare).Code) := AOnCompare;
  TMethod(FOnCompare).Data := Pointer(-1);
  Sort;
end;
{$ENDIF}

procedure TQPagedList.SetCapacity(const Value: Integer);
begin
  // 仅为兼容保留，实际不做任何事情
end;

procedure TQPagedList.SetItems(AIndex: Integer; const Value: Pointer);
var
  p: Integer;
begin
  p := FindPage(AIndex);
  if p <> -1 then
  begin
    Dec(AIndex, FPages[p].FStartIndex);
    FPages[p].FItems[AIndex] := Value;
  end
  else
    raise Exception.Create('索引越界:' + IntToStr(AIndex));
end;

procedure TQPagedList.SetOnCompare(const Value: TQPagedListSortCompare);
begin
  if (TMethod(FOnCompare).Code <> TMethod(Value).Code) or
    (TMethod(FOnCompare).Data <> TMethod(Value).Data) then
  begin
    FOnCompare := Value;
    if Assigned(Value) then
      Sort;
  end;
end;

procedure TQPagedList.Sort(AOnCompare: TQPagedListSortCompareG);
begin
  TMethod(FOnCompare).Code := @AOnCompare;
  TMethod(FOnCompare).Data := nil;
  Sort;
end;

procedure TQPagedList.Sort;
  procedure QuickSort(l, R: Integer);
  var
    I, J, p: Integer;
  begin
    repeat
      I := l;
      J := R;
      p := (l + R) shr 1;
      repeat
        while DoCompare(Items[I], Items[p]) < 0 do
          Inc(I);
        while DoCompare(Items[J], Items[p]) > 0 do
          Dec(J);
        if I <= J then
        begin
          if I <> J then
            Exchange(I, J);
          if p = I then
            p := J
          else if p = J then
            p := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if l < J then
        QuickSort(l, J);
      l := I;
    until I >= R;
  end;

begin
  if not Assigned(FOnCompare) then
    raise Exception.Create('未指定排序规则');
  if count > 0 then
    QuickSort(0, count - 1);
end;

function TQPagedList.RemoveItem(Item: Pointer; Direction: TDirection): Integer;
begin
  Result := IndexOfItem(Item, Direction);
  if Result > 0 then
    Remove(Result);
end;

{ TQListPage }

constructor TQListPage.Create(APageSize: Integer);
begin
  SetLength(FItems, APageSize);
end;

{ TQPagedListEnumerator }

constructor TQPagedListEnumerator.Create(AList: TQPagedList);
begin
  inherited Create;
  FList := AList;
  FIndex := -1;
end;

function TQPagedListEnumerator.GetCurrent: Pointer;
begin
  Result := FList[FIndex];
end;

function TQPagedListEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FList.count - 1;
  if Result then
    Inc(FIndex);
end;

{ TQPagedStream }
constructor TQPagedStream.Create;
begin
  Create(8192);
end;

function TQPagedStream.ActiveOffset: Integer;
begin
  Result := FPosition mod FPageSize;
end;

function TQPagedStream.ActivePage: Integer;
begin
  Result := FPosition div FPageSize;
end;

procedure TQPagedStream.Clear;
var
  I: Integer;
begin
  for I := 0 to High(FPages) do
    FreeMem(FPages[I]);
  SetLength(FPages, 0);
  FSize := 0;
  FPosition := 0;
end;

constructor TQPagedStream.Create(APageSize: Integer);
begin
  inherited Create;
  if APageSize <= 0 then
    APageSize := 8192;
  FPageSize := APageSize;
end;

destructor TQPagedStream.Destroy;
begin
  Clear;
  inherited;
end;

function TQPagedStream.GetAsBytes: TBytes;
begin
  if Size > 0 then
  begin
    SetLength(Result, FSize);
    FPosition := 0;
    Read(Result[0], FSize);
  end
  else
    FSize := 0;
end;

function TQPagedStream.GetBytes(AIndex: Int64): Byte;
begin
  if AIndex + 1 > FSize then
    Result := 0
  else
    Result := PByte(IntPtr(FPages[AIndex div FPageSize]) +
      (AIndex mod FPageSize))^;
end;

function TQPagedStream.GetSize: Int64;
begin
  Result := FSize;
end;

procedure TQPagedStream.LoadFromFile(const FileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(AStream);
  finally
    FreeAndNil(AStream);
  end;
end;

procedure TQPagedStream.LoadFromStream(Stream: TStream);
var
  ACount: Int64;
begin
  ACount := Stream.Size - Stream.Position;
  Capacity := ACount;
  CopyFrom(Stream, ACount);
end;

procedure TQPagedStream.PageNeeded(APageIndex: Integer);
begin
  if High(FPages) < APageIndex then
    Capacity := (APageIndex + 1) * FPageSize - 1;
end;

function TQPagedStream.Read(var Buffer; count: Longint): Longint;
var
  ACanRead: Int64;
  pBuf: PByte;
  APage, APageSpace, APageOffset, AToRead: Integer;
begin
  ACanRead := FSize - FPosition;
  Result := 0;
  if ACanRead >= count then
  begin
    if ACanRead < count then
      count := ACanRead;
    pBuf := @Buffer;
    while count > 0 do
    begin
      APage := ActivePage;
      APageOffset := ActiveOffset;
      APageSpace := FPageSize - ActiveOffset;
      if count > APageSpace then
        AToRead := APageSpace
      else
        AToRead := count;
      Dec(count, AToRead);
      Move(PByte(IntPtr(FPages[APage]) + APageOffset)^, pBuf^, AToRead);
      Inc(pBuf, AToRead);
      Inc(Result, AToRead);
      Inc(FPosition, AToRead);
    end;
  end;
end;

function TQPagedStream.Read(Buffer: TBytes; Offset, count: Longint): Longint;
begin
  if count > 0 then
    Result := Read(Buffer[Offset], count)
  else
    Result := 0;
end;

procedure TQPagedStream.SaveToFile(const FileName: string);
var
  AStream: TFileStream;
begin
  AStream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    FreeAndNil(AStream);
  end;
end;

procedure TQPagedStream.SaveToStream(Stream: TStream);
begin
  Stream.CopyFrom(Self, 0);
end;

function TQPagedStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  case Origin of
    soBeginning:
      Result := Offset;
    soCurrent:
      Result := FPosition + Offset;
    soEnd:
      Result := FSize - Offset
  else
    Result := 0;
  end;
  if Result > FSize then
    Result := FSize
  else if Result < 0 then
    Result := 0;
  FPosition := Result;
end;

procedure TQPagedStream.SetSize(const NewSize: Int64);
begin
  Capacity := NewSize;
end;

procedure TQPagedStream.SetAsBytes(const Value: TBytes);
begin
  Size := Length(Value);
  if Size > 0 then
    WriteBuffer(Value[0], Size);
end;

procedure TQPagedStream.SetBytes(AIndex: Int64; const Value: Byte);
begin
  if FSize < AIndex + 1 then
    Size := AIndex + 1;
  PByte(IntPtr(FPages[AIndex div FPageSize]) + (AIndex mod FPageSize))^
    := Value;
end;

procedure TQPagedStream.SetCapacity(Value: Int64);
var
  APageNum: Int64;
  I: Integer;
begin
  if Value < 0 then
    Value := 0;
  APageNum := (Value div FPageSize);
  if (Value mod FPageSize) <> 0 then
    Inc(APageNum);
  if FCapacity <> APageNum * FPageSize then
  begin
    FCapacity := APageNum * FPageSize;
    if Length(FPages) > APageNum then
    begin
      I := High(FPages);
      while I >= APageNum do
      begin
        FreeMem(FPages[I]);
        Dec(I);
      end;
      SetLength(FPages, APageNum);
    end
    else
    begin
      I := Length(FPages);
      SetLength(FPages, APageNum);
      while I < APageNum do
      begin
        GetMem(FPages[I], FPageSize);
        Inc(I);
      end;
    end;
  end;
end;

procedure TQPagedStream.SetSize(NewSize: Longint);
begin
  Capacity := NewSize;
end;

function TQPagedStream.Write(const Buffer: TBytes;
  Offset, count: Longint): Longint;
begin
  if count > 0 then
    Result := Write(Buffer[Offset], count)
  else
    Result := 0;
end;

function TQPagedStream.Write(const Buffer; count: Longint): Longint;
var
  ADest: PByte;
  APageIndex, APageOffset, APageSpace: Integer;
  AOffset: Int64;
  pBuf: PByte;
begin
  Result := 0;
  if count > 0 then
  begin
    AOffset := FPosition + count;
    PageNeeded(AOffset div FPageSize);
    APageIndex := ActivePage;
    APageOffset := ActiveOffset;
    APageSpace := FPageSize - APageOffset;
    pBuf := @Buffer;
    while count > 0 do
    begin
      ADest := PByte(IntPtr(FPages[APageIndex]) + APageOffset);
      if APageSpace < count then
      begin
        Move(pBuf^, ADest^, APageSpace);
        Inc(APageIndex);
        Dec(count, APageSpace);
        Inc(Result, APageSpace);
        Inc(pBuf, APageSpace);
        APageOffset := 0;
        APageSpace := FPageSize;
      end
      else
      begin
        Move(pBuf^, ADest^, count);
        Inc(Result, count);
        Break;
      end;
    end;
    Inc(FPosition, Result);
    if FSize < FPosition then
      FSize := FPosition;
  end;
end;

const
  PR_ORDERED = 9; // 如果存在顺序数列时，如12345，此时每个重复字符减小的权值
  PR_REPEAT = 5; // 如果存在重复的数列时，如aaaa，此时每次重复减少的权值
  PR_CHARTYPE = 20; // 每增加一个不同类型的字符时，增加的权值
  PR_LENGTH = 10; // 每增加一个字符时，增加的权值
  PR_CHART = 50; // 包含非数字和字母的控制字符时，额外增加的权值
  PR_UNICODE = 70; // 包含Unicode字符时，额外增加的权值

function PasswordScale(const S: QStringW): Integer;
var
  p: PQCharW;
  ARules: TPasswordRules;
  AMaxOrder, AMaxRepeat, ACharTypes: Integer;
  function RepeatCount: Integer;
  var
    t: PQCharW;
  begin
    t := p;
    Inc(t);
    Result := 0;
    while t^ = p^ do
    begin
      Inc(Result);
      Inc(t);
    end;
    if Result > AMaxRepeat then
      AMaxRepeat := Result;
  end;

  function OrderCount: Integer;
  var
    t, tl: PQCharW;
    AStep: Integer;
  begin
    t := p;
    tl := p;
    Inc(t);
    AStep := Ord(t^) - Ord(p^);
    Result := 0;
    while Ord(t^) - Ord(tl^) = AStep do
    begin
      Inc(Result);
      tl := t;
      Inc(t);
    end;
    if Result > AMaxOrder then
      AMaxOrder := Result;
  end;

begin
  if LowerCase(S) = 'password' then
    Result := 0
  else
  begin
    Result := Length(S) * PR_LENGTH;
    p := PQCharW(S);
    ARules := [];
    AMaxOrder := 0;
    AMaxRepeat := 0;
    while p^ <> #0 do
    begin
      if (p^ >= '0') and (p^ <= '9') then
        ARules := ARules + [prIncNumber]
      else if (p^ >= 'a') and (p^ <= 'z') then
        ARules := ARules + [prIncLowerCase]
      else if (p^ >= 'A') and (p^ <= 'Z') then
        ARules := ARules + [prIncUpperCase]
      else if p^ > #$7F then
        ARules := ARules + [prIncUnicode]
      else
        ARules := ARules + [prIncChart];
      if RepeatCount > 2 then
        ARules := ARules + [prRepeat];
      if OrderCount > 2 then
        ARules := ARules + [prSimpleOrder];
      Inc(p);
    end;
    if prSimpleOrder in ARules then
      Result := Result - AMaxOrder * PR_ORDERED;
    if prRepeat in ARules then
      Result := Result - AMaxRepeat * PR_REPEAT;
    ACharTypes := 0;
    if prIncNumber in ARules then
      Inc(ACharTypes);
    if prIncLowerCase in ARules then
      Inc(ACharTypes);
    if prIncUpperCase in ARules then
      Inc(ACharTypes);
    if prIncChart in ARules then
    begin
      Inc(ACharTypes);
      Result := Result + PR_CHART;
    end;
    if prIncUnicode in ARules then
    begin
      Inc(ACharTypes);
      Result := Result + PR_UNICODE;
    end;
    Result := Result + (ACharTypes - 1) * PR_CHARTYPE;
    // 密码强度的取值范围：<0
    if Result < 0 then
      Result := 0;
  end;
end;

function CheckPassword(const AScale: Integer): TPasswordStrongLevel; overload;
begin
  if AScale < 60 then
    Result := pslLowest
  else if AScale < 100 then
    Result := pslLower
  else if AScale < 200 then
    Result := pslNormal
  else if AScale < 300 then
    Result := pslHigher
  else
    Result := pslHighest;
end;

function CheckPassword(const S: QStringW): TPasswordStrongLevel; overload;
begin
  Result := CheckPassword(PasswordScale(S));
end;

{ TQBits }

function TQBits.GetIsSet(AIndex: Integer): Boolean;
begin
  if (AIndex < 0) or (AIndex >= Size) then
    Result := False
  else
    Result := (FBits[AIndex shr 3] and ($80 shr (AIndex and $7))) <> 0;
end;

function TQBits.GetSize: Integer;
begin
  Result := Length(FBits) shl 3;
end;

procedure TQBits.SetIsSet(AIndex: Integer; const Value: Boolean);
var
  AByteIdx: Integer;
begin
  if (AIndex < 0) or (AIndex >= Size) then
    raise QException.CreateFmt(SOutOfIndex, [AIndex, 0, Size - 1]);
  AByteIdx := AIndex shr 3;
  if Value then
    FBits[AByteIdx] := FBits[AByteIdx] or ($80 shr (AIndex and $7))
  else
    FBits[AByteIdx] := FBits[AByteIdx] and (not($80 shr (AIndex and $7)));
end;

procedure TQBits.SetSize(const Value: Integer);
begin
  if (Value and $7) <> 0 then
    SetLength(FBits, (Value shr 3) + 1)
  else
    SetLength(FBits, Value shr 3);
end;

initialization

{$IFDEF MSWINDOWS}
  hMsvcrtl := LoadLibrary('msvcrt.dll');
if hMsvcrtl <> 0 then
begin
  VCStrStr := TMSVCStrStr(GetProcAddress(hMsvcrtl, 'strstr'));
  VCStrStrW := TMSVCStrStrW(GetProcAddress(hMsvcrtl, 'wcsstr'));
  VCMemCmp := TMSVCMemCmp(GetProcAddress(hMsvcrtl, 'memcmp'));
end
else
begin
  VCStrStr := nil;
  VCStrStrW := nil;
  VCMemCmp := nil;
end;
{$ENDIF}
IsFMXApp := GetClass('TFmxObject') <> nil;

finalization

{$IFDEF MSWINDOWS}
if hMsvcrtl <> 0 then
  FreeLibrary(hMsvcrtl);
{$ENDIF}

end.

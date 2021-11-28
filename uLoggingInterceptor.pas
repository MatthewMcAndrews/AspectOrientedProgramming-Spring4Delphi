unit uLoggingInterceptor;

interface

uses
  Spring.Interception,
  System.Rtti;

type
  { Log Begin and End Time of Method Calls }
  ILoggingInterceptor = interface(IInterceptor) ['{32191D73-76C8-4B7F-AC0A-EC14F42DF535}']
  end;
  TLoggingInterceptor = class(TInterfacedObject, ILoggingInterceptor)
  public
    procedure Intercept(const Invocation: IInvocation);
  private
    function BeginMessage(const Invocation: IInvocation): string;
    function EndMessage(const Invocation: IInvocation): string;
    function Prefix(const Invocation: IInvocation): string;
    function ResultCount(const ResultValue: TValue): string;
  end;

implementation

uses
  Spring.Collections,
  System.SysUtils;

{ TLoggingInterceptor }

procedure TLoggingInterceptor.Intercept(const Invocation: IInvocation);
begin
  Writeln(BeginMessage(Invocation));
  Invocation.Proceed;
  Writeln(EndMessage(Invocation));
end;

function TLoggingInterceptor.BeginMessage(const Invocation: IInvocation): string;
begin
  Result := Prefix(Invocation) + ' Begin';
end;

function TLoggingInterceptor.EndMessage(const Invocation: IInvocation): string;
begin
  Result := Prefix(Invocation) + ' End.';
  if not Invocation.Result.IsEmpty then begin
    Result := Result + ResultCount(Invocation.Result);
  end;
end;

function TLoggingInterceptor.Prefix(const Invocation: IInvocation): string;
const
  TimeStampFmt = 'yyyy/mm/dd hh:nn:ss.zzz';
var
  Target: TObject;
  QualifiedClassName: string;
  TimeStamp: string;
begin
  Target := (Invocation.Target.AsObject);
  QualifiedClassName := Target.QualifiedClassName;
  TimeStamp := FormatDateTime(TimeStampFmt, Now);
  Result := Format('[%s][%s.%s]', [TimeStamp, QualifiedClassName, Invocation.Method.Name]);
end;

function TLoggingInterceptor.ResultCount(const ResultValue: TValue): string;
var
  List: IList<string>;
  Arr: TArray<string>;
  CountStr: string;
begin
  if ResultValue.TryAsType<IList<string>>(List) then begin
    CountStr := List.Count.ToString;
  end else if ResultValue.TryAsType<TArray<string>>(Arr) then begin
    CountStr := Length(Arr).ToString;
  end else begin
    CountStr := 'Unknown Number of';
  end;
  Result := Format(' %s Items Returned.', [CountStr]);
end;

end.

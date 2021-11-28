unit uFoulInterceptor;

interface

uses
  Spring.Interception;

type
  { Say Something Foul }
  IFoulInterceptor = interface(IInterceptor) ['{40365E0C-9578-49DB-94FE-9A0DBC5D0CBE}']
  end;
  TFoulInterceptor = class(TInterfacedObject, IFoulInterceptor)
    procedure Intercept(const Invocation: IInvocation);
  end;

implementation

{ TFoulInterceptor }

procedure TFoulInterceptor.Intercept(const Invocation: IInvocation);
begin
  Writeln('fuck');
  Invocation.Proceed;
end;

end.

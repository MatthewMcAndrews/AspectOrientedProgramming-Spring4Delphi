unit uAspectFactory;

interface

uses
  Spring.Container,
  Spring.Interception;

type
  TAspectFactory = class(TObject)
  private
    Container: TContainer;
  public
    function CreateWithInterceptor<T: class; I: IInterceptor>: T; overload;
    function CreateWithInterceptor<T: class; I1, I2: IInterceptor>: T; overload;
    constructor Create(const Container: TContainer);
  end;

implementation

{ TAspectFactory<T> }

constructor TAspectFactory.Create(const Container: TContainer);
begin
  inherited Create;
  Self.Container := Container;
end;


function TAspectFactory.CreateWithInterceptor<T, I>: T;
var
  Interceptor: I;
begin
  Interceptor := Container.Resolve<I>;
  Result := TProxyGenerator.CreateClassProxy<T>([Interceptor]);
end;

function TAspectFactory.CreateWithInterceptor<T, I1, I2>: T;
var
  Interceptor1: I1;
  Interceptor2: I2;
begin
  Interceptor1 := Container.Resolve<I1>;
  Interceptor2 := Container.Resolve<I2>;
  Result := TProxyGenerator.CreateClassProxy<T>([Interceptor1, Interceptor2]);
end;

end.

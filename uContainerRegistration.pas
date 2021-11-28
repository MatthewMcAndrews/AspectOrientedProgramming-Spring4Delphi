unit uContainerRegistration;

interface

uses
  uAspectFactory,
  Spring.Container;

procedure AddRegistrations(
  const AspectFactory: TAspectFactory;
  const Container: TContainer);

implementation

uses
  uAspectTarget,
  uFoulInterceptor,
  uLoggingInterceptor;

procedure AddRegistrations(
  const AspectFactory: TAspectFactory;
  const Container: TContainer);
begin
  Container.RegisterType<ILoggingInterceptor, TLoggingInterceptor>;
  Container.RegisterType<IFoulInterceptor, TFoulInterceptor>;
  Container.RegisterType<TAspectTarget>
    { This is a workaround. I have been unable to get the built-in
      InterceptedBy() to work with classes (only with interfaces...) }
    .DelegateTo(AspectFactory.CreateWithInterceptor<TAspectTarget, IFoulInterceptor, ILoggingInterceptor>);
end;

end.

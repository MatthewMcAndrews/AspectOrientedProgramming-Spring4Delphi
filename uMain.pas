unit uMain;

interface

procedure Run;

implementation

uses
  Spring.Container,
  uAspectFactory,
  uAspectTarget,
  uContainerRegistration;

procedure Run;
var
  Container: TContainer;
  AspectFactory: TAspectFactory;
  AspectTarget: TAspectTarget;
begin
  Container := TContainer.Create;
  AspectFactory := TAspectFactory.Create(Container);
  try
    AddRegistrations(AspectFactory, Container);
    Container.Build;
    AspectTarget := Container.Resolve<TAspectTarget>;
    AspectTarget.Test;
    AspectTarget.ReturnList;
    AspectTarget.ReturnArray;
  finally
    AspectFactory.Free;
    Container.Free;
  end;
end;

end.

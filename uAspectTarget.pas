unit uAspectTarget;

interface

uses
  Spring.Collections;

type
  { Note that methods must be marked virtual to be intercepted }
  TAspectTarget = class(TObject)
    procedure Test; virtual;
    function ReturnArray: TArray<string>; virtual;
    function ReturnList: IList<string>; virtual;
  end;

implementation

{ TAspectTarget }

function TAspectTarget.ReturnArray: TArray<string>;
begin
  Result := ['an', 'array'];
end;

function TAspectTarget.ReturnList: IList<string>;
begin
  Result := TCollections.CreateList<string>(['three', 'item', 'list']);
end;

procedure TAspectTarget.Test;
begin
  Writeln('Test() Invoked!');
end;

end.

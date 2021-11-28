program AspectOrientedProgramming_Spring4Delphi;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  uLoggingInterceptor in 'uLoggingInterceptor.pas',
  uFoulInterceptor in 'uFoulInterceptor.pas',
  uAspectTarget in 'uAspectTarget.pas',
  uContainerRegistration in 'uContainerRegistration.pas',
  uMain in 'uMain.pas',
  uAspectFactory in 'uAspectFactory.pas';

begin
  try
    Run;
  except
    on E: Exception do begin
      Writeln(E.ClassName, ': ', E.Message);
    end;
  end;
end.

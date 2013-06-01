program DGLMemo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FormDGLDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormDGLDemo, FormDGLDemo);
  Application.Run;
end.

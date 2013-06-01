program CWord;



uses
  //FastMM4,   使用 FastMM，内存分配速度会有很大提高
  Forms,
  UnitCWord in 'UnitCWord.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

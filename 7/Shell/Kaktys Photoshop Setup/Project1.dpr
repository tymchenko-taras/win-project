program Project1;

uses
  Forms,
  start in 'start.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Kaktys Photoshop Setup';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

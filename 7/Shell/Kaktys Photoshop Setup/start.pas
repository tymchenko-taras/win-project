unit start;

interface

uses
  Windows, Messages, registry, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function ExecuteAndWait(FileName: string; HideApplication: boolean): boolean;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  exitc: cardinal;
begin
  FillChar(StartupInfo, sizeof(StartupInfo), 0);
  with StartupInfo do begin
    cb := Sizeof(StartupInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := SW_SHOW;
  end;
  if not CreateProcess(nil, PChar(FileName), nil, nil, false,
    CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil,
    StartupInfo, ProcessInfo) then result := false
  else begin
    if HideApplication then begin
      Application.Minimize;
      ShowWindow(Application.Handle, SW_HIDE);
      WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
    end else
      while WaitforSingleObject(ProcessInfo.hProcess, 100) =
        WAIT_TIMEOUT do begin
        Application.ProcessMessages;
        if Application.Terminated
          then TerminateProcess(ProcessInfo.hProcess, 0);
      end;
    GetExitCodeProcess(ProcessInfo.hProcess, exitc);
    result := (exitc = 0);
    if HideApplication then begin
      ShowWindow(Application.Handle, SW_SHOW);
      Application.Restore;
      Application.BringToFront;
    end;
   end;    end;

procedure TForm1.FormCreate(Sender: TObject);
var r:TRegistry;
begin
  r:=TRegistry.Create;
  r.RootKey:=HKEY_CURRENT_USER;
  r.OpenKey('\Software\Adobe\ALM\B2B86000',true);
  r.WriteInteger('ActivationReminder',1121745600);
  r.WriteInteger('ActivationStatus',1);
  r.WriteInteger('ActivationType',2);
  r.Free;
  Sleep(1000);
ExecuteAndWait('activation.exe',true);
ExecuteAndWait('setup.exe /v/qb',true);
ExecuteAndWait('activation.exe',true);
  Sleep(2000);
Form1.Close;
end;

end.

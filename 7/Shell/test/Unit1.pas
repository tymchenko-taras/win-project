unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, ActnList, INIFiles, shellAPI, CheckLst,
  ComCtrls;

type

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    Timer2: TTimer;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Image3: TImage;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    RichEdit1: TRichEdit;
    Image4: TImage;
    Label27: TLabel;
    Label29: TLabel;
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label25Click(Sender: TObject);
    procedure Label26Click(Sender: TObject);
    procedure Label26MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label26MouseLeave(Sender: TObject);
    procedure Label25MouseLeave(Sender: TObject);
    procedure Label25MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label24MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure Label28MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label28MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label29Click(Sender: TObject);
    procedure Label29MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label29MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  INI:TINIFile;

implementation         {$R *.dfm}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

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
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
  function ShowInfo(s1:string): string;
   begin
   ShowInfo:=ini.ReadString('General','description','')+' '+
               ini.ReadString('install',s1,'')+'. '+
               ini.ReadString('General','description1','');

  end;
  procedure installinfo(s1:string);
    begin
     Form1.Label4.Caption:=ini.ReadString('General','description','')+' '+
                           ini.ReadString('install',s1,'')+'. '+
                           ini.ReadString('General','description1','');
     ExecuteAndWait(ini.ReadString('Path',s1,''),false);
    end;
(************** Процедура перевірки й виклику вибраних програм************)
procedure install(F:TForm1); 
 begin
   if F.CheckBox1.Checked=true then begin    installinfo('prog1');  end;
   if F.CheckBox2.Checked=true then begin    installinfo('prog2');  end;
   if F.CheckBox3.Checked=true then begin    installinfo('prog3');  end;
   if F.CheckBox4.Checked=true then begin    installinfo('prog4');  end;
   if F.CheckBox5.Checked=true then begin    installinfo('prog5');  end;
   if F.CheckBox6.Checked=true then begin    installinfo('prog6');  end;
   if F.CheckBox7.Checked=true then begin    installinfo('prog7');  end;
   if F.CheckBox8.Checked=true then begin    installinfo('prog8');  end;
   if F.CheckBox9.Checked=true then begin    installinfo('prog9');  end;
   if F.CheckBox10.Checked=true then begin   installinfo('prog10'); end;
   if F.CheckBox11.Checked=true then begin   installinfo('prog11'); end;
   if F.CheckBox12.Checked=true then begin   installinfo('prog12'); end;
   if F.CheckBox13.Checked=true then begin   installinfo('prog13'); end;
   if F.CheckBox14.Checked=true then begin   installinfo('prog14'); end;
   if F.CheckBox15.Checked=true then begin   installinfo('prog15'); end;
   if F.CheckBox16.Checked=true then begin   installinfo('prog16'); end;
   if F.CheckBox17.Checked=true then begin   installinfo('prog17'); end;
   if F.CheckBox18.Checked=true then begin   installinfo('prog18'); end;
   if F.CheckBox19.Checked=true then begin   installinfo('prog19'); end;
   if F.CheckBox20.Checked=true then begin   installinfo('prog20'); end;
   F.Label4.Caption:='Вітаю! Інсталяцію завершено.';
 end;



(************* Початкове положення чікбоксів і лейблів ************)
 procedure startpos(FRM: TForm1) ;
  begin
FRM. Label5.Left:=-105;   FRM. CheckBox2.Left:=-35;    FRM.Label5.Visible:=false;
FRM. Label6.Left:=-105;   FRM. CheckBox3.Left:=-45;    FRM.Label6.Visible:=false;
FRM. Label7.Left:=-95;    FRM. CheckBox4.Left:=-55;    FRM.Label7.Visible:=false;
FRM. Label8.Left:=-85;    FRM. CheckBox5.Left:=-65;    FRM.Label8.Visible:=false;
FRM. Label9.Left:=-105;   FRM. CheckBox6.Left:=-75;    FRM.Label9.Visible:=false;
FRM. Label10.Left:=-105;  FRM. CheckBox7.Left:=-85;    FRM.Label10.Visible:=false;
FRM. Label11.Left:=-135;  FRM. CheckBox8.Left:=-95;    FRM.Label11.Visible:=false;
FRM. Label12.Left:=-125;  FRM. CheckBox9.Left:=-105;   FRM.Label12.Visible:=false;
FRM. Label13.Left:=-185;  FRM. CheckBox10.Left:=-115;  FRM.Label13.Visible:=false;
FRM. Label14.Left:=-145;  FRM. CheckBox11.Left:=-125;  FRM.Label14.Visible:=false;
FRM. Label15.Left:=-205;  FRM. CheckBox12.Left:=-135;  FRM.Label15.Visible:=false;
FRM. Label16.Left:=-175;  FRM. CheckBox13.Left:=-145;  FRM.Label16.Visible:=false;
FRM. Label17.Left:=-145;  FRM. CheckBox14.Left:=-155;  FRM.Label17.Visible:=false;
FRM. Label18.Left:=-185;  FRM. CheckBox15.Left:=-165;  FRM.Label18.Visible:=false;
FRM. Label19.Left:=-105;  FRM. CheckBox16.Left:=-175;  FRM.Label19.Visible:=false;
FRM. Label20.Left:=-85;   FRM. CheckBox17.Left:=-185;  FRM.Label20.Visible:=false;
FRM. Label21.Left:=-165;  FRM. CheckBox18.Left:=-195;  FRM.Label21.Visible:=false;
FRM. Label22.Left:=-125;  FRM. CheckBox19.Left:=-205;  FRM.Label22.Visible:=false;
FRM. Label23.Left:=-145;  FRM. CheckBox20.Left:=-215;  FRM.Label23.Visible:=false;
FRM. Label24.Left:=-185;  FRM. CheckBox1.Left:=-25;    FRM.Label24.Visible:=false;
  end;
/////////////////////////////////////////////////////////////////////////////
(************************* Запуск форми ***************************)
procedure TForm1.FormActivate(Sender: TObject);
  begin   startpos(Form1);    // Cтавимо все у початкове положення

if not FileExists('Data\config.ini') then  begin    // Якщо конфігурацій не існує
     ShowMessage('Помилка! Не знайдено файлу конфігурації.'+
   'Файл конфігурації config.ini повинен розташовуватися у каталозі Data');

     Form1.Close; end


else begin Ini:=TiniFile.Create('Data\config.ini');
   Form1.Label27.Visible:=false;           // опис кожного пкнкту
   Form1.Caption:= ini.ReadString('General','Form','');
   Label1.Caption:=Ini.ReadString('General','Button1','');
   Label3.Caption:=Ini.ReadString('General','Button2','');
   Label25.Caption:=Ini.ReadString('General','Uncheck','');
   Label26.Caption:=Ini.ReadString('General','Checkall','');
end;    

Form1.Label28.Visible:=true;
Form1.Label28.Left:=16;
Form1.Label28.Top:=624;
end;
(************* Показати чікбокси і лейбли ***************)                ///
 procedure ShowChB(Box:TCheckBox; Lbl:Tlabel); // показати бокси          ///
  begin                                                                   ///
  if Lbl.Left<145 then Lbl.Left:=Lbl.Left+5 else  Lbl.Left:=145;          ///
        Form1.Update;                                                     ///
  if Box.Left<120 then box.Left:=box.Left+5 else  Box.Left:=120;          ///
                                                                          ///
  end;                                                                    ///
   (************* Заховати чікбокси і лейбли ***************)             ///
  procedure HideChB(Box:TCheckBox; Lbl:Tlabel);                           ///
begin                                                                     ///
  if Lbl.Left<-60 then   startpos(Form1)   else  Lbl.Left:=Lbl.Left-9;    ///
        Form1.Update;                                                     ///
  if Box.Left<-40 then    startpos(form1)  else  box.Left:=box.Left-5;    ///
end;                                                                      ///
/////////////////////////////////////////////////////////////////////////////
(****************************************************************************)
///////////////  Для кнопки Встановлення програм  ////////////////////////////
//////////////////////////////////////////////////////////////////////////////
procedure TForm1.Label1MouseMove(Sender: TObject; Shift: TShiftState; X,   ///
  Y: Integer);                                                             ///
begin  Image2.Visible:=True;  end;                                         ///
                                                                           ///
procedure TForm1.Label1MouseLeave(Sender: TObject);                        ///
begin Image2.Visible:=false;  end;                                         ///
                                                                           ///
procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,   ///
  Y: Integer);                                                             ///
begin  Image2.Visible:=true;  end;                                         ///
                                                                           ///
procedure TForm1.Label1MouseDown(Sender: TObject; Button: TMouseButton;    ///
  Shift: TShiftState; X, Y: Integer);                                      ///
begin  Image2.Picture.LoadFromFile('Data\1click.jpg'); end;                ///
                                                                           ///
                                                                           ///
                                                                           ///
procedure TForm1.Label1MouseUp(Sender: TObject; Button: TMouseButton;      ///
  Shift: TShiftState; X, Y: Integer);                                      ///
begin     Image2.Picture.LoadFromFile('Data\1mouse.jpg');                  ///
          Timer1.Enabled:=true;                                            ///
          Label2.Visible:=true;                                            ///
          Label25.visible:=true;                                           ///
          Label26.Visible:=true;                                           ///
          Label29.Visible:=true;                                           ///
          Timer2.Enabled:=false;                                           ///
          If Label2.Visible=true then Label3.Visible:=true else            ///
             Label3.Visible:=false;                                        ///
(************************************************************************* ///*)
 CheckBox1.Visible:=ini.ValueExists('Path','Prog1');                       ///
 CheckBox2.Visible:=ini.ValueExists('Path','Prog2');                       ///
 CheckBox3.Visible:=ini.ValueExists('Path','Prog3');                       ///
 CheckBox4.Visible:=ini.ValueExists('Path','Prog4');                       ///
 CheckBox5.Visible:=ini.ValueExists('Path','Prog5');                       ///
 CheckBox6.Visible:=ini.ValueExists('Path','Prog6');                       ///
 CheckBox7.Visible:=ini.ValueExists('Path','Prog7');                       ///
 CheckBox8.Visible:=ini.ValueExists('Path','Prog8');                       ///
 CheckBox9.Visible:=ini.ValueExists('Path','Prog9');                       ///
 CheckBox10.Visible:=ini.ValueExists('Path','Prog10');                     ///
 CheckBox11.Visible:=ini.ValueExists('Path','Prog11');                     ///
 CheckBox12.Visible:=ini.ValueExists('Path','Prog12');                     ///
 CheckBox13.Visible:=ini.ValueExists('Path','Prog13');                     ///
 CheckBox14.Visible:=ini.ValueExists('Path','Prog14');                     ///
 CheckBox15.Visible:=ini.ValueExists('Path','Prog15');                     ///
 CheckBox16.Visible:=ini.ValueExists('Path','Prog16');                     ///
 CheckBox17.Visible:=ini.ValueExists('Path','Prog17');                     ///
 CheckBox18.Visible:=ini.ValueExists('Path','Prog18');                     ///
 CheckBox19.Visible:=ini.ValueExists('Path','Prog19');                     ///
 CheckBox20.Visible:=ini.ValueExists('Path','Prog20');                     ///
                                                                           ///
 Label24.Visible:=ini.ValueExists('Path','Prog1');                         ///
 Label5.Visible:= ini.ValueExists('Path','Prog2');                         ///
 Label6.Visible:= ini.ValueExists('Path','Prog3');                         ///
 Label7.Visible:= ini.ValueExists('Path','Prog4');                         ///
 Label8.Visible:= ini.ValueExists('Path','Prog5');                         ///
 Label9.Visible:= ini.ValueExists('Path','Prog6');                         ///
 Label10.Visible:=ini.ValueExists('Path','Prog7');                         ///
 Label11.Visible:=ini.ValueExists('Path','Prog8');                         ///
 Label12.Visible:=ini.ValueExists('Path','Prog9');                         ///
 Label13.Visible:=ini.ValueExists('Path','Prog10');                        ///
 Label14.Visible:=ini.ValueExists('Path','Prog11');                        ///
 Label15.Visible:=ini.ValueExists('Path','Prog12');                        ///
 Label16.Visible:=ini.ValueExists('Path','Prog13');                        ///
 Label17.Visible:=ini.ValueExists('Path','Prog14');                        ///
 Label18.Visible:=ini.ValueExists('Path','Prog15');                        ///
 Label19.Visible:=ini.ValueExists('Path','Prog16');                        ///
 Label20.Visible:=ini.ValueExists('Path','Prog17');                        ///
 Label21.Visible:=ini.ValueExists('Path','Prog18');                        ///
 Label22.Visible:=ini.ValueExists('Path','Prog19');                        ///
 Label23.visible:=ini.ValueExists('Path','Prog20');                        ///
                                                                           ///
   Label24.Caption:= Ini.ReadString('Install','prog1','');                 ///
   Label5.Caption:= Ini.ReadString('Install','prog2','');                  ///
   Label6.Caption:= Ini.ReadString('Install','prog3','');                  ///
   Label7.Caption:= Ini.ReadString('Install','prog4','');                  ///
   Label8.Caption:= Ini.ReadString('Install','prog5','');                  ///
   Label9.Caption:= Ini.ReadString('Install','prog6','');                  ///
   Label10.Caption:=Ini.ReadString('Install','prog7','');                  ///
   Label11.Caption:=Ini.ReadString('Install','prog8','');                  ///
   Label12.Caption:=Ini.ReadString('Install','prog9','');                  ///
   Label13.Caption:=Ini.ReadString('Install','prog10','');                 ///
   Label14.Caption:=Ini.ReadString('Install','prog11','');                 ///
   Label15.Caption:=Ini.ReadString('Install','prog12','');                 ///
   Label16.Caption:=Ini.ReadString('Install','prog13','');                 ///
   Label17.Caption:=Ini.ReadString('Install','prog14','');                 ///
   Label18.Caption:=Ini.ReadString('Install','prog15','');                 ///
   Label19.Caption:= Ini.ReadString('Install','prog16','');                ///
   Label20.Caption:= Ini.ReadString('Install','prog17','');                ///
   Label21.Caption:= Ini.ReadString('Install','prog18','');                ///
   Label22.Caption:= Ini.ReadString('Install','prog19','');                ///
   Label23.Caption:= Ini.ReadString('Install','prog20','');                ///
                                                                           ///
                                                                           ///
 Label28.Visible:=false;        end;                                                                     ///
//////////////////////////////////////////////////////////////////////////////
//////////////// Для кнопки інсталювати програми /////////////////////////////
//////////////////////////////////////////////////////////////////////////////
procedure TForm1.Label3MouseMove(Sender: TObject; Shift: TShiftState; X,   ///
  Y: Integer);                                                             ///
begin Image3.Visible:=true;  end;                                          ///
                                                                           ///
procedure TForm1.Label3MouseLeave(Sender: TObject);                        ///
begin Image3.Visible:=false  end;                                          ///
                                                                           ///
procedure TForm1.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,   ///
  Y: Integer);                                                             ///
begin  Image3.Visible:=true  end;                                          ///
                                                                           ///
procedure TForm1.Label3MouseDown(Sender: TObject; Button: TMouseButton;    ///
  Shift: TShiftState; X, Y: Integer);                                      ///
begin  Image3.Picture.LoadFromFile('Data\2click.jpg');  end;               ///
                                                                           ///
procedure TForm1.Label3MouseUp(Sender: TObject; Button: TMouseButton;      ///
  Shift: TShiftState; X, Y: Integer);                                      ///
begin  Image3.Picture.LoadFromFile('Data\2mouse.jpg');                     ///
     install(Form1);                                                       ///
                                                                           ///
  end;                                                                     ///
//////////////////////////////////////////////////////////////////////////////

(****************** Висуваємо чікбокси і лейбли *******************)
procedure TForm1.Timer1Timer(Sender: TObject);
begin       // Виїзд фігні
  ShowChB(CheckBox2,Label5);
  ShowChB(CheckBox3,Label6);
  ShowChB(CheckBox4,Label7);
  ShowChB(CheckBox5,Label8);
  ShowChB(CheckBox6,Label9);
  ShowChB(CheckBox7,Label10);
  ShowChB(CheckBox8,Label11);
  ShowChB(CheckBox9,Label12);
  ShowChB(CheckBox10,Label13);
  ShowChB(CheckBox11,Label14);
  ShowChB(CheckBox12,Label15);
  ShowChB(CheckBox13,Label16);
  ShowChB(CheckBox14,Label17);
  ShowChB(CheckBox15,Label18);
  ShowChB(CheckBox16,Label19);
  ShowChB(CheckBox17,Label20);
  ShowChB(CheckBox18,Label21);
  ShowChB(CheckBox19,Label22);
  ShowChB(CheckBox20,Label23);
  ShowChB(CheckBox1,Label24);
end;
(****************** Ховаємо чікбокси і лейбли *******************)
procedure TForm1.Timer2Timer(Sender: TObject);
begin
  HideChB(CheckBox2,Label5);
  HideChB(CheckBox3,Label6);
  HideChB(CheckBox4,Label7);
  HideChB(CheckBox5,Label8);
  HideChB(CheckBox6,Label9);
  HideChB(CheckBox7,Label10);
  HideChB(CheckBox8,Label11);
  HideChB(CheckBox9,Label12);
  HideChB(CheckBox10,Label13);
  HideChB(CheckBox11,Label14);
  HideChB(CheckBox12,Label15);
  HideChB(CheckBox13,Label16);
  HideChB(CheckBox14,Label17);
  HideChB(CheckBox15,Label18);
  HideChB(CheckBox16,Label19);
  HideChB(CheckBox17,Label20);
  HideChB(CheckBox18,Label21);
  HideChB(CheckBox19,Label22);
  HideChB(CheckBox20,Label23);
  HideChB(CheckBox1, Label24);
end;

//////////// Для лейбла Заховати чікбокси /////////////////*
///////////////////////////////////////////////////////////*
procedure TForm1.Label2MouseMove(Sender: TObject;       ///*
 Shift: TShiftState; X,Y: Integer);                     ///*
begin                                                   ///*
Label2.Font.Style:=[fsUnderline]                        ///*
end;                                                    ///*
                                                        ///*
procedure TForm1.Label2MouseLeave(Sender: TObject);     ///*
begin                                                   ///*
Label2.Font.Style:=[]                                   ///*
end;                                                    ///*
                                                        ///*
procedure TForm1.Label2Click(Sender: TObject);          ///*
begin                                                   ///*
 Timer1.Enabled:=false;                                 ///*
 Timer2.Enabled:=true;                                  ///*
 Label2.Visible:=false;                                 ///*
 Label3.Visible:=false;                                 ///*
 Label26.Visible:=false;                                ///*
 Label25.Visible:=false;                                ///*
 Label28.Visible:=true;                                 ///*
 Label29.Visible:=false;                                ///*
end;                                                    ///*
///////////////////////////////////////////////////////////*

 procedure checked(ok:Boolean);
  begin
    Form1.CheckBox1.Checked:=OK;     Form1.CheckBox11.Checked:=OK;
    Form1.CheckBox2.Checked:=OK;     Form1.CheckBox12.Checked:=OK;
    Form1.CheckBox3.Checked:=OK;     Form1.CheckBox13.Checked:=OK;
    Form1.CheckBox4.Checked:=OK;     Form1.CheckBox14.Checked:=OK;
    Form1.CheckBox5.Checked:=OK;     Form1.CheckBox15.Checked:=OK;
    Form1.CheckBox6.Checked:=OK;     Form1.CheckBox16.Checked:=OK;
    Form1.CheckBox7.Checked:=OK;     Form1.CheckBox17.Checked:=OK;
    Form1.CheckBox8.Checked:=OK;     Form1.CheckBox18.Checked:=OK;
    Form1.CheckBox9.Checked:=OK;     Form1.CheckBox19.Checked:=OK;
    Form1.CheckBox10.Checked:=OK;    Form1.CheckBox20.Checked:=OK; 
  end;




/////////////////////////////////////////////////////////////////////////////
procedure TForm1.Label26Click(Sender: TObject);                           ///
                                                                          ///
begin   Checked(True)    end;                                             ///
                                                                          ///
procedure TForm1.Label26MouseMove(Sender: TObject; Shift: TShiftState; X, ///
  Y: Integer);                                                            ///
begin          Label26.Font.Style:=[fsUnderline];      end;               ///
                                                                          ///
procedure TForm1.Label26MouseLeave(Sender: TObject);                      ///
                                                                          ///
begin           Label26.Font.Style:=[];                end;               ///
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
procedure TForm1.Label25Click(Sender: TObject);                           ///
                                                                          ///
begin   Checked(False)   end;                                             ///
                                                                          ///
procedure TForm1.Label25MouseLeave(Sender: TObject);                      ///
begin                                                                     ///
Label25.Font.Style:=[];                                                   ///
end;                                                                      ///
                                                                          ///
procedure TForm1.Label25MouseMove(Sender: TObject; Shift: TShiftState; X, ///
  Y: Integer);                                                            ///
begin                                                                     ///
Label25.Font.Style:=[fsUnderline];                                        ///
end;                                                                      ///
/////////////////////////////////////////////////////////////////////////////

(***************** Показуємо інфу про прогу ****************)
procedure softinf(s1:string);
   var m:Tmouse;
begin
 if ini.ValueExists('Description',s1) = true then    begin
  Form1.Label27.Visible:=true;
  Form1.Label27.Left:=(m.CursorPos.x)-210;
  Form1.Label27.Top:=(m.CursorPos.y)-260;
  Form1.Label27.Caption:=ini.ReadString('Description',s1,''); end

else Form1.Label27.Visible:=false;
end;



procedure TForm1.Label24MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
 var   lbl:TLabel;
// Для кожного лейбла викликаємо процедуру
//                 В І Т А Л І К    Р У Л И Т Ь !!!
begin         lbl:=Sender as TLabel;  { softinf(lbl.Name);}
   begin
 if ini.ValueExists('Description',lbl.Name) = true then    begin
  Form1.Label27.Visible:=true;
  Form1.Label27.Left:=lbl.Left+100;
  Form1.Label27.Top:=lbl.Top-50;
  Form1.Label27.Caption:=ini.ReadString('Description',lbl.name,''); end
  
else Form1.Label27.Visible:=false;
end;








     end;

// Як параметр процури беремо імя лейбл (однойменний ключ в config.ini)
procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
// Ховаємо лейбл-підказку коли мишка на картинці
Form1.Label27.Visible:=false;
Form1.Label28.Font.Style:=[];

end;

procedure TForm1.Image1Click(Sender: TObject);
begin
Form1.RichEdit1.Lines.Clear;
Form1.RichEdit1.Visible:=false;
end;

procedure TForm1.Label28MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
Label28.Font.Style:=[fsUnderline];
end;

procedure TForm1.Label28MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Form1.RichEdit1.Visible:=True;
Form1.RichEdit1.Height:=601;
Form1.RichEdit1.Width:=401;
Form1.RichEdit1.Lines.LoadFromFile('sources\uk-ua\readme.rtf');
Form1.RichEdit1.SetFocus;
end;

procedure TForm1.Image4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
//Form1.Image4.Picture.LoadFromFile('Data\installmouse.jpg');
end;

procedure TForm1.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Form1.Image4.Picture.LoadFromFile('Data\installclick.jpg')
end;

procedure TForm1.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Form1.Image4.Picture.LoadFromFile('Data\install.jpg');
ExecuteandWait('sources\setup.exe',true);
end;

procedure TForm1.Label29Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', 'Data\Install\NoAutoInstall',nil,nil, SW_SHOWNORMAL);
end;

procedure TForm1.Label29MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
Label29.Font.Style:=[fsUnderline];
end;

procedure TForm1.Label29MouseLeave(Sender: TObject);
begin
Label29.Font.Style:=[];
end;

end.


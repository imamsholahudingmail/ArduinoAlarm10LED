unit ComMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, CPort, CPortCtl, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvCGrid, AeroButtons, AdvGlassButton, Vcl.ComCtrls, AdvProgr,
  AdvSmoothLedLabel, VaControls, VaDisplay, datelbl, Vcl.Mask, AdvDropDown,
  AdvTimePickerDropDown, Vcl.Buttons, AdvSmoothToggleButton;

type
  TForm1 = class(TForm)
    ComPort: TComPort;
    AdvStringGrid1: TAdvStringGrid;
    AdvGlassButton1: TAdvGlassButton;
    AdvGlassButton2: TAdvGlassButton;
    AdvGlassButton3: TAdvGlassButton;
    AdvProgress1: TAdvProgress;
    AdvGlassButton4: TAdvGlassButton;
    AdvTimePickerDropDown1: TAdvTimePickerDropDown;
    procedure ComPortOpen(Sender: TObject);
    procedure ComPortClose(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure Bt_LoadClick(Sender: TObject);
    procedure Bt_StoreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvStringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure AdvStringGrid1CellValidate(Sender: TObject; ACol, ARow: Integer;
      var Value: string; var Valid: Boolean);
    procedure AdvGlassButton1Click(Sender: TObject);
    procedure AdvGlassButton2Click(Sender: TObject);
    procedure AdvGlassButton3Click(Sender: TObject);
    procedure AmbilData(Sender: TObject);
    procedure Temporaridata(Sender: TObject);
    procedure AdvGlassButton4Click(Sender: TObject);
    procedure AdvTimePickerDropDown1DropDown(Sender: TObject;
      var acceptdrop: Boolean);
    procedure AdvTimePickerDropDown1DropUp(Sender: TObject; Cancelled: Boolean);
  private
    FMessage, perubahan: string;
    jam : TDateTime;
    isi,rubah : array[1..2,1..32] of string;
    lokasi, jumlah : word;
    ubahJam: boolean;
    procedure DoEvent(AMsg: string);

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses Unit2;

procedure TForm1.DoEvent(AMsg: string);
var
  myDay, myMonth, myYear, myHour, myMin, mySec, myMilli : word;
begin

  begin
    if jumlah > 0 then
    begin
      AdvProgress1.Position:=AdvProgress1.Max-Jumlah;
      jam := StrToTime(rubah[2,jumlah]);
      DecodeTime(jam, myHour, myMin, mySec, myMilli);
      if AMsg='Tentukan Lokasi Alarm! ' then
      begin
        ComPort.WriteStr(rubah[1,jumlah]);
      end else
      if AMsg='Tentukan Jam! ' then
      begin
        ComPort.WriteStr(IntToStr(myHour));
      end else
      if AMsg='Tentukan Menit! ' then
      begin
        ComPort.WriteStr(IntToStr(myMin));
      end else

      if AMsg='Tentukan Detik! ' then
      begin
        ComPort.WriteStr(IntToStr(mySec));
        dec(Jumlah);
        AdvProgress1.Position:=AdvProgress1.Max-Jumlah;
        if jumlah > 0 then ComPort.WriteStr('setup');
      end;

    end
    else AdvGlassButton1.Enabled:=True;


    if AMsg='Waktu Jam! ' then
    begin
      DecodeTime(AdvTimePickerDropDown1.Time, myHour, myMin, mySec, myMilli);
      ComPort.WriteStr(IntToStr(myHour));
    end else
    if AMsg='Waktu Menit! ' then
    begin
      DecodeTime(AdvTimePickerDropDown1.Time, myHour, myMin, mySec, myMilli);
      ComPort.WriteStr(IntToStr(myMin));
    end else
    if AMsg='Waktu Detik! ' then
    begin
      DecodeTime(AdvTimePickerDropDown1.Time, myHour, myMin, mySec, myMilli);
      ComPort.WriteStr(IntToStr(mySec));
    end else

    if AMsg='Waktu hari! ' then
    begin
      DecodeDate(Date, myYear, myMonth, myDay);
      ComPort.WriteStr(IntToStr(myDay));
    end else
    if AMsg='Waktu bulan! ' then
    begin
      Decodedate(Date, myYear, myMonth, myDay);
      ComPort.WriteStr(IntToStr(myMonth));
    end else
    if AMsg='Waktu tahun! ' then
    begin
      DecodeDate(Date, myYear, myMonth, myDay);
      ComPort.WriteStr(IntToStr(myYear));
    end else


    if (AMsg[1]='1') and (AMsg[2]='-') then
      AdvStringGrid1.Cells[1,1]:=AMsg[3]+AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10] else
    if (AMsg[1]='2') and (AMsg[2]='-') then
      AdvStringGrid1.Cells[2,1]:=AMsg[3]+AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10] else

    if (AMsg[1]='3') and (AMsg[2]='-') then
      AdvStringGrid1.Cells[1,2]:=AMsg[3]+AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10] else
    if (AMsg[1]='4') and (AMsg[2]='-') then
      AdvStringGrid1.Cells[2,2]:=AMsg[3]+AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10] else

    if (AMsg[1]='5') and (AMsg[2]='-') then
      AdvStringGrid1.Cells[1,3]:=AMsg[3]+AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10] else
    if (AMsg[1]='6') and (AMsg[2]='-') then
      AdvStringGrid1.Cells[2,3]:=AMsg[3]+AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10] else

    if (AMsg[1]='7') and (AMsg[2]='-') then
      AdvStringGrid1.Cells[1,4]:=AMsg[3]+AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10] else
    if (AMsg[1]='8') and (AMsg[2]='-') then
      AdvStringGrid1.Cells[2,4]:=AMsg[3]+AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10] else

    if (AMsg[1]='9') and (AMsg[2]='-') then
      AdvStringGrid1.Cells[1,5]:=AMsg[3]+AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10] else
    if (AMsg[1]='1') and (AMsg[2]='0') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,5]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='1') and (AMsg[2]='1') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,6]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='1') and (AMsg[2]='2') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,6]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else

    if (AMsg[1]='1') and (AMsg[2]='3') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,7]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='1') and (AMsg[2]='4') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,7]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='1') and (AMsg[2]='5') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,8]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='1') and (AMsg[2]='6') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,8]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else

    if (AMsg[1]='1') and (AMsg[2]='7') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,9]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='1') and (AMsg[2]='8') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,9]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='1') and (AMsg[2]='9') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,10]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='2') and (AMsg[2]='0') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,10]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else

    if (AMsg[1]='2') and (AMsg[2]='1') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,11]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='2') and (AMsg[2]='2') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,11]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='2') and (AMsg[2]='3') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,12]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='2') and (AMsg[2]='4') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,12]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else

    if (AMsg[1]='2') and (AMsg[2]='5') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,13]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='2') and (AMsg[2]='6') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,13]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='2') and (AMsg[2]='7') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,14]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='2') and (AMsg[2]='8') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,14]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else

    if (AMsg[1]='2') and (AMsg[2]='9') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,15]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='3') and (AMsg[2]='0') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,15]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='3') and (AMsg[2]='1') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[1,16]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[1]='3') and (AMsg[2]='2') and (AMsg[3]='-') then
      AdvStringGrid1.Cells[2,16]:=AMsg[4]+AMsg[5]+AMsg[6]+AMsg[7]+AMsg[8]+AMsg[9]+AMsg[10]+AMsg[11] else
    if (AMsg[3]=':') and (AMsg[6]=':') and (ubahJam=false) then AdvTimePickerDropDown1.Time:=strToTime(AMsg);

  end;

end;

procedure TForm1.AmbilData(Sender: TObject);
var
x,y : word;
begin
  for y := 1 to 16 do
  begin
    for x := 1 to 2 do
      begin
        isi[x,y]:= AdvStringGrid1.Cells[x,y];
      end;
  end;
end;

procedure TForm1.Temporaridata(Sender: TObject);
var
x,y,z,w : word;
begin
  z:=0;
  for y := 1 to 16 do
  begin
    for x := 1 to 2 do
      begin
        if isi[x,y] <> AdvStringGrid1.Cells[x,y] then
        begin
          perubahan := AdvStringGrid1.Cells[x,y];
          lokasi := (y*2)+x-2;
          jam := StrToTime(perubahan);
          inc(z);
          rubah[1,z]:=intToStr(lokasi);
          rubah[2,z]:=perubahan;
        end;
      end;
  end;

  jumlah := z;
  ComPort.WriteStr('setup');
  AdvGlassButton1.Enabled:=False;
  AdvProgress1.Max := jumlah;

end;

procedure TForm1.ComPortOpen(Sender: TObject);
begin
  AdvGlassButton3.Caption := 'Close';
end;

procedure TForm1.ComPortClose(Sender: TObject);
begin
  if AdvGlassButton3 <> nil then
  begin
    AdvGlassButton3.Caption := 'Open';
  end;
end;

procedure TForm1.ComPortRxChar(Sender: TObject; Count: Integer);
var
  Str: String;
  Asc : Byte;
  I: Integer;
  Tmp: string;
begin
  ComPort.ReadStr(Str, Count);
  //read data from comport
  Tmp := Str;

  //debugging log...

  for I := 1 to Length(Tmp) do
    case Tmp[I] of
      #10:; //skip this one
      #13:  //Waiting for this?
        begin
          DoEvent(FMessage);
          FMessage := '';  //reset received message
        end;
      else //not #10 or #13
        FMessage := FMessage + Tmp[I];
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ComPort.Connected then ComPort.Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
var x,y : word;
begin
  ubahJam:=False;
  jam:=Time;
  jumlah:=0;
  AdvStringGrid1.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSelect];

  AdvStringGrid1.Cells[0,0]:='Setting';
  AdvStringGrid1.Cells[1,0]:='Mulai';
  AdvStringGrid1.Cells[2,0]:='Selesai';

  for x := 0 to 2 do
    for y := 1 to 16 do
      if x=0 then AdvStringGrid1.Cells[x,y]:= 'Alarm '+IntToStr(y)
      else AdvStringGrid1.Cells[x,y]:='00:00:00';
end;

procedure TForm1.AdvGlassButton1Click(Sender: TObject);

begin
  if AdvGlassButton1.Caption = 'Setup' then
  begin
    AdvGlassButton2Click(sender);
    AmbilData(sender);
    AdvStringGrid1.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goEditing];
    AdvGlassButton1.Caption := 'Apply'
  end else
  begin
    Temporaridata(sender);
    AdvStringGrid1.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSelect];
    AdvGlassButton1.Caption := 'Setup'
  end;

end;

procedure TForm1.AdvGlassButton2Click(Sender: TObject);
begin
  ComPort.WriteStr('ambil');
end;

procedure TForm1.AdvGlassButton3Click(Sender: TObject);
begin
  if ComPort.Connected then
  begin
    AdvGlassButton1.Enabled:=False;
    AdvGlassButton2.Enabled:=False;
    AdvStringGrid1.Enabled:=False;
    ComPort.Close;
  end else
  begin
    ComPort.ShowSetupDialog;
    ComPort.Open;
    AdvGlassButton1.Enabled:=True;
    AdvGlassButton2.Enabled:=True;
    AdvStringGrid1.Enabled:=True;
    AdvGlassButton2Click(sender);
  end;
end;

procedure TForm1.AdvGlassButton4Click(Sender: TObject);
begin

  Form2.ShowModal;
end;

procedure TForm1.AdvStringGrid1CellValidate(Sender: TObject; ACol,
  ARow: Integer; var Value: string; var Valid: Boolean);
begin
//  if ACol = 0 then Value := Trim(Value);
end;

procedure TForm1.AdvStringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  case ACol of
    0: Value := '';
    1: Value := '!90:00:00;1;_';
    2: Value := '!90:00:00;1;_';
  end;
end;

procedure TForm1.AdvTimePickerDropDown1DropDown(Sender: TObject;
  var acceptdrop: Boolean);
begin
  showMessage('AdvTimePickerDropDown1DropDown');
  ubahJam:=True;
end;

procedure TForm1.AdvTimePickerDropDown1DropUp(Sender: TObject;
  Cancelled: Boolean);
begin
  showMessage('AdvTimePickerDropDown1DropUp');
  ubahJam:=False;
    ComPort.WriteStr('seting');

end;

procedure TForm1.Bt_LoadClick(Sender: TObject);
begin
//  ComPort.LoadSettings(stRegistry, 'HKEY_LOCAL_MACHINE\Software\Dejan');
//  ComPort.LoadSettings(stIniFile, 'e:\Test.ini');
end;

procedure TForm1.Bt_StoreClick(Sender: TObject);
begin
//  ComPort.StoreSettings(stIniFile, 'e:\Test.ini');
//  ComPort.StoreSettings(stRegistry, 'HKEY_LOCAL_MACHINE\Software\Dejan');
end;

end.

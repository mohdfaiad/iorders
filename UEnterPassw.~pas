unit UEnterPassw;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ADODB, jpeg, pngimage;


type
  TFEnterpassw = class(TForm)
    Edit1: TEdit;
    Image1: TImage;
    BitBtnOK: TBitBtn;
    BitBtnESC: TBitBtn;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnESCClick(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public

    { Public declarations }
    presultat : Boolean;
    user_name : string;
    id_user   : integer;
    id_role   : integer;
    flag_kol  : integer;
  end;

  type Tnastr = record
   NAme : string[255];
  end;
   type TUser = record
    id_user   : integer;
    ig_group  : integer;
    user_name : string;
    flag_kol  : integer;
   end;

var
  FEnterpassw: TFEnterpassw;
  Nastr :  Tnastr; //Настройки программы
  _User : array of TUser;

  user_name: string;
implementation

//uses Umain;
//  uses Umain;
{$R *.dfm}

procedure TFEnterpassw.FormActivate(Sender: TObject);
 var
  F : File of Tnastr;
  currdir: string;
  i: integer;

begin
 presultat := False;
 ADOQuery1.Close;
 ADOQuery1.Sql.Add('select * from workwith_gamma..ava_user_stat ORDER BY Name_User');
 ADOQuery1.Open;
 ADOQuery1.first;
 ComboBox1.Items.Clear;
 ComboBox2.Items.Clear;

 i:=1;
 while not ADOQuery1.eof do
  begin
   ComboBox1.Items.Add(ADOQuery1.FieldByname('Name_user').AsString);
   ComboBox2.Items.Add(ADOQuery1.FieldByname('paswd').AsString);
   setlength(_User,i+1);
   _User[i].user_name := ADOQuery1.FieldByname('Name_user').AsString;
   _User[i].id_user   := ADOQuery1.FieldByname('row_id').AsInteger;
   _User[i].ig_group  := ADOQuery1.FieldByname('user_role').AsInteger;
   _User[i].flag_kol  := ADOQuery1.FieldByname('flag_kol').AsInteger;
   i := i + 1;
   ADOQuery1.Next;
  end;

  try
   currdir := extractfiledir(Application.ExeName);
   AssignFile(F,currdir+'\nastr');
   Reset(f);
   REad(f,nastr);
   user_name := nastr.NAme;
   CloseFile(f);
  except
   showMessage('файл не доступен');
  end;

  ComboBox1.ItemIndex := 0 ;
  for i:=0 to ComboBox1.Items.Count-1 do
   begin
     ComboBox1.ItemIndex := i ;
     if (ComboBox1.Text =  user_name) then
        begin
         ComboBox1.ItemIndex := i;
          exit;
        end;
   end;

end;

procedure TFEnterpassw.BitBtnESCClick(Sender: TObject);
begin

  Close;
end;

procedure TFEnterpassw.BitBtnOKClick(Sender: TObject);
begin
  if ComboBox2.items[ComboBox1.ItemIndex] = Edit1.Text then
   begin
    user_name := _User[ComboBox1.ItemIndex+1].user_name;
    id_user   := _User[ComboBox1.ItemIndex+1].id_user;
    id_role   := _User[ComboBox1.ItemIndex+1].ig_group;
    flag_kol  := _User[ComboBox1.ItemIndex+1].flag_kol;
    presultat := True
   end
  else
   begin
    ShowMessage('Не правильно введен пароль!');
    presultat := False;
   end;

   close;

end;

procedure TFEnterpassw.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
    F : File of Tnastr;
    currdir: string;
begin

  try
   currdir := extractfiledir(Application.ExeName);
   system.Assign(F,currdir+'\nastr');
   ReWrite(f);
   nastr.NAme := ComboBox1.items[ComboBox1.ItemIndex];
   Write(f,nastr);
   system.Close(f);
  except
   showMessage('файл не доступен');
  end;

end;

end.

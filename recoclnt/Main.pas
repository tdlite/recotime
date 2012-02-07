unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg;

type
  TfrmRecoclnt = class(TForm)
    imgHeader: TImage;
    imgWarning: TImage;    
    lblEntry: TStaticText;
    lblComment: TStaticText;
    txtComment: TMemo;
    btnSend: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecoclnt: TfrmRecoclnt;

implementation

{$R *.dfm}

procedure TfrmRecoclnt.FormCreate(Sender: TObject);
begin
lblEntry.Caption := 'Вход в систему был произведен после времени начала' +
  ' рабочего дня.' + #10#13 + 'Пожалуйста, укажите поясняющий' +
  ' комментарий для Вашего руководителя.';
end;

end.

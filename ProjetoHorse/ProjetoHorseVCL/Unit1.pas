unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Horse, ppPrnabl, ppClass, ppCtrls,
  ppBands, ppCache, ppDesignLayer, ppParameter, ppComm, ppRelatv, ppProd,
  ppReport, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    ppReport1: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      vNamePdf: string;
    begin
      vNamePdf := DateTimeToStr(now);
      vNamePdf := StringReplace(vNamePdf, ' ', '', [rfReplaceAll]);
      vNamePdf := StringReplace(vNamePdf, '/', '', [rfReplaceAll]);
      vNamePdf := StringReplace(vNamePdf, ':', '', [rfReplaceAll]);

     // ppReport1.Device := dvPrinter;
      ppLabel1.Caption := 'Teste de relatório pdf - ' + DateTimeToStr(now) + vNamePdf;
      ppReport1.PrinterSetup.PrinterName := 'Bullzip PDF Printer';
      ppReport1.DeviceType := 'PDF';
      ppReport1.TextFileName := 'teste' + vNamePdf + '.pdf';
      ppReport1.ShowPrintDialog := False;
      ppReport1.ShowCancelDialog := False;
      ppReport1.ModalCancelDialog := False;
      ppReport1.ModalPreview := False;
      ppReport1.Print;

      Memo1.Lines.Add('Impresso - ' + 'teste' + vNamePdf + '.pdf');

      Res.Send('pong');
    end);

  THorse.Listen(9000);
end;

end.

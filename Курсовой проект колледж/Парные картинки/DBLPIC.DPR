program dblpic;

uses
  Forms,
  DBLPIC_ in 'DBLPIC_.PAS' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.Title := 'Парные картинки';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

unit test;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Objects,
  FMX.EditBox, FMX.NumberBox, System.Generics.Collections,main;

type
  TTestFrm = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    NumberBox1: TNumberBox;
    NumberBox2: TNumberBox;
    NumberBox3: TNumberBox;
    NumberBox4: TNumberBox;
    Line1: TLine;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestFrm: TTestFrm;

implementation

{$R *.fmx}

procedure AddToDictionary(VType: VarType; Pntr:Pointer; name:string);
var
 p1:^integer;
 p2:^double;
 p3:^float;
 p4:^string;
begin
if (not StringDict.ContainsKey(name)) and (not DecimalDict.ContainsKey(name)) and (not IntDict.ContainsKey(name))  and (not FloatDict.ContainsKey(name)) then
 case VType of
  DInt:begin
        p1:=pntr;
        IntDict.Add(name, p1^);
       end;
  DFloat:begin
        p3:=Pntr;
        FloatDict.Add(name,p3^);
       end;
  DString:begin
        p4:=Pntr;
        StringDict.Add(name,p4^);
       end;
  DDecimal:begin
        p2:=Pntr;
        DecimalDict.Add(name,p2^);
       end;
 end else
 begin

 end;
end;

procedure TTestFrm.Button1Click(Sender: TObject);
var
p:pointer;
v: VarType;
f:float;
name:string;
a:double;
s:string;
begin
 name:=Edit1.Text;
 if RadioButton2.IsChecked then
    begin
     f.nominator:=round(NumberBox4.Value);
     f.denominator:=round(NumberBox3.Value);
     v:=VarType(1);
     p:=@f;
    end else
 if RadioButton4.IsChecked then
    begin
     a:=NumberBox2.Value;
     v:=VarType(2);
     p:=@a;
    end else
 if RadioButton3.IsChecked then
    begin
     f.nominator:=round(NumberBox1.Value);
     v:=VarType(0);
     p:=@f.nominator;
    end else
    begin
     s:=Edit1.Text;
     v:=VarType(3);
     p:=@s;
    end;
    AddToDictionary(v,p,name);
end;

procedure TTestFrm.Button2Click(Sender: TObject);
var
pair1: TPair<string,string>;
pair2: TPair<string,integer>;
pair3: TPair<string,float>;
pair4: TPair<string,double>;
begin
Memo1.Lines.Clear;
 Memo1.Lines.Add('strings');
 for Pair1 in StringDict do
   begin
    Memo1.Lines.Add(Pair1.Value);
   end;
 Memo1.Lines.Add('int');
 for Pair2 in IntDict do
   begin
    Memo1.Lines.Add(Inttostr(Pair2.Value));
   end;
 Memo1.Lines.Add('float');
 for Pair3 in FloatDict do
   begin
    Memo1.Lines.Add(inttostr(Pair3.Value.nominator)+'/'+inttostr(Pair3.Value.denominator));
   end;
  Memo1.Lines.Add('decimal');
 for Pair4 in DecimalDict do
   begin
    Memo1.Lines.Add(Floattostr(Pair4.Value));
   end;
end;

end.

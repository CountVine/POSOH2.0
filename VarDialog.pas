unit VarDialog;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.EditBox,
  FMX.NumberBox, FMX.Objects, FMX.Text;

type
  TDialogFrm = class(TForm)
    CBVarType: TComboBox;
    LBIInt: TListBoxItem;
    LBIDecimal: TListBoxItem;
    LBIFloat: TListBoxItem;
    LBIString: TListBoxItem;
    PanelParams: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    DefVal: TLayout;
    DefValEdit: TEdit;
    DefValNB: TNumberBox;
    DefValFloatEditor: TLayout;
    NBUpper: TNumberBox;
    NBLower: TNumberBox;
    Line1: TLine;
    CBRound: TCheckBox;
    LabelCount: TLabel;
    NBCount: TNumberBox;
    CBRegIgnore: TCheckBox;
    Button1: TButton;
    procedure CBVarTypeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CBRoundChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialogFrm: TDialogFrm;
implementation
uses
main;

{$R *.fmx}

procedure TDialogFrm.Button1Click(Sender: TObject);
begin
 if Edit1.Text<>'' then

end;

procedure TDialogFrm.CBRoundChange(Sender: TObject);
begin
 LabelCount.Enabled:= not LabelCount.Enabled;
 NBCount.Enabled:= not NBCount.Enabled;
end;

procedure TDialogFrm.CBVarTypeChange(Sender: TObject);
begin
case CBVarType.ItemIndex of
0:begin
   DefValEdit.Visible:=false;
   DefValFloatEditor.Visible:=false;
   DefValNB.Visible:=true;
   DefValNB.Value:=Round(DefValNB.Value);
   DefValNB.ValueType:=TNumValueType(0);
   CBRound.Enabled:=false;
   CBRegIgnore.Enabled:=false;
   NBCount.Enabled:=false;
   LabelCount.Enabled:=false;
  end;
1:begin
   DefValEdit.Visible:=false;
   DefValFloatEditor.Visible:=false;
   DefValNB.Visible:=true;
   DefValNB.ValueType:=TNumValueType(1);
   CBRound.Enabled:=true;
   CBRound.IsChecked:=true;
   CBRegIgnore.Enabled:=false;
   NBCount.Enabled:=true;
   LabelCount.Enabled:=true;
  end;
2:begin
   DefValEdit.Visible:=false;
   DefValFloatEditor.Visible:=true;
   DefValNB.Visible:=false;
   CBRound.Enabled:=false;
   CBRegIgnore.Enabled:=false;
   NBCount.Enabled:=false;
   LabelCount.Enabled:=false;
  end;
3:begin
   DefValEdit.Visible:=true;
   DefValFloatEditor.Visible:=false;
   DefValNB.Visible:=false;
   CBRound.Enabled:=false;
   CBRegIgnore.Enabled:=true;
   NBCount.Enabled:=false;
   LabelCount.Enabled:=false;
  end;
end;
end;

procedure TDialogFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DefValEdit.Text:='';
 DefValNB.Value:=0;
 NBUpper.Value:=0;
 NBLower.Value:=0;
end;

end.

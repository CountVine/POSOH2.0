unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Menus, IniFiles, Windows,
  FMX.ListBox, FMX.Layouts, FMX.TreeView, FMX.Objects, System.Math.Vectors,
  FMX.Colors;

type
  TMainFrm = class(TForm)
    MainMenu: TMainMenu;
    FileMI: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    FileNewMI: TMenuItem;
    FileOpenMI: TMenuItem;
    SaveDialog: TSaveDialog;
    StyleBook1: TStyleBook;
    Panel1: TPanel;
    Properties: TLayout;
    TreeView1: TTreeView;
    TreeViewItem1: TTreeViewItem;
    TreeViewItem2: TTreeViewItem;
    TreeViewItem3: TTreeViewItem;
    TreeViewItem4: TTreeViewItem;
    TreeViewItem5: TTreeViewItem;
    TreeViewItem6: TTreeViewItem;
    TreeViewItem7: TTreeViewItem;
    TreeViewItem8: TTreeViewItem;
    TreeViewItem9: TTreeViewItem;
    TreeViewItem10: TTreeViewItem;
    TreeViewItem11: TTreeViewItem;
    TreeViewItem12: TTreeViewItem;
    SizeChanger: TPanel;
    ObjectProperties: TFramedScrollBox;
    TreeView: TFramedScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    TreeViewItem13: TTreeViewItem;
    TreeViewItem14: TTreeViewItem;
    TreeViewItem15: TTreeViewItem;
    TreeViewItem16: TTreeViewItem;
    procedure SaveDialogClose(Sender: TObject);
    procedure FileNewMIClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SizeChangerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure SizeChangerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure SizeChangerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  FilePath = 'C:\Users\object37\Documents\Embarcadero\Studio\Projects\POSOH2.0\TestFiles\file1.ptf';
var
  MainFrm: TMainFrm;
  PathToEXE: string;
  IsLMBPressed : boolean = false;
  StartPos:TPointF;
implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}





procedure TMainFrm.FileNewMIClick(Sender: TObject);
var IniFile: TIniFile;
begin
 IniFile:=TIniFile.Create(PathToEXE+'settings.ini');
 if DirectoryExists(IniFile.ReadString('SaveDialog','InitialDir','')) then
   SaveDialog.InitialDir:=IniFile.ReadString('SaveDialog','InitialDir','');
 IniFile.Free;
 SaveDialog.Execute;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
  SizeChanger.AutoCapture:=true;
  PathToEXE:=ExtractFilePath(ParamStr(0));
end;

procedure TMainFrm.SaveDialogClose(Sender: TObject);
var
  TempFile:file;
  TempStr:string;
  IniFile: TIniFile;
begin
 if SaveDialog.FileName<>'' then
   begin
     TempStr:=Copy(SaveDialog.FileName,length(SaveDialog.FileName)-3,4);
     if TempStr = '.ptf' then
       begin
         AssignFile(TempFile,SaveDialog.FileName);
         TempStr:=SaveDialog.FileName;
       end
     else
       begin
         TempStr:=SaveDialog.FileName+'.ptf';
         AssignFile(TempFile,TempStr);
       end;
     if not FileExists(TempStr) then
       begin
        Rewrite(TempFile);
        CloseFile(TempFile);
       end else
     if MessageDlg('Файл с таким именем уже существует, вы действительно хотите перезаписать его?',System.UITypes.TMsgDlgType.mtConfirmation ,[System.UITypes.TMsgDlgBtn.mbYes,System.UITypes.TMsgDlgBtn.mbNo], 0)= mrYes then
       Rewrite(TempFile);
     IniFile:=TIniFile.Create(PathToEXE+'settings.ini');
     IniFile.WriteString('SaveDialog','InitialDir',ExtractFilePath(TempStr));
     IniFile.Free;
   end;
end;


procedure TMainFrm.SizeChangerMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
SizeChanger.Align:=TAlignLayout(0);
StartPos := TPointF.Create(X, Y);
IsLMBPressed:=true;
end;

procedure TMainFrm.SizeChangerMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
  var
 MoveVector: TVector;
begin
if IsLMBPressed then
  begin
    MoveVector := TVector.Create(0, Y - StartPos.Y, 0);
    MoveVector := SizeChanger.LocalToAbsoluteVector(MoveVector);
    MoveVector := SizeChanger.ParentControl.AbsoluteToLocalVector(MoveVector);
    SizeChanger.Position.Point := SizeChanger.Position.Point + TPointF(MoveVector);
  end;
end;

procedure TMainFrm.SizeChangerMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  IsLMBPressed:=false;
  if SizeChanger.Position.Y<MainFrm.ClientHeight-SizeChanger.Size.Height-150 then
    begin
      if SizeChanger.Position.Y<150 then
       begin
        TreeView.Height:=150;
       end else
        TreeView.Height:=SizeChanger.Position.Y;
    end else
    begin
      TreeView.Height:=MainFrm.ClientHeight-SizeChanger.Size.Height-150;
    end;
    SizeChanger.Align:=TAlignLayout(1);
end;

end.

unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Menus, IniFiles, Windows,
  FMX.ListBox, FMX.Layouts, FMX.TreeView, FMX.Objects, System.Math.Vectors,
  FMX.Colors, System.ImageList, FMX.ImgList;

type
  TMainFrm = class(TForm)
    MainMenu: TMainMenu;
    FileMI: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    FileNewMI: TMenuItem;
    FileOpenMI: TMenuItem;
    SaveDialog: TSaveDialog;
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
    SizeChangerLeft: TPanel;
    ObjectProperties: TFramedScrollBox;
    TreeView: TFramedScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    TreeViewItem13: TTreeViewItem;
    TreeViewItem14: TTreeViewItem;
    TreeViewItem15: TTreeViewItem;
    TreeViewItem16: TTreeViewItem;
    SetOfObjects: TFramedVertScrollBox;
    Label3: TLabel;
    Layout1: TLayout;
    SizeChangerRight: TPanel;
    FramedScrollBox1: TFramedScrollBox;
    Label4: TLabel;
    Layout2: TLayout;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    MiddlePanel: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ToolBar1: TToolBar;
    ListBox1: TListBox;
    ImageList1: TImageList;
    ListBoxItem3: TListBoxItem;
    StyleBook1: TStyleBook;
    procedure SaveDialogClose(Sender: TObject);
    procedure FileNewMIClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SizeChangerLeftMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure SizeChangerLeftMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure SizeChangerLeftMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormResize(Sender: TObject);
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
  FormMinHeight,FormMinWidth: integer;
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
  SizeChangerLeft.AutoCapture:=true;
  SizeChangerRight.AutoCapture:=true;
  PathToEXE:=ExtractFilePath(ParamStr(0));
  FormMinHeight:=550;
  FormMinWidth:=760;
end;

procedure TMainFrm.FormResize(Sender: TObject);
begin
  if MainFrm.Width<FormMinWidth then
   begin
    Mouse_Event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    MainFrm.Width:=FormMinWidth;
   end;
   if MainFrm.Height<FormMinHeight then
   begin
    Mouse_Event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    MainFrm.Height:=FormMinHeight;
   end;
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


procedure TMainFrm.SizeChangerLeftMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
(Sender as TPanel).Align:=TAlignLayout(0);
StartPos := TPointF.Create(X, Y);
IsLMBPressed:=true;
end;

procedure TMainFrm.SizeChangerLeftMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
  var
 MoveVector: TVector;
begin
if IsLMBPressed then
  begin
       MoveVector := TVector.Create(0, Y - StartPos.Y, 0);
       MoveVector := (Sender as TPanel).LocalToAbsoluteVector(MoveVector);
       MoveVector := (Sender as TPanel).ParentControl.AbsoluteToLocalVector(MoveVector);
       (Sender as TPanel).Position.Point := (Sender as TPanel).Position.Point + TPointF(MoveVector);
  end;
end;

procedure TMainFrm.SizeChangerLeftMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  IsLMBPressed:=false;
  if (Sender as TPanel).Position.Y<MainFrm.ClientHeight-(Sender as TPanel).Size.Height-150 then
    begin
      if (Sender as TPanel).Position.Y<150 then
       begin
        if (Sender as TPanel).Name='SizeChangerLeft' then
          TreeView.Height:=150 else
          SetOfObjects.Height:=150;
       end else
        if (Sender as TPanel).Name='SizeChangerLeft' then
          TreeView.Height:=(Sender as TPanel).Position.Y else
          SetOfObjects.Height:=(Sender as TPanel).Position.Y;
    end else
    begin
      if (Sender as TPanel).Name='SizeChangerLeft' then
        TreeView.Height:=MainFrm.ClientHeight-(Sender as TPanel).Size.Height-150 else
        SetOfObjects.Height:=MainFrm.ClientHeight-(Sender as TPanel).Size.Height-150;
    end;
    (Sender as TPanel).Align:=TAlignLayout(1);
end;

end.

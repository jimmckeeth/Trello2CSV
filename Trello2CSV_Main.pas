unit Trello2CSV_Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Grid, REST.Response.Adapter,
  Data.Bind.Components, Data.Bind.ObjectScope, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Grid, Data.Bind.DBScope, IPPeerClient, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, FireDAC.Phys.SQLiteVDataSet, REST.Client, FireDAC.DApt,
  FMX.ScrollBox, FMX.Memo, FireDAC.Comp.UI, FMX.Edit, FMX.ListBox,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.Text;

type
  TForm5 = class(TForm)
    Grid1: TGrid;
    Layout1: TLayout;
    Button1: TButton;
    BindingsList1: TBindingsList;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    FDLocalSQL1: TFDLocalSQL;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    Memo1: TMemo;
    Button2: TButton;
    Edit1: TEdit;
    LinkControlToField1: TLinkControlToField;
    CardsTable: TFDMemTable;
    CardsAdapter: TRESTResponseDataSetAdapter;
    ListsTable: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    ListsAdapter: TRESTResponseDataSetAdapter;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    LabelsAdapter: TRESTResponseDataSetAdapter;
    LabelsTable: TFDMemTable;
    Label1: TLabel;
    Layout2: TLayout;
    TablesList: TListBox;
    FieldsList: TListBox;
    FDBatchMoveTextWriter1: TFDBatchMoveTextWriter;
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    ButtonSave: TButton;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TablesListClick(Sender: TObject);
    procedure TablesListDblClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

uses FMX.Memo.Types;

procedure TForm5.Button1Click(Sender: TObject);
begin
  RESTRequest1.Execute;
  ListsAdapter.Active := True;
  CardsAdapter.Active := True;
  FDLocalSQL1.Active := True;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin



  FDQuery1.FieldDefs.Clear;
  FDQuery1.Open(Memo1.Text);
end;

procedure TForm5.ButtonSaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    FDBatchMoveTextWriter1.FileName := SaveDialog1.FileName;
    FDBatchMove1.Execute;
  end;
end;

procedure ListFields(DS: TDataSet; SL: TStrings);
var
  I: Integer;
begin
  for I := 0 to ds.Fields.Count - 1 do
    sl.Add(ds.Fields[i].FieldName);
end;

procedure TForm5.TablesListClick(Sender: TObject);
begin
  FieldsList.Clear;
  case TablesList.ItemIndex of
    0: ListFields(ListsTable, FieldsList.Items);
    1: ListFields(CardsTable, FieldsList.Items);
    2: ListFields(LabelsTable, FieldsList.Items);
  end;

end;

procedure TForm5.TablesListDblClick(Sender: TObject);
var
  lb: TListBox;
begin
  lb := Sender as TListBox;
  if Assigned(lb) then
    Memo1.InsertAfter(Memo1.CaretPosition, lb.Selected.Text,
      [TInsertOption.MoveCaret, TInsertOption.CanUndo, TInsertOption.Typed]);
  Memo1.SetFocus;
end;

end.

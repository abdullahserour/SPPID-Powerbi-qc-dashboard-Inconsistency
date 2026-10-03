// =============================================================================
// QC Visualization - Power Query code for the FAKE-DATA version
// Paste each block into: Home > Transform data > select the query > Advanced Editor
// =============================================================================

// ----- 0. NEW PARAMETER (Home > Manage parameters > New parameter) -----
// Name: DataFolder | Type: Text | Current value: the folder that holds the fake CSV files
// Example: C:\QC_Fake_Data


// ----- 1. Replace the code of the query  VW_PBI_DRAWING_CSV -----
let
    Source   = Csv.Document(File.Contents(DataFolder & "\VW_PBI_DRAWING.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    NoEmpty  = Table.ReplaceValue(Promoted, "", null, Replacer.ReplaceValue, Table.ColumnNames(Promoted)),
    Typed    = Table.TransformColumnTypes(NoEmpty, {{"SP_ID", type text}, {"NAME", type text}, {"UNITNAME", type text}})
in
    Typed


// ----- 2. Replace the code of the query  VW_PBI_INCONSISTENCY_TYPE_CSV -----
let
    Source   = Csv.Document(File.Contents(DataFolder & "\VW_PBI_INCONSISTENCY_TYPE.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    NoEmpty  = Table.ReplaceValue(Promoted, "", null, Replacer.ReplaceValue, Table.ColumnNames(Promoted)),
    Typed    = Table.TransformColumnTypes(NoEmpty, {{"INCONSISTENCYTYPE", Int64.Type}, {"NAME", type text}})
in
    Typed


// ----- 3. Replace the code of the query  VW_PBI_INCONSISTENCY_CSV  (current-state fact, 17 columns) -----
let
    Source   = Csv.Document(File.Contents(DataFolder & "\VW_PBI_INCONSISTENCY.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    NoEmpty  = Table.ReplaceValue(Promoted, "", null, Replacer.ReplaceValue, Table.ColumnNames(Promoted)),
    Typed    = Table.TransformColumnTypes(NoEmpty, {
        {"SP_ID", type text}, {"DESCRIPTION", type text}, {"NAME", type text},
        {"INCONSISTENCYTYPE", Int64.Type}, {"ISAPPROVED", Int64.Type}, {"INCONSISTENCYSTATUS", Int64.Type}, {"SEVERITY", Int64.Type},
        {"SP_DRAWINGID", type text}, {"SP_ITEM1ID", type text}, {"SP_ITEM2ID", type text},
        {"OPC_TAG1", type text}, {"OPC_TAG2", type text}, {"ITEMTAG1", type text}, {"ITEMTAG2", type text},
        {"ITEMTYPENAME1", type text}, {"ITEMTYPENAME2", type text}, {"SP_PLANTGROUPID", type text}})
in
    Typed


// ----- 4. Replace the code of the query  VW_PBI_INCONSISTENCY_SNAPSHOT_CSV  (16 columns) -----
let
    Source   = Csv.Document(File.Contents(DataFolder & "\VW_PBI_INCONSISTENCY_SNAPSHOT.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    NoEmpty  = Table.ReplaceValue(Promoted, "", null, Replacer.ReplaceValue, Table.ColumnNames(Promoted)),
    Typed    = Table.TransformColumnTypes(NoEmpty, {
        {"SNAPSHOT_TIME", type text}, {"SP_ID", type text}, {"DESCRIPTION", type text}, {"NAME", type text},
        {"INCONSISTENCYTYPE", Int64.Type}, {"ISAPPROVED", Int64.Type}, {"INCONSISTENCYSTATUS", Int64.Type}, {"SEVERITY", Int64.Type},
        {"SP_DRAWINGID", type text}, {"SP_ITEM1ID", type text}, {"SP_ITEM2ID", type text},
        {"ITEMTAG1", type text}, {"ITEMTAG2", type text}, {"ITEMTYPENAME1", type text}, {"ITEMTYPENAME2", type text},
        {"SP_PLANTGROUPID", type text}})
in
    Typed


// ----- 5. In each of the 4 TABLE queries, change ONLY the first "Source =" line -----
// Open the query in the Advanced Editor and replace the line that starts with
//   Source = if SourceType = "ORACLE" then ... else ...,
// with the matching line below. Do not change anything else in these queries.
//
//   DRAWING_DIM                  ->  Source = VW_PBI_DRAWING_CSV,
//   INCONSISTENCY_TYPE_DIM       ->  Source = VW_PBI_INCONSISTENCY_TYPE_CSV,
//   INCONSISTENCY_FACT           ->  Source = VW_PBI_INCONSISTENCY_CSV,
//   INCONSISTENCY_SNAPSHOT_FACT  ->  Source = VW_PBI_INCONSISTENCY_SNAPSHOT_CSV,

' MergeDuplicateSelectedItems.vbs
' Purpose: Merge duplicate item numbers among selected items in Camduct.

Dim App, Job, i, j
Dim selCount, totalQty
Dim dict

' Connect to the running Camduct instance
On Error Resume Next
Set App = GetObject(, "Fabrication.Application")
If Err.Number <> 0 Then
    MsgBox "Could not connect to Camduct. Make sure Camduct is running.", vbExclamation, "Merge Script"
    WScript.Quit
End If
On Error GoTo 0

Set Job = App.ActiveJob
If Job Is Nothing Then
    MsgBox "No active job found. Open a job in Camduct first.", vbExclamation, "Merge Script"
    WScript.Quit
End If

' Count selected items
selCount = Job.NumSelected
If selCount < 2 Then
    MsgBox "Select two or more items to merge duplicates.", vbExclamation, "Merge Script"
    WScript.Quit
End If

Set dict = CreateObject("Scripting.Dictionary")

' First pass: group selected items by number
For i = 1 To selCount
    Dim num, qty, id
    id = Job.Selected(i)
    num = Job.Item(id).Number
    qty = Job.Item(id).Qty

    If num <> "" Then
        If dict.Exists(num) Then
            dict(num) = dict(num) & "," & id
        Else
            dict.Add num, id
        End If
    End If
Next

' Second pass: merge duplicates
Dim key
For Each key In dict.Keys
    Dim idList, ids, baseID, total
    idList = dict(key)
    ids = Split(idList, ",")

    If UBound(ids) > 0 Then
        total = 0

        ' Sum quantities
        For j = 0 To UBound(ids)
            total = total + Job.Item(CInt(ids(j))).Qty
        Next

        ' Update first item with total
        baseID = CInt(ids(0))
        Job.Item(baseID).Qty = total

        ' Delete the rest
        For j = 1 To UBound(ids)
            Job.DeleteItem CInt(ids(j))
        Next
    End If
Next

MsgBox "Duplicate item numbers merged among selected items.", vbInformation, "Merge Script"

Set dict = Nothing
Set Job = Nothing
Set App = Nothing
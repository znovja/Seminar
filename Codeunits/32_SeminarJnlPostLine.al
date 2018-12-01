codeunit 50132 "CSD Seminar Jnl.-Post Line"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper 
    // Chapter 7 - Lab 2-8

    TableNo = "CSD Seminar Journal Line";

    trigger OnRun()
    begin

    end;

    var
        SeminarJnlLine: Record "CSD Seminar Journal Line";
        SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";
        SeminarRegister: Record "CSD Seminar Register";
        SeminarJnlCheckLine: Codeunit "CSD Seminar Jnl.-Check Line";
        NextEntryNo: Integer;

    local procedure Code()
    var
        myInt: Integer;
    begin
        with SeminarJnlLine do begin

            if NextEntryNo = 0 then begin
                SeminarLedgerEntry.LockTable;
                if SeminarLedgerEntry.FindLast then
                    NextEntryNo := SeminarLedgerEntry."Entry No.";
                NextEntryNo := NextEntryNo + 1;
            end;

            if SeminarRegister."No." = 0 then begin
                SeminarRegister.LockTable;
                if (not SeminarRegister.FindLast) or (SeminarRegister."To Entry No." <> 0) then begin
                    SeminarRegister.INIT;
                    SeminarRegister."No." := SeminarRegister."No." + 1;
                    SeminarRegister."From Entry No." := NextEntryNo;
                    SeminarRegister."To Entry No." := NextEntryNo;
                    SeminarRegister."Creation Date" := TODAY;
                    SeminarRegister."Source Code" := "Source Code";
                    SeminarRegister."Journal Batch Name" := "Journal Batch Name";
                    SeminarRegister."User ID" := USERID;
                    SeminarRegister.Insert;
                end;
            end;
        end;
        SeminarRegister."To Entry No." := NextEntryNo;
        SeminarRegister.Modify;

        SeminarLedgerEntry.INIT;
        SeminarLedgerEntry."Seminar No." := SeminarJnlLine."Seminar No.";
        SeminarLedgerEntry."Posting Date" := SeminarJnlLine."Posting Date";
        SeminarLedgerEntry."Document Date" := SeminarJnlLine."Document Date";
        SeminarLedgerEntry."Entry Type" := SeminarJnlLine."Entry Type";
        SeminarLedgerEntry."Document No." := SeminarJnlLine."Document No.";
        SeminarLedgerEntry.Description := SeminarJnlLine.Description;
        SeminarLedgerEntry."Bill-to Customer No." := SeminarJnlLine."Bill-to Customer No.";
        SeminarLedgerEntry."Charge Type" := SeminarJnlLine."Charge Type";
        SeminarLedgerEntry.Type := SeminarJnlLine.Type;
        SeminarLedgerEntry.Quantity := SeminarJnlLine.Quantity;
        SeminarLedgerEntry."Unit Price" := SeminarJnlLine."Unit Price";
        SeminarLedgerEntry."Total Price" := SeminarJnlLine."Total Price";
        SeminarLedgerEntry."Participant Contact No." := SeminarJnlLine."Participant Contact No.";
        SeminarLedgerEntry."Participant Name" := SeminarJnlLine."Participant Name";
        SeminarLedgerEntry.Chargeable := SeminarJnlLine.Chargeable;
        SeminarLedgerEntry."Room Resource No." := SeminarJnlLine."Room Resource No.";
        SeminarLedgerEntry."Instructor Resource No." := SeminarJnlLine."Instructor Resource No.";
        SeminarLedgerEntry."Starting Date" := SeminarJnlLine."Starting Date";
        SeminarLedgerEntry."Seminar Registration No." := SeminarJnlLine."Seminar Registration No.";
        SeminarLedgerEntry."Res. Ledger Entry No." := SeminarJnlLine."Res. Ledger Entry No.";
        SeminarLedgerEntry."Source Type" := SeminarJnlLine."Source Type";
        SeminarLedgerEntry."Source No." := SeminarJnlLine."Source No.";
        SeminarLedgerEntry."Journal Batch Name" := SeminarJnlLine."Journal Batch Name";
        SeminarLedgerEntry."Source Code" := SeminarJnlLine."Source Code";
        SeminarLedgerEntry."Reason Code" := SeminarJnlLine."Reason Code";
        SeminarLedgerEntry."Posting No. Series" := SeminarJnlLine."Posting No. Series";
        SeminarLedgerEntry."Entry No." := NextEntryNo;
        NextEntryNo += 1;
        SeminarLedgerEntry.Insert;
    end;

    procedure RunWithCheck(var SeminarJnLine2: Record "CSD Seminar Journal Line");
    var
        myInt: Integer;
    begin
        with SeminarJnLine2 do begin
            SeminarJnlLine := SeminarJnLine2;
            Code();
            SeminarJnLine2 := SeminarJnlLine;
        end;
    end;
}
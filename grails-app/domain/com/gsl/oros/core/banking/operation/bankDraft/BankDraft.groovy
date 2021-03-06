package com.gsl.oros.core.banking.operation.bankDraft
import com.gsl.cbs.contraints.enums.DraftType

class BankDraft {
    String acholderName
    String bankName
    String branchName
    Double amount
    DraftType status
    static constraints = {
    status nullable: true
    }
}

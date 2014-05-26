package com.gsl.oros.core.banking.operation.withdrawal

import com.gsl.oros.core.banking.operation.Client

class WithdrawalApprove {
    Double amount
    String chequeNo
    String signatureOwner
    String withdrawalType
    Date withdrawDate
    Client client
    String status

    static constraints = {
        withdrawalType nullable: true
    }
}

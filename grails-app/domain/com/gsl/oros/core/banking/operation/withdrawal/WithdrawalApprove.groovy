package com.gsl.oros.core.banking.operation.withdrawal

import com.gsl.oros.core.banking.operation.Client
import com.gsl.plugin.attachments.OrosAttachment

class WithdrawalApprove {
    Double amount
    String chequeNo
    String signatureOwner
    String withdrawalType
    Date withdrawDate
    Client client
    String status

    OrosAttachment orosAttachment


    static constraints = {
        withdrawalType nullable: true
    }
}

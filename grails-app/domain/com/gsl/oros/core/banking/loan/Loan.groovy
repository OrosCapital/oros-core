package com.gsl.oros.core.banking.loan

import com.gsl.cbs.contraints.enums.StatusType
import com.gsl.oros.core.banking.operation.Client
import com.gsl.plugin.attachments.OrosAttachment

class Loan {
    Long id
    Integer amount
    String amountInWord
    String accountNo
    String accountName
    String purpose
    String income
    Date durationStart
    Date durationEnd
    Client client
    StatusType status=StatusType.REQUESTED
    Boolean sts=true
    static hasMany =[attachments:OrosAttachment]
    static constraints = {
        purpose nullable: true
        amountInWord nullable: true
        income nullable: true
        accountName nullable: true

    }
}

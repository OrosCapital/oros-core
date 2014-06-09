package com.gsl.oros.core.banking

import com.gsl.cbs.contraints.enums.TransactionType
import com.gsl.uma.security.User

class TransactionMaster {
    String glCode
    Double amount
    String invoiceNumber
    Date transactionDate
    TransactionType transactionType //enam
    String reconciliationCode

    User createdBy    // logged in user
    Date createdOn
    User updatedBy    // logged in user
    Date updatedOn

    static constraints = {
        updatedBy nullable: true
        updatedOn nullable: true
    }
}

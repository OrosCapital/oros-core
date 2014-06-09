package com.gsl.oros.core.banking

import com.gsl.cbs.contraints.enums.TransactionType
import com.gsl.uma.security.User

class InvoiceMaster {
    Long invoiceId		// object of Invoice
    String invoiceNumber	// formatted generated
    TransactionType transactionType	//enam Payment, Deposit, Withdrawal,Transfer
    Date transactionDate
    Double amount
    String accountNumber
    String glCode
    String note

    User createdBy	// logged in user
    Date createdOn
    User updatedBy	// logged in user
    Date updatedOn

    static constraints = {
        updatedBy nullable: true
        updatedOn nullable: true
        note nullable: true
    }
}

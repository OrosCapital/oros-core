package com.gsl.oros.core.banking.operation.bankDraft

class BankAccount {
    String bankAccountNo
    String bankAccountName
    Double amount
    Date today
    String financialInstitution
    String routingNo
    static constraints = {
        financialInstitution nullable: true
        routingNo nullable: true
    }
}

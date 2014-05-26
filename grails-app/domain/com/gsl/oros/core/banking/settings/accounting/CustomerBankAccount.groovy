package com.gsl.oros.core.banking.settings.accounting

class CustomerBankAccount {
    String bankName
    String bankAccountName
    String bankAccountNo
    String ibanPrefix
    Boolean status = true

    static constraints = {
        bankName nullable: false
        bankAccountName nullable: false
        bankAccountNo nullable: false
        ibanPrefix nullable: false
        status nullable: false

    }
}

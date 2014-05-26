package com.gsl.oros.core.banking.operation

import com.gsl.oros.core.banking.settings.Bank
import com.gsl.oros.core.banking.settings.Branch

class AccountOtherBank {

    String otherBankAccNo
    String accountTitle
    String otherBankAccType
    String sortCode

    boolean status = true


    static belongsTo = [bank:Bank, branch:Branch]

    static constraints = {}
}

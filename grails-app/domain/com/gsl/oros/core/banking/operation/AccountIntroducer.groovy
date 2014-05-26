package com.gsl.oros.core.banking.operation

import com.gsl.oros.core.banking.accountHolder.AccountHolder

class AccountIntroducer {
    String relation
    boolean status = true
    static belongsTo = [accountHolder : AccountHolder]

    static constraints = {
    }
}

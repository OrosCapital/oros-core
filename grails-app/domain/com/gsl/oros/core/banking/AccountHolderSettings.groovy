package com.gsl.oros.core.banking

import com.gsl.cbs.contraints.enums.AccountType

class AccountHolderSettings {
    int prefix	//101
    AccountType accountType	//Savings/Current/Retail
    int length

    static constraints = {
    }
}

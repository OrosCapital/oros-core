package com.gsl.oros.core.banking

import com.gsl.uma.security.User

class SavingsAccountHolder {
    Long customerId
    String accountNumber
    //int prefix		// will be in account settings table
    Long productId
    Double balance

    User createdBy	// logged in user
    Date createdOn
    User updatedBy	// logged in user
    Date updatedOn

    static constraints = {
        updatedBy nullable: true
        updatedOn nullable: true
    }
}

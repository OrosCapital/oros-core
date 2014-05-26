package com.gsl.oros.core.banking.operation.bankDraft
import com.gsl.oros.core.banking.settings.Address

class BankDraft {
    String firstName
    String lastName
    String nationalID
    Address address
    static constraints = {
        address nullable: true
        nationalID nullable: true
    }
}

package com.gsl.uma.security

import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.oros.core.banking.settings.BranchSetup

class Hierarchy {
    User user
    Integer rank
    BankSetup bankSetup
    BranchSetup branchSetup
    boolean status
    static constraints = {
        rank unique: true
        bankSetup nullable: true
        branchSetup nullable: true
    }
}

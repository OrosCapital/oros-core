package com.gsl.oros.core.banking.product.savings

class SavingsTermSetup {
    Integer productId
    Integer type
    Integer min
    Integer max
    String circleId

    //static belongsTo = [savingsProduct:SavingsProduct]

    static constraints = {
        productId nullable: false;
        type nullable: false;
        min nullable: false;
        max nullable: false;
        circleId nullable: false;
    }
}

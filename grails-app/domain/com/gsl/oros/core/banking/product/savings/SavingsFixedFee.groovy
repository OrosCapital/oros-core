package com.gsl.oros.core.banking.product.savings

class SavingsFixedFee {
    Long productId
    Double min
    Double max
    String rateType
    Double value

    //static belongsTo = [savingsProduct:SavingsProduct]

    static constraints = {
        productId nullable: false;
        min nullable: false;
        max nullable: false;
        rateType nullable: false;
        value nullable: false;
    }
}

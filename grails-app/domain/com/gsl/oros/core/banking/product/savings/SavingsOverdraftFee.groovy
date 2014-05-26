package com.gsl.oros.core.banking.product.savings

class SavingsOverdraftFee {
    Long productId
    Double min
    Double max
    String circleId
    String rateType
    Double value

    static constraints = {
        productId nullable: false;
        min nullable: false;
        max nullable: false;
        circleId nullable: false;
        rateType nullable: false;
        value nullable: false;
    }
}

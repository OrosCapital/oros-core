package com.gsl.oros.core.banking.clients

import com.gsl.plugin.attachments.OrosAttachment

class RetailAccount {

    String title
    Date openingDate
    String accountPurpose
    Integer termAndCondition
    Long createAccountInfoId // fk

    boolean status = true

    static hasMany = [retailIntroducer: RetailIntroducer, retailOtherBank: RetailOtherBank, retailNominee: RetailNominee, retailSignature: OrosAttachment]

    static constraints = {
        /*title blank: true, nullable: true
        openingDate blank: true, nullable: true
        accountPurpose blank: true, nullable: true
        termAndCondition blank: true, nullable: true
        status blank: true, nullable: true*/
    }

}

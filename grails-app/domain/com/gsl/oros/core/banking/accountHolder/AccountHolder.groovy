package com.gsl.oros.core.banking.accountHolder

import com.gsl.oros.core.banking.attachments.Attachments
import com.gsl.oros.core.banking.attachments.Pictures
import com.gsl.oros.core.banking.settings.Address
import com.gsl.oros.core.banking.settings.Country
import com.gsl.plugin.attachments.OrosAttachment

class AccountHolder {
    String firstName
    String middleName
    String lastName
    String motherName
    String fatherName
    String gender
    String profession
    Country birthCountry
    Country nationality1
    Country nationality2
    String nationalID
    Address generalAddress
    Address postalAddress
    OrosAttachment pictures
    Boolean status = true

    static hasMany = [spouse:SpouseInfo, educationalInfo: EducationalInfo, attachments: OrosAttachment]

    static constraints = {
        generalAddress nullable: true
        postalAddress nullable: true
        spouse nullable: true
        middleName nullable: true
        fatherName nullable: true
        motherName nullable: true
        gender nullable: true
        profession nullable: true
        nationality2 nullable: true
        nationalID nullable: true
        pictures nullable: true
    }
}

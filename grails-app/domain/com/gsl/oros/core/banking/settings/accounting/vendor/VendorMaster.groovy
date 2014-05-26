package com.gsl.oros.core.banking.settings.accounting.vendor

import com.gsl.oros.core.banking.settings.Address
import com.gsl.oros.core.banking.settings.accounting.VatCategory
class VendorMaster {

    Integer byShop
    String chamOfCommerce
    String comments
    String companyName
    String creditStatus
    String currCode
    String defaultGlAccount
    String email
    String firstName
    String frequencyOfInvoice
    String gender
    String lastName
    String middleName
    String momentOfSending
    Integer status
    VatCategory vat
    String vendorCode
    String vendorName
    String vendorType
    Integer paymentTermId
    Address generalAddress
    Address postalAddress

    static hasMany = [bankAccountInfo:VendorBankAccount]
    static constraints = {
        generalAddress nullable: true
        postalAddress nullable: true
        bankAccountInfo nullable: true
        chamOfCommerce nullable: true
        comments nullable: true
        defaultGlAccount nullable: true
        email nullable: true, email: true
        firstName nullable: true
        gender nullable: true
        frequencyOfInvoice nullable: true
        lastName nullable: true
        currCode nullable: true
        momentOfSending nullable: true
        middleName nullable: true
        companyName nullable: true
        vat nullable: true
        vendorCode unique: true
        vendorType nullable: true
    }
}

package com.gsl.oros.core.banking.operation

import com.gsl.cbs.contraints.enums.AddressType
import com.gsl.oros.core.banking.settings.Address
import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.oros.core.banking.operation.bankDraft.BankDraft
import com.gsl.oros.core.banking.operation.bankDraft.BankAccount

class BankDraftController {

    def index() {
        render(view: '/coreBanking/settings/operation/bankDraft/chargeList')

    }

    def create(){

        render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [tabSelectIndicator: 1, dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                dateMask: "99/99/9999", decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])

    }

    def savePersonalInfo(BankDraftCommand bankDraftCommand){
        if (request.method == "POST") {
            def tabSelector = 1
            if (bankDraftCommand.hasErrors()) {
                render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [bankDraft: bankDraftCommand, tabSelectIndicator: tabSelector])
                return
            }
            BankDraft bankDraft
            BankDraft savedBankDraft
            Address address
            Address savedAddress
            address = new Address(bankDraftCommand.address.properties)
            address.addressType = AddressType.GENERAL
            savedAddress = address.save(flush: true)
            bankDraft = new BankDraft(bankDraftCommand.properties)
            bankDraft.address = savedAddress
            if (!bankDraft.validate()) {
                render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [bankDraft: bankDraft, tabSelectIndicator: tabSelector])
                return
            }
            savedBankDraft = bankDraft.save(flush: true)
            if (!savedBankDraft) {
                render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [bankDraft: bankDraft, tabSelectIndicator: tabSelector])
                return
            }

            flash.message = "Personal Information of Bank Draft Owner Saved Successfully"
            render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [tabSelectIndicator: 2, bankDraft: savedBankDraft, decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
            }else {
                render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [tabSelectIndicator: 1])
            }


    }
    def saveBankAccountInfo(BankAccountCommand bankAccountCommand){
        if (request.method == "POST"){
            def tabSelector = 2
            if (bankAccountCommand.hasErrors()){
                render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [tabSelectIndicator: tabSelector, bankAccountInfo: bankAccountCommand])
                return
            }

            BankAccount bankAccountInfo
            BankAccount savedBankAccountInfo
            bankAccountInfo = new BankAccount(bankAccountCommand.properties)

            if(!bankAccountInfo.validate()){
                render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [tabSelectIndicator: tabSelector, bankAccountInfo: bankAccountInfo])
                return
            }

            savedBankAccountInfo = bankAccountInfo.save(flush: true)
            if(!savedBankAccountInfo){
                render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [tabSelectIndicator: tabSelector, bankAccountInfo: bankAccountInfo])
                return
            }
            flash.message = "Bank Account Info of Draft Owner Successfully Saved"
            render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2, tabSelectIndicator: tabSelector, bankAccountInfo: savedBankAccountInfo])
        }else {
            render(template: '/coreBanking/settings/operation/bankDraft/personalInfo', model: [tabSelectIndicator: 2])
        }
    }
}

class BankDraftCommand{
    String firstName
    String lastName
    String nationalID
    Address address
    static constraints = {
        importFrom BankDraft

    }
}

class BankAccountCommand{
    String bankAccountNo
    String bankAccountName
    Double amount
    Date today
    String financialInstitution
    String routingNo
    static constraints = {
        importFrom BankAccount

    }

}

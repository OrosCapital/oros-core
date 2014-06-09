package com.gsl.oros.core.banking.operation

import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.oros.core.banking.operation.bankDraft.BankDraft
import com.gsl.oros.core.banking.operation.bankDraft.DraftPayment
import grails.converters.JSON

class BankDraftController {

    def index() {
        render(view: '/coreBanking/settings/operation/bankDraft/chargeList')

    }

    def create(){
        render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [tabSelectIndicator: 1, decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
    }

    def saveOwnerInfo(BankDraftCommand bankDraftCommand){
        if (request.method == "POST") {
            def tabSelector = 1
            if (bankDraftCommand.hasErrors()) {
                render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [bankDraft: bankDraftCommand, tabSelectIndicator: tabSelector])
                return
            }
            BankDraft bankDraft
            BankDraft savedBankDraft
            bankDraft = new BankDraft(bankDraftCommand.properties)
            if (!bankDraft.validate()) {
                render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [bankDraft: bankDraft, tabSelectIndicator: tabSelector])
                return
            }
            savedBankDraft = bankDraft.save(flush: true)
            if (!savedBankDraft) {
                render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [bankDraft: bankDraft, tabSelectIndicator: tabSelector])
                return
            }

            flash.message = "Owner Information of Bank Draft Saved Successfully"
            render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [tabSelectIndicator: 2, bankDraft: savedBankDraft, decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
            }else {
                render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [tabSelectIndicator: 1])
            }

    }
    def checkPaidByAcNo(){
//        def result = Client.findByAccountNo(params.accountNo)
        def result
        if(params.accountNo == "123456"){
             result = "123456"
        }else {
             result = null
        }
        def r = [result: result]
        render r as JSON
    }
    def savePaymentInfo(DraftPaymentCommand draftPaymentCommand){
        if (request.method == "POST"){
            def tabSelector = 2
            if (draftPaymentCommand.hasErrors()){
                render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [tabSelectIndicator: tabSelector, draftPayment: draftPaymentCommand])
                return
            }

            DraftPayment draftPayment
            DraftPayment savedDraftPayment
            draftPayment = new DraftPayment(draftPaymentCommand.properties)
            BankDraft bankDraft = BankDraft.read(draftPaymentCommand.draftId)
            draftPayment.amount = bankDraft.amount
            if(!draftPayment.validate()){
                render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [tabSelectIndicator: tabSelector, draftPayment: draftPayment])
                return
            }

            savedDraftPayment = draftPayment.save(flush: true)
            if(!savedDraftPayment){
                render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [tabSelectIndicator: tabSelector, draftPayment: draftPayment])
                return
            }
            flash.message = "Payment Info of Draft Owner Successfully Saved"
            render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2, tabSelectIndicator: 3, draftPayment: savedDraftPayment])
        }else {
            render(template: '/coreBanking/settings/operation/bankDraft/ownerInfo', model: [tabSelectIndicator: 2])
        }
    }

    def processDraftRequest(){
        Double balance = 50000.0
        DraftPayment draftPayment = DraftPayment.read(params.paymentId)
        Double checkingAmount = balance - 2000.0
        def result
        if (draftPayment.amount > checkingAmount){

            result = [message: "Your Requested Amount Exceed Your Balance", draftPayment: draftPayment]
            render result as JSON
        }else{
            //go to invoice receipt
        }

    }


}

class BankDraftCommand{
    String acholderName
    String bankName
    String branchName
    Double amount
    static constraints = {
        importFrom BankDraft

    }
}

class DraftPaymentCommand{
    String amountInWord
    Long draftId
    String paymentType
    String paidByAcNo
    String nameForCash
    String nameForAc
    Double amount
    String nationalID
    String phoneNo
    static constraints = {
        importFrom DraftPayment
        draftId nullable: true
        amountInWord nullable: true
    }

}

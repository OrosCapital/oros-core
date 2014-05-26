package com.gsl.oros.core.banking.operation

import com.gsl.cbs.contraints.enums.DepositType
import com.gsl.oros.core.banking.settings.BankDepositCheck
import com.gsl.oros.core.banking.settings.BankDepositBankTransfer
import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.oros.core.banking.settings.CreditCard
import com.gsl.uma.security.User
import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.codehaus.groovy.grails.plugins.jasper.JasperExportFormat
import org.codehaus.groovy.grails.plugins.jasper.JasperReportDef


class DepositController {

    def springSecurityService
    def jasperService

    def index() {
        /*render(template: '/coreBanking/settings/operation/bankDeposit', model: [
                dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                dateMask: "99/99/9999", currentDt: new Date().format("dd/MM/yyyy"),
                decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2
        ])*/
    }
    def cashDeposit() {
        render(template: '/coreBanking/settings/operation/cashDeposit', model: [
                dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                dateMask: "99/99/9999", currentDt: new Date().format("dd/MM/yyyy"),
                decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2
        ])
    }

    def chequeDeposit() {
        render(template: '/coreBanking/settings/operation/chequeDeposit', model: [
                dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                dateMask: "99/99/9999", currentDt: new Date().format("dd/MM/yyyy"),
                decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2
        ])
    }

    def showChequeInfo(Integer chequeNumber) {
        // need cheque information of a client
        Map data
        BankDepositCheck result = BankDepositCheck.findByAccountNumber(chequeNumber)
        if (!result) {
            data = [success: false, chequeNo: chequeNumber]
            render(data as JSON)
            return
        } else {
            data = [success: true, chequeNo: 205537130]
            render(data as JSON)
            return
        }
    }

    def bankTransfer() {
        def bankTransferCheckNo = params.bankTransferCheckNo
        println("the id is  " + bankTransferCheckNo)
        def result = BankDepositBankTransfer.findByCheckNo(bankTransferCheckNo)
        def bankTransferAccountHolderInfo
        if (!result) {
            bankTransferAccountHolderInfo = [success: false, message: "SORRY,NO FOUND", btnErrorMessage: 1]
            render bankTransferAccountHolderInfo as JSON
            return
        }
        bankTransferAccountHolderInfo = [success: true, value: result, message: "yes"]
        String output = bankTransferAccountHolderInfo as JSON
        render output
    }

    def creditCard() {
        def creditCardHolderFirstName = params.creditCardHolderFirstName
        def result = CreditCard.findByCreditCardHolderFirstName(creditCardHolderFirstName)
        if (!result) {
            render(contentType: 'text/json') {
                [success: true, message: 'SORRY !!! THE DESIRED NAME IS NOT FOUND', error: 1]
            }
        }
        def accountHolderInfo = [success: true, message: 'Some Message Will Display Here', value: result]
        render accountHolderInfo as JSON
    }

    def deposit(DepositCommand depositCommand) {

        String depositType = params.depositType.toString()
        println "params " + params
        if (depositType == DepositType.CASH.toString()) {

            if (depositCommand.hasErrors()) {
                render(template: '/coreBanking/settings/operation/cashDeposit', model: [commandObjError: depositCommand])
                return
            }

            Deposit deposit = new Deposit(depositCommand.properties)
            deposit.balance = 0.00d
            deposit.depositType = DepositType.CASH
            deposit.createdBy = User.read(springSecurityService.principal.id)
            deposit.validate()

            if (!deposit.hasErrors()) {
                deposit.save(flush: true);
            }

            DepositTypeCash depositTypeCash = new DepositTypeCash(depositCommand.cash.properties)
            depositTypeCash.deposit = deposit
            depositTypeCash.save(flush: true);
            // show cash receipt in pdf


            flash.message = " Account deposited successfully"
            render(template: '/coreBanking/settings/operation/cashDeposit', model: [
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999", currentDt: new Date().format("dd/MM/yyyy"),
                    decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2
            ])
//            cashReceipt(deposit)
            return

        }
        if (depositType == DepositType.CHEQUE.toString()) {
            if (depositCommand.hasErrors()) {
                render(template: '/coreBanking/settings/operation/depositCheck', model: [commandObjError: depositCommand])
                return
            }

            Deposit deposit = new Deposit(depositCommand.properties)
            deposit.balance = 0.00d
//            deposit.status = 0
            deposit.depositType = DepositType.CHEQUE
            deposit.createdBy = User.read(springSecurityService.principal.id)
            deposit.validate()

            if (!deposit.hasErrors()) {
                deposit.save(flush: true);
            }

            DepositTypeCheque depositTypeCheck = new DepositTypeCheque(depositCommand.cheque.properties)
            depositTypeCheck.deposit = deposit
            depositTypeCheck.save();

            flash.message = " Account deposited successfully"
            render(template: '/coreBanking/settings/operation/cashDeposit', model: [
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999", currentDt: new Date().format("dd/MM/yyyy"),
                    decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2
            ])
            return
        }

        if (depositType == DepositType.BANK_TRANSFER.toString()) {
            // do somethings

            if (depositCommand.hasErrors()) {
                render(template: '/coreBanking/settings/operation/cashDeposit', model: [commandObjError: depositCommand])
                return
            }

            Deposit deposit = new Deposit(depositCommand.properties)
            deposit.balance = 0.00d
            deposit.depositType = DepositType.BANK_TRANSFER
            deposit.createdBy = User.read(springSecurityService.principal.id)
            deposit.validate()

            if (!deposit.hasErrors()) {
                deposit.save(flush: true);
            }

            DepositTypeBankTransfer depositTypeBankTransfer = new DepositTypeBankTransfer(depositCommand.bank.properties)
            depositTypeBankTransfer.deposit = deposit
            depositTypeBankTransfer.save(flush: true);

            flash.message = " Bank transfer successfully"
            render(template: '/coreBanking/settings/operation/cashDeposit', model: [
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999", currentDt: new Date().format("dd/MM/yyyy"),
                    decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2
            ])
            return
        }

        if (depositType == DepositType.CREDIT_CARD.toString()) {
            // do somethings
            if (depositCommand.hasErrors()) {
                render(template: '/coreBanking/settings/operation/cashDeposit', model: [commandObjError: depositCommand])
                return
            }

            Deposit deposit = new Deposit(depositCommand.properties)
            deposit.balance = 0.00d
            deposit.depositType = DepositType.CREDIT_CARD
            deposit.createdBy = User.read(springSecurityService.principal.id)
            deposit.validate()

            if (!deposit.hasErrors()) {
                deposit.save(flush: true);
            }

            DepositTypeCard depositTypeCard = new DepositTypeCard(depositCommand.card.properties)
            depositTypeCard.deposit = deposit
            depositTypeCard.save(flush: true);

            flash.message = " Account deposited successfully"
            render(template: '/coreBanking/settings/operation/cashDeposit', model: [
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999", currentDt: new Date().format("dd/MM/yyyy"),
                    decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2
            ])

            return
        }
    }

    private static final String JASPER_FILE = 'cashReceiptForDeposit.jasper'
    private static final String REPORT_FILE_FORMAT = 'pdf'
    private static final String OUTPUT_FILE_NAME = "cashReceiptForDeposit.pdf"

    private void cashReceipt(Deposit deposit) {
        Map reportMap = new LinkedHashMap()
        reportMap.put("clientAccountId",deposit.accountHolderId)
        reportMap.put("depositAmount",deposit.amount)

        File reportFolder = ApplicationHolder.application.parentContext.getResource("/reports/deposit").file;
        String reportDir = reportFolder.absolutePath;
        println "reportDir " + reportDir
        JasperReportDef reportDef = new JasperReportDef(name: JASPER_FILE, fileFormat: JasperExportFormat.PDF_FORMAT,
                parameters: reportMap, folder: reportDir)
        ByteArrayOutputStream report = jasperService.generateReport(reportDef)            // generate report

        response.contentType = ConfigurationHolder.config.grails.mime.types[REPORT_FILE_FORMAT]
        response.setHeader("Content-disposition", "attachment;filename=${OUTPUT_FILE_NAME}")
        response.outputStream << report.toByteArray()
    }

    def validateCheque(String chequeNumber, String isValid) {
//        String dummyChequeNumber = "205537130"
        boolean isValidCheque = Boolean.parseBoolean(isValid)
        Map chequeInfoObj
        if (isValidCheque) {
            String verifiedInfo = "Cheque Number (${chequeNumber}) Verified."

            chequeInfoObj = [verified: true, verifiedInfo: verifiedInfo]
            render(chequeInfoObj as JSON)
            return
        } else {
            String notVerifiedInfo = "Cheque Number ( ${chequeNumber} ) Invalid.!"
            chequeInfoObj = [verified: false, notVerifiedInfo: notVerifiedInfo]
            render(chequeInfoObj as JSON)
            return
        }
    }
}

class DepositCommand {
    Long accountHolderId
    Long branchId
    Date dateOfDeposit
    String recipientCurrency
    String depositorCurrency
    Double amount
    int status

    DepositTypeCash cash
    DepositTypeCheque cheque
    DepositTypeBankTransfer bank
    DepositTypeCard card

    static constraints = {
        accountHolderId nullable: false
        branchId nullable: false
        dateOfDeposit nullable: false
        recipientCurrency nullable: false
        depositorCurrency nullable: false
        amount nullable: false
        cash nullable: true
        cheque nullable: true
        bank nullable: true
        card nullable: true
    }
}


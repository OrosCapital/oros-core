package com.gsl.oros.core.banking.operation

import com.gsl.oros.core.banking.operation.withdrawal.WithdrawalApprove
import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.plugin.attachments.OrosAttachment
import grails.converters.JSON

class CashWithdrawalController {
    def imageIndirectService

    def index() {
        render(view: '/coreBanking/settings/operation/cashWithdrawal/cashWithdrawal',
                model: [decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])


    }

    def accountNoVerify() {
        def verifyAccountNo = Client.findByAccountNo(params.accountNo)
        if (verifyAccountNo) {
            def result = [isError: false, accountInfo: verifyAccountNo]
            String outPut = result as JSON
            render outPut
            return
        }
        def result = [isError: true, message: "Account Holder Not Found"]
        render result as JSON
    }

    def save(CashWithdrawalCommand cashWithdrawalCommand) {

        def file = request.getFile('signature')

        if (!request.method == 'POST') {
            cashWithdrawalCommand.properties == null
            def result = [isError: true, message: 'Sorry Requested Method Is Not Post']
            render result as JSON
            return
        }
        if (cashWithdrawalCommand.hasErrors()) {
            cashWithdrawalCommand.properties == null
            def result = [isError: true, message: 'Transaction Is Terminate']
            render result as JSON
            return
        }
        WithdrawalApprove withdrawalApprove = new WithdrawalApprove(cashWithdrawalCommand.properties)
        if (!cashWithdrawalCommand.validate()) {
            cashWithdrawalCommand.properties == null
            def result = [isError: true, message: 'Transaction Is Terminate']
            render result as JSON
            return
        }
        Client clientInfo = Client.findByAccountNo(params.accountNo)
        withdrawalApprove.client = clientInfo

        Long attachmentId = signature(clientInfo, file)
        if (attachmentId == 0) {
            def result = [isError: true, message: 'Have some problem in signature Image']
            render result as JSON
            return
        }
        withdrawalApprove.orosAttachment = OrosAttachment.findById(attachmentId)
        WithdrawalApprove savedApprove = withdrawalApprove.save(flush: true)
        if (!savedApprove) {
            cashWithdrawalCommand.properties == null
            def result = [isError: true, message: 'Sorry']
            render result as JSON
            return
        }
        def result = [isError: false, message: 'Transaction Is On Approve Process']
        render result as JSON
        return
    }

    private Long signature(Client clientInfo, file) {
        String signatureName = clientInfo.name + " Signature for cash withdrawal"
        String originalName = file.originalFilename
        String type = file.contentType
        Long size = file.size

        if (!(type in ['image/jpeg', 'image/gif', 'image/bmp', 'image/png', 'image/jpg'])) {
            return 0
        }
        if (size >= 900000) {
            return 0
        }
        OrosAttachment orosAttachment = new OrosAttachment(
                name: signatureName,
                originalName: originalName,
                type: type,
                fileDir: "cashWithdrawal/" + clientInfo.accountNo.toString(),
                size: size
        )
        if (!orosAttachment.validate()) {
            return 0
        }
        OrosAttachment savedSignature = orosAttachment.save(flush: true)
        if (!savedSignature) {
            return 0
        }
        File uploadInDirectory = imageIndirectService.storeFile(file, orosAttachment.link, orosAttachment.fileDir)
        return savedSignature.id

    }


}

class CashWithdrawalCommand {

    Double amount
    String chequeNo
    String signatureOwner
    String withdrawalType
    Date withdrawDate = new Date()
    String status = "Pending"
    Client client
    OrosAttachment orosAttachment

    static constraints = {

        withdrawalType nullable: true
        amount nullable: false, validator: { balance, cashWithdrawObj ->
            Double amountExpect = cashWithdrawObj.amount
            Double afterTransBalance = 10000 - amountExpect      //existBalance = 10000
            if (amountExpect > 10000 || afterTransBalance < 500) {
                return false
            }

        }
        chequeNo nullable: false, validator: { chequeNo, cashWithdrawObj ->
            if (chequeNo != "123456789") {
                return false
            }
        }
        signatureOwner nullable: true
    }
}


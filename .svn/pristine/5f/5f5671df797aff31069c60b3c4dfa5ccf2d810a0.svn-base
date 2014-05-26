package com.gsl.oros.core.banking.operation

import com.gsl.oros.core.banking.operation.withdrawal.WithdrawalApprove
import com.gsl.oros.core.banking.settings.BankSetup
import grails.converters.JSON

class CashWithdrawalController {

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
        if (!cashWithdrawalCommand.validate()) {
            def result = [isError: true, message: 'Transaction Is Terminate']
            render result as JSON
            return
        }
        WithdrawalApprove withdrawalApprove = new WithdrawalApprove(cashWithdrawalCommand.properties)
        withdrawalApprove.client = Client.findByAccountNo(params.accountNo)
        def savedApprove = withdrawalApprove.save(failOnError: true)
        if (savedApprove) {
            def result = [isError: false, message: 'Transaction Is On Approve Process']
            render result as JSON
            return
        }
        def result = [isError: true, message: 'Sorry']
        render result as JSON
        return


    }
}

class CashWithdrawalCommand {

    Double amount
    String chequeNo
    String signatureOwner
    String withdrawalType
    Date withdrawDate = new Date()
    String status="Pending"
    Client client

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


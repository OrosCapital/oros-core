package com.gsl.oros.core.banking.loan

import com.gsl.oros.core.banking.settings.BankSetup

class LoanController {

    def index() {
        render(view: '/loan/createLoan')
    }

    def create(){
        render(view: '/loan/loanApplication',model: [
                dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                dateMask: "99/99/9999",
                currentDt: new Date().format("dd/MM/yyyy"),
                decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
    }

    def showLoanInfo(){
           if(params.id=="1")
            render(template: 'loanType1')
           if(params.id=="2")
            render(template: 'loanType2')
            if(params.id=="3")
            render(template: 'loanType3')

    }

    def save(){
        render(view: '/loan/createLoan')
    }

}

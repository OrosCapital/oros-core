package com.gsl.oros.core.banking.operation

class AccountCloseController {

    def index() {
        render(view: '/coreBanking/settings/operation/accountClose/accountClose', model: [tabSelectIndicator: 1])
    }

    def docCollection(AccountCloseCommand accountCloseCommand) {
        if (!request.method == 'post') {
            flash.message = "Request Not Post"
            render(view: '/coreBanking/settings/operation/accountClose/accountClose')
            return
        }
        render(view: '/coreBanking/settings/operation/accountClose/accountClose',
                model: [tabSelectIndicator: 2, accountClose:accountCloseCommand])
    }

   def saveForApprove(){
       render(view: '/coreBanking/settings/operation/accountClose/accountClose', model: [tabSelectIndicator: 1])
   }

}

class AccountCloseCommand{
    Integer preBalance = 10000
    Integer charge = 1000
    Integer getBalance = preBalance - charge
}

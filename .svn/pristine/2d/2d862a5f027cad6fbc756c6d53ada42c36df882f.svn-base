package com.gsl.oros.core.banking.api

import com.gsl.cbs.contraints.enums.AccountType
import grails.rest.RestfulController

class ApiController extends RestfulController {
    static allowedMethods = [accountList: "GET"]
    static responseFormats = ['json']

    def accountList() {
        println params
        String str = params.str
        if(!str || str !='aminul'){
            render status:404
        }
        def accountType = AccountType.findAll()
        println(accountType)
        if(accountType == null) {
            render status:404
        }
        respond(accountType)
    }
}

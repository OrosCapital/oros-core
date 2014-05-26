package com.gsl.oros.core.banking.settings

import com.gsl.oros.core.banking.product.settings.VatCategoryUtility
import grails.converters.JSON

class VatCategoryController {
    def vatCategoryService
    def vatGlAccount = [[id: 1, account: 'Loan Account', accountNum: 10001],
            [id: 2, account: 'Saving Account', accountNum: 10002],
            [id: 3, account: 'Deposit Account', accountNum: 10003]]

    def purchaseGlAc = [[id: 1, account: 'PurchaseAcc A', accountNum: 20001],
            [id: 2, account: 'PurchaseAcc B', accountNum: 20002],
            [id: 3, account: 'PurchaseAcc C', accountNum: 20003]]

    def salesGlAc = [[id: 1, account: 'SalesAcc A', accountNum: 30001],
            [id: 2, account: 'SalesAcc B', accountNum: 30002],
            [id: 3, account: 'SalesAcc C', accountNum: 30003]]

    def index() {

        LinkedHashMap resultMap =vatCategoryService.vatCategoryPaginateList(params)
        if(!resultMap || resultMap.totalCount== 0){
            render(view: '/coreBanking/settings/vatCategoryBackup/vatCategoryList', model: [dataReturns: null, totalCount: 0])
            return
        }
        int totalCount =resultMap.totalCount
        render(view: '/coreBanking/settings/vatCategoryBackup/vatCategoryList', model: [dataReturns: resultMap.results, totalCount: totalCount])

    }

    def create() {
        render(view: '/coreBanking/settings/vatCategoryBackup/vatCategory',
                model: [vatGlAcc: vatGlAccount.asList(),
                        purchaseAcc: purchaseGlAc.asList(),
                        salesGlAcc: salesGlAc.asList()])
    }

    def save(VatCatagoryCommand vatCatagoryCommand) {
        println(vatCatagoryCommand)
        if (!request.method == 'POST') {
            render(view: '/coreBanking/settings/vatCategoryBackup/vatCategory')
            return
        }
        if (vatCatagoryCommand.hasErrors()) {
            render(view: '/coreBanking/settings/vatCategoryBackup/vatCategory',
                    model: [vatCategory: vatCatagoryCommand,
                            vatGlAcc: vatGlAccount.asList(),
                            purchaseAcc: purchaseGlAc.asList(),
                            salesGlAcc: salesGlAc.asList()])
            return
        }
        VatCategoryBackup vatCategoryBackup
        if (params.id) {
            vatCategoryBackup = VatCategoryBackup.get(vatCatagoryCommand.id)
            if (!vatCategoryBackup) {
                flash.message = "Vat Category Is not Available"
                render(view: '/coreBanking/settings/vatCategoryBackup/vatCategory',
                        model: [vatCategory: vatCatagoryCommand,
                                vatGlAcc: vatGlAccount.asList(),
                                purchaseAcc: purchaseGlAc.asList(),
                                salesGlAcc: salesGlAc.asList()])
                return
            }
            vatCategoryBackup.properties = vatCatagoryCommand.properties
            if (!vatCategoryBackup.validate()) {
                render(view: '/coreBanking/settings/vatCategoryBackup/vatCategory',
                        model: [vatCategory: vatCatagoryCommand,
                                vatGlAcc: vatGlAccount.asList(),
                                purchaseAcc: purchaseGlAc.asList(),
                                salesGlAcc: salesGlAc.asList()])
                return
            }
            vatCategoryBackup.save(failOnError: true)

            LinkedHashMap resultMap =vatCategoryService.vatCategoryPaginateList(params)
            flash.message = "SuccessFully Update Vat Category"
            render(view: '/coreBanking/settings/vatCategoryBackup/vatCategoryList',model: [dataReturns: resultMap.results, totalCount: resultMap.totalCount])
            return
        }
        vatCategoryBackup = new VatCategoryBackup(vatCatagoryCommand.properties)
        if (!vatCategoryBackup.validate()) {
            render(view: '/coreBanking/settings/vatCategoryBackup/vatCategory',
                    model: [vatCategory: vatCatagoryCommand,
                            vatGlAcc: vatGlAccount.asList(),
                            purchaseAcc: purchaseGlAc.asList(),
                            salesGlAcc: salesGlAc.asList()])
            return
        }
        VatCategoryBackup vatCatSaved = vatCategoryBackup.save(failOnError: true)
        if (!vatCatSaved) {
            render(view: '/coreBanking/settings/vatCategoryBackup/vatCategory',
                    model: [vatCategory: vatCatagoryCommand,
                            vatGlAcc: vatGlAccount.asList(),
                            purchaseAcc: purchaseGlAc.asList(),
                            salesGlAcc: salesGlAc.asList()])
            return
        }
        flash.message = "SuccessFully Saved Vat Category"
        LinkedHashMap resultMap =vatCategoryService.vatCategoryPaginateList(params)
        render(view: '/coreBanking/settings/vatCategoryBackup/vatCategoryList',model: [dataReturns: resultMap.results, totalCount: resultMap.totalCount])
    }

    def list() {
        LinkedHashMap gridData
        String result
        LinkedHashMap resultMap =vatCategoryService.vatCategoryPaginateList(params)
        if(!resultMap || resultMap.totalCount== 0){
            gridData = [iTotalRecords: 0, iTotalDisplayRecords: 0, aaData: null]
            result = gridData as JSON
            render result
            return
        }
        int totalCount =resultMap.totalCount
        gridData = [iTotalRecords: totalCount, iTotalDisplayRecords: totalCount, aaData: resultMap.results]
        result = gridData as JSON
        render result
    }

    def delete(Long id) {
        def vatCategory = VatCategoryBackup.get(id)
        if (!vatCategory) {
            flash.message = "Vat Category Is Not Available"
            render(view: '/coreBanking/settings/vatCategoryBackup/vatCategoryList')
            return
        }
        vatCategory.status = false
        vatCategory.save(flush: true)
        def result=[isError:false,message:"Vat category deleted successfully"]
        String outPut=result as JSON
        render outPut

    }

    def update(Long id) {
        def vatCategory = VatCategoryBackup.get(id)
        if (!vatCategory) {
            flash.message = "Vat Category Is Not Available"
            render(view: '/coreBanking/settings/vatCategoryBackup/vatCategoryList')
            return
        }
        render(view: '/coreBanking/settings/vatCategoryBackup/vatCategory',
                model: [vatCategory: vatCategory,
                        vatGlAcc: vatGlAccount.asList(),
                        purchaseAcc: purchaseGlAc.asList(),
                        salesGlAcc: salesGlAc.asList()])
        return
    }
}

class VatCatagoryCommand {
    Long id
    String name
    String rate
    String vatGlAccount
    String purchaseGlAcc
    String salesGlAcc
    Boolean status = true
    static constraints = {

    }
}

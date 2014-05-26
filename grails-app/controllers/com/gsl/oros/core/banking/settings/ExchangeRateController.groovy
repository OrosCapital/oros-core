package com.gsl.oros.core.banking.settings

import com.gsl.oros.core.banking.product.settings.ExchRateUtility
import grails.converters.JSON

class ExchangeRateController {
    def exchangeRateService

    def index() {
        LinkedHashMap resultMep = exchangeRateService.exchangeRateList(params)
        if (!resultMep || resultMep.totalCount == 0) {
            render(template: '/coreBanking/settings/exchangeRate/exchangeRateList', model: [dataReturn: null, totalCount: 0])
            return
        }
        render(template: '/coreBanking/settings/exchangeRate/exchangeRateList', model: [dataReturn: resultMep.results, totalCount: resultMep.totalCount])
    }

    def create() {
        render(view: '/coreBanking/settings/exchangeRate/_createExchangeRate',
                model: [dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999", currentDt: new Date().format("dd/MM/yyyy"), decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
    }

    def save(ExchangeCommand exchangeCommand) {
        println(params)
        if (!request.method == 'POST') {
            render(template: '/coreBanking/settings/exchangeRate/createExchangeRate')
            return
        }
        if (exchangeCommand.hasErrors()) {
            render(template: '/coreBanking/settings/exchangeRate/createExchangeRate', model: [exchangeRate: exchangeCommand])
            return
        }
        ExchangeRate exchangeRate

        if (params.id) {     //update exchangeRate
            exchangeRate = ExchangeRate.get(exchangeCommand.id)
            if (!exchangeRate) {
                flash.message = "Exchange Rate not found"
                render(template: '/coreBanking/settings/exchangeRate/exchangeRateList')
                return
            }
            exchangeRate.properties = exchangeCommand.properties

            if (!exchangeRate.validate()) {
                render(template: '/coreBanking/settings/exchangeRate/createExchangeRate', model: [exchangeRate: exchangeRate])
                return
            }
            exchangeRate.save(flush: true)
            LinkedHashMap resultMep = exchangeRateService.exchangeRateList(params)
            flash.message = "Exchange Rate Updated successfully"
            render(template: '/coreBanking/settings/exchangeRate/exchangeRateList', model: [dataReturn: resultMep.results, totalCount: resultMep.totalCount])
            return
        }
        exchangeRate = new ExchangeRate(exchangeCommand.properties)

        if (!exchangeRate.validate()) {
            render(template: '/coreBanking/settings/exchangeRate/createExchangeRate', model: [exchangeRate: exchangeRate])
            return
        }
        ExchangeRate svaeExch = exchangeRate.save(flush: true)
        if (!svaeExch) {
            render(template: '/coreBanking/settings/exchangeRate/createExchangeRate', model: [exchangeRate: exchangeRate])
        }
        LinkedHashMap resultMep = exchangeRateService.exchangeRateList(params)
        flash.message = "Exchange Rate created successfully"
        render(template: '/coreBanking/settings/exchangeRate/exchangeRateList', model: [dataReturn: resultMep.results, totalCount: resultMep.totalCount])
        return

    }

    def delete(Long id) {

        ExchangeRate exchangeRate = ExchangeRate.get(id)
        if (!exchangeRate) {
            flash.message = "Exchange Rate not found"
            render(template: '/coreBanking/settings/exchangeRate/exchangeRateList')
            return
        }
        exchangeRate.status = false
        exchangeRate.save(flush: true)
        def result=[isError:false,message:"Exchange Rate deleted successfully"]
        String outPut=result as JSON
        render outPut
    }

    def update(Long id) {
        ExchangeRate exchangeRate = ExchangeRate.read(id)
        if (!exchangeRate) {
            flash.message = "Exchange Rate not found"
            render(template: '/coreBanking/settings/exchangeRate/exchangeRateList')
            return
        }

        def date = exchangeRate.date.format("dd/MM/yyyy")
        render(template: '/coreBanking/settings/exchangeRate/createExchangeRate',
                model: [exchangeRate: exchangeRate,
                        dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999", currentDt: date,
                        decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
    }

    def list() {
        LinkedHashMap gridData
        String result
        LinkedHashMap resultMap = exchangeRateService.exchangeRateList(params)

        if (!resultMap || resultMap.totalCount == 0) {
            gridData = [iTotalRecords: 0, iTotalDisplayRecords: 0, aaData: null]
            result = gridData as JSON
            render result
            return
        }
        int totalCount = resultMap.totalCount
        gridData = [iTotalRecords: totalCount, iTotalDisplayRecords: totalCount, aaData: resultMap.results]
        result = gridData as JSON
        render result
    }


}

class ExchangeCommand {
    Long id
    Double buyPrice
    Double sellPrice
    Date date
    Currencys currency
    Boolean status = true
    static constraints = {

    }
}

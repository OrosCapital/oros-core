package com.gsl.oros.core.banking.operation

import com.gsl.oros.core.banking.operation.withdrawal.WithdrawalApprove
import grails.converters.JSON

class WithdrawalApproveController {
    def withdrawalApproveService
    def index() {
        def a=WithdrawalApprove.list()

        LinkedHashMap resultMap = withdrawalApproveService.withdrawalAppList(params)
        if (!resultMap || resultMap.totalCount == 0) {
            render(view: '/coreBanking/settings/operation/cashWithdrawal/withdrawalApprove', model: [dataReturn: null, totalCount: 0])
            return
        }
        int totalCount = resultMap.totalCount
        render(view: '/coreBanking/settings/operation/cashWithdrawal/withdrawalApprove', model: [dataReturn: resultMap.results, totalCount: totalCount])


    }

    def list() {
        LinkedHashMap gridData
        String result
        LinkedHashMap resultMap =withdrawalApproveService.withdrawalAppList(params)

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

    def approve(){

    }

    def delete(){

    }
}

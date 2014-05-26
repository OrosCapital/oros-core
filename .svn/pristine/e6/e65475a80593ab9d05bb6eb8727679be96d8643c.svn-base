package com.gsl.core.banking

import com.gsl.oros.core.banking.operation.withdrawal.WithdrawalApprove
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class WithdrawalApproveService {
    def springSecurityService
    def webInvocationPrivilegeEvaluator

    static final String[] sortColumns = ['name', 'accountNo', 'amount', 'chequeNo', 'status']

    LinkedHashMap withdrawalAppList(GrailsParameterMap params) {
        int iDisplayStart = params.iDisplayStart ? params.getInt('iDisplayStart') : CommonUtility.DEFAULT_PAGINATION_START
        int iDisplayLength = params.iDisplayLength ? params.getInt('iDisplayLength') : CommonUtility.DEFAULT_PAGINATION_LENGTH
        String sSortDir = params.sSortDir_0 ? params.sSortDir_0 : CommonUtility.DEFAULT_PAGINATION_SORT_ORDER
        int iSortingCol = params.iSortingCols ? params.getInt('iSortingCols') : CommonUtility.DEFAULT_PAGINATION_SORT_IDX
        //Search string, use or logic to all fields that required to include
        String sSearch = params.sSearch ? params.sSearch : null
        if (sSearch) {
            sSearch = CommonUtility.PERCENTAGE_SIGN + sSearch + CommonUtility.PERCENTAGE_SIGN
        }
        String sortColumn = CommonUtility.getSortColumn(sortColumns, iSortingCol)
        List dataReturns = new ArrayList()
        def c = WithdrawalApprove.createCriteria()
        def results = c.list(max: iDisplayLength, offset: iDisplayStart) {

        }


        int totalCount = results.totalCount
        int serial = iDisplayStart;
        if (totalCount > 0) {
            if (sSortDir.equals(CommonUtility.SORT_ORDER_DESC)) {
                serial = (totalCount + 1) - iDisplayStart
            }
            results.each { WithdrawalApprove withdrawalApprove ->
                if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: withdrawalApprove.id, 0: withdrawalApprove.client.name, 1: withdrawalApprove.client.accountNo, 2: withdrawalApprove.amount, 3: withdrawalApprove.chequeNo, 4: withdrawalApprove.status, 5: ''])
            }
        }
        return [totalCount: totalCount, results: dataReturns]
    }

}

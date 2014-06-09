package com.gsl.core.banking

import com.gsl.oros.core.banking.loan.Loan
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class LoanService {

    def springSecurityService
    def webInvocationPrivilegeEvaluator

    static final String[] sortColumns = ['accountNo','accountName','amount']

    LinkedHashMap loanPaginateList(GrailsParameterMap params){
        int iDisplayStart = params.iDisplayStart ? params.getInt('iDisplayStart') : CommonUtility.DEFAULT_PAGINATION_START
        int iDisplayLength = params.iDisplayLength ? params.getInt('iDisplayLength') : CommonUtility.DEFAULT_PAGINATION_LENGTH
        String sSortDir = params.sSortDir_0 ? params.sSortDir_0 : CommonUtility.DEFAULT_PAGINATION_SORT_ORDER
        int iSortingCol = params.iSortingCols ? params.getInt('iSortingCols') : CommonUtility.DEFAULT_PAGINATION_SORT_IDX
        //Search string, use or logic to all fields that required to include
        String sSearch = params.sSearch ? params.sSearch : null
        if (sSearch) {
            sSearch = CommonUtility.PERCENTAGE_SIGN + sSearch + CommonUtility.PERCENTAGE_SIGN
        }
        String sortColumn = CommonUtility.getSortColumn(sortColumns,iSortingCol)
        List dataReturns = new ArrayList()
        def v = Loan.createCriteria()
        def results = v.list(max: iDisplayLength, offset: iDisplayStart) {

            and {
                eq("sts", true)
            }

            if (sSearch) {
                or {
                    ilike('accountNo',sSearch)


                }
            }
            order(sortColumn, sSortDir)
        }
        int totalCount = results.totalCount
        int serial = iDisplayStart;
        if (totalCount > 0) {
            if (sSortDir.equals(CommonUtility.SORT_ORDER_DESC)) {
                serial = (totalCount + 1) - iDisplayStart
            }
            results.each { Loan loan ->
                if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: loan.id, 0: serial, 1: loan.accountNo, 2: loan.accountName,3:loan.amount,4:''])
            }
        }
        return [totalCount:totalCount,results:dataReturns]
    }
}

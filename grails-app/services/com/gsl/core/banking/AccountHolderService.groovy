package com.gsl.core.banking

import com.gsl.oros.core.banking.accountHolder.AccountHolder
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

/**
 * Created with IntelliJ IDEA.
 * User: gsl
 * Date: 5/15/14
 * Time: 5:01 PM
 * To change this template use File | Settings | File Templates.
 */
@Transactional
class AccountHolderService {
    def springSecurityService
    def webInvocationPrivilegeEvaluator

    static final String[] sortColumns = ['id','firstName','lastName','birthCountry','nationality1']

    LinkedHashMap accountHolderPaginateList(GrailsParameterMap params){
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
        def a = AccountHolder.createCriteria()
        def results = a.list(max: iDisplayLength, offset: iDisplayStart) {
            and {
                eq("status", true)
            }
            if (sSearch) {
                or {
                    ilike('firstName', sSearch)
                    ilike('lastName', sSearch)
                    ilike('birthCountry', sSearch)
                    ilike('nationality1', sSearch)
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
            results.each { AccountHolder clients ->
                if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: clients.id, 0: serial, 1: clients.firstName, 2: clients.lastName, 3: clients.birthCountry.name, 4: clients.nationality1.name, 5: ''])
            }
        }
        return [totalCount:totalCount,results:dataReturns]
    }
}

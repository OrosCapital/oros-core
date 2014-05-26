package com.gsl.core.banking

import com.gsl.oros.core.banking.settings.VatCategoryBackup
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class VatCategoryService {

    def springSecurityService
    def webInvocationPrivilegeEvaluator

    static final String[] sortColumns = ['name','rate','vatGlAccount','purchaseGlAcc','salesGlAcc']

    LinkedHashMap vatCategoryPaginateList(GrailsParameterMap params){
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
        def v = VatCategoryBackup.createCriteria()
        def results = v.list(max: iDisplayLength, offset: iDisplayStart) {
            and {
                eq("status", true)
            }
            if (sSearch) {
                or {
                    ilike('vatGlAccount',sSearch)


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
            results.each { VatCategoryBackup vatCategoryBackup->
                if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: vatCategoryBackup.id, 0: serial, 1: vatCategoryBackup.name, 2: vatCategoryBackup.rate, 3: vatCategoryBackup.vatGlAccount, 4: vatCategoryBackup.purchaseGlAcc, 5: vatCategoryBackup.salesGlAcc, 6: ''])
            }
        }
        return [totalCount:totalCount,results:dataReturns]
    }
}

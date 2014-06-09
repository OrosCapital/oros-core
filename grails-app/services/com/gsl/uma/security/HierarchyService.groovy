package com.gsl.uma.security

import com.gsl.core.banking.CommonUtility
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class HierarchyService {
    def springSecurityService
    def webInvocationPrivilegeEvaluator

    static final String[] sortColumns = ['id','user','rank','bankFullName','branchFullName']

    LinkedHashMap hierarchyPaginateList(GrailsParameterMap params){
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
        def h = Hierarchy.createCriteria()
        def results = h.list(max: iDisplayLength, offset: iDisplayStart) {
            and {
                eq("status", true)
            }
            if (sSearch) {
                or {
                    ilike('rank', sSearch)
                }
            }
            order(sortColumn, sSortDir)
        }
        int totalCount = results.totalCount
        int serial = iDisplayStart;
        if (totalCount > 0) {
            if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                serial = (totalCount + 1) - iDisplayStart
            }
            results.each { Hierarchy hierarchy ->
                if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: hierarchy.id, 0: serial, 1: hierarchy.user.username, 2: hierarchy.rank, 3: hierarchy.bankSetup?.bankFullName, 4: hierarchy.branchSetup?.branchFullName, 5: ''])
            }
        }
        return [totalCount:totalCount,results:dataReturns]
    }
}

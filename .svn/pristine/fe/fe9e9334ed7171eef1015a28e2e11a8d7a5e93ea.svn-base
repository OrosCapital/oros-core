package com.gsl.core.banking

import com.gsl.oros.core.banking.settings.OthersBranchSetup
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

/**
 * Created with IntelliJ IDEA.
 * User: gsl
 * Date: 5/18/14
 * Time: 5:28 PM
 * To change this template use File | Settings | File Templates.
 */
@Transactional
class OthBranchSetupService {
    def springSecurityService
    def webInvocationPrivilegeEvaluator

    static final String[] sortColumns = ['id','branchFullName','branchShortName','bankName','country','state']

LinkedHashMap othBranchSetupPaginateList(GrailsParameterMap params){
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
        def o = OthersBranchSetup.createCriteria()
        def results = o.list(max: iDisplayLength, offset: iDisplayStart) {
            and {
                eq("status", true)
            }
            if (sSearch) {
                or {
                    ilike('branchFullName', sSearch)
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
            results.each { OthersBranchSetup othersBranchSetup ->
                if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: othersBranchSetup.id, 0: serial, 1: othersBranchSetup.branchFullName, 2: othersBranchSetup.branchShortName, 3: othersBranchSetup.bankName.bankFullName, 4: othersBranchSetup.bankName.generalAdd.country[0].name, 5: othersBranchSetup.generalAdd.state[0].name, 6: ''])
            }
        }
        return [totalCount:totalCount,results:dataReturns]
    }
}

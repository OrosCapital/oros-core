package com.gsl.core.banking

import com.gsl.oros.core.banking.settings.accounting.vendor.VendorMaster
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class VendorService {
    def springSecurityService
    def webInvocationPrivilegeEvaluator

    static final String[] sortColumns = ['id','vendorCode','vendorName','email','status']

    LinkedHashMap vendorPaginateList(GrailsParameterMap params){
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
        def v = VendorMaster.createCriteria()
        def results = v.list(max: iDisplayLength, offset: iDisplayStart) {
            and {
                eq("status", 1)
            }
            if (sSearch) {
                or {
                    ilike('vendorName', sSearch)
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
            results.each { VendorMaster vendor ->
                if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: vendor.id, 0: serial, 1: vendor.vendorCode, 2: vendor.vendorName, 3: vendor.email, 4: vendor.status, 5: ''])
            }
        }
        return [totalCount:totalCount,results:dataReturns]
    }
}

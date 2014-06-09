package com.gsl.core.banking

import com.gsl.oros.core.banking.operation.Client
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class DormantAccountService {

    static final String[] sortColumns = ['id', 'name', 'accountNo', 'address', 'contactNo']

    LinkedHashMap dormantAccList(GrailsParameterMap params) {
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
        def c = Client.createCriteria()
        def results = c.list(max: iDisplayLength, offset: iDisplayStart) {

        }
        int totalCount = results.totalCount
        int serial = iDisplayStart;
        if (totalCount > 0) {
            if (sSortDir.equals(CommonUtility.SORT_ORDER_DESC)) {
                serial = (totalCount + 1) - iDisplayStart
            }
            results.each { Client client ->
                if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: client.id,0: serial, 1: client.name, 2: client.accountNo, 3: client.address, 4: client.contactNo, 5: ''])
            }
        }
        return [totalCount: totalCount, results: dataReturns]
    }
}

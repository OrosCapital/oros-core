package com.gsl.core.banking

import com.gsl.oros.core.banking.settings.Currencys
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class CurrencyService {
    def springSecurityService

    static final String[] sortColumns = ['id','name','abbreviation','symbol','country','hundredName']

    LinkedHashMap currencyPaginateList(GrailsParameterMap params){
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
        def c = Currencys.createCriteria()
        def results = c.list(max: iDisplayLength, offset: iDisplayStart) {
            and {
                eq("status", true)
                and {
                    country {
                        eq('status', true)
                    }
                }

            }
            if (sSearch) {
                or {
                    ilike('name', sSearch)
                    ilike('symbol', sSearch)
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
            results.each { Currencys currencys ->
                if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: currencys.id, 0: serial, 1: currencys.name, 2: currencys.abbreviation, 3: currencys.symbol, 4: currencys.country.name, 5: currencys.hundredName, 6: ''])
            }
        }
        return [totalCount:totalCount,results:dataReturns]
    }

}

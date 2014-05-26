package com.gsl.core.banking

import com.gsl.oros.core.banking.agent.PersonalInfo
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class AgentService {


        def springSecurityService
        def webInvocationPrivilegeEvaluator

        static final String[] sortColumns = ['firstName','nationality','gender']

        LinkedHashMap agentPaginateList(GrailsParameterMap params){
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
            def v = PersonalInfo.createCriteria()
            def results = v.list(max: iDisplayLength, offset: iDisplayStart) {
                and {
                    eq("status", true)
                }
                if (sSearch) {
                    or {
                        ilike('firstName',sSearch)
                        ilike('gender',sSearch)

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
                results.each { PersonalInfo personalInfo ->
                    if (sSortDir.equals(CommonUtility.SORT_ORDER_ASC)) {
                        serial++
                    } else {
                        serial--
                    }
                    dataReturns.add([DT_RowId: personalInfo.id, 0: serial, 1: personalInfo.firstName, 2: personalInfo.nationality.name,3:personalInfo.gender,4:''])
                }
            }
            return [totalCount:totalCount,results:dataReturns]
        }

    def serviceMethod() { }
}

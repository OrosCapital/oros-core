package com.gsl.uma.security

import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.oros.core.banking.settings.BranchSetup
import grails.converters.JSON

class HierarchyController {
    def hierarchyService
    def index() {
        LinkedHashMap resultMap = hierarchyService.hierarchyPaginateList(params)
        if(!resultMap || resultMap.totalCount== 0){
            render(view: '/hierarchy/hierarchyList', model: [dataReturns: null, totalCount: 0])
            return
        }
        int totalCount =resultMap.totalCount
        render(view: '/hierarchy/hierarchyList', model: [dataReturns: resultMap.results, totalCount: totalCount])
    }

    def list() {
        LinkedHashMap gridData
        String result
        LinkedHashMap resultMap =hierarchyService.hierarchyPaginateList(params)
        if(!resultMap || resultMap.totalCount== 0){
            gridData = [iTotalRecords: 0, iTotalDisplayRecords: 0, aaData: null]
            result = gridData as JSON
            render result
            return
        }
        int totalCount =resultMap.totalCount
        gridData = [iTotalRecords: totalCount, iTotalDisplayRecords: totalCount, aaData: resultMap.results]
        result = gridData as JSON
        render result
    }

    def create(){
        def userList = User.list();
        render(template: '/hierarchy/hierarchy', model: [userList:userList]);
    }

    def assignRank(){
        if (request.method == "POST"){
            String[] userId
            userId = params.hierarchy.split("_")
            BankSetup bankSetup = null
            BranchSetup branchSetup = null
            User user
            Integer r = 0
            for (int i = 0; i < userId.length; i++) {
                Hierarchy assignHierarchy = new Hierarchy()
                Integer userIdIntoInteger = Integer.parseInt(userId[i])
                user = User.read(userIdIntoInteger)
                assignHierarchy.user = user
                assignHierarchy.rank = ++r
                assignHierarchy.bankSetup = bankSetup
                assignHierarchy.branchSetup = branchSetup
                assignHierarchy.status = true
                assignHierarchy.save(flush: true)
            }

            def result = [message: "Thank You. Assigning Ranking is done"]
            render result as JSON
        }
    }

    def update(){}

}

package com.gsl.oros.core.banking.settings

import com.gsl.cbs.contraints.enums.AddressType
import com.gsl.oros.core.banking.product.settings.OthBankUtility
import grails.converters.JSON

class OthBankSetupController {
     def othBankSetupService
    def index() {
        LinkedHashMap requestMep=othBankSetupService.othBankSetupList(params)
        if(!requestMep || requestMep.totalCount==0){
            render(view: '/coreBanking/settings/othBankSetup/othBankList',model: [dataReturn:null,totalCount:0])
            return
        }
        render(view: '/coreBanking/settings/othBankSetup/othBankList',model: [dataReturn:requestMep.results,totalCount:requestMep.totalCount])
    }

    def create() {
        render(view: "/coreBanking/settings/othBankSetup/othBankSetup")
    }

    def save(OthBankSetupCommand othBankSetupCommand) {
        if (!request.method == 'POST') {
            render(view: '/coreBanking/settings/othBankSetup/othBankSetup')
            return
        }
        if (othBankSetupCommand.hasErrors()) {
            render(view: '/coreBanking/settings/othBankSetup/othBankSetup',
                    model: [othBankSetup: othBankSetupCommand,
                            generalId: othBankSetupCommand.generalId,
                            postalId: othBankSetupCommand.postalId,
                            generalAdd: othBankSetupCommand.general.properties,
                            postalAdd: othBankSetupCommand.postal.properties])
            return
        }
        OthersBankSetup othersBankSetup
        if (params.id) {  // Update Others Bank Setup
            othersBankSetup = OthersBankSetup.get(othBankSetupCommand.id)
            if (!othersBankSetup) {
                flash.message = "Bank is not Availavle"
                render(view: '/coreBanking/settings/othBankSetup/othBankList')
                return
            }
            othersBankSetup.properties = othBankSetupCommand.properties
            if (!othBankSetupCommand.validate()) {
                render(view: '/coreBanking/settings/othBankSetup/othBankSetup',
                        model: [othBankSetup: othBankSetupCommand,
                                generalId: othBankSetupCommand.generalId,
                                postalId: othBankSetupCommand.postalId,
                                generalAdd: othBankSetupCommand.general.properties,
                                postalAdd: othBankSetupCommand.postal.properties])
                return
            }
            othersBankSetup.save(failOnError: true)

            Address general = Address.get(othBankSetupCommand.generalId)
            general.properties = othBankSetupCommand.general.properties
            general.addressType = AddressType.GENERAL
            general.save(failOnError: true)

            Address postal = Address.get(othBankSetupCommand.postalId)
            postal.properties = othBankSetupCommand.postal.properties
            postal.addressType = AddressType.POSTAL
            postal.save(failOnError: true)
            LinkedHashMap requestMep=othBankSetupService.othBankSetupList(params)
            flash.message = "Successfully Update Bank Setup Information"
            render(view: '/coreBanking/settings/othBankSetup/othBankList',model: [dataReturn: requestMep.results,totalCount: requestMep.totalCount])
            return
        }
        othersBankSetup = new OthersBankSetup(othBankSetupCommand.properties)
        if (!othBankSetupCommand.validate()) {
            render(view: '/coreBanking/settings/othBankSetup/othBankSetup',
                    model: [othBankSetup: othBankSetupCommand,
                            generalAdd: othBankSetupCommand.general.properties,
                            postalAdd: othBankSetupCommand.postal.properties])
            return
        }
        OthersBankSetup savedBank = othersBankSetup.save(flash: true)
        if (!savedBank) {
            render(view: '/coreBanking/settings/othBankSetup/othBankSetup',
                    model: [othBankSetup: othersBankSetup])
            return
        }
        othersBankSetup.save(failOnError: true)
        Address general = new Address(othBankSetupCommand.general.properties)
        general.addressType = AddressType.GENERAL
        general.save(failOnError: true)
        othersBankSetup.addToGeneralAdd(general)

        Address postal = new Address(othBankSetupCommand.postal.properties)
        postal.addressType = AddressType.POSTAL
        postal.save(failOnError: true)
        othersBankSetup.addToPostalAdd(postal)

        LinkedHashMap requestMep=othBankSetupService.othBankSetupList(params)
        flash.message = "Successfully Save Bank Setup"
        render(view: '/coreBanking/settings/othBankSetup/othBankList',model: [dataReturn: requestMep.results,totalCount: requestMep.totalCount])
        return
    }

    def list() {
        LinkedHashMap gridData
        String result
        LinkedHashMap resultMap=othBankSetupService.othBankSetupList(params)
        if (!resultMap || resultMap.totalCount == 0) {
            gridData = [iTotalRecords: 0, iTotalDisplayRecords: 0, aaData: null]
            result = gridData as JSON
            render result
            return
        }
        int totalCount = resultMap.totalCount
        gridData = [iTotalRecords: totalCount, iTotalDisplayRecords: totalCount, aaData: resultMap.results]
        result = gridData as JSON
        render result
    }

    def delete(Long id) {
        def otherBankSetup = OthersBankSetup.get(id)
        if (!otherBankSetup) {
            flash.message = "Bank not found"
            render(view: '/coreBanking/settings/othBankSetup/othBankList')
        }
        otherBankSetup.status = false
        otherBankSetup.save(flash: true)

        def result=[isError:false,message:"Bank deleted successfully"]
        String outPut=result as JSON
        render outPut
    }

    def update(Long id) {
        def othBankSetup = OthersBankSetup.read(id)
        if (!othBankSetup) {
            flash.branchSetUpMess = "Bank not found"
            render(view: '/coreBanking/settings/othBankSetup/othBankList')
        }
        render(view: '/coreBanking/settings/othBankSetup/othBankSetup',
                model: [othBankSetup: othBankSetup,
                        generalAdd: othBankSetup.generalAdd[0],
                        postalAdd: othBankSetup.postalAdd[0]]
        )
    }
}

class OthBankSetupCommand {
    Long id
    Long generalId
    Long postalId

    String bankFullName
    String bankShortName
    String iban
    String contactName
    String contactDesignation
    String contactPhone
    String contactMobile
    String contactEmail
    Boolean status = true

    Address general
    Address postal

    static constraints = {
        contactEmail nullable: true

        bankFullName nullable: false, validator: { name, othBankSetupObj ->
            def id = othBankSetupObj.id as Long
            if (id == null) {
                def bankFullName = OthersBankSetup.findByBankFullNameAndStatus(name, true)
                if (bankFullName) {
                    return 'coreBanking.setting.othBankSetup.bankFullName.unique'
                }
            } else {
                def bankFullName = OthersBankSetup.withCriteria {
                    not { 'in'('id', [othBankSetupObj.id]) }
                    and {
                        eq('status', true)
                        eq('bankFullName', name)
                    }
                }
                if (bankFullName.size() > 0) {
                    return 'coreBanking.setting.othBankSetup.bankShortName.unique'
                }
            }
        }
        bankShortName nullable: false, validator: { sortName, othBankSetupObj ->
            def id = othBankSetupObj.id as Long
            println("IDDDDDDDDDDDDD"+id)
            if (id == null) {
                def bankShortName = OthersBankSetup.findByBankShortNameAndStatus(sortName, true)
                if (bankShortName) {
                    return 'coreBanking.setting.othBankSetup.bankShortName.unique'
                }
            } else {
                def bankShortName = OthersBankSetup.withCriteria {
                    not { 'in'('id', [othBankSetupObj.id]) }
                    and {
                        eq('status', true)
                        eq('bankShortName', sortName)
                    }
                }
                if (bankShortName.size() > 0) {
                    return 'coreBanking.setting.othBankSetup.bankShortName.unique'
                }
            }
        }

    }
}


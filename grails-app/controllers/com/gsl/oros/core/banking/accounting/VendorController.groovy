package com.gsl.oros.core.banking.accounting

import com.gsl.cbs.contraints.enums.AddressType
import com.gsl.oros.core.banking.product.accounting.VendorBankAcountUtility
import com.gsl.oros.core.banking.product.accounting.VendorUtility
import com.gsl.oros.core.banking.settings.Address
import com.gsl.oros.core.banking.settings.Country
import com.gsl.oros.core.banking.settings.State
import com.gsl.oros.core.banking.settings.accounting.VatCategory
import com.gsl.oros.core.banking.settings.accounting.vendor.VendorBankAccount
import com.gsl.oros.core.banking.settings.accounting.vendor.VendorMaster
import grails.converters.JSON

class VendorController {
    def vendorService
    def status = [[id: 1, status: "Active", value: 1],
            [id: 2, status: "InActive", value: 0]]

    def index() {
        LinkedHashMap resultMap = vendorService.vendorPaginateList(params)
        if(!resultMap || resultMap.totalCount== 0){
            render(view: '/coreBanking/settings/accounting/vendor/vendorList', model: [dataReturns: null, totalCount: 0])
            return
        }
        int totalCount =resultMap.totalCount
        render(view: '/coreBanking/settings/accounting/vendor/vendorList', model: [dataReturns: resultMap.results, totalCount: totalCount])

    }

    def create() {
        def tabSelector = 1
        def updateSelector = 0
        flash.message = null
        render(template: '/coreBanking/settings/accounting/vendor/basic', model: [tabSelectIndicator: tabSelector,updateSelector:updateSelector])

    }


    def saveVendorBasic(VendorMasterCommand vendorMasterCommand) {
        if (request.method == "POST") {

            def tabSelector = 1
            if (vendorMasterCommand.hasErrors()) {
                render(template: '/coreBanking/settings/accounting/vendor/basic', model: [vendorMaster: vendorMasterCommand, tabSelectIndicator: tabSelector])
                return
            }
            VendorMaster vendorMaster
            VendorMaster savedVendor
            if (vendorMasterCommand.id) {
                vendorMaster = VendorMaster.get(vendorMasterCommand.id)
                vendorMaster.properties = vendorMasterCommand.properties
                vendorMaster.frequencyOfInvoice = "monthly"
                vendorMaster.byShop = 1
                vendorMaster.creditStatus = "Good History"
                savedVendor = vendorMaster.save()
                flash.message = "Basic Information of Vendor Master Successfully Updated"
            } else {
                vendorMaster = new VendorMaster(vendorMasterCommand.properties)
                vendorMaster.frequencyOfInvoice = "monthly"
                vendorMaster.byShop = 1
                vendorMaster.creditStatus = "Good History"

                if (!vendorMaster.validate()) {
                    render(template: '/coreBanking/settings/accounting/vendor/basic', model: [tabSelectIndicator: tabSelector, vendorMaster: vendorMaster])
                    return
                }
                savedVendor = vendorMaster.save(flush: true)
                if (!savedVendor) {
                    render(template: '/coreBanking/settings/accounting/vendor/basic', model: [tabSelectIndicator: tabSelector, vendorMaster: vendorMaster])
                    return
                }

                flash.message = "Basic Information of Vendor Master Saved Successfully"
            }
            render(template: '/coreBanking/settings/accounting/vendor/basic', model: [tabSelectIndicator: 2, vendorMaster: savedVendor])
        }
    }

    def stateList() {
        def states = State.findAllByCountry(Country.read(params.country as Long))
        for (def i = 0; i < states.size(); i++) {
            render "<option value='${states.id[i]}'>${states.name[i]}</option>"
        }
    }


    def saveVendorGeneralAddress(AddressCommand vendorGeneralAddressCommand) {
        if (request.method == "POST") {

            VendorMaster vendorMaster = VendorMaster.get(vendorGeneralAddressCommand.id)
            VendorMaster savedVendor
            Address vendorGeneralAddress
            Address vendorPostalAddress
            def tabSelector = 2
            if (vendorGeneralAddressCommand.hasErrors()) {
                render(template: 'basic', model: [tabSelectIndicator: tabSelector, vendorMaster: vendorMaster, vendorGeneralAddress: vendorGeneralAddressCommand])
                return
            }

            if (vendorGeneralAddressCommand.addressId) {
                vendorGeneralAddress = vendorMaster.generalAddress
                vendorGeneralAddress.properties = vendorGeneralAddressCommand.properties
                vendorGeneralAddress.addressType = AddressType.GENERAL
                savedVendor = vendorMaster.save(flush: true)
                if (!savedVendor) {
                    render(template: '/coreBanking/settings/accounting/vendor/basic', model: [vendorMaster: vendorMaster, vendorGeneralAddress: vendorGeneralAddressCommand, tabSelectIndicator: tabSelector])
                    return
                }

                flash.message = "General Address of Vendor Master Successfully Updated"
            } else {
                vendorGeneralAddress  = new Address(vendorGeneralAddressCommand.properties)
                vendorGeneralAddress.addressType = AddressType.GENERAL
                Address savedAddress = vendorGeneralAddress.save(flush: true)
                vendorMaster.generalAddress =  savedAddress

                if (!vendorGeneralAddress.validate()) {
                    render(template: '/coreBanking/settings/accounting/vendor/basic', model: [vendorMaster: vendorMaster, vendorGeneralAddress: vendorGeneralAddressCommand, tabSelectIndicator: tabSelector])
                    return
                }
                savedVendor = vendorMaster.save()
                if (!savedVendor) {
                    render(template: '/coreBanking/settings/accounting/vendor/basic', model: [vendorMaster: vendorMaster, vendorGeneralAddress: vendorGeneralAddressCommand, tabSelectIndicator: tabSelector])
                    return
                }
                flash.message = "General Address of Vendor Master Successfully Saved"

            }
            render(template: '/coreBanking/settings/accounting/vendor/basic', model: [tabSelectIndicator: 3, vendorMaster: savedVendor])
        }
    }

    def saveVendorPostalAddress(AddressCommand vendorPostalAddressCommand) {
        if (request.method == "POST") {
            VendorMaster savedVendor
            Address vendorPostalAddress
            println"checkbox value="+vendorPostalAddressCommand.genaddSame
            VendorMaster vendorMaster = VendorMaster.get(vendorPostalAddressCommand.id)

            def tabSelector = 3
            if (vendorPostalAddressCommand.hasErrors()) {
                render(template: '/coreBanking/settings/accounting/vendor/basic', model: [tabSelectIndicator: tabSelector, vendorMaster: vendorMaster, vendorPostalAddress: vendorPostalAddressCommand])
                return
            }


            if (vendorPostalAddressCommand.addressId) {
                if(vendorPostalAddressCommand.genaddSame == 1 && vendorMaster.generalAddress != null){
                    vendorPostalAddress = vendorMaster.postalAddress
                    Address vendorGeneralAddress = vendorMaster.generalAddress
                    vendorPostalAddress.properties = vendorGeneralAddress.properties
                    vendorPostalAddress.addressType = AddressType.POSTAL
                }else{
                    vendorPostalAddress = vendorMaster.postalAddress
                    vendorPostalAddress.properties = vendorPostalAddressCommand.properties
                    vendorPostalAddress.addressType = AddressType.POSTAL
                }

                if (!vendorPostalAddress.validate()) {
                    render(template: '/coreBanking/settings/accounting/vendor/basic', model: [vendorMaster: vendorMaster, vendorPostalAddress: vendorPostalAddress, tabSelectIndicator: tabSelector])
                    return
                }
                savedVendor = vendorMaster.save(flush: true)
                if (!savedVendor) {
                    render(template: '/coreBanking/settings/accounting/vendor/basic', model: [vendorMaster: vendorMaster, vendorPostalAddress: vendorPostalAddressCommand, tabSelectIndicator: tabSelector])
                    return
                }
                flash.message = "Postal Address of Vendor Master Successfully Updated"
            } else {
                if(vendorPostalAddressCommand.genaddSame == 1 && vendorMaster.generalAddress != null){
                    vendorPostalAddress = new Address(vendorMaster.generalAddress.properties)
                    vendorPostalAddress.addressType = AddressType.POSTAL
                }else{
                    vendorPostalAddress = new Address(vendorPostalAddressCommand.properties)
                    vendorPostalAddress.addressType = AddressType.POSTAL
                }

                Address savedAddress = vendorPostalAddress.save(flush: true)
                vendorMaster.postalAddress = savedAddress

                if (!vendorPostalAddress.validate()) {
                    render(template: '/coreBanking/settings/accounting/vendor/basic', model: [vendorMaster: vendorMaster, vendorPostalAddress: vendorPostalAddress, tabSelectIndicator: tabSelector])
                    return
                }
                savedVendor = vendorMaster.save(flush: true)
                if (!savedVendor) {
                    render(template: '/coreBanking/settings/accounting/vendor/basic', model: [vendorMaster: vendorMaster, vendorPostalAddress: vendorPostalAddressCommand, tabSelectIndicator: tabSelector])
                    return
                }
                flash.message = "Postal Address of Vendor Master Saved Successfully"
            }
            render(template: '/coreBanking/settings/accounting/vendor/basic', model: [tabSelectIndicator: 4, vendorMaster: savedVendor])

        }
    }


    def saveVendorBankAccountInfo(VendorBankAccountCommand vendorBankAccountCommand) {

        if (request.method == "POST") {
            if (!params.id) {
            }
            VendorMaster vendorMaster = VendorMaster.get(vendorBankAccountCommand.id)
            def tabSelector = 4
            if (vendorBankAccountCommand.hasErrors()) {
                return
            }
            VendorBankAccount vendorBankAccount
            VendorMaster savedVendor
            if (vendorBankAccountCommand.accountID) {
                vendorBankAccount = VendorBankAccount.get(vendorBankAccountCommand.accountID)
                vendorBankAccount.properties = vendorBankAccountCommand.properties
                if (!vendorBankAccount.validate()) {
                    return
                }
                savedVendor = vendorMaster.save(flush: true)
                if (!savedVendor) {
                    return
                }
                def selectedRow = params.selectRow
                def result = [isError: false, message: "Account Info Updated successsfully", bankInfo: vendorBankAccount, vandorInfo: savedVendor, update: true, selectedRow: selectedRow]
                String output = result as JSON
                render output
            } else {
                vendorBankAccount = new VendorBankAccount(vendorBankAccountCommand.properties)
                if (!vendorBankAccount.validate()) {
                    return
                }
                VendorBankAccount savedAccount = vendorBankAccount.save(flush: true)
                if (!savedAccount) {
                    //handle unable to save case
                    return
                }
                vendorMaster.getBankAccountInfo().add(savedAccount)

                savedVendor = vendorMaster.save(flush: true)
                if (!savedVendor) {
                    return
                }
                def result = [isError: false, message: "Added successsfully", bankInfo: savedAccount, vandorInfo: vendorMaster]
                String output = result as JSON
                render output
            }


        }
    }


    def deleteVendor(Long id) {

        VendorMaster vendor = VendorMaster.get(id)
        if (!vendor) {
            flash.message = "Vendor not found"
            render(view: '/coreBanking/settings/accounting/vendor/vendorList')
        }
        vendor.status = 0
        vendor.save(flush: true)
        def result=[isError:false,message:"Vendor deleted successfully"]
        String outPut=result as JSON
        render outPut

    }

    def list() {
        int sEcho = params.sEcho ? params.getInt('sEcho') : 1
        int iDisplayStart = params.iDisplayStart ? params.getInt('iDisplayStart') : 0
        int iDisplayLength = params.iDisplayLength ? params.getInt('iDisplayLength') : 10
        String sSortDir = params.sSortDir_0 ? params.sSortDir_0 : 'asc'
        int iSortingCol = params.iSortingCols ? params.getInt('iSortingCols') : 1
        //Search string, use or logic to all fields that required to include
        String sSearch = params.sSearch ? params.sSearch : null
        if (sSearch) {
            sSearch = "%" + sSearch + "%"
        }
        String sortColumn = VendorUtility.getSortColumn(iSortingCol)
        List dataReturns = new ArrayList()
        def v = VendorMaster.createCriteria()
        def results = v.list(max: iDisplayLength, offset: iDisplayStart) {
            and {
                eq("status", 1)
            }
            if (sSearch) {
                or {
                    ilike('vendorCode', sSearch)
                }
            }
            order(sortColumn, sSortDir)
        }
        int totalCount = results.totalCount
        int serial = iDisplayStart;
        if (totalCount > 0) {
            if (sSortDir.equalsIgnoreCase('desc')) {
                serial = (totalCount + 1) - iDisplayStart
            }
            results.each { VendorMaster vendor ->
                if (sSortDir.equalsIgnoreCase('asc')) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: vendor.id, 0: serial, 1: vendor.vendorCode, 2: vendor.vendorName, 3: vendor.email, 4: vendor.status, 5: ''])
            }
        }

        Map gridData = [iTotalRecords: totalCount, iTotalDisplayRecords: totalCount, aaData: dataReturns]
        String result = gridData as JSON
        println(result)
        render result
    }

    def update() {
        VendorMaster vendor = VendorMaster.read(params.id)
        if (!vendor) {
            flash.message = "Vendor not found"
            render(view: '/coreBanking/settings/accounting/vendor/vendorList')
        }
        def updateSelector = 1
        def tabSelector = 1
        flash.message = null
        render(template: '/coreBanking/settings/accounting/vendor/basic', model: [vendorMaster: vendor, tabSelectIndicator: tabSelector, updateSelector: updateSelector])
    }

    def vendorBankAccountList(Long vendorMasterId) {
        VendorMaster vendorMaster = VendorMaster.read(vendorMasterId)
        int iDisplayStart = params.iDisplayStart ? params.getInt('iDisplayStart') : 0
        int iDisplayLength = params.iDisplayLength ? params.getInt('iDisplayLength') : 10
        int iSortingCol = params.iSortingCols ? params.getInt('iSortingCols') : 1
        String sSortDir = params.sSortDir_0 ? params.sSortDir_0 : 'asc'
        String sSearch = params.sSearch ? params.sSearch : null
        if (sSearch) {
            sSearch = "%" + sSearch + "%"
        }
        String sortColumn = VendorBankAcountUtility.getSortColumn(iSortingCol)
        List dataReturns = new ArrayList()
        def bankAccId = vendorMaster.bankAccountInfo.id
        VendorBankAccount bankAccountInfo = VendorBankAccount.read(bankAccId)
        def vb = bankAccountInfo.createCriteria()
        def results = vb.list(max: iDisplayLength, offset: iDisplayStart) {
            and {
                eq("status", 1)
            }
            if (sSearch) {
                or {
                    ilike('bankName', sSearch)
                }
            }
            order(sortColumn, sSortDir)
        }
        int totalCount = results.totalCount
        int serial = iDisplayStart;
        if (totalCount > 0) {
            if (sSortDir.equalsIgnoreCase('desc')) {
                serial = (totalCount + 1) - iDisplayStart
            }
            results.each { VendorBankAccount bankAccount ->
                if (sSortDir.equalsIgnoreCase('asc')) {
                    serial++
                } else {
                    serial--
                }
                dataReturns.add([DT_RowId: bankAccount.id, 0: serial, 1: bankAccount.bankName, 2: bankAccount.bankAccountName, 3: bankAccount.bankAccountNo, 4: bankAccount.ibanPrefix, 5: ''])
            }
        }

        Map gridData = [iTotalRecords: totalCount, iTotalDisplayRecords: totalCount, aaData: dataReturns]
        String result = gridData as JSON
        println(result)
        render result
    }

    def editBankAccount(Long id, Long bankAccountId) {

        VendorMaster vendorMaster = VendorMaster.get(id)
        if (!vendorMaster) {
            //return with error message
            return
        }
        VendorBankAccount bankAccount = vendorMaster.bankAccountInfo.find { it.id == bankAccountId }
        String result = bankAccount as JSON
        println result
        render result
    }

    def deleteBankAccount(Long id, Long bankAccountId) {
        println(params)
        VendorMaster vendorMaster = VendorMaster.get(id)
        if (!vendorMaster) {
            //return with error message
            return
        }
        VendorBankAccount bankAccount = vendorMaster.bankAccountInfo.find { it.id == bankAccountId }
        bankAccount.status = 4
        VendorMaster savedMaster = vendorMaster.save()
        if (!savedMaster) {
            // return error message
            return
        }
        savedMaster.bankAccountInfo?.removeAll { it.status == 4 }
//        render(template: 'bankAccountList', model: [vendorMaster: savedMaster])
        def result = [isError: false, message: "Successfully Deleted"]
        String outPut = result as JSON
        render outPut
    }
}


class VendorBankAccountCommand {
    Long id
    Long accountID
    String bankName
    String bankAccountName
    String bankAccountNo
    String ibanPrefix
    Integer status

    static constraints = {
        importFrom VendorBankAccount
    }
}

class VendorMasterCommand {
    Long id
    String chamOfCommerce
    String comments
    String companyName
    String defaultGlAccount
    String email
    String firstName
    String gender
    String lastName
    String middleName
    Integer status
    VatCategory vat
    String vendorCode
    String vendorName
    String vendorType
    Integer paymentTermId
    Address generalAddress
    Address postalAddress
    VendorBankAccount bankAccountInfo
    static constraints = {
        importFrom VendorMaster
        id nullable: true
        vendorCode validator: { val, obj ->
            if (obj.id == null){
                if (VendorMaster.findByVendorCode(val)){
                    return "com.gsl.clients.vendor.vendorCode.already.exist"
                }
            }
        }
    }
}

class AddressCommand {
    Long id
    Long addressId
    Long genaddSame
    String contactPersonName
    String contactPersonReference
    String contactDealType
    String phoneNo
    String mobileNo
    String faxNo
    String email1
    String email2
    String websiteUrl
    String addressLine1
    String addressLine2
    String streetName
    String streetNo
    String zipCode
    String postCode
    Country country
    State state
    String city
    Integer status

    static constraints = {

    }
}

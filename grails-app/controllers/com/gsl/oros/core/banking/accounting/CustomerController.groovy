package com.gsl.oros.core.banking.accounting

import com.gsl.cbs.contraints.enums.AddressType
import com.gsl.oros.core.banking.product.accounting.CustomerBankAccountUtility
import com.gsl.oros.core.banking.settings.Address
import com.gsl.oros.core.banking.settings.Country
import com.gsl.oros.core.banking.settings.State
import com.gsl.oros.core.banking.settings.accounting.VatCategory
import com.gsl.oros.core.banking.settings.accounting.PaymentTerms
import com.gsl.oros.core.banking.settings.accounting.CustomerMaster
import com.gsl.oros.core.banking.settings.accounting.CustomerBankAccount
import com.gsl.oros.core.banking.product.accounting.CustomerUtility
import grails.converters.JSON

class CustomerController {

    def index() {
        render (view: '/coreBanking/settings/accounting/customer/customerList')
    }

    def list(){
        println(params)
        int sEcho = params.sEcho?params.getInt('sEcho'):1
        int iDisplayStart = params.iDisplayStart? params.getInt('iDisplayStart'):0
        int iDisplayLength = params.iDisplayLength? params.getInt('iDisplayLength'):10
        String sSortDir = params.sSortDir_0? params.sSortDir_0:'asc'
        int iSortingCol = params.iSortingCols? params.getInt('iSortingCols'):1
        //Search string, use or logic to all fields that required to include
        String sSearch = params.sSearch?params.sSearch:null
        if(sSearch){
            sSearch = "%"+sSearch+"%"
        }
        String sortColumn = CustomerUtility.getSortColumn(iSortingCol)
        List dataReturns = new ArrayList()
        def c = CustomerMaster.createCriteria()
        def results = c.list (max: iDisplayLength, offset:iDisplayStart) {
            and {
                eq("status", 1)
            }
            if(sSearch){
                or {
                    ilike('customerName',sSearch)
                    ilike('customerCode',sSearch)
                    ilike('customerType',sSearch)
                    ilike('paymentTerm',sSearch)
                }
            }
            order(sortColumn, sSortDir)
        }
        int totalCount = results.totalCount
        int serial = iDisplayStart;
        if(totalCount>0){
            if(sSortDir.equalsIgnoreCase('desc')){
                serial =(totalCount+1)-iDisplayStart
            }
            results.each {CustomerMaster customerMaster ->
                if(sSortDir.equalsIgnoreCase('asc')){
                    serial++
                }else{
                    serial--
                }
                dataReturns.add([DT_RowId: customerMaster.id, 0: serial, 1: customerMaster.customerCode, 2: customerMaster.customerName, 3: customerMaster.customerType, 4: customerMaster.paymentTerm.paymentTermName, 5: ''])
            }
        }
        Map gridData = [iTotalRecords: totalCount, iTotalDisplayRecords: totalCount, aaData: dataReturns]
        String result = gridData as JSON
        render result
    }

    def edit(Long id) {
        CustomerMaster customerMaster = CustomerMaster.read(id)
        if (!customerMaster) {
            flash.message = "Customer not found"
            render(view: '/coreBanking/settings/accounting/customer/customerList')
        }
        render(view: '/coreBanking/settings/accounting/customer/create',
                model: [customerMaster: customerMaster,
                        generalAddress: customerMaster.generalAddress[0],
                        postalAddress: customerMaster.postalAddress[0],
                        shippingAddress: customerMaster.shippingAddress[0],
                        vatList: VatCategory.list(),
                        paymentTermsList:PaymentTerms.list(),
                        stateList:State.list(),
                        countryList: Country.list()])
    }


    def delete(Long id) {
        CustomerMaster customerMaster = CustomerMaster.get(id)
        if (!customerMaster) {
            flash.message = "Customer not found"
            render(view: '/coreBanking/settings/accounting/customer/customerList')
        }
        customerMaster.status = 0
        customerMaster.save(flush: true)
        flash.message = "Customer deleted successfully"
        render(view: '/coreBanking/settings/accounting/customer/customerList')
    }

    def create(){
        render (view: '/coreBanking/settings/accounting/customer/create',
                model: [vatList: VatCategory.list(),
                        paymentTermsList:PaymentTerms.list()])
    }

    def saveCustomerMaster(CustomerMasterCommand customerMasterCommand){
        if (request.method == 'POST') {
            if (customerMasterCommand.hasErrors()) {
                render (view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster: customerMasterCommand,
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: Address.get(params.shippingAddressId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(),
                                countryList:Country.list(),
                                stateList:State.list()])
                return
            }
            if(customerMasterCommand.id){
                CustomerMaster customerMaster = CustomerMaster.get(customerMasterCommand.id)
                customerMaster.properties['customerName','gender','bankName','firstName','middleName','lastName','email','defaultGlAccount','momentOfSending','chamberOfCommerce','customerType','vat','comments','paymentTerm','status'] = customerMasterCommand.properties
                CustomerMaster savedCustomer = customerMaster.save()
                flash.message = "Basic Info Updated successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model: [customerMaster:savedCustomer,
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: Address.get(params.shippingAddressId),
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(),
                                stateList:State.list(),
                                countryList:Country.list(),
                                tabSelectIndicator:2])
            }
            else {
                CustomerMaster customerMaster = new CustomerMaster(customerMasterCommand.properties)
                if(!customerMaster.validate()){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster: customerMaster,
                                    generalAddress: Address.get(params.generalAddressId),
                                    postalAddress: Address.get(params.postalAddressId),
                                    shippingAddress: Address.get(params.shippingAddressId),
                                    savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                    vatList: VatCategory.list(),
                                    paymentTermsList:PaymentTerms.list(),
                                    stateList:State.list(),
                                    countryList:Country.list()])
                    return
                }
                CustomerMaster savedCustomer = customerMaster.save(flush: true)
                if(!savedCustomer){
                    render (view: '/coreBanking/settings/accounting/customer/create',model:[customerMaster: customerMaster,
                            generalAddress: Address.get(params.generalAddressId),
                            postalAddress: Address.get(params.postalAddressId),
                            shippingAddress: Address.get(params.shippingAddressId),
                            savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                            vatList: VatCategory.list(),
                            paymentTermsList:PaymentTerms.list(),
                            stateList:State.list(),
                            countryList:Country.list()])
                    return
                }
                flash.message = "Basic Info Saved successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model: [customerMaster:savedCustomer,
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: Address.get(params.shippingAddressId),
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(),
                                stateList:State.list(),
                                countryList:Country.list(),
                                tabSelectIndicator:2])
                return

            }
        }
    }

    def stateList() {
        def states = State.findAllByCountry(Country.read(params.country as Long))
        for (def i = 0; i < states.size(); i++) {
            render "<option value='${states.id[i]}'>${states.name[i]}</option>"
        }
    }

    def saveGeneralAddress(CustomerAddressCommand addressCommand){
        if (request.method == 'POST') {
            if (addressCommand.hasErrors()) {
                render (view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(params.customerId),
                                generalAddress: addressCommand,
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: Address.get(params.shippingAddressId),
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:2])
                return
            }
            if(addressCommand.id){
                Address savedAddress = Address.get(addressCommand.id)
                savedAddress.properties = addressCommand.properties
                savedAddress.save()
                flash.message = "General Address updated successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(params.customerId),
                                generalAddress: savedAddress,
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: Address.get(params.shippingAddressId),
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:3])

            }
            else {
                Address address = new Address(addressCommand.properties)
                address.addressType = AddressType.GENERAL
                CustomerMaster customerMaster = CustomerMaster.get(params.customerId)
                customerMaster.addToGeneralAddress(address)
                if(!address.validate()){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:CustomerMaster.get(params.customerId),
                                    generalAddress: address,
                                    postalAddress: Address.get(params.postalAddressId),
                                    shippingAddress: Address.get(params.shippingAddressId),
                                    savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                    vatList: VatCategory.list(),
                                    paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                    countryList:Country.list(), tabSelectIndicator:2])
                    return
                }
                Address savedAddress = address.save(flush: true)
                if(!savedAddress){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:CustomerMaster.get(params.customerId),
                                    generalAddress: address, postalAddress: Address.get(params.postalAddressId),
                                    shippingAddress: Address.get(params.shippingAddressId),
                                    savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                    vatList: VatCategory.list(),
                                    paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                    countryList:Country.list(), tabSelectIndicator:2])
                    return
                }
                flash.message = "General Address Saved successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(params.customerId),
                                generalAddress: savedAddress,
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: Address.get(params.shippingAddressId),
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:3])
                return

            }

        }
    }

    def savePostalAddress(CustomerAddressCommand addressCommand){
        if (request.method == 'POST') {
            if (addressCommand.hasErrors()) {
                render (view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(params.customerId),
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: addressCommand,
                                shippingAddress: Address.get(params.shippingAddressId),
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:3])
                return
            }
            if(addressCommand.id){
                Address savedAddress = Address.get(addressCommand.id)
                savedAddress.properties = addressCommand.properties
                savedAddress.save()
                flash.message = "Postal Address updated successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(params.customerId),
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: savedAddress, shippingAddress: Address.get(params.shippingAddressId),
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:4])

            }
            else {
                Address address = new Address(addressCommand.properties)
                address.addressType = AddressType.POSTAL
                CustomerMaster customerMaster = CustomerMaster.get(params.customerId)
                customerMaster.addToPostalAddress(address)
                if(!address.validate()){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:CustomerMaster.get(params.customerId),
                                    generalAddress: Address.get(params.generalAddressId),
                                    postalAddress: address, shippingAddress: Address.get(params.shippingAddressId),
                                    savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                    vatList: VatCategory.list(),
                                    paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                    countryList:Country.list(), tabSelectIndicator:3])
                    return
                }
                Address savedAddress = address.save(flush: true)
                if(!savedAddress){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:CustomerMaster.get(params.customerId),
                                    generalAddress: Address.get(params.generalAddressId),
                                    postalAddress: address, shippingAddress: Address.get(params.shippingAddressId),
                                    bankAccountInfo: CustomerBankAccount.get(params.bankAccountId),
                                    vatList: VatCategory.list(),
                                    paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                    countryList:Country.list(), tabSelectIndicator:3])
                    return
                }
                flash.message = "Postal Address Saved successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(params.customerId),
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: savedAddress, shippingAddress: Address.get(params.shippingAddressId),
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:4])
                return

            }
        }
    }

    def likeGeneralAddress (Long generalAddressId) {
        Address postalAddress = Address.read(generalAddressId)
    }

    def saveShipmentAddress(CustomerAddressCommand addressCommand){
        if (request.method == 'POST') {
            if (addressCommand.hasErrors()) {
                render (view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(params.customerId),
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: addressCommand,
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:4])
                return
            }
            if(addressCommand.id){
                Address savedAddress = Address.get(addressCommand.id)
                savedAddress.properties = addressCommand.properties
                savedAddress.save()
                flash.message = "Shipping Address updated successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(params.customerId),
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: savedAddress,
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:5])

            }
            else {
                Address address = new Address(addressCommand.properties)
                address.addressType = AddressType.SHIPPING
                CustomerMaster customerMaster = CustomerMaster.get(params.customerId)
                customerMaster.addToShippingAddress(address)
                if(!address.validate()){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:CustomerMaster.get(params.customerId),
                                    generalAddress: Address.get(params.generalAddressId),
                                    postalAddress: Address.get(params.postalAddressId),
                                    shippingAddress: address, vatList: VatCategory.list(),
                                    savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                    paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                    countryList:Country.list(), tabSelectIndicator:4])
                    return
                }
                Address savedAddress = address.save(flush: true)
                if(!savedAddress){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:CustomerMaster.get(params.customerId),
                                    generalAddress: Address.get(params.generalAddressId),
                                    postalAddress: Address.get(params.postalAddressId),
                                    shippingAddress: address,
                                    savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                    vatList: VatCategory.list(),
                                    paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                    countryList:Country.list(), tabSelectIndicator:4])
                    return
                }
                flash.message = "Shipping Address Saved successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(params.customerId),
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: savedAddress,
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:5])
                return

            }
        }
    }

    def saveBankAccount(CustomerBankAccountCommand customerBankAccountCommand){
        if (request.method == 'POST') {
//            CustomerMaster customerMaster  = CustomerMaster.get(customerBankAccountCommand.customerId)
            if (customerBankAccountCommand.hasErrors()) {
                render (view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:CustomerMaster.get(customerBankAccountCommand.customerId),
                                generalAddress: Address.get(params.generalAddressId),
                                postalAddress: Address.get(params.postalAddressId),
                                shippingAddress: Address.get(params.shippingAddressId),
                                bankAccountInfo: customerBankAccountCommand, vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:5])
                return
            }
            if(customerBankAccountCommand.id){
                CustomerMaster customerMaster = CustomerMaster.get(customerBankAccountCommand.customerId)
                CustomerBankAccount savedBankAccount = CustomerBankAccount.get(customerBankAccountCommand.id)
                savedBankAccount.properties = customerBankAccountCommand.properties
                savedBankAccount.save()
                flash.message = "Bank Account updated successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:customerMaster,
                        generalAddress: customerMaster.generalAddress[0],
                        postalAddress: customerMaster.postalAddress[0],
                        shippingAddress: customerMaster.shippingAddress[0],
                        savedBankAccount: savedBankAccount,
                        vatList: VatCategory.list(),
                        paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                        countryList:Country.list(), tabSelectIndicator:5])

            }
            else {
                CustomerBankAccount bankAccount = new CustomerBankAccount(customerBankAccountCommand.properties)
                CustomerMaster customerMaster = CustomerMaster.get(customerBankAccountCommand.customerId)
                customerMaster.addToBankAccounts(bankAccount)
                if(!bankAccount.validate()){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:CustomerMaster.get(params.customerId),
                                    generalAddress: Address.get(params.generalAddressId),
                                    postalAddress: Address.get(params.postalAddressId),
                                    shippingAddress: Address.get(params.shippingAddressId),
                                    bankAccountInfo: bankAccount,
                                    vatList: VatCategory.list(),
                                    paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                    countryList:Country.list(), tabSelectIndicator:5])
                    return
                }
                CustomerBankAccount savedBankAccount = bankAccount.save(flush: true)
                if(!savedBankAccount){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:customerMaster,
                                    generalAddress: customerMaster.generalAddress[0],
                                    postalAddress: customerMaster.postalAddress[0],
                                    shippingAddress: customerMaster.shippingAddress[0],
                                    bankAccountInfo: bankAccount,
                                    vatList: VatCategory.list(),
                                    paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                    countryList:Country.list(), tabSelectIndicator:5])
                    return
                }
                flash.message = "Bank Account Saved successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:customerMaster,
                               generalAddress: customerMaster.generalAddress[0],
                               postalAddress: customerMaster.postalAddress[0],
                               shippingAddress: customerMaster.shippingAddress[0],
                               savedBankAccount: savedBankAccount,
                        vatList: VatCategory.list(),
                        paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                        countryList:Country.list(), tabSelectIndicator:5])
                return

            }
        }
    }

    def listBankAccount(Long bankAccountId){
        CustomerBankAccount thisCustomer = CustomerBankAccount.read(params.bankAccountId)
        def onlyThisCustomer = thisCustomer.customer
        int sEcho = params.sEcho ? params.getInt('sEcho') : 1
        int iDisplayStart = params.iDisplayStart ? params.getInt('iDisplayStart') : 0
        int iDisplayLength = params.iDisplayLength ? params.getInt('iDisplayLength') : 10
        String sSortDir = params.sSortDir_0 ? params.sSortDir_0 : 'asc'
        int iSortingCol = params.iSortingCols ? params.getInt('iSortingCols') : 1
        String sortColumn = CustomerBankAccountUtility.getSortColumn(iSortingCol)
        List dataReturns = new ArrayList()
        List<CustomerBankAccount> customerBankAccountList = CustomerBankAccount.withCriteria {
            eq('status', 1)
            eq('customer', onlyThisCustomer)
            firstResult(iDisplayStart)
            maxResults(iDisplayLength)
            order(sortColumn, sSortDir)
            order('bankName', 'desc')
        }
        customerBankAccountList.each { CustomerBankAccount customerBankAccount ->
            dataReturns.add([DT_RowId: customerBankAccount.id, 0: ++iDisplayStart, 1: customerBankAccount.bankName, 2: customerBankAccount.ibanPrefix, 3: customerBankAccount.bankAccountNo, 4: customerBankAccount.bankAccountName, 5: ''])
        }
        Map gridData = [iTotalRecords: CustomerBankAccount.count, iTotalDisplayRecords: CustomerBankAccount.count, aaData: dataReturns]
        String result = gridData as JSON
        render result
    }

    def editBankAccount(Long id, Long customerId) {
        CustomerMaster customerMaster = CustomerMaster.get(customerId)
        if(!customerMaster){
            //return with error message
            return
        }
        CustomerBankAccount customerBankAccount = customerMaster.bankAccounts.find {it.id ==id}
        String result = customerBankAccount as JSON
        println result
        render result
//        def bankAccountId = params.id as Long
//        CustomerBankAccount customerBankAccount = CustomerBankAccount.read(bankAccountId)
//        def customId = customerBankAccount.customerId
//        CustomerMaster customerMaster = CustomerMaster.read(customId)
//        if (!customerBankAccount) {
//            flash.message = "Bank Account not found"
//            render(view: '/coreBanking/settings/accounting/customer/create',
//                    model: [customerMaster: customerMaster,
//                            generalAddress: customerMaster.generalAddress[0],
//                            postalAddress: customerMaster.postalAddress[0],
//                            shippingAddress: customerMaster.shippingAddress[0],
//                            savedBankAccount: customerBankAccount,
//                            vatList: VatCategory.list(),
//                            paymentTermsList:PaymentTerms.list(),
//                            stateList:State.list(),
//                            countryList:Country.list(),
//                            tabSelectIndicator:5])
//        }
//        flash.message = "Bank Account updated successfully."
//        render(view: '/coreBanking/settings/accounting/customer/create',
//                model: [customerMaster: customerMaster,
//                        generalAddress: customerMaster.generalAddress[0],
//                        postalAddress: customerMaster.postalAddress[0],
//                        shippingAddress: customerMaster.shippingAddress[0],
//                        savedBankAccount: customerBankAccount,
//                        bankAccountInfo: customerBankAccount,
//                        vatList: VatCategory.list(),
//                        paymentTermsList:PaymentTerms.list(),
//                        stateList:State.list(),
//                        countryList:Country.list(),
//                        tabSelectIndicator:5])
    }

    def deleteBankAccount(Long id, Long customerId) {
        CustomerMaster customerMaster = CustomerMaster.get(customerId)
        if(!customerMaster){
            flash.message = "Customer not found"
            render(view: '/coreBanking/settings/accounting/customer/create',
                    model: [customerMaster: customerMaster,
                            generalAddress: customerMaster.generalAddress[0],
                            postalAddress: customerMaster.postalAddress[0],
                            shippingAddress: customerMaster.shippingAddress[0],
                            vatList: VatCategory.list(),
                            paymentTermsList:PaymentTerms.list(),
                            stateList:State.list(),
                            countryList:Country.list(),
                            tabSelectIndicator:5])
            return
        }
        CustomerBankAccount customerBankAccount = customerMaster.bankAccounts.find {it.id ==id}
        customerBankAccount.status = 0
        CustomerMaster savedCustomerMaster = customerMaster.save()
        if(!savedCustomerMaster){
            flash.message = "Bank Account not saved"
            render(view: '/coreBanking/settings/accounting/customer/create',
                    model: [customerMaster: customerMaster,
                            generalAddress: customerMaster.generalAddress[0],
                            postalAddress: customerMaster.postalAddress[0],
                            shippingAddress: customerMaster.shippingAddress[0],
                            vatList: VatCategory.list(),
                            paymentTermsList:PaymentTerms.list(),
                            stateList:State.list(),
                            countryList:Country.list(),
                            tabSelectIndicator:5])
            return
        }
        savedCustomerMaster.bankAccounts?.removeAll {it.status== 0}
        flash.message = "Bank Account deleted successfully"
        render(view: '/coreBanking/settings/accounting/customer/create',
                model: [customerMaster: savedCustomerMaster,
                        generalAddress: customerMaster.generalAddress[0],
                        postalAddress: customerMaster.postalAddress[0],
                        shippingAddress: customerMaster.shippingAddress[0],
                        vatList: VatCategory.list(),
                        paymentTermsList:PaymentTerms.list(),
                        stateList:State.list(),
                        countryList:Country.list(),
                        tabSelectIndicator:5])
//        render(template: '/coreBanking/settings/accounting/customer/bankAccountList', model: [customerMaster: savedCustomerMaster])
//        def bankAccountId = params.id as Long
//        CustomerBankAccount customerBankAccount = CustomerBankAccount.read(bankAccountId)
//        def customId = customerBankAccount.customerId
//        CustomerMaster customerMaster = CustomerMaster.read(customId)
//        if (!customerBankAccount) {
//            flash.message = "Bank Account not found"
//            render(view: '/coreBanking/settings/accounting/customer/create',
//                    model: [customerMaster: customerMaster,
//                            generalAddress: customerMaster.generalAddress[0],
//                            postalAddress: customerMaster.postalAddress[0],
//                            shippingAddress: customerMaster.shippingAddress[0],
//                            savedBankAccount: customerBankAccount,
//                            vatList: VatCategory.list(),
//                            paymentTermsList:PaymentTerms.list(),
//                            stateList:State.list(),
//                            countryList:Country.list(),
//                            tabSelectIndicator:5])
//        }
//        customerBankAccount.status = 0
//        customerBankAccount.save(flush: true)
//        flash.message = "Bank Account deleted successfully"
//        render(view: '/coreBanking/settings/accounting/customer/create',
//                model: [customerMaster: customerMaster,
//                        generalAddress: customerMaster.generalAddress[0],
//                        postalAddress: customerMaster.postalAddress[0],
//                        shippingAddress: customerMaster.shippingAddress[0],
//                        savedBankAccount: customerBankAccount,
//                        vatList: VatCategory.list(),
//                        paymentTermsList:PaymentTerms.list(),
//                        stateList:State.list(),
//                        countryList:Country.list(),
//                        tabSelectIndicator:5])
    }
}

class CustomerMasterCommand {
    Long id
//    Long bankAccounts
    String chamberOfCommerce
    String comments
    String bankName
    String customerCode
    String customerName
    String customerType
    String defaultGlAccount
    String email
    String firstName
    String gender
    String lastName
    String middleName
    String momentOfSending
    int status
    VatCategory vat
    PaymentTerms paymentTerm
    CustomerBankAccount bankAccounts

    static constraints = {
        importFrom CustomerMaster
        id nullable: true
        customerCode nullable: true, validator: { val, obj ->
            if (obj.id == null) {
                if(!val){
                    return "clients.customer.customerCode.required"
                } else if(CustomerMaster.findByCustomerCode(val)){
                    return "clients.customer.customerCode.already.exist"
                }
            }
        }

    }
}

class CustomerAddressCommand {
    Long id
    String contactPersonName
    String contactPersonReference
    String contactDealType
    String mobileNo
    String faxNo
    String phoneNo
    String phoneNo2
    String websiteUrl
    String addressLine1
    String addressLine2
    String email1
    String email2
    State state
    String postCode
    String city
    Country country
    Integer status
    Boolean likeGeneralAddress

    static constraints = {
        contactPersonName nullable: false
        contactPersonReference nullable : true
        contactDealType nullable: true
        mobileNo nullable: true
        faxNo nullable: true
        phoneNo nullable: true
        websiteUrl nullable: true
        addressLine1 nullable: true
        addressLine2 nullable: true
        email2 nullable: true
        state nullable: true
        postCode nullable: true
        country nullable: false
        city nullable: true
        status nullable: false
    }
}

class CustomerBankAccountCommand {
    Long id
    Long customerId
    String bankName
    String ibanPrefix
    String bankAccountNo
    String bankAccountName
    int status

    static constraints = {
        importFrom CustomerBankAccount
    }
}
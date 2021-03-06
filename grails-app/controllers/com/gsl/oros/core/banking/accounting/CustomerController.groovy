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
        flash.message = null
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
                                generalAddress: customerMaster.generalAddress[0],
                                postalAddress: customerMaster.postalAddress[0],
                                shippingAddress: customerMaster.shippingAddress[0],
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
                CustomerMaster customerMaster = CustomerMaster.get(addressCommand.customerId)
                render (view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:customerMaster,
                               generalAddress: addressCommand,
                               postalAddress: customerMaster.postalAddress[0],
                               shippingAddress: customerMaster.shippingAddress[0],
                               vatList: VatCategory.list(),
                               paymentTermsList:PaymentTerms.list(),
                               countryList:Country.list(),
                               stateList:State.list(),
                               tabSelectIndicator:2])
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
        if (!request.method == 'POST') {
            flash.message = "This action is not allowed!"
            render (view: '/coreBanking/settings/accounting/customer/customerList')
            return
        }
        else {
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
                                    postalAddress: address,
                                    shippingAddress: Address.get(params.shippingAddressId),
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
                                postalAddress: savedAddress,
                                shippingAddress: Address.get(params.shippingAddressId),
                                savedBankAccount: CustomerBankAccount.get(params.bankAccountId),
                                vatList: VatCategory.list(),
                                paymentTermsList:PaymentTerms.list(), stateList:State.list(),
                                countryList:Country.list(), tabSelectIndicator:4])
                return

            }
        }
    }

    def saveShipmentAddress(CustomerAddressCommand addressCommand){
        if (request.method == 'POST') {
            if (addressCommand.hasErrors()) {
                CustomerMaster customerMaster = CustomerMaster.get(addressCommand.customerId)
                render (view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:customerMaster,
                               generalAddress: customerMaster.generalAddress[0],
                               postalAddress: customerMaster.postalAddress[0],
                               shippingAddress: addressCommand,
                               vatList: VatCategory.list(),
                               paymentTermsList:PaymentTerms.list(),
                               countryList:Country.list(),
                               stateList:State.list(),
                               tabSelectIndicator:4])
                return
            }
            if(addressCommand.id){
                CustomerMaster customerMaster = CustomerMaster.get(addressCommand.customerId)
                Address savedAddress = Address.get(addressCommand.id)
                savedAddress.properties = addressCommand.properties
                savedAddress.save()
                flash.message = "Shipping Address updated successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:customerMaster,
                               generalAddress: customerMaster.generalAddress[0],
                               postalAddress: customerMaster.postalAddress[0],
                               shippingAddress: savedAddress,
                               vatList: VatCategory.list(),
                               paymentTermsList:PaymentTerms.list(),
                               countryList:Country.list(),
                               stateList:State.list(),
                               tabSelectIndicator:5])

            }
            else {
                Address address = new Address(addressCommand.properties)
                address.addressType = AddressType.SHIPPING
                CustomerMaster customerMaster = CustomerMaster.get(params.customerId)
                customerMaster.addToShippingAddress(address)
                if(!address.validate()){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:customerMaster,
                                   generalAddress: customerMaster.generalAddress[0],
                                   postalAddress: customerMaster.postalAddress[0],
                                   shippingAddress: address,
                                   vatList: VatCategory.list(),
                                   paymentTermsList:PaymentTerms.list(),
                                   countryList:Country.list(),
                                   stateList:State.list(),
                                   tabSelectIndicator:4])
                    return
                }
                Address savedAddress = address.save(flush: true)
                if(!savedAddress){
                    render (view: '/coreBanking/settings/accounting/customer/create',
                            model:[customerMaster:customerMaster,
                                   generalAddress: customerMaster.generalAddress[0],
                                   postalAddress: customerMaster.postalAddress[0],
                                   shippingAddress: address,
                                   vatList: VatCategory.list(),
                                   paymentTermsList:PaymentTerms.list(),
                                   countryList:Country.list(),
                                   stateList:State.list(),
                                   tabSelectIndicator:4])
                    return
                }
                flash.message = "Shipping Address Saved successfully"
                render(view: '/coreBanking/settings/accounting/customer/create',
                        model:[customerMaster:customerMaster,
                               generalAddress: customerMaster.generalAddress[0],
                               postalAddress: customerMaster.postalAddress[0],
                               shippingAddress: savedAddress,
                               vatList: VatCategory.list(),
                               paymentTermsList:PaymentTerms.list(),
                               countryList:Country.list(),
                               stateList:State.list(),
                               tabSelectIndicator:5])
            }
        }
    }

    def saveBankAccount(CustomerBankAccountCommand customerBankAccountCommand){
        if (!request.method == 'POST') {
            flash.message = "This action is not allowed!"
            render (view: '/coreBanking/settings/accounting/customer/customerList')
        }
        else {
            CustomerMaster customerMaster = CustomerMaster.get(customerBankAccountCommand.customerId)
            if (customerBankAccountCommand.hasErrors()) {
                def result = [isError:true, message:"Bank account Info data has any problem!!"]
                render result as JSON
                return
            }
            if(customerBankAccountCommand.id){ // update
                def row = params.row
                CustomerBankAccount customerBankAccount = CustomerBankAccount.get(customerBankAccountCommand.id)
                customerBankAccount.properties = customerBankAccountCommand.properties
                if(!customerBankAccount.validate()){
                    def result = [isError:true, message:"Bank account info data have some validation problem!"]
                    render result as JSON
                    return
                }
                CustomerBankAccount updatedBankAccount = customerBankAccount.save()
                if (!updatedBankAccount){
                    def result = [isError:true, message:"Bank account Info not updated successfully!"]
                    render result as JSON
                    return
                }
                def result = [isError:false, message:"Bank account info update successfully!", update:true, customerMaster:customerMaster, customerBankAccount: updatedBankAccount, row: row]
                render result as JSON
            }
            else { // add
                CustomerBankAccount bankAccount = new CustomerBankAccount(customerBankAccountCommand.properties)
                if(!bankAccount.validate()){
                    def result = [isError:true, message:"Bank account Info not validated successfully!"]
                    render result as JSON
                    return
                }
                CustomerBankAccount savedBankAccount = bankAccount.save(flush: true)
                if(!savedBankAccount){
                    def result = [isError:true, message:"Bank account Info not added successfully!"]
                    render result as JSON
                    return
                }
                customerMaster.addToBankAccounts(savedBankAccount)
                CustomerMaster savedCustomerMaster = customerMaster.save(flash:true)
                def result = [isError:false, add:true, message:"Bank Account Info Added successfully!", customerBankAccount: savedBankAccount, customerMaster:savedCustomerMaster]
                render result as JSON
            }
        }
    }

    def editBankAccount(Long id, Long row) {
        CustomerBankAccount customerBankAccount = CustomerBankAccount.findById(id)
        if(!customerBankAccount){
            def result = [isError:true, message:"Bank Account not found !"]
            render result as JSON
            return
        }
        def result = [isError:false, customerBankAccount: customerBankAccount, row:row]
        render result as JSON
    }

    def deleteBankAccount(Long id, Long customerId) {
        CustomerMaster customerMaster = CustomerMaster.get(customerId)
        if(!customerMaster){
            def result = [isError:true, message:"Customer not found!"]
            render result as JSON
            return
        }
        CustomerBankAccount customerBankAccount = CustomerBankAccount.get(id)
        if (!customerBankAccount) {
            def result = [isError:true, message:"Bank Account not found!"]
            render result as JSON
            return
        }
        customerBankAccount.status = false
        CustomerMaster savedCustomerMaster = customerMaster.save()
        if (!savedCustomerMaster){
            def result = [isError:true, message:"Bank account information not deleted!"]
            render result as JSON
            return
        }
        savedCustomerMaster.bankAccounts?.removeAll {it.status== false}
        def result = [isError:false, message:"Bank account information deleted successfully!"]
        String output = result as JSON
        render output
    }
}

class CustomerMasterCommand {
    Long id
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
    Long customerId
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
        id nullable: true
        customerId nullable: false
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

    static constraints = {
        importFrom CustomerBankAccount
        customerId nullable: false
    }
}
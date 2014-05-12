package com.gsl.oros.core.banking.clients

import com.gsl.oros.core.banking.attachments.Signatures
import com.gsl.oros.core.banking.operation.Client
import com.gsl.oros.core.banking.product.clients.RetailClientUtility
import com.gsl.oros.core.banking.settings.Bank
import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.oros.core.banking.settings.Branch
import grails.converters.JSON
import org.apache.commons.io.FileUtils
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

class RetailClientController {
    def attachmentService

    def index() {
        render (template: 'retailClientList')
    }

    def create() {
        render(view: 'create', model: [dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                dateMask: "99/99/9999"])
    }

    def editRetailClient(){
        Long id = params.getLong('id')
        RetailAccount retailAccountList = RetailAccount.get(id)

        def openingDate = retailAccountList.openingDate.format("dd/MM/yyyy")
        render(view: 'create', model: [tabSelector: 'tabSelectorEdit',openingDate: openingDate, retailAccountList: retailAccountList])
        render(view: 'create', model: [tabSelector: 'tabSelectorEdit',openingDate: openingDate, retailAccountList: retailAccountList])

    }
    def deleteRetailClient(){
        Long id = params.getLong('id')
        RetailAccount retailAccount = RetailAccount.get(id)
        if (!retailAccount) {
            flash.message = "Chart Class not found"
            render(template: 'retailClientList')
            return
        }
        retailAccount.status = false
        retailAccount.save(flush: true)
        flash.message = "Retail Account deleted successfully"
        render(template: 'retailClientList')
    }

    def saveRetailSignatures(SignaturesCommand signaturesCommand) {

        if (!request.method == 'POST') {
            flash.message = "Signature data have some problem!"
            render (template: 'retailClientList')
            return
        }
        if (signaturesCommand.hasErrors()) {
            render (view: 'create',model:[tabSelector: '5', signaturesCommand: signaturesCommand])
            return
        }

        def firstfile = request.getFile('firstSignature')
        def secondfile = request.getFile('secondSignature')

        String firstOriginalFilename = firstfile.originalFilename
        firstOriginalFilename = UUID.randomUUID().toString() + ".${firstOriginalFilename.split("\\.")[-1]}"

        String secondOriginalFilename = secondfile.originalFilename
        secondOriginalFilename = UUID.randomUUID().toString() + ".${secondOriginalFilename.split("\\.")[-1]}"

        File firstStoreFile = attachmentService.storeImage(firstfile, firstOriginalFilename)
        File secondStoreFile = attachmentService.storeImage(secondfile, secondOriginalFilename)

        if (!firstStoreFile && !secondStoreFile) {
            flash.message = "Signatures file have some problem!!"
            render (view: 'create',model:[tabSelector: '5'])
            return
        }
        Signatures signatures = new Signatures()
        signatures.firstSignatureName = firstOriginalFilename
        signatures.secondSignatureName = secondOriginalFilename

        RetailAccount retailAccount = RetailAccount.read(params.retailAccount as Long)
        signatures.retailAccount=retailAccount

        if(!signatures.validate()){
            flash.message = "Signatures file Not Validate!"
            render (view: 'create', model: [tabSelector: '5', retailAccount:retailAccount])
            return
        }

        if(params.id){
            def signaturesEdit = Signatures.get(params.id as Long)
            signaturesEdit.properties = signatures
            Signatures signaturesUpdate = signaturesEdit.save(flush: true)
            if (!signaturesUpdate){
                flash.message = "Signatures Not Update Successfully!"
                render (view: 'create', model: [tabSelector: '5'])
                return
            }
            flash.message = "Signatures File update successfully!!"
            render(template: 'attachments', model: [tabSelector: '6', retailAccount:retailAccount, signatures: signaturesUpdate])
        }
        else{
            Signatures signaturesSaved = signatures.save(flush: true)
            if (!signaturesSaved){
                flash.message = "Signatures Not Added Successfully!"
                render (view: 'create', model: [tabSelector: '5'])
                return
            }
            flash.message = "Signatures File added successfully!!"
            render(template: 'attachments', model: [tabSelector: '6', retailAccount:retailAccount, signatures: signaturesSaved])
        }
    }

    // Retail Account Save and Edit
    def saveRetailAccount(RetailAccountCommand retailAccountCommand) {
        if (!request.method == 'POST') {
            render (template: 'retailClientList')
            return
        }
        if (retailAccountCommand.hasErrors()) {
            render (view: 'create',model:[tabSelector: '1', retailAccountCommand: retailAccountCommand])
            return
        }

        if(retailAccountCommand.id){ // update
            RetailAccount retailAccount = RetailAccount.get(retailAccountCommand.id)
            retailAccount.properties = retailAccountCommand.properties
            if(!retailAccount.validate()){
                flash.message = "Retail Account Information Not Validate!"
                render (view: 'create', model: [tabSelector: '1'])
                return
            }
            RetailAccount savedAccount = retailAccount.save(flash:true)
            if(!savedAccount){
                flash.message = "Retail Account Not Update Data Successfully!"
                render (view: 'create', model: [tabSelector: '1'])
                return
            }

            savedAccount?.retailIntroducer?.removeAll{it.status== false}
            savedAccount?.retailNominee?.removeAll{it.status== false}
            savedAccount?.retailOtherBank?.removeAll{it.status== false}

            flash.message = "Retail Account Update Data Successfully!"
            render(view: 'create', model: [
                    tabSelector : '1',
                    retailAccount: savedAccount,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])
        }
        else{
            RetailAccount retailAccount = new RetailAccount(retailAccountCommand.properties)
            if(!retailAccount.validate()){
                flash.message = "Retail Account Information Not Validate!"
                render (view: 'create', model: [tabSelector: '1'])
                return
            }
            RetailAccount savedAccount = retailAccount.save(flash:true)
            if(!savedAccount){
                flash.message = "Retail Account Not Added Data Successfully!"
                render (view: 'create', model: [tabSelector: '1'])
                return
            }
            flash.message = "Retail Account Added Data Successfully!"
            render(view: 'create', model: [
                    tabSelector : '2',
                    retailAccount: savedAccount,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])
        }
    }

    def saveRetailIntroducer(RetailIntroducerCommand retailIntroducerCommand) {

        if (!request.method == 'POST') {
            flash.message = "Retail Introducer have some problem!"
            render (template: 'retailClientList')
            return
        }
        RetailAccount retailAccount = RetailAccount.get(retailIntroducerCommand.retailAccount.id)
        if (!retailAccount) {
            flash.message = "Retail account not found"
            render (template: 'retailClientList')
            return
        }
        if (retailIntroducerCommand.hasErrors()) {
            def result = [isError:true, message:"Introducer data have some problem!!!"]
            String output = result as JSON
            return
        }

        RetailIntroducer retailIntroducer = new RetailIntroducer(retailIntroducerCommand.properties)
        if(!retailIntroducer.validate()){
            def result = [isError:true, message:"Introducer data have some validated problem!!"]
            return
        }

        RetailIntroducer savedIntroducer = retailIntroducer.save(flush: true)
        if(!savedIntroducer){
            def result = [isError:true, message:"Introducer dose not save successfully!!"]
            return
        }

        retailAccount.getRetailIntroducer().add(savedIntroducer)
        RetailAccount savedAccount = retailAccount.save(flash:true)

        def result = [isError:false, message:"Added successsfully!", introducer: savedIntroducer, client:retailIntroducerCommand.client ]
        String output = result as JSON
        println(output)
        render output

    }

    def deleteRetailIntroducer(){
        RetailIntroducer retailIntroducer = RetailIntroducer.get(params.id as Long)
        //RetailAccount retailAccount = RetailAccount.read(params.retailAccount as Long)
        if (!retailIntroducer) {
            def result = [isError:true, message:"Introducer dose not delete successfully!"]
            String output = result as JSON
            render output
            return
            return
        }
        retailIntroducer.status = false
        def savedIntroducer = retailIntroducer.save(flush: true)
        if(!savedIntroducer){
            def result = [isError:true, message:"Introducer dose not delete successfully!"]
            String output = result as JSON
            render output
            return
        }

        /*retailAccount?.retailIntroducer?.removeAll{it.status== false}
        retailAccount?.retailNominee?.removeAll{it.status== false}
        retailAccount?.retailOtherBank?.removeAll{it.status== false}*/

        /*render(view: 'create', model: [
                tabSelector: '2',
                retailAccount: retailAccount,
                dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                dateMask: "99/99/9999"
        ])*/

        def result = [isError:false, message:"Delete successsfully"]
        String output = result as JSON
        println(output)
        render output

    }

    def saveRetailOtherBankAccount(RetailOtherBankCommand retailOtherBankCommand) {

        if (!request.method == 'POST') {
            flash.message = "Other bank account data have some problem!"
            render (template: 'retailClientList')
            return
        }

        RetailAccount retailAccount = RetailAccount.read(retailOtherBankCommand.retailAccount.id)
        if (retailOtherBankCommand.hasErrors()) {
            /*render (view: 'create', model:[
                    tabSelector: '3',
                    retailAccount: retailAccount,
                    retailOtherBankCommand: retailOtherBankCommand,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])*/
            // error
            return
        }

        if(retailOtherBankCommand.id){  // update
            def row = params.row
            RetailOtherBank retailOtherBank = RetailOtherBank.get(retailOtherBankCommand.id)
            retailOtherBank.properties = retailOtherBankCommand.properties
            if(!retailOtherBank.validate()){
                /*flash.message = "Other bank account data have some validated problem!"
                render (view: 'create', model:[
                        tabSelector: '3',
                        retailAccount: retailAccount,
                        dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999"
                ])*/
                // error
                return
            }
            RetailOtherBank retailOtherBankUpdate = retailOtherBank.save()
            if (!retailOtherBankUpdate){
                flash.message = "Other Bank account data dose not update Successfully!"
                render (view: 'create', model:[
                        tabSelector: '3',
                        retailAccount: retailAccount,
                        dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999"
                ])
                return
            }
            /*retailAccount?.retailIntroducer?.removeAll{it.status== false}
            retailAccount?.retailNominee?.removeAll{it.status== false}
            retailAccount?.retailOtherBank?.removeAll{it.status== false}*/
            /*flash.message = "Other Bank account data update Successfully!"
            render (view: 'create', model:[
                    tabSelector:'3',
                    retailAccount:retailAccount,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])*/

            def result = [isError:false, message:"Other bank account information data update successsfully!", update:true, retailOtherBank: retailOtherBankUpdate, bank: retailOtherBankCommand.bank.name, branch: retailOtherBankCommand.branch.name, row: row]
            String output = result as JSON
            println(output)
            render output

        }
        else{   // add
            RetailOtherBank retailOtherBank = new RetailOtherBank(retailOtherBankCommand.properties)
            if(!retailOtherBank.validate()){
                /*flash.message = "Other bank Information Not Validate!"
                render (view: 'create', model: [
                        tabSelector: '3',
                        retailAccount:retailAccount,
                        dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999"
                ])*/
                // error
                return
            }
            RetailOtherBank retailOtherBankSaved = retailOtherBank.save()
            if(!retailOtherBankSaved){
                /*flash.message = "Other Bank account data dose not added Successfully!"
                render (view: 'create', model:[
                        tabSelector: '3',
                        retailAccount: retailAccount,
                        dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999"
                ])*/
                // error
                return
            }

            retailAccount.getRetailOtherBank().add(retailOtherBankSaved)
            RetailAccount savedAccount = retailAccount.save(flash:true)

            /*savedAccount?.retailIntroducer?.removeAll{it.status== false}
            savedAccount?.retailNominee?.removeAll{it.status== false}
            savedAccount?.retailOtherBank?.removeAll{it.status== false}*/

            /*flash.message = "Other Bank account data added Successfully!"
            render(view: 'create', model:[
                    tabSelector: '3',
                    retailAccount: savedAccount,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])*/

            def result = [isError:false, add:true, message:"Added successsfully!", retailOtherBank: retailOtherBankSaved, bank: retailOtherBankCommand.bank.name, branch: retailOtherBankCommand.branch.name]
            String output = result as JSON
            println(output)
            render output

        }

    }

    def editOtherBankAccount(){
        def row = params.row
        RetailOtherBank retailOtherBank = RetailOtherBank.findById(params.id as Long)
        if(!retailOtherBank){
            def result = [isError:true, message:"Data not find !!"]
            render result as JSON
            return
        }
        Bank bank = Bank.findById(retailOtherBank.bank.id as Long)
        Branch branch = Branch.findById(retailOtherBank.branch.id as Long)
        def result = [isError:false, retailOtherBank: retailOtherBank, bank: bank, branch: branch, row:row]
        render result as JSON
    }

    def deleteOtherBankAccount(){
        RetailOtherBank retailOtherBank = RetailOtherBank.get(params.id as Long)
        //RetailAccount retailAccount = RetailAccount.read(params.retailAccount as Long)
        if (!retailOtherBank) {
            /*flash.message = "Other Bank account not delete Successfully!"
            render(view: 'create', model: [
                    tabSelector: '3',
                    retailAccount: retailAccount,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])*/
            def result = [isError:true, message:"Have some problem!!"]
            return
        }
        retailOtherBank.status = false
        RetailOtherBank retailOtherBankSaved = retailOtherBank.save(flush: true)
        if (!retailOtherBankSaved){
            /*flash.message = "Other Bank account not delete Successfully!"
            render(view: 'create', model: [
                    tabSelector: '3',
                    retailAccount: retailAccount,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])*/
            def result = [isError:true, message:"Other bank account information does not delete!!"]
            return
        }

        /*retailAccount?.retailIntroducer?.removeAll{it.status== false}
        retailAccount?.retailNominee?.removeAll{it.status== false}
        retailAccount?.retailOtherBank?.removeAll{it.status== false}*/
        /*flash.message = "Other Bank account delete Successfully!"
        render(view: 'create', model: [
                tabSelector: '3',
                retailAccount: retailAccount,
                dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                dateMask: "99/99/9999"
        ])*/
        def result = [isError:false, message:"Delete successsfully!"]
        String output = result as JSON
        println(output)
        render output
    }

    def saveRetailNomineeInfo(RetailNomineeCommand retailNomineeCommand) {
        if (!request.method == 'POST') {
            flash.message = "Nominee data dose not added Successfully!"
            render (template: 'retailClientList')
            return
        }

        RetailAccount retailAccount = RetailAccount.read(retailNomineeCommand.retailAccount.id)
        if (retailNomineeCommand.hasErrors()) {
            render (view: 'create', model:[
                    tabSelector: '4',
                    retailAccount: retailAccount,
                    retailNomineeCommand: retailNomineeCommand,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])
            return
        }

        if(retailNomineeCommand.id){ // update
            RetailNominee retailNominee = RetailNominee.get(retailNomineeCommand.id)
            retailNominee.properties = retailNomineeCommand.properties
            RetailNominee retailNomineeSaved = retailNominee.save()
            if (!retailNomineeSaved){
                flash.message = "Nominee data dose not update Successfully!"
                render (view: 'create', model:[tabSelector: '4', retailAccount:retailAccount])
                return
            }
            flash.message = "Nominee data update Successfully!"
            render (view: 'create', model:[
                    tabSelector:'5',
                    retailAccount:retailAccount,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])
        }
        else{ // add
            RetailNominee retailNominee = new RetailNominee(retailNomineeCommand.properties)
            RetailNominee retailNomineeSaved = retailNominee.save(flush: true)
            if(!retailNomineeSaved){
                flash.message = "Nominee data dose not added Successfully!"
                render (view: 'create', model:[tabSelector: '4', retailAccount: retailAccount])
                return
            }

            retailAccount.getRetailNominee().add(retailNomineeSaved)
            RetailAccount savedAccount = retailAccount.save(flash:true)

            savedAccount?.retailIntroducer?.removeAll{it.status== false}
            savedAccount?.retailNominee?.removeAll{it.status== false}
            savedAccount?.retailOtherBank?.removeAll{it.status== false}

            flash.message = "Nominee data added Successfully!"
            render(view: 'create', model: [
                    tabSelector: '5',
                    retailAccount: savedAccount,
                    dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                    dateMask: "99/99/9999"
            ])
        }
    }

    def deleteRetailNominee(){
        RetailNominee retailNominee = RetailNominee.get(params.id as Long)
        RetailAccount retailAccount = RetailAccount.read(params.retailAccount as Long)
        if (!retailNominee) {
            flash.message = "Nominee information not delete Successfully!"
            render(view: 'create', model: [tabSelector: '4', retailAccount: retailAccount])
        }
        retailNominee.status = false
        RetailNominee retailNomineeSaved = retailNominee.save(flush: true)
        if (!retailNomineeSaved){
            flash.message = "Nominee information not delete Successfully!"
            render(view: 'create', model: [tabSelector: '4', retailAccount: retailAccount])
        }

        retailAccount?.retailIntroducer?.removeAll{it.status== false}
        retailAccount?.retailNominee?.removeAll{it.status== false}
        retailAccount?.retailOtherBank?.removeAll{it.status== false}

        flash.message = "Nominee information data delete Successfully!"
        render(view: 'create', model: [tabSelector: '4', retailAccount: retailAccount])

    }

    def editRetailNominee(){
        RetailAccount retailAccount = RetailAccount.get(params.retailAccount as Long)
        RetailNominee retailNominee = RetailNominee.findById(params.id as Long)
        if (!retailNominee) {
            flash.message = "Nominee information dose not exist!"
            render(view: 'create', model: [tabSelector: '4', retailAccount: retailAccount])
        }
        render(view: 'create', model: [tabSelector: '4', retailAccount: retailAccount, retailNominee: retailNominee])
    }

    def checkAccountNo() {
        def accountNo = params.accountNo
        def result = Client.findByAccountNo(accountNo)
        def r = [result: result]
        render r as JSON
    }

    def fetchBranch(Long id) {
        Bank bank = Bank.read(id)
        List<Branch> branch = Branch.findAllByBank(bank)
        for (def i = 0; i < branch.size(); i++) {
            render "<option value='${branch.id[i]}'>${branch.name[i]}</option>"
        }

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
        String sortColumn = RetailClientUtility.getSortColumn(iSortingCol)
        List dataReturns = new ArrayList()
        def c = RetailAccount.createCriteria()
        def results = c.list (max: iDisplayLength, offset:iDisplayStart) {
            and {
                eq("status", true)
            }
            if(sSearch){
                or {
                    ilike('title',sSearch)
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
            results.each {RetailAccount retailAccount ->
                if(sSortDir.equalsIgnoreCase('asc')){
                    serial++
                }else{
                    serial--
                }
                dataReturns.add([DT_RowId:retailAccount.id,0:serial,1:retailAccount.title,2:retailAccount.accountPurpose,3:retailAccount.openingDate.format("dd/MM/yyyy"),4:''])
            }
        }
        Map gridData =[iTotalRecords:totalCount,iTotalDisplayRecords:totalCount,aaData:dataReturns]
        String result = gridData as JSON
        println(result)
        render result
    }
}


// Command Object
class RetailAccountCommand {
    Long id
    String title
    Date openingDate
    String accountPurpose
    Integer termAndCondition
    Long createAccountInfoId // fk

    static constraints = {
        id blank: true,nullable: true
        title blank: false, nullable: false
        openingDate blank: false, nullable: false
        accountPurpose blank: false, nullable: false
        termAndCondition blank: false, nullable: false
    }

}

class RetailIntroducerCommand {
    Long id
    String relation
    Client client
    RetailAccount retailAccount

    static constraints = {
        id blank: true, nullable: true
        relation blank: false, nullable: false
        client blank: false, nullable: false
    }

}

class RetailOtherBankCommand {
    Long id
    String accountNo
    String accountName
    String type
    String sortCode
    RetailAccount retailAccount
    Bank bank
    Branch branch

    static constraints = {
        accountNo   blank: false, nullable: false
        accountName blank: false, nullable: false
        type        blank: false, nullable: false
        sortCode    blank: false, nullable: false
    }
}

class RetailNomineeCommand{
    Long id
    String firstName
    String middleName
    String lastName
    String email
    String addressLine1
    String addressLine2
    String accountNo
    Date dob
    String branchName
    String contactNo
    String type
    String relation
    String gender
    RetailAccount retailAccount

    static constraints = {
        id blank: true, nullable: true
        firstName blank: true, nullable: true
        middleName blank: true, nullable: true
        lastName blank: true, nullable: true
        email blank: true, nullable: true
        addressLine1 blank: true, nullable: true
        addressLine2 blank: true, nullable: true
        accountNo blank: false, nullable: false   // must fillup
        dob blank: false, nullable: false         // must fillup
        branchName blank: true, nullable: true
        contactNo blank: true, nullable: true
        type blank: true, nullable: true
        relation blank: true, nullable: true
        gender blank: false, nullable: false      // must fillup
     }
}

class SignaturesCommand {
    String firstSignatureName                     //Type of the uploaded file (such as pdf, txt …)
    String secondSignatureName

    static constraints = {
        firstSignatureName nullable: false, blank: false
        secondSignatureName nullable: false, blank: false
    }
}

package com.gsl.oros.core.banking.clients

import com.gsl.cbs.contraints.enums.AddressType
import com.gsl.oros.core.banking.accountHolder.AccountHolder
import com.gsl.oros.core.banking.accountHolder.EducationalInfo
import com.gsl.oros.core.banking.attachments.Pictures
import com.gsl.oros.core.banking.operation.Client
import com.gsl.oros.core.banking.product.clients.AccountHolderUtility
import com.gsl.oros.core.banking.product.clients.EducationalInfoUtility
import com.gsl.oros.core.banking.settings.Address
import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.oros.core.banking.settings.Country
import com.gsl.oros.core.banking.settings.Currencys
import com.gsl.oros.core.banking.settings.State
import com.gsl.oros.core.banking.settings.accounting.vendor.VendorBankAccount
import com.gsl.oros.core.banking.settings.accounting.vendor.VendorMaster
import com.gsl.plugin.attachments.AttachStatus
import com.gsl.plugin.attachments.OrosAttachment
import grails.converters.JSON
import org.apache.commons.io.FileUtils
import org.omg.PortableInterceptor.ACTIVE
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import com.gsl.oros.core.banking.attachments.Attachments
import org.springframework.web.multipart.commons.CommonsMultipartFile
import com.gsl.oros.core.banking.accountHolder.SpouseInfo
class AccountHolderInfoController {
    def imageIndirectService

    def index() {
        render (view: 'clientList')
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
        String sortColumn = AccountHolderUtility.getSortColumn(iSortingCol)
        List dataReturns = new ArrayList()
        def c = AccountHolder.createCriteria()
        def results = c.list (max: iDisplayLength, offset:iDisplayStart) {
            and {
                eq("status", true)
            }
            if(sSearch){
                or {
                    ilike('firstName',sSearch)
                    ilike('lastName',sSearch)
                    ilike('birthCountry',sSearch)
                    ilike('nationality1',sSearch)
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
            results.each {AccountHolder accountHolder ->
                if(sSortDir.equalsIgnoreCase('asc')){
                    serial++
                }else{
                    serial--
                }
                dataReturns.add([DT_RowId: accountHolder.id, 0: serial, 1: accountHolder.firstName, 2: accountHolder.lastName, 3: accountHolder.birthCountry.name, 4: accountHolder.nationality1.name, 5: ''])
            }
        }
        Map gridData = [iTotalRecords: totalCount, iTotalDisplayRecords: totalCount, aaData: dataReturns]
        String result = gridData as JSON
        render result
    }

    def edit(Long id) {
        AccountHolder accountHolder = AccountHolder.read(id)
        if (!accountHolder) {
            flash.message = "Client not found"
            render(view: 'clientList')
        }
        render(view: 'create',
                model: [accountHolder: accountHolder,
                        generalAddress: accountHolder.generalAddress[0],
                        postalAddress: accountHolder.postalAddress[0],
                        educationalInfoList: accountHolder.educationalInfo,
                        spouseInfoList: accountHolder.spouse,
                        attachmentList: accountHolder.attachments,
                        stateList:State.list(),
                        countryList: Country.list(),tabSelectIndicator:1])
    }


    def delete(Long id) {
        AccountHolder accountHolder = AccountHolder.get(id)
        if (!accountHolder) {
            flash.message = "Client not found"
            render(view: 'clientList')
        }
        accountHolder.status = false
        accountHolder.save(flush: true)
        flash.message = "Client deleted successfully"
        render(view: 'clientList')
    }

    def create() {
        def tabSelector = 1
        render(view: '/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
    }

    def savePersonalInfo(){
        if(request.method=="POST"){

            def tabSelector=1
            if(params.id){
                AccountHolder accountHolder = AccountHolder.get(params.id)
                accountHolder.properties = params
                AccountHolder savedAccountHolder = accountHolder.save(flush: true)
                if(!savedAccountHolder){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
                    return
                }
                println "AccountHolder ID="+ savedAccountHolder.id

                flash.message = "Personal Information of Account Holder Successfully Updated"
                render (view: '/accountHolderInfo/create', model: [tabSelectIndicator: 2, accountHolder:savedAccountHolder])
                return
            }else{
                AccountHolder accountHolder = new AccountHolder(params)

                if(!accountHolder.validate()){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
                    return
                }
                AccountHolder savedAccountHolder = accountHolder.save(flush: true)
                if(!savedAccountHolder){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
                    return
                }
                println "AccountHolder ID="+ savedAccountHolder.id

                flash.message = "Personal Information of Account Holder Successfully Saved"
                render (view: '/accountHolderInfo/create', model: [tabSelectIndicator: 2, accountHolder:savedAccountHolder])
                return
            }


        }
    }

    def saveGeneralAddress(){
        if(request.method=="POST"){
            def AccountHolderId = params.id
            def tabSelector=2
            AccountHolder accountHolder = AccountHolder.get(AccountHolderId)
            Address generalAddress
            Address postalAddress
            AccountHolder savedAccountHolder
            def posid
            if (params.generalAddressId) {
                def genid = accountHolder.generalAddress.id
                generalAddress = Address.get(genid)
                generalAddress.addressType = AddressType.GENERAL
                generalAddress.properties = params
                posid = accountHolder.postalAddress.id
                if (posid!=null){
                    postalAddress = Address.get(posid)
                }
                savedAccountHolder = accountHolder.save(flush: true)
                flash.message = "Contact Address of Account Holder Successfully Updated"

            }else {
                posid = accountHolder.postalAddress.id
                if (posid!=null){
                    postalAddress = Address.get(posid)
                }
                generalAddress = new Address(params)
                generalAddress.addressType = AddressType.GENERAL
                accountHolder.addToGeneralAddress(generalAddress)
                if(!accountHolder.validate()){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
                    return
                }
                savedAccountHolder = accountHolder.save(flush: true)
                if(!savedAccountHolder){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
                    return
                }
                flash.message = "Contact Address of Account Holder Successfully Saved"

            }
            render (view: '/accountHolderInfo/create', model: [tabSelectIndicator: 3, accountHolder:savedAccountHolder, generalAddress:generalAddress,postalAddress:postalAddress])
            return
        }

    }
    def  stateList(){
        def states = State.findAllByCountry(Country.read(params.country as Long))
        for (def i = 0; i < states.size(); i++) {
            render "<option value='${states.id[i]}'>${states.name[i]}</option>"
        }
    }
    def savePostalAddress(){
        if(request.method=="POST"){
            def AccountHolderId = params.id
            def tabSelector=3
            AccountHolder accountHolder = AccountHolder.get(AccountHolderId)
            if (params.postalAddressId){
                def genid = accountHolder.generalAddress.id
                Address generalAddress = Address.get(genid)
                def posid = accountHolder.postalAddress.id
                Address postalAddress = Address.get(posid)
                postalAddress.properties = params
                postalAddress.addressType = AddressType.POSTAL
                AccountHolder savedAccountHolder = accountHolder.save(flush: true)
                flash.message = "Postal Address of Account Holder Successfully Updated"
                render (view: '/accountHolderInfo/create', model: [tabSelectIndicator: 4, accountHolder:savedAccountHolder, generalAddress:generalAddress, postalAddress:postalAddress])
                return
            }else{
                def genid = accountHolder.generalAddress.id
                Address generalAddress = Address.get(genid)
                Address postalAddress = new Address(params)
                postalAddress.addressType = AddressType.POSTAL


                accountHolder.addToPostalAddress(postalAddress)
                if(!accountHolder.validate()){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector, accountHolder:accountHolder, generalAddress:generalAddress])
                    return
                }
                AccountHolder savedAccountHolder = accountHolder.save(flush: true)
                if(!savedAccountHolder){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector, accountHolder:accountHolder, generalAddress:generalAddress])
                    return
                }
                def postalId = savedAccountHolder.postalAddress.id
                Address savedPostalAddress = Address.get(postalId)
                flash.message = "Postal Address of Account Holder Successfully Saved"
                render (view: '/accountHolderInfo/create', model: [tabSelectIndicator: 4, accountHolder:savedAccountHolder, generalAddress:generalAddress, postalAddress:savedPostalAddress])
                return
            }

        }
    }
    def saveSpouseInfo(){
        if(request.method=="POST"){
            if(!params.id){
                //handle error
                return
            }
            AccountHolder accountHolder = AccountHolder.get(params.id)
            AccountHolder savedAccountHolder
            if (params.spouseId){
                def spouseID = accountHolder.spouse.id
                SpouseInfo spouseInfo = SpouseInfo.get(spouseID)
                spouseInfo.properties = params
                spouseInfo.status = true
                savedAccountHolder = accountHolder.save(flush: true)
                flash.message = "Spouse Information of Account Holder Successfully Updated"

            }else{
                SpouseInfo spouseInfo = new SpouseInfo(params)
                spouseInfo.status = true
                if(!spouseInfo.validate()){
//                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector, accountHolder:accountHolder, spouseInfo:spouseInfo, generalAddress:generalAddress,postalAddress: postalAddress])
                    return
                }
                accountHolder.addToSpouse(spouseInfo)
                savedAccountHolder = accountHolder.save(flush: true)
                if(!savedAccountHolder){
//                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector, accountHolder:accountHolder, spouseInfo:spouseInfo,generalAddress:generalAddress,postalAddress: postalAddress])
                    return
                }

                flash.message = "Spouse Information of Account Holder Successfully Saved"

            }
            savedAccountHolder.spouse?.removeAll {it.status ==false}
            render (template: 'familyInfoList', model: [accountHolder:savedAccountHolder])
            return
        }
    }

    def editSpouseInfo(Long id, Long memberId){
        AccountHolder accountHolder = AccountHolder.get(id)
        if(!accountHolder){
            //return with error message
            return
        }
        SpouseInfo spouseInfo = accountHolder.spouse.find {it.id ==memberId}
        String result = spouseInfo as JSON
        println result
        render result
    }
    def deleteSpouseInfo(Long id, Long memberId){
        AccountHolder accountHolder = AccountHolder.get(id)
        if(!accountHolder){
            //return with error message
            return
        }
//        SpouseInfo spouseInfo = accountHolder.spouse.find {it.id ==memberId}
        SpouseInfo spouseInfo = SpouseInfo.get(memberId)
        spouseInfo.status = false
        AccountHolder savedaccountHolder = accountHolder.save()
        if(!savedaccountHolder){
            // return error message
            return
        }
        savedaccountHolder.spouse?.removeAll {it.status ==false}
        render(template: 'familyInfoList', model: [accountHolder: savedaccountHolder])
    }
    def showAccountHolder(Long receiptAccountId) {
        Map clientMap
        Client client = Client.findByAccountNo(receiptAccountId.toString())
        if (!client) {
            clientMap = [available: false, message: "Client not found"]
            render(clientMap as JSON)
            return
        }
        BankSetup bankSetup = BankSetup.read(1)
        Currencys currencys = Currencys.read(bankSetup.currencysId)
        clientMap = [client: client, brName: "Main Br.", brId: "101", currency: currencys]
        render(clientMap as JSON)
    }

    def showAccountDetails(Long receiptAccountId) {
        Map clientMap
        Client client = Client.findByAccountNo(receiptAccountId.toString())
        if(!client){
            clientMap = [available: false, message: "Client not found"]
            render(clientMap as JSON)
            return
        }
        clientMap = [client: client, accType: "Savings", accTitle: client.name, accOpDate: "01/01/2014"]
        render(clientMap as JSON)
    }








    def saveEducation(EducationalInfoCommand educationalInfoCommand){
        if (request.method == 'POST') {
            if (educationalInfoCommand.hasErrors()) {
                render (view: '/accountHolderInfo/create',
                        model:[accountHolder: AccountHolder.get(educationalInfoCommand.accountHolderId),
                        educationalInfo: educationalInfoCommand])
                return
            }
            if(educationalInfoCommand.id){
                EducationalInfo savedEducationalInfo = EducationalInfo.get(educationalInfoCommand.id)
                savedEducationalInfo.properties = educationalInfoCommand.properties
                savedEducationalInfo.save()
                flash.message = "Educational Info Updated successfully"
                render(view: '/accountHolderInfo/_educationListTable',
                        model: [accountHolder: AccountHolder.get(params.accountHolderId),
                        savedEducationalInfo:savedEducationalInfo])
            }
            else {
                EducationalInfo educationalInfo = new EducationalInfo(educationalInfoCommand.properties)
                AccountHolder accountHolder = AccountHolder.get(educationalInfoCommand.accountHolderId)
                accountHolder.addToEducationalInfo(educationalInfo)
                if(!educationalInfo.validate()){
                    render (view: '/accountHolderInfo/_educationListTable',
                            model:[accountHolder: AccountHolder.get(params.accountHolderId),
                            educationalInfo: educationalInfo])
                    return
                }
                EducationalInfo savedEducationalInfo = educationalInfo.save(flush: true)
                if(!savedEducationalInfo){
                    render (view: '/accountHolderInfo/_educationListTable',
                            model:[accountHolder: AccountHolder.get(params.accountHolderId),
                            educationalInfo: educationalInfo])
                    return
                }
                flash.message = "Educational Info Saved successfully"
                render(view: '/accountHolderInfo/_educationListTable',
                        model: [accountHolder: AccountHolder.get(params.accountHolderId),
                                savedEducationalInfo:savedEducationalInfo])
                return

            }

        }
    }

    def listEducationalInfo(Long educationId){
//        def educationId = params.id as Long
        EducationalInfo thisAccountHolder = EducationalInfo.read(educationId)
        def onlyThisAccountHolder = thisAccountHolder.accountHolder
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
        String sortColumn = EducationalInfoUtility.getSortColumn(iSortingCol)
        List dataReturns = new ArrayList()
        def c = EducationalInfo.createCriteria()
        def results = c.list (max: iDisplayLength, offset:iDisplayStart) {
            and {
                eq("status", true)
                eq('accountHolder', onlyThisAccountHolder)
            }
            if(sSearch){
                or {
                    ilike('degreeName',sSearch)
                    ilike('instituteName',sSearch)
                    ilike('boardName',sSearch)
                    ilike('achievedResult',sSearch)
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
            results.each {EducationalInfo educationalInfo ->
                if(sSortDir.equalsIgnoreCase('asc')){
                    serial++
                }else{
                    serial--
                }
                dataReturns.add([DT_RowId: educationalInfo.id, 0: serial, 1: educationalInfo.degreeName, 2: educationalInfo.instituteName, 3: educationalInfo.boardName, 4: educationalInfo.achievedResult, 5: ''])
            }
        }
        Map gridData = [iTotalRecords: totalCount, iTotalDisplayRecords: totalCount, aaData: dataReturns]
        String result = gridData as JSON
        render result
    }

    def editEducationalInfo(Long id, Long accountHolderId) {
        AccountHolder accountHolder = AccountHolder.get(accountHolderId)
        if(!accountHolder){
            //return with error message
            return
        }
        EducationalInfo educationalInfo = accountHolder.educationalInfo.find {it.id ==id}
        String result = educationalInfo as JSON
        println result
        render result
    }

    def deleteEducationalInfo(Long id, Long accountHolderId) {
        AccountHolder accountHolder = AccountHolder.get(accountHolderId)
        if(!accountHolder){
            //return with error message
            return
        }
        EducationalInfo educationalInfo = accountHolder.educationalInfo.find {it.id ==id}
        educationalInfo.status = false
        AccountHolder savedAccountHolder = accountHolder.save()
        if(!savedAccountHolder){
            // return error message
            return
        }
        savedAccountHolder.educationalInfo?.removeAll {it.status== false}
        render(template: 'educationListTable', model: [accountHolder: savedAccountHolder])
    }

    def saveAttachment(AttachmentsCommand attachmentsCommand){
        String type
        Long size
        String fileName
        String originalFileName
        if (!request.method == 'POST') {
            flash.message = "This action not allowed"
            render (template: 'identificationListTable')
            return
        }
        if(!params.accountHolderId){
//            flash.message = "Account Holder not found"
//            render (template: 'identificationListTable', model: [accountHolder: AccountHolder.get(attachmentsCommand.accountHolderId)])
//            @todos- add error message
            return
        }
        if (attachmentsCommand.hasErrors()) {
            flash.message = "This action not allowed"
            render (template: 'identificationListTable',
                    model: [accountHolder: AccountHolder.get(attachmentsCommand.accountHolderId)])
            return
        }

        AccountHolder accountHolder =  AccountHolder.get(attachmentsCommand.accountHolderId)
        if(!accountHolder){
            //@todos- add error message
            return
        }
        String fileDir = accountHolder.id.toString()
        fileName = request.getFileNames()[0]
        MultipartFile uploadedFile = request.getFile(fileName)
        type = uploadedFile.contentType
        size = uploadedFile.size
        originalFileName = uploadedFile.originalFilename

        OrosAttachment orosAttachment
        if(attachmentsCommand.id){
//            Long attachmentId = params.getLong('id')
            orosAttachment = accountHolder.attachments.find{it.id == attachmentsCommand.id}
            if(!orosAttachment){
//                flash.message = "Attachment not found"
//                render (template: 'identification', model: [accountHolder: accountHolder])
                //@todos- return json error
                return
            }
            if (uploadedFile.empty){
                orosAttachment.properties['name','description','caption','remarks'] = [name:fileName,description: attachmentsCommand.caption,caption: attachmentsCommand.caption,remarks: attachmentsCommand.remarks]
            }else {
                orosAttachment.properties['name', 'description', 'originalName', 'type', 'size', 'caption', 'remarks'] = [
                        name         : fileName,
                        description  : attachmentsCommand.caption,
                        originalName : originalFileName,
                        type         : type,
                        fileDir      : fileDir,
                        size         : size,
                        caption      : attachmentsCommand.caption,
                        remarks      : attachmentsCommand.remarks]
            }
            if(!orosAttachment.validate()){
                flash.message = "Attachment not saved"
                render (template: 'identification', model: [accountHolder: accountHolder])
                return
            }
            OrosAttachment savedAttachment = orosAttachment.save()
            File savedFile = imageIndirectService.storeFile(uploadedFile,orosAttachment.link,fileDir)
            if(!savedFile){
                // unable to upload file
            }
        }else{
            if (uploadedFile.empty) {
                flash.message = "Attachment not found"
                render (template: 'identification', model: [accountHolder: accountHolder])
                return
            }
            orosAttachment = new OrosAttachment(
                    name: fileName,
                    description: attachmentsCommand.caption,
                    originalName: originalFileName,
                    type: type,
                    fileDir: fileDir,
                    size: size,
                    caption: attachmentsCommand.caption,
                    remarks: attachmentsCommand.remarks
            )
            if(!orosAttachment.validate()){
                flash.message = "Attachment not saved"
                render (template: 'identification', model: [accountHolder: accountHolder])
                return
            }
            OrosAttachment savedAttachment = orosAttachment.save(flush: true)
            if(!savedAttachment){
                flash.message = "Document not found"
                render (template: 'identificationListTable')
                return
            }
            accountHolder.getAttachments().add(savedAttachment)

            File savedFile = imageIndirectService.storeFile(uploadedFile,orosAttachment.link,fileDir)
            if(!savedFile){
                // unable to upload file
            }
        }

        AccountHolder savedInfo = accountHolder.save()
        if(!savedInfo){
            flash.message = "Document not saved"
            render (template: 'identificationListTable')
            return
        }
        flash.message = "Document saved successfully"
        render (template: 'identificationListTable',model: [accountHolder: savedInfo])
    }

    def downloadIdentification(Long attachmentId){
        OrosAttachment orosAttachment = OrosAttachment.read(attachmentId)
        if(!orosAttachment){
            flash.message="Attachment not found"
            return
        }
        String filePath = imageIndirectService.fullDirPath(orosAttachment.fileDir)
        def files = new File(filePath,orosAttachment.link) //Full path of a file
        if (files.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${orosAttachment.originalName.replaceAll(' ','_')}") //Please filename must be add with its extension .jpg,.png,.pdf,.doc otherwise it cant detect the file
            response.outputStream << files.bytes
        }else {
            flash.message="Attachment not found"
            return
        }
    }

    def editIdentification(Long id, Long accountHolderId){
        AccountHolder accountHolder = AccountHolder.get(accountHolderId)
        if(!accountHolder){
            //return with error message
            return
        }
        OrosAttachment orosAttachment = accountHolder.attachments.find {it.id ==id}
        String result = orosAttachment as JSON
        println result
        render result
    }

    def deleteIdentification(Long id, Long accountHolderId){
        AccountHolder accountHolder = AccountHolder.get(accountHolderId)
        if(!accountHolder){
            //return with error message
            return
        }
        OrosAttachment orosAttachment = accountHolder.attachments.find {it.id ==id}
        orosAttachment.status = AttachStatus.DELETED
        AccountHolder savedAccountHolder = accountHolder.save()
        if(!savedAccountHolder){
            // return error message
            return
        }
        savedAccountHolder.attachments?.removeAll {it.status== AttachStatus.DELETED}
        render(template: 'identificationListTable', model: [accountHolder: savedAccountHolder])
    }

    def savePicture(){
        println params
        String message
        boolean isError = true
        if (!request.method == 'POST') {
            message = "This action not allowed"
            render (template: 'picture', model: [isError : isError, message:message])
            return
        }
        if(!params.accountHolderId){
            message = "Account Holder not found"
            render (template: 'picture', model: [isError : isError, message:message])
            return
        }
        Long accountHolderId = params.getLong('accountHolderId')
        AccountHolder accountHolder =  AccountHolder.get(accountHolderId)
        if(!accountHolder){
            message = "Account Holder not found"
            render (template: 'picture', model: [isError : isError, message:message])
        }
        String type
        Long size
        String fileName
        String originalFileName
        String fileTobeStoredInDirPath
        String pictureUrl

        fileName = request.getFileNames()[0]
        MultipartFile uploadedFile = request.getFile(fileName)
//        if (uploadedFile.empty) {
//            message = "Picture not found"
//            render (template: 'picture', model: [isError : isError, message:message])
//            return
//        }
        type = uploadedFile.contentType
        size = uploadedFile.size
        pictureUrl = UUID.randomUUID().toString() + ".${uploadedFile.originalFilename.split("\\.")[-1]}"
        originalFileName = uploadedFile.originalFilename
        fileTobeStoredInDirPath = grailsApplication.config.imageindirect.basePath
        attachmentService.storeImage(uploadedFile, pictureUrl)
        if(accountHolder.pictures){
            Pictures pictures = accountHolder.pictures
            if (uploadedFile.empty){
                pictures.properties['name'] = [name:fileName]
            }else{
            pictures.properties['name','originalName','type','size','pictureUrl'] = [name:fileName,originalName: originalFileName,type: type, size: size,
                    pictureUrl: pictureUrl]
            }
            if(!pictures.validate()){
                // domain validate
            }
            Pictures savedPictures = pictures.save(flash:true)
        }else{
            if (uploadedFile.empty) {
                message = "Picture not found"
                render (template: 'picture', model: [isError : isError, message:message])
                return
            }
            Pictures pictures = new Pictures(
                    name: fileName,
                    originalName: originalFileName,
                    type: type,
                    size: size,
                    pictureUrl: pictureUrl
            )
            if(!pictures.validate()){
                // domain validate
            }
            Pictures savedPictures = pictures.save(flash:true)
            accountHolder.pictures = pictures
        }
        AccountHolder savedInfo = accountHolder.save()
        if(!savedInfo){
            message = "Document not found"
            isError = true
            render (template: 'picture', model: [isError : isError, message:message])
            return
        }
        message = "Picture saved successfully"
        isError= false
        render (template: 'picture',model: [accountHolder: savedInfo])
    }
}


class EducationalInfoCommand {
    Long id
    Long accountHolderId

    String degreeName
    String boardName
    String instituteName
    String achievedResult
    Boolean status = true

    static constraints = {
        importFrom EducationalInfo
    }
}

class AttachmentsCommand{
    Long id
    Long accountHolderId
    String caption
    String remarks
    static constraints = {
        accountHolderId nullable: false
        caption nullable: false
        remarks nullable: false
    }
}

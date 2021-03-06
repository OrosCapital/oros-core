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
import com.gsl.plugin.attachments.AttachStatus
import com.gsl.plugin.attachments.OrosAttachment
import grails.converters.JSON
import org.springframework.web.multipart.MultipartFile
import com.gsl.oros.core.banking.accountHolder.SpouseInfo

class AccountHolderInfoController {
    def imageIndirectService
    def accountHolderService
    def index() {
        LinkedHashMap resultMap = accountHolderService.accountHolderPaginateList(params)
        if(!resultMap || resultMap.totalCount== 0){
            render(view: 'clientList', model: [dataReturns: null, totalCount: 0])
            return
        }
        int totalCount =resultMap.totalCount
        render(view: 'clientList', model: [dataReturns: resultMap.results, totalCount: totalCount])

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
                        generalAddress: accountHolder.generalAddress,
                        postalAddress: accountHolder.postalAddress,
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
        def result=[isError:false,message:"Client deleted successfully"]
        String outPut=result as JSON
        render outPut
    }

    def create() {
        def tabSelector = 1
        render(view: '/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
    }

    def savePersonalInfo(){
        if(request.method=="POST"){
            AccountHolder accountHolder
            AccountHolder savedAccountHolder
            def tabSelector=1
            if(params.id){
                accountHolder = AccountHolder.get(params.id)
                accountHolder.properties = params
                savedAccountHolder = accountHolder.save(flush: true)
                if(!savedAccountHolder){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
                    return
                }
                flash.message = "Personal Information of Account Holder Successfully Updated"
                render (view: '/accountHolderInfo/create', model: [tabSelectIndicator: 2, accountHolder:savedAccountHolder])
                return
            }else{
                accountHolder = new AccountHolder(params)

                if(!accountHolder.validate()){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
                    return
                }
                savedAccountHolder = accountHolder.save(flush: true)
                if(!savedAccountHolder){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector])
                    return
                }

                flash.message = "Personal Information of Account Holder Successfully Saved"
                render (view: '/accountHolderInfo/create', model: [tabSelectIndicator: 2, accountHolder:savedAccountHolder])
                return
            }


        }
    }

    def saveGeneralAddress(){
        if(request.method=="POST"){
            def tabSelector=2
            AccountHolder accountHolder = AccountHolder.get(params.id)
            Address generalAddress
            Address savedGeneralAddress

            AccountHolder savedAccountHolder

            if (params.addressId) {
                generalAddress = accountHolder.generalAddress
                generalAddress.properties = params
                generalAddress.addressType = AddressType.GENERAL
                savedAccountHolder = accountHolder.save(flush: true)
                flash.message = "Contact Address of Account Holder Successfully Updated"
            }else {
                generalAddress = new Address(params)
                generalAddress.addressType = AddressType.GENERAL
                savedGeneralAddress = generalAddress.save(flush: true)
                if(!savedGeneralAddress){
//                    handle error
                }
                accountHolder.generalAddress = savedGeneralAddress
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
            render (view: '/accountHolderInfo/create', model: [tabSelectIndicator: 3, accountHolder:savedAccountHolder])
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
            def tabSelector=3
            AccountHolder accountHolder = AccountHolder.get(params.id)
            AccountHolder savedAccountHolder
            Address postalAddress
            Address savedPostalAddress
            if (params.addressId){
                postalAddress = accountHolder.postalAddress
                postalAddress.properties = params
                postalAddress.addressType = AddressType.POSTAL
                savedAccountHolder = accountHolder.save(flush: true)
                flash.message = "Postal Address of Account Holder Successfully Updated"

            }else{
                postalAddress = new Address(params)
                postalAddress.addressType = AddressType.POSTAL
                savedPostalAddress = postalAddress.save(flush: true)
                accountHolder.postalAddress = savedPostalAddress
                if(!accountHolder.validate()){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector, accountHolder:accountHolder])
                    return
                }
                savedAccountHolder = accountHolder.save(flush: true)
                if(!savedAccountHolder){
                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector, accountHolder:accountHolder])
                    return
                }

                flash.message = "Postal Address of Account Holder Successfully Saved"
            }
            render (view: '/accountHolderInfo/create', model: [tabSelectIndicator: 4, accountHolder:savedAccountHolder])
            return
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
            SpouseInfo savedSpouse
            SpouseInfo spouseInfo
            if (params.spouseId){
                savedSpouse = SpouseInfo.get(params.spouseId)
                savedSpouse.properties = params
                savedSpouse.status = true
                savedAccountHolder = accountHolder.save(flush: true)
                flash.message = "Spouse Information of Account Holder Successfully Updated"
                savedAccountHolder.spouse?.removeAll {it.status ==false}

                def result = [isError:false, message:flash.message, spouseInfo:savedSpouse, bdCountry:savedSpouse.birthCountry.name, nationality:savedSpouse.nationality.name, accountHolder: savedAccountHolder,update: true, selectedRow: params.selectRow]
                String output = result as JSON
                println(output)
                render output

            }else{
                spouseInfo = new SpouseInfo(params)
                spouseInfo.status = true
                if(!spouseInfo.validate()){
//                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector, accountHolder:accountHolder, spouseInfo:spouseInfo, generalAddress:generalAddress,postalAddress: postalAddress])
                    return
                }
                savedSpouse = spouseInfo.save(flush: true)
                if(!savedSpouse){
                    //handle unable to save case
                    return
                }
                accountHolder.getSpouse().add(savedSpouse)
                savedAccountHolder = accountHolder.save(flush: true)
                if(!savedAccountHolder){
//                    render(view:'/accountHolderInfo/create', model: [tabSelectIndicator: tabSelector, accountHolder:accountHolder, spouseInfo:spouseInfo,generalAddress:generalAddress,postalAddress: postalAddress])
                    return
                }

                flash.message = "Spouse Information of Account Holder Successfully Saved"
                savedAccountHolder.spouse?.removeAll {it.status ==false}

                def result = [isError:false, message:flash.message, spouseInfo:savedSpouse, bdCountry:savedSpouse.birthCountry.name, nationality:savedSpouse.nationality.name, accountHolder: savedAccountHolder ]
                String output = result as JSON
                println(output)
                render output

            }

        }
    }

    def editSpouseInfo(Long id, Long memberId){
        AccountHolder accountHolder = AccountHolder.get(id)
        if(!accountHolder){
            //return with error message
            return
        }
        SpouseInfo spouseInfo = accountHolder.spouse.find {it.id == memberId}
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
//        render(template: 'familyInfoList', model: [accountHolder: savedaccountHolder])
        def result = [isError: false, message: "Successfully Deleted"]
        String outPut = result as JSON
        render outPut
    }
    def showAccountHolder(Long receiptAccountId) {
        Map clientMap
        AccountHolder accountHolder = AccountHolder.findById(receiptAccountId)
        if (!accountHolder) {
            clientMap = [available: false, message: "Account Holder not found"]
            render(clientMap as JSON)
            return
        }
        BankSetup bankSetup = BankSetup.read(1)
        Currencys currencys = Currencys.read(bankSetup.currencysId)
        clientMap = [accountHolder: accountHolder, brName: "Main Br.", brId: "101", currency: currencys]
        render(clientMap as JSON)
    }

    def showAccountDetails(Long receiptAccountId) {
        Map clientMap
        AccountHolder accountHolder = AccountHolder.findById(receiptAccountId)
        if(!accountHolder){
            clientMap = [available: false, message: "Client not found"]
            render(clientMap as JSON)
            return
        }
        clientMap = [accountHolder: accountHolder, accType: "Savings", accTitle: accountHolder.firstName, accOpDate: "01/01/2014"]
        render(clientMap as JSON)
    }

    def saveEducation(EducationalInfoCommand educationalInfoCommand){
        if (!request.method == 'POST') {
            flash.message = "This action is not allowed!"
            render (view: 'clientList')
        }
        else {
            AccountHolder accountHolder = AccountHolder.get(educationalInfoCommand.accountHolderId)
            if (educationalInfoCommand.hasErrors()) {
                def result = [isError:true, message:"Educational Info data has any problem!!"]
                render result as JSON
                return
            }
            if(educationalInfoCommand.id){ // update
                def row = params.row
                EducationalInfo educationalInfo = EducationalInfo.get(educationalInfoCommand.id)
                educationalInfo.properties = educationalInfoCommand.properties
                if(!educationalInfo.validate()){
                    def result = [isError:true, message:"Educational info data have some validation problem!"]
                    render result as JSON
                    return
                }
                EducationalInfo updatedEducationalInfo = educationalInfo.save()
                if (!updatedEducationalInfo){
                    def result = [isError:true, message:"Educational Info not updated successfully!"]
                    render result as JSON
                    return
                }
                def result = [isError:false, message:"Educational info update successfully!",
                        update:true, accountHolder:accountHolder, educationalInfo: updatedEducationalInfo, row: row]
                render result as JSON
            }
            else { // add
                EducationalInfo educationalInfo = new EducationalInfo(educationalInfoCommand.properties)
                if(!educationalInfo.validate()){
                    def result = [isError:true, message:"Educational Info not validated successfully!"]
                    render result as JSON
                    return
                }
                EducationalInfo savedEducationalInfo = educationalInfo.save(flush: true)
                if(!savedEducationalInfo){
                    def result = [isError:true, message:"Educational Info not added successfully!"]
                    render result as JSON
                    return
                }
                accountHolder.addToEducationalInfo(savedEducationalInfo)
                AccountHolder savedAccountHolder = accountHolder.save(flash:true)
                def result = [isError:false, add:true, message:"Educational Info Added successfully!",
                        educationalInfo: savedEducationalInfo, accountHolder:savedAccountHolder]
                render result as JSON
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

    def editEducationalInfo(Long id, Long row) {
        EducationalInfo educationalInfo = EducationalInfo.findById(id)
        if(!educationalInfo){
            def result = [isError:true, message:"Education info not found !"]
            render result as JSON
            return
        }
        def result = [isError:false, educationalInfo: educationalInfo, row:row]
        render result as JSON
    }

    def deleteEducationalInfo(Long id, Long accountHolderId) {
        AccountHolder accountHolder = AccountHolder.get(accountHolderId)
        if(!accountHolder){
            def result = [isError:true, message:"Account Holder not found!"]
            render result as JSON
            return
        }
        EducationalInfo educationalInfo = EducationalInfo.get(id)
        if (!educationalInfo) {
            def result = [isError:true, message:"Educational info not found!"]
            render result as JSON
            return
        }
        educationalInfo.status = false
        AccountHolder savedAccountHolder = accountHolder.save()
        if(!savedAccountHolder){
            def result = [isError:true, message:"Educational info not deleted!"]
            render result as JSON
            return
        }
        savedAccountHolder.educationalInfo?.removeAll {it.status== false}
        def result = [isError:false, message:"Educational info deleted successfully!"]
        String output = result as JSON
        render output
    }

    def saveAttachment(AttachmentsCommand attachmentsCommand){
        ArrayList<String> extList = new ArrayList<String>();
        extList.add(".jpg");
        extList.add(".jpeg");
        extList.add(".gif");
        extList.add(".png");
        extList.add(".bmp");
        extList.add(".pdf");
//        String [] allowedAttachmentList = ['']

        String type
        Long size
        String fileName
        String originalFileName
        if (!request.method == 'POST') {
            flash.message = "This action not allowed"
            render (view: 'clientList')
            return
        }
        if(!params.accountHolderId){
            def result = [isError:true, message:"Account Holder not found!"]
            render result as JSON
            return
        }
        if (attachmentsCommand.hasErrors()) {
            def result = [isError:true, message:"Identification document has any problem!!"]
            render result as JSON
            return
        }

        AccountHolder accountHolder =  AccountHolder.get(attachmentsCommand.accountHolderId)
        if(!accountHolder){
            def result = [isError:true, message:"Account Holder not found!"]
            render result as JSON
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
            def row = params.row
            orosAttachment = accountHolder.attachments.find{it.id == attachmentsCommand.id}
            if(!orosAttachment){
                def result = [isError:true, message:"Identification document not found!"]
                render result as JSON
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
                int a = originalFileName.lastIndexOf(".")
                String extName = originalFileName.substring(a)
                if(!(extList.contains(extName)))
                {
                    def result = [isError:true, message:"Invalid file type!"]
                    render result as JSON
                    return
                }
                if(size>=900000){
                    def result = [isError:true, message:"File is greater than 900 KB!"]
                    render result as JSON
                    return
                }
            }
            if(!orosAttachment.validate()){
                def result = [isError:true, message:"Identification document data have some validation problem!"]
                render result as JSON
                return
            }
            OrosAttachment updatedAttachment = orosAttachment.save()
            if(!updatedAttachment){
                // unable to upload file
                def result = [isError:true, message:"Identification document not updated successfully!"]
                render result as JSON
                return
            }
            File savedFile = imageIndirectService.storeFile(uploadedFile,orosAttachment.link,fileDir)
            if(!savedFile){
                // unable to upload file
                def result = [isError:true, message:"Identification document not updated successfully!"]
                render result as JSON
                return
            }
            def result = [isError:false, message:"Identification document update successfully!",
                    update:true, accountHolder:accountHolder, attachments: updatedAttachment, row: row]
            render result as JSON
        }
        else{
            if (uploadedFile.empty) {
                def result = [isError:true, message:"Identification document not found!"]
                render result as JSON
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
                def result = [isError:true, message:"Identification document data have some validation problem!"]
                render result as JSON
                return
            }
            int a = originalFileName.lastIndexOf(".")
            String extName = originalFileName.substring(a)
            if(!(extList.contains(extName)))
            {
                def result = [isError:true, message:"Invalid file type!"]
                render result as JSON
                return
            }
            if(size>=900000){
                def result = [isError:true, message:"File is greater than 900 KB!"]
                render result as JSON
                return
            }
            OrosAttachment savedAttachment = orosAttachment.save(flush: true)
            if(!savedAttachment){
                def result = [isError:true, message:"Identification document not added successfully!"]
                render result as JSON
                return
            }
            accountHolder.getAttachments().add(savedAttachment)
            AccountHolder savedInfo = accountHolder.save()
            if(!savedInfo){
                def result = [isError:true, message:"Identification document not saved successfully!"]
                render result as JSON
                return
            }
            File savedFile = imageIndirectService.storeFile(uploadedFile,orosAttachment.link,fileDir)
            if(!savedFile){
                // unable to upload file
                def result = [isError:true, message:"Identification document not saved successfully!"]
                render result as JSON
                return
            }
            def result = [isError:false, message:"Identification document added successfully!",
                    add:true, accountHolder:savedInfo, attachments: savedAttachment]
            render result as JSON
        }
    }

    def downloadIdentification(Long attachmentId){
        OrosAttachment orosAttachment = OrosAttachment.read(attachmentId)
        if(!orosAttachment){
            def result = [isError:true, message:"Identification document not found !"]
            render result as JSON
            return
        }
        String filePath = imageIndirectService.fullDirPath(orosAttachment.fileDir)
        def files = new File(filePath,orosAttachment.link) //Full path of a file
        if (files.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${orosAttachment.originalName.replaceAll(' ','_')}") //Please filename must be add with its extension .jpg,.png,.pdf,.doc otherwise it cant detect the file
            response.outputStream << files.bytes
        }else {
            return
        }
    }

    def editIdentification(Long id, Long row){
        OrosAttachment orosAttachment = OrosAttachment.findById(id)
        if(!orosAttachment){
            def result = [isError:true, message:"Identification document not found !"]
            render result as JSON
            return
        }
        def result = [isError:false, attachments: orosAttachment, row:row]
        render result as JSON
    }

    def deleteIdentification(Long id, Long accountHolderId){
        AccountHolder accountHolder = AccountHolder.get(accountHolderId)
        if(!accountHolder){
            def result = [isError:true, message:"Account Holder not found!"]
            render result as JSON
            return
        }
        OrosAttachment orosAttachment = OrosAttachment.get(id)
        if (!orosAttachment) {
            def result = [isError:true, message:"Identification document not found!"]
            render result as JSON
            return
        }
        orosAttachment.status = AttachStatus.DELETED
        AccountHolder savedAccountHolder = accountHolder.save()
        if(!savedAccountHolder){
            def result = [isError:true, message:"Identification document not deleted!"]
            render result as JSON
            return
        }
        savedAccountHolder.attachments?.removeAll {it.status== AttachStatus.DELETED}
        def result = [isError:false, message:"Identification document deleted successfully!"]
        String output = result as JSON
        render output
    }

    def savePicture(){
        ArrayList<String> extList = new ArrayList<String>();
        extList.add(".jpg");
        extList.add(".jpeg");
        extList.add(".gif");
        extList.add(".png");
        extList.add(".bmp");
        extList.add(".pdf");
//        String [] allowedAttachmentList = ['']

        String type
        Long size
        String fileName
        String originalFileName
        if (!request.method == 'POST') {
            flash.message = "This action not allowed"
            render (view: 'clientList')
            return
        }
        if(!params.accountHolderId){
            render (template: 'picture', model: [isError:true, message:"Account Holder not found!"])
            def result = [isError:true, message:"Account Holder not found!"]
            render result as JSON
            return
        }
//        if (params.hasErrors()) {
//            def result = [isError:true, message:"Picture has any problem!!"]
//            render result as JSON
//            return
//        }

        AccountHolder accountHolder =  AccountHolder.get(params.accountHolderId)
        if(!accountHolder){
            render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Account Holder not found!"])
//            def result = [isError:true, message:"Account Holder not found!"]
//            render result as JSON
            return
        }
        String fileDir = accountHolder.id.toString()
        fileName = request.getFileNames()[0]
        MultipartFile uploadedFile = request.getFile(fileName)
        type = uploadedFile.contentType
        size = uploadedFile.size
        originalFileName = uploadedFile.originalFilename

        OrosAttachment orosAttachment
        if(params.id){
//            def row = params.row
            orosAttachment = accountHolder.pictures.find{it.id == params.id}
            if(!orosAttachment){
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture not found!"])
//                def result = [isError:true, message:"Picture not found!"]
//                render result as JSON
                return
            }
            if (uploadedFile.empty){
                orosAttachment.properties['name'] = [name:fileName]
            }else {
                orosAttachment.properties['name', 'originalName', 'type', 'size'] = [
                        name         : fileName,
//                        description  : attachmentsCommand.caption,
                        originalName : originalFileName,
                        type         : type,
                        fileDir      : fileDir,
                        size         : size]
//                        caption      : attachmentsCommand.caption,
//                        remarks      : attachmentsCommand.remarks]
                int a = originalFileName.lastIndexOf(".")
                String extName = originalFileName.substring(a)
                if(!(extList.contains(extName)))
                {
                    render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Invalid file type!"])
//                    def result = [isError:true, message:"Invalid file type!"]
//                    render result as JSON
                    return
                }
                if(size>=900000){
                    render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"File is greater than 900 KB!"])
//                    def result = [isError:true, message:"File is greater than 900 KB!"]
//                    render result as JSON
                    return
                }
            }
            if (orosAttachment.hasErrors()) {
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture has any problem!!"])
//            def result = [isError:true, message:"Picture has any problem!!"]
//            render result as JSON
            return
            }
            if(!orosAttachment.validate()){
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture data have some validation problem!"])
//                def result = [isError:true, message:"Picture data have some validation problem!"]
//                render result as JSON
                return
            }
            OrosAttachment updatedAttachment = orosAttachment.save()
            if(!updatedAttachment){
                // unable to upload file
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture not updated successfully!"])
//                def result = [isError:true, message:"Picture not updated successfully!"]
//                render result as JSON
                return
            }
            File savedFile = imageIndirectService.storeFile(uploadedFile,orosAttachment.link,fileDir)
            if(!savedFile){
                // unable to upload file
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture not updated successfully!"])
//                def result = [isError:true, message:"Picture not updated successfully!"]
//                render result as JSON
                return
            }
            render (template: 'picture', model: [accountHolder:accountHolder, isError:false, message:"Picture update successfully!",
                    update:true, picture: updatedAttachment])
//            def result = [isError:false, message:"Picture update successfully!",
//                    update:true, accountHolder:accountHolder, picture: updatedAttachment]
//            render result as JSON
        }
        else{
            if (uploadedFile.empty) {
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture not found!"])
//                def result = [isError:true, message:"Picture not found!"]
//                render result as JSON
                return
            }
            orosAttachment = new OrosAttachment(
                    name: fileName,
//                    description: attachmentsCommand.caption,
                    originalName: originalFileName,
                    type: type,
                    fileDir: fileDir,
                    size: size
//                    caption: attachmentsCommand.caption,
//                    remarks: attachmentsCommand.remarks
            )
            if (orosAttachment.hasErrors()) {
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture has any problem!!"])
//                def result = [isError:true, message:"Picture has any problem!!"]
//                render result as JSON
                return
            }
            if(!orosAttachment.validate()){
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture data have some validation problem!"])
//                def result = [isError:true, message:"Picture data have some validation problem!"]
//                render result as JSON
                return
            }
            int a = originalFileName.lastIndexOf(".")
            String extName = originalFileName.substring(a)
            if(!(extList.contains(extName)))
            {
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Invalid file type!"])
//                def result = [isError:true, message:"Invalid file type!"]
//                render result as JSON
                return
            }
            if(size>=900000){
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"File is greater than 900 KB!"])
//                def result = [isError:true, message:"File is greater than 900 KB!"]
//                render result as JSON
                return
            }
            OrosAttachment savedAttachment = orosAttachment.save(flush: true)
            if(!savedAttachment){
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture not added successfully!"])
//                def result = [isError:true, message:"Picture not added successfully!"]
//                render result as JSON
                return
            }
            accountHolder.pictures = savedAttachment
//            accountHolder.getPicture().add(savedAttachment)
            AccountHolder savedInfo = accountHolder.save()
            if(!savedInfo){
//                def result = [isError:true, message:"Picture not saved successfully!"]
//                render result as JSON
                return
            }
            File savedFile = imageIndirectService.storeFile(uploadedFile,orosAttachment.link,fileDir)
            if(!savedFile){
                // unable to upload file
                render (template: 'picture', model: [accountHolder: accountHolder, isError:true, message:"Picture not saved successfully!"])
//                def result = [isError:true, message:"Picture not saved successfully!"]
//                render result as JSON
                return
            }
            render (template: 'picture', model: [accountHolder:savedInfo, isError:false, message:"Picture added successfully!",
                    add:true, picture: savedAttachment])
//            def result = [isError:false, message:"Picture added successfully!",
//                    add:true, accountHolder:savedInfo, picture: savedAttachment]
//            render result as JSON
        }
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

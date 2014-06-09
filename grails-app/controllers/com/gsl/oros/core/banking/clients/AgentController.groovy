package com.gsl.oros.core.banking.clients

import com.gsl.cbs.contraints.enums.AddressType
import com.gsl.oros.core.banking.agent.AdditionalDetail
import com.gsl.oros.core.banking.agent.ClientHelp
import com.gsl.oros.core.banking.agent.PersonalInfo
import com.gsl.oros.core.banking.agent.ThirdParty
import com.gsl.oros.core.banking.settings.Address
import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.oros.core.banking.settings.Country
import com.gsl.plugin.attachments.AttachStatus
import com.gsl.plugin.attachments.OrosAttachment
import grails.converters.JSON
import org.springframework.web.multipart.MultipartFile


class AgentController {

    def imageIndirectService
    def agentService
    def index(){
        LinkedHashMap resultMap =agentService.agentPaginateList(params)
        if(!resultMap || resultMap.totalCount== 0){
            render(view: 'agentList', model: [dataReturns: null, totalCount: 0])
            return
        }
        int totalCount =resultMap.totalCount
        render(view: 'agentList', model: [dataReturns: resultMap.results, totalCount: totalCount])


    }
    def create() {
        def tabSelector = 1
        def updateSelector = 0
        render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector,updateSelector:updateSelector,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                dateMask: "99/99/9999",
                currentDt: new Date().format("dd/MM/yyyy")])
    }


    def savePersonalInfo() {
        if (request.method == "POST") {

            def tabSelector = 1
            if (params.id) {
                PersonalInfo personalInfo = PersonalInfo.get(params.id)
                personalInfo.properties = params
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                if (!savedPersonalInfo) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                            dateMask: "99/99/9999",
                            currentDt: new Date().format("dd/MM/yyyy")])
                    return
                }
                println "Agent" + savedPersonalInfo.id

                flash.message = "Personal Information of Agent Successfully Updated"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 2,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999",
                        currentDt: new Date().format("dd/MM/yyyy"), personalInfo: savedPersonalInfo])

            } else {
                PersonalInfo personalInfo = new PersonalInfo(params)

                if (!personalInfo.validate()) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                            dateMask: "99/99/9999",
                            currentDt: new Date().format("dd/MM/yyyy")])
                    return
                }
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                if (!savedPersonalInfo) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                            dateMask: "99/99/9999",
                            currentDt: new Date().format("dd/MM/yyyy")])
                    return
                }
                println "Agent Id=" + savedPersonalInfo.id

                flash.message = "Personal Information of Agent Successfully Saved"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 2, personalInfo: savedPersonalInfo,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999",
                        currentDt: new Date().format("dd/MM/yyyy")])

            }


        }
    }

    def saveContactDetail() {
        if (request.method == "POST") {
            def agentId = params.id
            def tabSelector = 2
            PersonalInfo personalInfo = PersonalInfo.get(agentId)
            if (params.conid) {
                def conid = personalInfo.contactAddress.id
                Address contactAddress = Address.get(conid)


                contactAddress.properties = params
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                flash.message = "Contact Detail of Agent Successfully Updated"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 3, personalInfo: savedPersonalInfo, contactAddress: contactAddress])

            } else {


                Address contactAddress = new Address(params)
                contactAddress.addressType = AddressType.GENERAL

                personalInfo.addToContactAddress(contactAddress)
                if (!personalInfo.validate()) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: personalInfo, contactAddress: contactAddress])
                    return
                }
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                if (!savedPersonalInfo) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: savedPersonalInfo, contactAddress: contactAddress])
                    return
                }

                flash.message = "Contact Detail of Agent Successfully Saved"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 3, personalInfo: savedPersonalInfo, contactAddress: contactAddress])


            }

        }
    }

    def saveResidentialAddress() {
        if (request.method == "POST") {
            def agentId = params.id
            def tabSelector = 3
            PersonalInfo personalInfo = PersonalInfo.get(agentId)
            if (params.resid) {
                def conid = personalInfo.contactAddress.id
                Address savedContactAddress = Address.get(conid)
                def resid = personalInfo.residentialAddress.id
                Address residentialAddress = Address.get(resid)

                residentialAddress.properties = params
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                flash.message = "Residential Address of Agent Successfully Updated"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 4, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: residentialAddress])

            } else {
                def conid = personalInfo.contactAddress.id
                Address savedContactAddress = Address.get(conid)

                Address residentialAddress = new Address(params)
                residentialAddress.addressType = AddressType.GENERAL

                personalInfo.addToResidentialAddress(residentialAddress)
                if (!personalInfo.validate()) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: personalInfo, contactAddress: savedContactAddress, residentialAddress: residentialAddress])
                    return
                }
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                if (!savedPersonalInfo) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: residentialAddress])
                    return
                }

                flash.message = "Residential Address  of Agent Successfully Saved"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 4, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: residentialAddress])
                return

            }

        }
    }

    def saveAdditionalDetail() {
        if (request.method == "POST") {

            def tabSelector = 4

            def agentId = params.id
            PersonalInfo personalInfo = PersonalInfo.get(agentId)

            if (params.addid) {
                def conid = personalInfo.contactAddress.id
                Address savedContactAddress = Address.get(conid)
                def resid = personalInfo.residentialAddress.id
                Address savedResidentialAddress = Address.get(resid)
                def addid = personalInfo.additionalDetail.id
                AdditionalDetail additionalDetail = AdditionalDetail.get(addid)
                additionalDetail.properties = params
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                flash.message = "Additional Detail of Agent Successfully Updated"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 5, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail])

            } else {
                def conid = personalInfo.contactAddress.id
                Address savedContactAddress = Address.get(conid)
                def resid = personalInfo.residentialAddress.id
                Address savedResidentialAddress = Address.get(resid)

                AdditionalDetail additionalDetail = new AdditionalDetail(params)
                personalInfo.addToAdditionalDetail(additionalDetail)
                if (!personalInfo.validate()) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: personalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail])
                    return
                }
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                if (!savedPersonalInfo) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail])
                    return
                }

                flash.message = "Additional Detail of Agent Successfully Saved"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 5, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail])


            }
        }
    }


    def saveClientHelp() {
        if (request.method == "POST") {

            def tabSelector = 5

            def agentId = params.id
            PersonalInfo personalInfo = PersonalInfo.get(agentId)

            if (params.clientid) {
                def conid = personalInfo.contactAddress.id
                Address savedContactAddress = Address.get(conid)
                def resid = personalInfo.residentialAddress.id
                Address savedResidentialAddress = Address.get(resid)
                def addid = personalInfo.additionalDetail.id
                AdditionalDetail additionalDetail = AdditionalDetail.get(addid)
                def clientid = personalInfo.clientHelp.id
                ClientHelp clientHelp = ClientHelp.get(clientid)
                clientHelp.properties = params
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                flash.message = "Client Help of Agent Successfully Updated"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 6, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail, clientHelp: clientHelp])

            } else {
                def conid = personalInfo.contactAddress.id
                Address savedContactAddress = Address.get(conid)
                def resid = personalInfo.residentialAddress.id
                Address savedResidentialAddress = Address.get(resid)
                def addid = personalInfo.additionalDetail.id
                AdditionalDetail additionalDetail = AdditionalDetail.get(addid)


                ClientHelp clientHelp = new ClientHelp(params)
                personalInfo.addToClientHelp(clientHelp)
                if (!personalInfo.validate()) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: personalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail, clientHelp: clientHelp])
                    return
                }
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                if (!savedPersonalInfo) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail, clientHelp: clientHelp])
                    return
                }

                flash.message = "Client Help of Agent Successfully Saved"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 6, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail, clientHelp: clientHelp])


            }


        }
    }

    def saveThirdParty() {
        if (request.method == "POST") {

            def tabSelector = 6


            def agentId = params.id
            PersonalInfo personalInfo = PersonalInfo.get(agentId)
            if (params.thirdid) {
                def conid = personalInfo.contactAddress.id
                Address savedContactAddress = Address.get(conid)
                def resid = personalInfo.residentialAddress.id
                Address savedResidentialAddress = Address.get(resid)
                def addid = personalInfo.additionalDetail.id
                AdditionalDetail additionalDetail = AdditionalDetail.get(addid)
                def clientid = personalInfo.clientHelp.id
                ClientHelp clientHelp = ClientHelp.get(clientid)
                def thirdid = personalInfo.thirdParty.id
                ThirdParty thirdParty = ThirdParty.get(thirdid)

                thirdParty.properties = params
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                flash.message = "Successfully Updated"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 7, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail, clientHelp: clientHelp, thirdParty: thirdParty])

            } else {
                def conid = personalInfo.contactAddress.id
                Address savedContactAddress = Address.get(conid)
                def resid = personalInfo.residentialAddress.id
                Address savedResidentialAddress = Address.get(resid)
                def addid = personalInfo.additionalDetail.id
                AdditionalDetail additionalDetail = AdditionalDetail.get(addid)
                def clientid = personalInfo.clientHelp.id
                ClientHelp clientHelp = ClientHelp.get(clientid)


                ThirdParty thirdParty = new ThirdParty(params)
                personalInfo.addToThirdParty(thirdParty)
                if (!personalInfo.validate()) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: personalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail, clientHelp: clientHelp, thirdParty: thirdParty])
                    return
                }
                PersonalInfo savedPersonalInfo = personalInfo.save(flush: true)
                if (!savedPersonalInfo) {
                    render(view: '/agent/createAgent', model: [tabSelectIndicator: tabSelector, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail, clientHelp: clientHelp, thirdParty: thirdParty])
                    return
                }

                flash.message = "Successfully Saved"
                render(view: '/agent/createAgent', model: [tabSelectIndicator: 7, personalInfo: savedPersonalInfo, contactAddress: savedContactAddress, residentialAddress: savedResidentialAddress, additionalDetail: additionalDetail, clientHelp: clientHelp, thirdParty: thirdParty])


            }


        }
    }

    def saveAttachment(AttachmentCommand attachmentsCommand){
        String message
        boolean isError = true
        if (!request.method == 'POST') {
            message = "This action is not allowed"
            render (template: 'attachmentListTable', model: [isError : isError, message:message])
            return
        }
        if (attachmentsCommand.hasErrors()) {
            message = "This action is not allowed"
            render (template: 'attachmentListTable', model: [personalInfo:PersonalInfo.get(attachmentsCommand.personalInfoId), isError : isError, message:message])
            return
        }
        if(!attachmentsCommand.personalInfoId){
            message = "Personal Info not found"
            render (template: 'attachmentListTable', model: [personalInfo:PersonalInfo.get(attachmentsCommand.personalInfoId), isError : isError, message:message])
            return
        }
        PersonalInfo personalInfo =  PersonalInfo.get(attachmentsCommand.personalInfoId)
        if(!personalInfo){
            //error
            return
        }
        String dirPath = "Agent_Attachments/"+personalInfo.id.toString()


        String type
        Long size
        String fileName
        String originalFileName

        fileName = request.getFileNames()[0]
        MultipartFile uploadedFile = request.getFile(fileName)
        type = uploadedFile.contentType
        size = uploadedFile.size
        originalFileName = uploadedFile.originalFilename


        OrosAttachment orosAttachment
        if(attachmentsCommand.id){
            Long attachmentId = params.getLong('id')
            orosAttachment = personalInfo.attachments.find{it.id == attachmentId}
            if(!orosAttachment){
                //render error template
                return
            }
            if (uploadedFile.empty){
                orosAttachment.properties['name','description','caption'] = [name:fileName,description: attachmentsCommand.description,caption: attachmentsCommand.caption]
            }else {
                orosAttachment.properties['name', 'description', 'originalName', 'type', 'size','fileDir','caption', 'remarks', 'status'] = [
                        name         : fileName,
                        description  : attachmentsCommand.description,
                        originalName : originalFileName,
                        type         : type,
                        size         : size,
                        fileDir      :dirPath,
                        caption      : attachmentsCommand.caption,
                        remarks      : attachmentsCommand.remarks,
                        status       : AttachStatus.ACTIVE
                ]
            }
            if(!orosAttachment.validate()){
                message = "Attachment not saved"
                render (template: 'attachment', model: [personalInfo: personalInfo, isError : isError, message:message])
                return
            }
            //save the holder obj

        }else{
            if (uploadedFile.empty) {
                message = "Attachment not found"
                render (template: 'attachment', model: [personalInfo: personalInfo, isError : isError, message:message])
                return
            }
            orosAttachment = new OrosAttachment(
                    name: fileName,
                    description: attachmentsCommand.description,
                    originalName: originalFileName,
                    type: type,
                    size: size,
                    fileDir:dirPath,
                    caption: attachmentsCommand.caption,
                    status: AttachStatus.ACTIVE
            )
            if(!orosAttachment.validate()){
                message = "Attachment not saved"
                render (template: 'attachment', model: [personalInfo: personalInfo, isError : isError, message:message])
                return
            }
            OrosAttachment savedAttachment = orosAttachment.save(flush: true)
            if(!savedAttachment){
                message = "Attachment not found"
                isError = true
                render (template: 'attachmentListTable', model: [isError : isError, message:message])
                return
            }
            personalInfo.getAttachments().add(savedAttachment)
        }
        imageIndirectService.storeFile(uploadedFile,orosAttachment.link,dirPath)
        PersonalInfo savedInfo = personalInfo.save()
        if(!savedInfo){
            message = "Attachment not saved"
            isError = true
            render (template: 'attachmentListTable', model: [isError : isError, message:message])
            return
        }
        message = "Attachment saved successfully"
        isError= false
        render (template: 'attachmentListTable',model: [personalInfo: savedInfo])
    }


    def downloadAttachment(Long attachmentId){
        OrosAttachment attachment= OrosAttachment.get(attachmentId)
        if(!attachment){
            flash.message="Attachment not found."
            return
        }
        String filePath = imageIndirectService.fullDirPath(attachment.fileDir)
        def files = new File(filePath,attachment.link) //Full path of a file
        if (files.exists()) {

            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${attachment.originalName.replaceAll(' ','_')}")
            response.outputStream << files.bytes
        }else {
            flash.message="Attachment not found."

        }
    }

    def deleteAttachment(Long id, Long personalInfoId){
        PersonalInfo personalInfo = PersonalInfo.get(personalInfoId)
        if(!personalInfo){
            //return with error message
            return
        }
        OrosAttachment orosAttachment = personalInfo.attachments.find {it.id ==id}
        orosAttachment.status = AttachStatus.DELETED
        PersonalInfo savedPersonalInfo = personalInfo.save()
        if(!savedPersonalInfo){
            // return error message
            return
        }
        savedPersonalInfo.attachments?.removeAll {it.status== AttachStatus.DELETED}
        render(template: 'attachmentListTable', model: [personalInfo:savedPersonalInfo])



    }



    def deleteAgent(Long id){
        println(params.selectRow)
        PersonalInfo personalInfo = PersonalInfo.get(id)
        if (!personalInfo) {
            flash.message = "Agent not found"
            render(view: 'agentList')
        }
        personalInfo.status = false
        personalInfo.save(flush: true)

        def result=[isError:false,message:"Agent deleted successfully"]
        String outPut=result as JSON
        render outPut

    }
    def list() {
        LinkedHashMap gridData
        String result
        LinkedHashMap resultMap =agentService.agentPaginateList(params)
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

    def update(Long id) {

        PersonalInfo personalInfo = PersonalInfo.read(id)
        if (!personalInfo) {
            flash.message = "Agent not found"
            render(view: 'agentList')
        }
        def updateSelector = 1
        def tabSelector = 1
        render(view: 'createAgent',
                model: [personalInfo: personalInfo,
                        contactAddress: personalInfo.contactAddress[0],
                        residentialAddress: personalInfo.residentialAddress[0],
                        additionalDetail: personalInfo.additionalDetail[0],
                        clientHelp: personalInfo.clientHelp[0],
                        thirdParty:personalInfo.thirdParty[0],
                        attachmentList: personalInfo.attachments,
                        countryList: Country.list(),tabSelectIndicator: tabSelector, updateSelector:updateSelector])


}
}
    class AttachmentCommand{
        Long id
        Long personalInfoId
        String caption
        String remarks
        String description
        static constraints = {
            personalInfoId nullable: false
            caption nullable: false
            description nullable: true
            remarks nullable: true
        }
    }

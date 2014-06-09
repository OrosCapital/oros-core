package com.gsl.oros.core.banking.loan

import com.gsl.cbs.contraints.enums.StatusType
import com.gsl.oros.core.banking.operation.Client
import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.plugin.attachments.AttachStatus
import com.gsl.plugin.attachments.OrosAttachment
import org.springframework.web.multipart.MultipartFile
import grails.converters.JSON

class LoanController {
    def imageIndirectService
    def loanService
    def index() {

        render(view: '/loan/createLoan')
    }

    def create(){
        def tabSelector = 1
        def updateSelector = 0
        render(view: '/loan/loanMain',model: [
                tabSelectIndicator: tabSelector,updateSelector:updateSelector,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                                                                              dateMask: "99/99/9999",
                                                                              currentDt: new Date().format("dd/MM/yyyy"),
                                                                              decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
    }

    def showLoanInfo(){
           if(params.id=="1")
            render(template: 'loanType1')
           if(params.id=="2")
            render(template: 'loanType2')
            if(params.id=="3")
            render(template: 'loanType3')

    }

    def save(LoanCommand loanCommand){
        def tabSelector = 1
        if (request.method == "POST"){

            if (loanCommand.hasErrors()){
                render(view: '/loan/loanMain', model: [loan: loanCommand,tabSelectIndicator: tabSelector,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999",
                        currentDt: new Date().format("dd/MM/yyyy"),
                        decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
                return
            }

            Loan loan
            Loan saveLoan
            if (loanCommand.id) {
                loan = Loan.get(loanCommand.id)
                loan.properties = loanCommand.properties
                Client clientInfo = Client.findByAccountNo(params.accountNo)
                loan.client = clientInfo
                saveLoan = loan.save()
                flash.message = "Successfully Updated"
                render(view: '/loan/loanMain', model: [loan: saveLoan,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999",
                        currentDt: new Date().format("dd/MM/yyyy"),
                        decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2,tabSelectIndicator: 2])
            } else {

            loan= new Loan(loanCommand.properties)
            Client clientInfo = Client.findByAccountNo(params.accountNo)
            loan.client = clientInfo


            if(!loan.validate()){
                render(view: '/loan/loanMain', model: [loan:loan,tabSelectIndicator: tabSelector,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999",
                        currentDt: new Date().format("dd/MM/yyyy"),
                        decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
                return
            }

            saveLoan = loan.save(flush: true)
            if(!saveLoan){
                render(view: '/loan/loanMain', model: [loan:saveLoan,tabSelectIndicator: tabSelector,dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                        dateMask: "99/99/9999",
                        currentDt: new Date().format("dd/MM/yyyy"),
                        decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2])
                return
            }
            flash.message = "Loan Info Successfully Saved"
            }
            render(view: '/loan/loanMain', model: [dateFormat: BankSetup.properties.bankDateFormat ? BankSetup.properties.bankDateFormat : "dd/mm/yyyy",
                                                   dateMask: "99/99/9999",
                                                   currentDt: new Date().format("dd/MM/yyyy"),decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2,loan: saveLoan,tabSelectIndicator: 2])
        }


    }

          def saveAttachment(AttachmentCommand attachmentsCommand){
              def tabSelector = 2

              String message
              boolean isError = true
              if (!request.method == 'POST') {
                  message = "This action is not allowed"
                  render (template: 'attachmentList', model: [tabSelectIndicator: tabSelector,isError : isError, message:message])
                  return
              }
              if (attachmentsCommand.hasErrors()) {
                  message = "This action is not allowed"
                  render (template: 'attachmentList', model: [loan:Loan.get(attachmentsCommand.loanId), isError : isError, message:message,tabSelectIndicator: tabSelector])
                  return
              }
              if(!attachmentsCommand.loanId){
                  message = "Loan not found"
                  render (template: 'attachmentList', model: [loan:Loan.get(attachmentsCommand.loanId), isError : isError, message:message,tabSelectIndicator: tabSelector])
                  return
              }
              Loan loan =  Loan.get(attachmentsCommand.loanId)
              if(!loan){
                  //error
                  return
              }
              String dirPath = "Loan_Attachments/"+loan.accountNo.toString()




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
                  orosAttachment = loan.attachments.find{it.id == attachmentId}
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
                      render (template: 'attachment', model: [loan: loan, isError : isError, message:message,tabSelectIndicator: tabSelector])
                      return
                  }


              }else{
                  if (uploadedFile.empty) {
                      message = "Attachment not found"
                      render (template: 'attachment', model: [loan: loan, isError : isError, message:message,tabSelectIndicator: tabSelector])
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
                      render (template: 'attachment', model: [loan: loan, isError : isError, message:message,tabSelectIndicator: tabSelector])
                      return
                  }
                  OrosAttachment savedAttachment = orosAttachment.save(flush: true)
                  if(!savedAttachment){
                      message = "Attachment not found"
                      isError = true
                      render (template: 'attachmentList', model: [isError : isError, message:message,tabSelectIndicator: tabSelector])
                      return
                  }
                  loan.getAttachments().add(savedAttachment)
              }
              imageIndirectService.storeFile(uploadedFile,orosAttachment.link,dirPath)
              Loan savedInfo = loan.save()
              if(!savedInfo){
                  message = "Attachment not saved"
                  isError = true
                  render (template: 'attachmentList', model: [isError : isError, message:message,tabSelectIndicator: tabSelector])
                  return
              }
              message = "Attachment saved successfully"
              isError= false
              render (template: 'attachmentList',model: [loan: savedInfo,tabSelectIndicator: tabSelector])

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
            flash.message="Attachment not found"

        }
    }

    def deleteAttachment(Long id, Long loanId){
        Loan loan = Loan.get(loanId)
        if(!loan){
            //return with error message
            return
        }
        OrosAttachment orosAttachment = loan.attachments.find {it.id ==id}
        orosAttachment.status = AttachStatus.DELETED
        Loan saveLoan = loan.save()
        if(!saveLoan){

            return
        }
        saveLoan.attachments?.removeAll {it.status== AttachStatus.DELETED}
        render(template: 'attachmentList', model: [loan:saveLoan])



    }
    def checkAccountNo() {


        def verifyAccountNo = Client.findByAccountNo(params.accountNo)
        if (verifyAccountNo) {
            def result = [isError: false, accountInfo: verifyAccountNo]
            String outPut = result as JSON
            render outPut
            return
        }
        def result = [isError: true, message: "Account Holder Not Found"]
        render result as JSON
    }
    def loanRequest(){
        LinkedHashMap resultMap =loanService.loanPaginateList(params)
        if(!resultMap || resultMap.totalCount== 0){
            render(view: 'loanRequestedList', model: [dataReturns: null, totalCount: 0])
            return
        }
        int totalCount =resultMap.totalCount
        render(view: 'loanRequestedList', model: [dataReturns: resultMap.results, totalCount: totalCount])
}
    def loanList(){
        LinkedHashMap gridData
        String result
        LinkedHashMap resultMap =loanService.loanPaginateList(params)
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
    def approveRequest(Long id){
        Loan loan= Loan.get(id)
        loan.status= StatusType.APPROVED
        render(view: '/loan/createLoan')
    }
    def deleteRequest(Long id){
        println(params.selectRow)
          Loan loan= Loan.get(id)
        if (!loan) {
            flash.message = "Loan not found"
            render(view: 'loanRequestedList')
        }
        loan.sts= false
        loan.status=StatusType.DECLINED


        loan.save(flush: true)


        def result=[isError:false,message:"Loan deleted successfully"]
        String outPut=result as JSON
        render outPut

    }
}
class LoanCommand{
    Long id
    Integer amount
    String amountInWord
    String accountNo
    String accountName
    String purpose
    String income
    Date durationStart
    Date durationEnd
    Client client
    Boolean sts= true
    StatusType status=StatusType.REQUESTED

    static constraints = {
        purpose nullable: true
        amountInWord nullable: true
        income nullable: true
        accountName nullable: true

    }


}
class AttachmentCommand{
    Long id
    Long loanId
    String caption
    String remarks
    String description
    static constraints = {
        loanId nullable: false
        caption nullable: false
        description nullable: true
        remarks nullable: true
    }
}

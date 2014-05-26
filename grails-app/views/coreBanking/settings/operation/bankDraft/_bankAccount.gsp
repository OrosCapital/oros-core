<%@ page import="com.gsl.oros.core.banking.settings.State; com.gsl.oros.core.banking.settings.Country" %>
<html>
<head>
    <style>
    .form-control, label, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"]{font-size: 12px;}
    label{max-width: 150px;}
    </style>
    <title>Draft Owner's Bank Account Info</title>
</head>
<body>



<g:hasErrors bean="${bankAccountInfo}">
    <div class='alert alert-success '>
        <ul>
            <g:eachError var="err" bean="${bankAccountInfo}">
                <li><g:message error="${err}" /></li>
            </g:eachError>
        </ul>
    </div>
</g:hasErrors>
<g:form name="draftBankAccountInfoForm" id="draftBankAccountInfoForm" method="post" role="form" class="form-horizontal" url="[controller:'vendor', action:'saveVendorGeneralAddress']" onsubmit="return false;">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

            <div class="col-xs-6 col-sm-6 col-md-6">

                <div class="form-group ${hasErrors(bean: bankAccountInfo, field: 'bankAccountNo', 'has-error')}">
                    <label for="bankAccountNo" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.bankAccount.accountNo" default="Account Number"/><span class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Bank Account No"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Bank Account No'"
                                   id="bankAccountNo"
                                   name="bankAccountNo" value="${bankAccountInfo?.bankAccountNo}"/>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: bankAccountInfo, field: 'bankAccountName', 'has-error')}">
                    <label for="vendorBankAccountName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.bankAccount.accountName" default="Account Name"/><span class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Bank Account Name"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Bank Account Name'"
                                   id="vendorBankAccountName"
                                   name="bankAccountName" value="${bankAccountInfo?.bankAccountName}"/>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: bankAccountInfo, field: 'addressLine1','has-error')}">
                    <label for="draftAmount" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.operation.bankDraft.bankAccount.amount" default="Amount"/><span class="red">*</span>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Amount" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Amount'" id="draftAmount"
                                   name="amount" value="${bankAccountInfo?.amount}"/>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: bankAccountInfo, field: 'today', 'has-error')}">
                    <label class="col-sm-4 col-xs-6 control-label no-padding-right" for="today">Date<span class="red">*</span></label>

                    <div class="col-sm-7 col-xs-7">
                        <div class="clearfix">
                            <div class="input-append date input-group" id="today">
                                <input type="date" name="today" value="${bankAccountInfo?.today?.format("dd/MM/yyyy")}" class="form-control datepicker" data-date-format="dd-mm-yyyy"/>
                                <span class="input-group-addon add-on"><i class="icon-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-xs-6 col-sm-6 col-md-6">

                <div class="form-group ${hasErrors(bean: bankAccountInfo, field: 'financialInstitution','has-error')}">
                    <label for="financialInstitution" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.operation.bankDraft.bankAccount.financialInstitution" default="Financial Institution"/>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Financial Institution" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Financial Institution'" id="financialInstitution"
                                   name="financialInstitution" value="${bankAccountInfo?.financialInstitution}"/>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: bankAccountInfo, field: 'routingNo','has-error')}">
                    <label for="routingNo" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.operation.bankDraft.bankAccount.routingNo" default="Routing Number"/>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Routing Number" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Routing Number'" id="routingNo"
                                   name="routingNo" value="${bankAccountInfo?.routingNo}"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="clearfix form-actions">
        <div class="col-md-offset-8 col-md-4">
            <button class="btn btn-primary btn-sm" type="submit" name="saveDraftAccountInfo" id="saveDraftAccountInfo">Submit</button>
        </div>
    </div>

</g:form>

<script type="text/javascript">

    jQuery(function ($) {

        $('#draftBankAccountInfoForm').validate({

            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                bankAccountNo: {
                    required: true
                },
                bankAccountName: {
                    required: true
                },
                today: {
                    required: true
                },
                amount: {
                    required: true
                }
            } ,
            messages: {
                bankAccountNo: {
                    required: " "
                },
                bankAccountName: {
                    required: " "
                },
                today: {
                    required: " "
                },
                amount: {
                    required: " "
                }
            },
            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            errorPlacement: function (error, element) {
                if(element.is(':checkbox') || element.is(':radio')) {
                    var controls = element.closest('div[class*="col-"]');
                    if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                }
                else if(element.is('.select2')) {
                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
                }
                else if(element.is('.chosen-select')) {
                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
                }
                else error.insertAfter(element.parent());
            },
            submitHandler: function (form) {
                $.ajax({
                    url:"${createLink(controller: 'bankDraft', action: 'saveBankAccountInfo')}",
                    type:'post',
                    data: $("#draftBankAccountInfoForm").serialize(),
                    success:function(data){
                        $('#page-content').html(data);
                    },
                    failure:function(data){
                    }
                })

            }
        });
    });

</script>

</body>
</html>
<%@ page import="com.gsl.cbs.contraints.enums.CardType; com.gsl.oros.core.banking.settings.BankSetup; com.gsl.oros.core.banking.settings.Country; com.gsl.oros.core.banking.settings.BranchSetup; com.gsl.oros.core.banking.settings.Currencys; com.gsl.cbs.contraints.enums.DepositType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title></title>
<script src="${resource(dir: 'js/compressed', file: 'toword.js')}"></script>
<style>
.popover {
    width: 275px;
    height: 250px;
}
.modal-dialog {
    padding-top: 75px;
    width: 645px;
}
textarea{
    width: 225px;
    min-width:225px;
    max-width:225px;

    height:70px;
    min-height:70px;
    max-height:70px;
}
.popover{
    height: 260px;
    width: 400px;
    max-width: 400px;
}
</style>
<script type="text/javascript">
    var currentDate;
    $(document).ready(function () {
        initDefaultValue();

        $("#chequeNumber").blur(function (e) {
            $("#verified-status").hide();
            var chequeNumber = $("#chequeNumber").val();

            if (chequeNumber) {
                $("#chequeVerifiedDiv").show();
                $("#cheque-verify-link-div").show();
                $("#verify-cheque-number").text("Please click here to Verify Cheque No! " + chequeNumber);
            } else {
                $("#chequeVerifiedDiv").hide();
                $("#cheque-verify-link-div").hide();
                $("#link-message").text('');
                $("#verify-cheque-number").text('');
            }
        });

        $('#chequeDepositForm').submit(function (e) {
            onSubmitDepositForm()
            return false;
        });


        $("#receiptAccountId").bind('keypress', function (e) {
            if ((e.keyCode == 13) || ( e.keyCode == 9)) {
                e.preventDefault();
                if(!$("#receiptAccountId").valid()) return false;
                var receiptAccountId = $("#receiptAccountId").val().trim();
                jQuery.ajax({
                    type: 'post',
                    dataType: 'json',
                    url: "${createLink(controller:'accountHolderInfo', action: 'showAccountHolder')}?receiptAccountId=" + receiptAccountId,
                    success: function (data, textStatus) {
                        showAccountHolderInfo(data);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    },
                    complete: function (XMLHttpRequest, textStatus) {
                        showSpinner(false);
                    }
                });
                return false;
            }
        });


        function showAccountHolderInfo(data) {
            if (data.available == false) {
                $('.err-msg').text(data.message).show();
                $('div#error-message-div').show();

                $("#accountHolderId").val('');
                $("#accountHolderName").val('');
                $("#branchName").val('');
                $("#branchId").val('');
                $("#currencyId").val('');
                $("#recipientCurrencyCode").val('');
                $("#accHolderInfoDiv").hide();
                $("#showDetailsAccountHolderDiv").hide();
                return false;
            }
            var accountHolder = data.accountHolder
            $("#accountHolderId").val(accountHolder.id);
            $("#accountHolderName").val(accountHolder.firstName);
            $("#branchName").val(data.brName);
            $("#branchId").val(data.brId);
            $("#currencyId").val(data.currency.id);
            $("#recipientCurrencyCode").val(data.currency.symbol);
            $("#showDetailsAccountHolderDiv").show();
            $(".depositorCurrCode").attr('disabled', false);
            $("#recipientCurrencyId").val(data.currency.symbol);

            $('.err-msg').text('');
            $('div#error-message-div').hide();
            showDepositorInfoForSame();
            return false;
        }


        $('#chequeDepositForm').validate({
            errorPlacement: function (error, element) {
            },
            focusInvalid: false,
            rules: {
                receiptAccountId: {
                    required: true
                },
                receiptCurrencyCode: {
                    required: true
                },
                chequeNumber: {
                    required: true
                },

                depositCurrencyCode: {
                    required: true
                },
                dateOfDeposit: {
                    required: true,
                    onSelect: function () {
                        var minDate = new Date();
                        minDate.setHours(0);
                        minDate.setMinutes(0);
                        minDate.setSeconds(0, 0);
                        var currDt = $(".datepicker").val();
                        if (new Date(currDt) <= minDate) {
                            $('#dateOfDeposit').closest('.form-group').removeClass('has-info').addClass('has-error');
                            $(".datepicker").val('');
                            $('#dateOfDeposit').focus;
                            return false;
                        } else {
                            $('#dateOfDeposit').closest('.form-group').removeClass('has-error').addClass('has-info');
                        }
                    }
                },
                amount: {
                    required: true
                }
            },
           /* invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#chequeDepositForm')).show();
            },*/
            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },
            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            unhighlight: function (e) { // <-- fires when element is valid
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
            }
        });

        $("#saveAndPosting").on('click', function (e) {
            $("#statusId").val("1001");
            jQuery("#chequeDepositForm").submit();
        });

        $("#saveAndSendForChecking").on('click', function (e) {
            $("#statusId").val("2001");
            jQuery("#chequeDepositForm").submit();
        });

    });     // end document ready


    $(".depositorCurrCode").change(function () {
        $("#conversionAmount").val('');
        $("#amountInWord").text('None');
        $("#conversionAmountDiv").hide();
        $("#conversionRateDiv").hide();

        var depositorCurrCode = $("#depositorCurrCode option:selected").text();
        var conversionRate = 78
        var recipientCurrCode = $("#recipientCurrencyCode").val();
        var depositAmount = $("#depositAmount").val();

        var numToWordDepoAmt = depositAmount.replace('.00', '');
        numToWordDepoAmt = numToWordDepoAmt.replace(/,/g, '');

        if (depositAmount.isEmpty) {
            $("#conversionAmount").val('');
            $("#amountInWord").text('None');
            $("#conversionAmountDiv").hide();
            $("#conversionRateDiv").hide();
            return false;
        }
        if (depositorCurrCode == recipientCurrCode) {
            if (depositAmount == 0.00) {
                $("#amountInWord").text('None');
                return false
            }
            $("#amountInWord").text('None');
            $("#conversionAmount").val('');
            $("#conversionAmountDiv").hide();
            $("#conversionRateDiv").hide();
            $("span#amountInWord").text(toWords(parseInt(numToWordDepoAmt)));
        } else {
            if (depositAmount == 0.00) {
                $("#amountInWord").text('None');
                $("#conversionAmount").val('');
                $("#conversionAmountDiv").hide();
                $("#conversionRateDiv").hide();
                return false
            }

            var convertedAmount = parseFloat(depositAmount.replace(/[^\d\.]/g, '') * conversionRate);
            $("#conversionAmount").val(convertedAmount.toFixed(${decimalSep}));
            $("#conversionRateTxt").text("Rate :" + conversionRate);
            $("#conversionAmountDiv").show();
            $("#conversionRateDiv").show();
            $("span#amountInWord").text(toWords(convertedAmount));
        }
    });

    $("#depositAmount").focusout(function () {
        $("#amountInWord").text('None');
        $("#conversionAmount").val('');
        $("#conversionAmountDiv").hide();
        $("#conversionRateDiv").hide();


        var depositorCurrCode = $("#depositorCurrCode option:selected").text();
        var conversionRate = 78
        var recipientCurrCode = $("#recipientCurrencyCode").val();
        var depositAmount = $("#depositAmount").val();

        var numToWordDepoAmt = depositAmount.replace('.00', '');
        numToWordDepoAmt = numToWordDepoAmt.replace(/,/g, '');

        if (depositAmount == 0.00) {
            $("#amountInWord").text('None');
            return false;
        }
        if (!recipientCurrCode) {
            $("span#amountInWord").text(toWords(parseInt(numToWordDepoAmt)));

            return false;
        }

        if (depositorCurrCode == recipientCurrCode) {
            $("#conversionAmount").val('');
            $("#conversionAmountDiv").hide();
            $("#conversionRateDiv").hide();
            $("span#amountInWord").text(toWords(parseInt(numToWordDepoAmt)));
        } else {
            if (depositAmount == 0.00) {
                $("#amountInWord").text('None');
                $("#conversionAmount").val('');
                $("#conversionAmountDiv").hide();
                $("#conversionRateDiv").hide();
                return false
            }
            var convertedAmount = parseFloat(depositAmount.replace(/[^\d\.]/g, '') * conversionRate);
            $("#conversionAmount").val(convertedAmount.toFixed(${decimalSep}));
            $("#conversionRateTxt").text("Rate :" + conversionRate);
            $("#conversionAmountDiv").show();
            $("#conversionRateDiv").show();
            $("span#amountInWord").text(toWords(convertedAmount));
        }
    });

    function initDefaultValue() {
        var dateF = "${dateFormat}";
        var dateM = " ${dateMask}";
        currentDate = "${currentDt}";
        $(".datepicker").val(currentDate);
        $(".datepicker").inputmask(dateM);

//        $('input:radio[id="depositTypeCheque"]').prop('checked', true);

        $('input[name=amount]').autoNumeric("init", {mDec: ${decimalSep}});

        $('#depositAmount').autoNumeric('set', $('#depositAmount').val());

        var date = new Date();
        date.setDate(date.getDate() - 1);

        $("#dateOfDeposit").datepicker({
            format: dateF,
            startDate: date,
            gotoCurrent:true,
            minDate: new Date(),
            stepMonths:1,
            autoclose:true,
            todayHighlight:true
        })
        jQuery.validator.messages.required = "";
    }

    $('#showDetailsAccountHolder').click(function (e) {
        var receiptAccountId = $("#accountHolderId").val();
        jQuery.ajax({
            type: 'post',
            dataType: 'json',
            url: "${createLink(controller:'accountHolderInfo', action: 'showAccountDetails')}?receiptAccountId=" + receiptAccountId,
            success: function (data, textStatus) {
                showPopoverData(data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            },
            complete: function (XMLHttpRequest, textStatus) {
                showSpinner(false);
            }
        });

        return false;
    });


    function showPopoverData(data) {
        if(data.available == false){
            $('.err-msg').text(data.message).show();
            $('div#error-message-div').show();
            return false;
        }
        var accountHolder = data.accountHolder
        $("#lblAccNum").text(accountHolder.id);
        $("#lblAccTitle").text(data.accTitle);
        $("#lblName").text(accountHolder.firstName);
        $("#lblNamePhoto").text(accountHolder.firstName);
        $("#lblAccType").text(data.accType);
        $("#lblAccOpDate").text(data.accOpDate);
        $("#showAccountDetailsPopover").show();

    }

    function showDepositorInfoForSame() {

        if ($("#depositorAndAccHolder").is(":checked") && $("#accountHolderId").val()) {
            $("#cashDepositorAccountNo").val($("#accountHolderId").val());
            $("#cashDepositorAccountNo").attr('readOnly', true);
            $("#cashDepositorName").val($("#accountHolderName").val());
            $("#cashDepositorName").attr('readOnly', true);
            $("#cashDepositorContactNo").val();
            $("#cashDepositorAddress").val();
        } else {
            $("#cashDepositorAccountNo").val('');
            $("#cashDepositorAccountNo").attr('readOnly', false);
            $("#cashDepositorName").val('');
            $("#cashDepositorName").attr('readOnly', false);
            $("#cashDepositorAddress").val('');
        }

        return false;
    }

    function onSubmitDepositForm() {
//        trimForm('#chequeDepositForm');
        if (!$('#chequeDepositForm').valid()) return false;

        var accHolderId = $("#accountHolderId").val();
        if(accHolderId.isEmpty || accHolderId == ''){
            $('.err-msg').text('Account holder no found').show();
            $('div#error-message-div').show();
            return false;
        }

        jQuery.ajax({
            type: 'post',
            data: jQuery("#chequeDepositForm").serialize(),
            url: "${createLink(controller:'deposit', action: 'deposit')}",
            success: function (data, textStatus) {
                $("#page-content").html(data);
                downloadCashReceipt();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            },
            complete: function (XMLHttpRequest, textStatus) {
                showSpinner(false);
            }
        });
        return false;
    }


    function downloadCashReceipt() {
        var chequeNumber = $("#chequeNumber").val();
//        var accHolderId = $("#accountHolderId").val();
//        var amount =  $("#depositAmount").val();
        /*        if (confirm('Do you want to download the PDF now?')) {
         var url = */
        %{--document.location = "${createLink(controller: 'deposit', action: 'downloadCashReceipt')}";--}%
        var url = "${createLink(controller: 'deposit', action: 'downloadChequeReceipt')}?chequeNumber="+ chequeNumber;
        window.open(url, '_newtab');
//        window.focus();
        return false;
    }

    $('span.cheque-validate-link').click(function (e) {
        var control = this;
        var url = $(control).attr('url');
        var chequeNumber = $("#chequeNumber").val();
        jQuery.ajax({
            type: 'POST',
            url: "${createLink(controller:'deposit', action: 'showChequeInfo')}?chequeNumber=" + chequeNumber,
            dataType: 'json',
//            data: {chequeNumber: chequeNumber},
            success: function (data, textStatus) {
                showModalForChequeValidation(data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    });

    function showModalForChequeValidation(data){
        if(data){
            $("#cheque-no").text(data.chequeNo);
            $('#chequeValidationModal').modal("show");
        }
        return false;
    }

    $(".cheque-validation-btn").click(function(e){
        var control = this;
        var isValid = $(control).attr('isValid');
        var chequeNumber = $("#chequeNumber").val();

        jQuery.ajax({
            type: 'post',
//            data: {chequeNumber: chequeNumber},
            dataType: 'json',
            url: "${createLink(controller:'deposit', action: 'validateCheque')}?chequeNumber= " + chequeNumber + "&isValid=" + isValid,
            success: function (data, textStatus) {
                if (data.verified == true) {
                    $("#link-message").text('');
                    $("#verified-status").show();
                    $("#verify-message").text(data.verifiedInfo);
                    $("#cheque-verify-link-div").hide();
                    $("#saveAndSendForChecking").removeClass("disabled");
                    $('#chequeValidationModal').modal("hide");
                } else if(data.verified == false) {
                    $("#link-message").text('');
                    $("#chequeNumber").val('');
                    $("#verified-status").show();
                    $("#verify-message").text("Cheque not verified!");
                    $("#cheque-verify-link-div").hide();
                    $("#close-chequeVerified-btn").show();
                    $('#chequeValidationModal').modal("hide");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            },
            complete: function (XMLHttpRequest, textStatus) {
                showSpinner(false);
            }

        });
    });

    $("#reset").click(function (e) {
        $("#chequeDepositForm").validate().resetForm();
        $(".datepicker").val(currentDate);
        $("#accountHolderId").val('');
        $("#showDetailsAccountHolderDiv").hide();
        $("#depositorAndAccHolder").prop('checked', false);
        $('.form-group').removeClass('has-error');
        $('.form-group').removeClass('has-info');
        $("input[type=text],input[type=number], input[type=select], textarea").val('');
//        $("#depositTypeChequeDiv").find("input").removeClass("required").addClass("cheque-req");
        $("#conversionAmountDiv").hide();
        $("#amountInWord").text('None');
        $("select#depositorCurrCode").prop('selectedIndex',0).attr('disabled',true);
        $("#saveAndPosting").removeClass("disabled");
        $("#verified-status").remove();
        $('.err-msg').text('').hide();
        $('div#error-message-div').hide();
    });

    function trimForm(form) {
        // iterate over all of the inputs for the form
        $(':input', form).each(function () {
            var type = this.type.toLowerCase();
            var tag = this.tagName.toLowerCase(); // normalize case

            // for inputs and textareas
            if (type == 'text' || type == 'hidden' || tag == 'textarea')
                this.value = jQuery.trim(this.value);
        });
    }

</script>
</head>

<body>
<g:if test='${flash.message}'>
    <div class='alert alert-success '>
        <i class="icon-bell green"><b>${flash.message}</b></i>
        <button data-dismiss="alert" class="close" type="button">
            <i class="icon-remove"></i>
        </button>
    </div>
</g:if>
<g:hasErrors bean="${commandObjError}">
    <div class='alert alert-success '>
        <ul>
            <g:eachError var="err" bean="${commandObjError}">
                <li><g:message error="${err}"/></li>
            </g:eachError>
            <button data-dismiss="alert" class="close" type="button"><i class="icon-remove"></i></button>
        </ul>
    </div>
</g:hasErrors>
<div class="row">
<div class="alert alert-danger" id="error-message-div" style="display: none">
    <a class="close" onclick="$('div#error-message-div').hide();">×</a>
    <span class="err-msg">&nbsp;</span>
</div>

<div class="col-md-12">
<div class="widget-box">
<div class="widget-header widget-header-blue"><h4 class="smaller">
    <g:message code="coreBanking.operation.deposit.cheque.header.lbl" default="Deposit (CHEQUE)"/></h4>
</div>

<div class="widget-body">
<div class="widget-main no-padding">

<g:form name="chequeDepositForm" method="post" role="form" id="chequeDepositForm" class="form-horizontal cssform">

<g:hiddenField name="branchId" id="branchId"/>
<g:hiddenField name="currencyId" id="currencyId"/>
<g:hiddenField name="accountHolderId" id="accountHolderId"/>
<g:hiddenField name="status" id="statusId"/>
<g:hiddenField name="recipientCurrency" id="recipientCurrencyId"/>
<g:hiddenField name="depositType" id="depositTypeCheque"  value="${DepositType.CHEQUE}"/>
<fieldset>
<div class="col-md-6">
    <div class="form-group col-md-12">
        <label for="receiptAccountId" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.recipient.ac.lbl" default="Recipient A/C No"/><span class="required-indicator">*</span></label>

        <div class="col-md-6">
            <input type="number" class="form-control" id="receiptAccountId" name="receiptAccountId"
                   placeholder="Receipt Account No">
        </div>

        <div class="col-md-2" id="showDetailsAccountHolderDiv"
             style="display: none; padding-left: 0px; padding-right: 0px;">
            <label for="showDetailsAccountHolder" title="Show Account Holder Details">
                <input name="showDetails" type="checkbox" class="ace showAccountDetailsPopover"
                       id="showDetailsAccountHolder"/>
                <span class="lbl">&nbsp;Details</span>
            </label>
        </div>
    </div>

    <div class="form-group col-md-12">
        <label for="accountHolderName" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.recipient.ac.holder.name.lbl" default="A/C Holder Name"/></label>

        <div class="col-md-6">
            <input type="text" class="form-control" id="accountHolderName" name="accountHolderName" value=""
                   readonly="true" placeholder="Account Holder Name">
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label for="branchName" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.recipient.branch.name.lbl" default="Branch Name"/></label>

        <div class="col-md-6">
            <input type="text" class="form-control" id="branchName" name="branchName" value="" readonly="true"
                   placeholder="Branch Name">
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label class="col-md-4 control-label" for="dateOfDeposit">
            <g:message code="coreBanking.operation.deposit.date.lbl" default="Date of Deposit"/><span class="required-indicator">*</span></label>

        <div class="col-md-6">
            <div class="input-append date input-group" id="dateOfDeposit">
                <input class="form-control datepicker" type="date" name="dateOfDeposit" data-date-format="dd-mm-yyyy">
                <span class="input-group-addon add-on"><i class="icon-calendar"></i></span>
            </div>
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label for="depositAmount" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.amount.lbl" default="Deposit Amount"/><span class="required-indicator">*</span>
        </label>

        <div class="col-md-6">
            <input type="text" class="form-control amountDouble" id="depositAmount" name="amount"
                   placeholder="Amount (0.00)" style="text-align: right">
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12" id="conversionAmountDiv" style="display: none">
        <label for="conversionAmount" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.conversion.amount.lbl" default="Conversion Amount"/></label>

        <div class="col-md-6">
            <input type="text" class="form-control amountDouble" id="conversionAmount" name="conversionAmount"
                   readonly="true" style="text-align: right">
        </div>

        <div id="conversionRateDiv" class="col-md-2" style="display: none">
            <span id="conversionRateTxt"></span>
        </div>
    </div>

    <div class="form-group col-md-12" id="amountInWordDiv">
        <label for="amountInWord" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.amount.in.word.lbl" default="Amount in Word"/></label>

        <div class="col-md-8">
            <span class="control-label" id="amountInWord">None</span>
        </div>
    </div>

    <div class="form-group col-md-12">
        <label class="col-md-4 control-label"><g:message code="coreBanking.operation.deposit.recipient.currency.lbl" default="Recipient Currency"/></label>

        <div class="col-md-6">
            <input type="text" class="form-control" id="recipientCurrencyCode" name="recipientCurrency"
                   readonly="true" placeholder="Currency Code">
        </div>

        <div class="col-md-2"></div>
    </div>

</div>

<div class="col-md-6">
<div id="depositTypeChequeDiv">
    <div class="form-group col-md-12">
        <label class="col-md-4 control-label" for="bankId">Bank Name<span class="required-indicator">*</span>
        </label>

        <div class="col-md-6">
            %{--   <g:select class="width-40 chosen-select" id="bankId" name='bankId'
                         noSelection="${['': 'Select Bank...']}"
                         from='${Country.list()}'
                         optionKey="id" optionValue="name">
               </g:select>--}%

            <select class="form-control required" name="bankId" id="bankId" onchange="">
                <g:each var="currCode" in="${BankSetup.list()}">
                    <option value="1" class="selected">Oroscapital</option>
                </g:each>
            </select>
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label for="chequeDepositorAccountNo" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.depositor.ac.no.lbl" default="Depositor A/C No"/><span
                class="required-indicator">*</span></label>

        <div class="col-md-6">
            <input type="number" class="form-control cheque-req"
                   id="chequeDepositorAccountNo" name="cheque.accountNo"
                   placeholder="Depositor A/C No">
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label for="chequeDepositorName" class="col-md-4 control-label"><g:message code="coreBanking.operation.deposit.depositor.name.lbl" default="Depositor Name"/>
        <span class="required-indicator">*</span></label>

        <div class="col-md-6">
            <input type="text" class="form-control cheque-req" id="chequeDepositorName" name="cheque.name"
                   placeholder="Depositor Name">
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label for="branchId" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.depositor.br.name.lbl" default="Branch Name"/>
        <span class="required-indicator">*</span></label>

        <div class="col-md-6">
            <input type="text" class="form-control cheque-req" id="branchId" name="cheque.branch" placeholder="Branch Name">
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label for="addressCheck" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.depositor.address.lbl" default="Address"/><span class="required-indicator">*</span></label>

        <div class="col-md-6">
            <input type="text" class="form-control cheque-req" id="addressCheck" name="cheque.address" placeholder="Address">
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label class="col-md-4 control-label" for="chequeNumber">
            <g:message code="coreBanking.operation.deposit.depositor.cheque.no.lbl" default="Cheque No"/><span class="required-indicator">*</span>
        </label>

        <div class="col-md-6">
            <input id="chequeNumber" class="form-control" type="text" name="cheque.chequeNumber"
                   placeholder="Cheque Number(205537130)" maxlength="9" min="9" required="required">
        </div>

        <div class="col-md-2"></div>
    </div>

    <div id="chequeVerifiedDiv" class="form-group col-md-12" style="display: none">

        <div class="col-md-10">
            <div class="alert alert-warning alert-dismissable" id="cheque-verify-link-div" style="display: none">
                <span url="${createLink(controller: 'deposit', action: 'validateCheque')}" id="validate-url" class="cheque-validate-link" style="cursor: pointer">
                    <strong><span id="link-message"></span>&nbsp;<span id="verify-cheque-number"></span></strong>
                </span>
            </div>

            <div class="alert alert-warning alert-dismissable" id="verified-status" style="display: none">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true" id="close-chequeVerified-btn" style="display: none"
                        onclick="$('#chequeVerifiedDiv').hide();"></button>
                <span><strong><span id="verify-message"></span>&nbsp;</strong></span>
            </div>
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.depositor.currency.lbl" default="Depositor Currency"/></label>

        <div class="col-md-6">
            <select class="form-control depositorCurrCode required" name="depositorCurrency" id="depositorCurrCode" disabled="true">
                <g:each var="currCode" in="${Currencys.list()}">
                    <option value="${currCode.id}" ${currCode.id == 5 ? 'selected' : ''}>${currCode.symbol}</option>
                </g:each>
            </select>
        </div>

        <div class="col-md-2"></div>
    </div>

    <div class="form-group col-md-12">
        <label for="commentCheque" class="col-md-4 control-label">
            <g:message code="coreBanking.operation.deposit.comment.lbl" default="Comments"/></label>

        <div class="col-md-6">
            <textarea type="text" class="form-control" id="commentCheque" name="cheque.comment"
                      placeholder="Comments here"></textarea>
        </div>

        <div class="col-md-2"></div>
    </div>
</div>
</div>

</fieldset>
</g:form>
<div class="clearfix form-actions col-md-12" id="deposit-button-panel" style="padding: 5px 20px; margin-top: 5px; border-top: 0px ">
    <div id="deposit-button-panel-action" class="col-md-6 col-md-offset-6 pull-left">
        <sec:access controller="deposit" action="deposit">
            <button class="btn btn-primary btn-success" type="submit" id="saveAndPosting"><i
                    class="icon-ok bigger-110"></i>Save & Posting</button>
            <button class="btn btn-primary btn-success disabled" type="submit" id="saveAndSendForChecking">
                <i class="icon-ok bigger-110"></i>Save & Send for Checking
            </button>
        </sec:access>
        <button type="button" class="btn reset-button" id="reset"><i class="icon-undo bigger-110"></i>Reset</button>
    </div>
    %{--<div class="col-md-2"></div>--}%
</div>
</div>
</div>
</div>
</div>

</div>

<div id="showAccountDetailsPopover" style="display: none;">
    <div class="popover fade right in" data-placement="right" style="display: block; top: -10px; left: 640px;">
        <div class="arrow"></div>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="padding-right: 3px"
                onclick="$('div#showAccountDetailsPopover').hide();">×</button>

        <h3 class="popover-title">Account Holder Details</h3>

        <div class="popover-content">
            <div class="row">
                <div class="col-md-8">
                    <div class="form-group">
                        <label class="control-label">A/C No:</label>
                        <label class="align-left control-label" id="lblAccNum"></label>
                    </div>

                    <div class="form-group">
                        <label class="control-label">A/C Title:</label>
                        <label class="control-label" id="lblAccTitle"></label>
                    </div>

                    <div class="form-group"><label class="control-label">A/C Holder Name:</label>
                        <label class="control-label" id="lblName"></label>
                    </div>

                    <div class="form-group"><label class="control-label">A/C Type:</label>
                        <label class="control-label" id="lblAccType"></label>
                    </div>

                    <div class="form-group"><label class="control-label">Opening Date:</label>
                        <label class="control-label" id="lblAccOpDate"></label>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="col-md-offset-2">
                        %{--<img border="1" class="img-polaroid" alt="150x150" src="/template/static/images/pic2.png" width="150"
                             height="150">
--}%
                        <span class="profile-picture">
                            <img src="/gslcbs/images/default-photo.png" width="160" height="105" alt="Client Avatar" class="img-thumbnail" id="avatar" style="display: block;"/>
                        <label class="control-label" id="lblNamePhoto" style="font-size: 10px"></label>
                        </span>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

%{--modal--}%

<div id="chequeValidationModal" role="dialog" tabindex="-1" class="bootbox modal fade in" style="display: none;" aria-hidden="false">

    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="padding: 10px;">
                <button class="close-button close" type="button" data-dismiss="modal" aria-hidden="true" style="font-size: 22px;">×</button>
                <h2 class="modal-title" style="font-size: 20px;">Cheque Validation</h2>
            </div>
            <div class="modal-body">
                <div class="bootbox-body">
                    <span class="bigger-110">Cheque Number <strong><span id="cheque-no"></span></strong></span></div>
            </div>

            <div class="modal-footer">
                <button id="cheque-valid" isValid="true" class="btn btn-sm btn-success cheque-validation-btn" type="button" data-bb-handler="success">
                    <i class="icon-ok"></i> Valid
                </button>
                <button id="cheque-not-valid" isValid="false" class="btn btn-sm btn-danger cheque-validation-btn" type="button" data-bb-handler="danger">Not Valid!</button>
                %{--<button class="btn btn-sm" type="button" data-bb-handler="cancel">Cancel</button>--}%
            </div>
        </div>
    </div>
</div>
</body>
</html>

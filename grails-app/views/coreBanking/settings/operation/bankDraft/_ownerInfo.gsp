<%@ page
        contentType="text/html;charset=UTF-8"
        import="com.gsl.oros.core.banking.settings.State; com.gsl.oros.core.banking.settings.Country; com.gsl.oros.core.banking.settings.accounting.VatCategory"
%>
<html>
<head>
    <script src="${resource(dir: 'js/compressed', file: 'toword.js')}"></script>
    <style>
    .form-control, label, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"]{font-size: 12px;}
    label{max-width: 150px;}
    </style>
    <title>Bank Draft</title>
</head>

<body>
<div class="col-xs-12">
    <g:if test='${flash.message}'>
        <div class='alert alert-success '>
            <i class="icon-bell green"> <b> ${flash.message} </b> </i>
        </div>
    </g:if>
</div>
<div class="col-xs-12">
    <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-1">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="collapse navbar-collapse" id="navbar-collapse-1">
                <ul id="myTab4" class="nav navbar-nav responsive padding-12 tab-color-blue background-blue">
                    <li class="" id="draftOwnerInfo">
                        <a href="#draftOwnerInfoDiv" data-toggle="tab">Owner's Info</a>
                    </li>
                    <li class="" id="draftPaymentInfo">
                        <a href="#draftPaymentInfoDiv" data-toggle="tab">Payment</a>
                    </li>
                    <li class="" id="paymentDetail">
                        <a href="#paymentDetailDiv" data-toggle="tab">Payment Info</a>
                    </li>
                    <li class="" id="hierarchy">
                        <a href="#hierarchyDiv" data-toggle="tab">M/C Hierarchy</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="tab-content responsive">
        <div class="tab-pane" id="draftOwnerInfoDiv">
            <g:hasErrors bean="${bankDraft}">
                <div class='alert alert-success '>
                    <ul>
                        <g:eachError var="err" bean="${bankDraft}">
                            <li><g:message error="${err}" /></li>
                        </g:eachError>
                    </ul>
                </div>
            </g:hasErrors>
            <g:form name="draftOwnerPersonalInfo" id="draftOwnerPersonalInfo" method="post" role="form" class="form-horizontal" url="[controller:'bankDraft', action:'saveOwnerInfo']" onsubmit="return false;">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                        <div class="col-xs-6 col-sm-6 col-md-6">

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'acholderName','has-error')}">
                                <label for="acholderName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.operation.bankDraft.ownerInfo.acholderName" default="A/C Holder Name"/><span class="red">*</span>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="text" class="col-sm-11 col-xs-12" placeholder="A/C Holder Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'A/C Holder Name'" id="acholderName"
                                               name="acholderName" value="${bankDraft?.acholderName}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'bankName','has-error')}">
                                <label for="bankName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.operation.bankDraft.ownerInfo.bankName" default="Bank Name"/><span class="red">*</span>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <select id="bankName" class="col-sm-11 col-xs-12" name="bankName">
                                            <option value="">-Choose Bank Name-</option>
                                            <option value="OrosCapital">OrosCapital</option>
                                            <option value="DBBL">DBBL</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'bankName','has-error')}">
                                <label for="branchName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.operation.bankDraft.ownerInfo.branchName" default="Branch Name"/><span class="red">*</span>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <select id="branchName" class="col-sm-11 col-xs-12" name="branchName">
                                            <option value="">-Choose Branch Name-</option>
                                            <option value="Bauchi">Bauchi</option>
                                            %{--<option value="0">Inactive</option>--}%
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'amount','has-error')}">
                                <label for="draftAmount" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.operation.bankDraft.ownerInfo.amount" default="Amount"/><span class="red">*</span>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="text" class="col-sm-11 col-xs-12" placeholder="Amount" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Amount'" id="draftAmount"
                                               name="amount" value="${bankDraft?.amount}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="form-group" id="amountInWordDiv">
                            <label for="amountInWord" class="col-sm-4 col-xs-6 control-label no-padding-right"><g:message code="loan.loanApplication.label.amountInWord" default="Amount in words"/></label>
                            <div class="col-sm-8 col-xs-12">
                                <div class="clearfix">
                                    <span class="col-sm-11 col-xs-12" name="amountInWord" id="amountInWord">None</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix form-actions">
                    <div class="col-md-offset-10 col-md-2">
                        <button class="btn btn-primary btn-sm" type="submit" name="saveDraftPersonalInfo" id="saveDraftPersonalInfo">Next</button>
                    </div>
                </div>
            </g:form>
        </div>
        <div class="tab-pane" id="draftPaymentInfoDiv">
            <g:render template='/coreBanking/settings/operation/bankDraft/payment'/>
        </div>
        <div class="tab-pane" id="paymentDetailDiv">
            <g:render template='/coreBanking/settings/operation/bankDraft/showPaymentInfo'/>
        </div>
        <div class="tab-pane" id="hierarchyDiv">
            <g:render template='/hierarchy/hierarchy'/>
        </div>
    </div>
</div>

<script type="text/javascript">

    jQuery(function ($) {
        var tabSelector = "${tabSelectIndicator}";
        if(tabSelector == 1){
            $('#draftPaymentInfo').removeClass("active");
            $('#draftOwnerInfo').addClass("active");
            $('#draftOwnerInfoDiv').addClass("active");
            $('#draftOwnerInfo').show();
        }
        else if(tabSelector == 2){
        $('#draftOwnerInfo').removeClass("active");
        $('#draftPaymentInfo').addClass("active");
        $('#draftPaymentInfoDiv').addClass("active");
        $('#draftPaymentInfo').show();
        }
        else if(tabSelector == 3){
            $('#draftOwnerInfo').removeClass("active");
            $('#draftPaymentInfo').removeClass("active");
            $('#paymentDetail').addClass("active");
            $('#paymentDetailDiv').addClass("active");
            $('#paymentDetail').show();
        }


        var getDecimal = "${decimalSep}";
        var amount
        if("${bankDraft?.bankName}" != ''){
            $('#bankName').val('${bankDraft?.bankName}');
        }
        if("${bankDraft?.branchName}" != ''){
            $('#branchName').val('${bankDraft?.branchName}');
        }
        amount = "${bankDraft?.amount}";
        if(amount != ''){
            if (amount == 0.00) {
                $("#amountInWord").text('None');
                return false;
            } else{

                var number = amount.replace('.00', '');
                number = number.replace(/,/g, '');
                var balance = toWords(parseInt(number));
                $("#amountInWord").text(balance);

            }
        }
        $('#draftAmount').autoNumeric("init", {mDec: getDecimal});

        $("#draftAmount").focusout(function () {
            $("#amountInWord").text('None');
            amount = $("#draftAmount").val();

            if (amount == 0.00) {
                $("#amountInWord").text('None');
                return false;
            } else{

                var number = amount.replace('.00', '');
                    number = number.replace(/,/g, '');
                var balance = toWords(parseInt(number));
                $("#amountInWord").text(balance);

            }
        });
        $('#draftOwnerPersonalInfo').validate({

            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                acholderName: {
                    required: true
                },
                bankName: {
                    required: true
                },
                amount: {
                    required: true
                },
                branchName: {
                    required: true
                }
            } ,
            messages: {
                acholderName: {
                    required: " "
                },
                bankName: {
                    required: " "
                },
                amount: {
                    required: " "
                },
                branchName: {
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
                    url:"${createLink(controller: 'bankDraft', action: 'saveOwnerInfo')}",
                    type:'post',
                    data: $("#draftOwnerPersonalInfo").serialize(),
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
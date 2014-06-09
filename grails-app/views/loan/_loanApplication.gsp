

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script src="${resource(dir: 'js/compressed', file: 'toword.js')}"></script>
    <title>Loan</title>
    <style>

    textarea {
        resize: none;
    }</style>
</head>
<body>

<g:hasErrors bean="${saveLoan}">
    <div class='alert alert-success '>
        <ul>
            <g:eachError var="err" bean="${saveLoan}">
                <li><g:message error="${err}" /></li>
            </g:eachError>
        </ul>
    </div>
</g:hasErrors>
<g:form name="loanForm" id="loanForm" method="post" role="form" class="form-horizontal" url="[controller:'loan', action:'save']" onsubmit="return false;">
    <g:hiddenField name="id" value="${loan?.id}"/>
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-7">
                <div class="form-group ${hasErrors(bean: loan, field: 'accountNo', 'has-error')}" id="accountNoDiv">
                    <label for="accountNo" class="col-md-4 control-label"><g:message code="loan.loanApplication.label.accNo" default=" Account no."/>
                        <span class="red">*</span>
                    </label>

                    <div class="col-md-6">
                        <g:textField name="accountNo" id="accountNo" placeholder="Account No." onfocus="this.placeholder = ''" onblur="this.placeholder = 'Account No.'" class="form-control" value="${loan?.accountNo}"/>
                    </div>
                    <span id="errorInAccount"></span>
                </div>
                <div class="form-group ${hasErrors(bean: loan, field: 'accountName', 'has-error')}">
                    <label for="accountName" class="col-md-4 control-label"><g:message code="loan.loanApplication.label.accName" default="Account Holder Name"/>

                    </label>

                    <div class="col-md-6">
                        <div class="clearfix">
                            <g:textField name="accountName" id="accountName"  class="form-control" value="${loan?.accountName}"/>

                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: loan, field: 'amount', 'has-error')}">
                    <label for="amount" class="col-md-4 control-label"><g:message code="loan.loanApplication.label.amount" default="Amount Requested"/>
                        <span class="red">*</span>
                    </label>

                    <div class="col-md-6">
                        <div class="clearfix">
                            <g:textField name="amount" id="amount" placeholder="Amount" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Amount'" class="form-control" value="${loan?.amount}"/>
                        </div>
                    </div>
                </div>
                <div class="form-group ${hasErrors(bean: loan, field: 'amountInWord', 'has-error')}" id="amountInWordDiv">
                    <label for="amountInWord" class="col-md-4 control-label"><g:message code="loan.loanApplication.label.amountInWord" default="Amount in words"/></label>
                    <div class="col-md-6">
                        <div class="clearfix">
                            <span class="control-label" name="amountInWord" id="amountInWord">None</span>
                        </div>
                    </div>
                </div>
                <div class="form-group ${hasErrors(bean: loan, field: 'purpose', 'has-error')}">
                    <label for="purpose" class="col-md-4 control-label"><g:message code="loan.loanApplication.label.purpose" default="Purpose of Loan"/>

                    </label>

                    <div class="col-md-6">
                        <div class="clearfix">
                            <g:textArea name="purpose" id="purpose" placeholder="Purpose of Loan" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Purpose of Loan'" class="form-control" value="${loan?.purpose}"/>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-md-4 control-label"><g:message code="loan.loanApplication.label.loanDuration" default="Loan Duration"/>
                        <span class="red">*</span>
                    </label>

                    <div class="col-md-8 form-group">

                        <div class="col-md-6 ${hasErrors(bean: loan, field: 'durationStart', 'has-error')}">
                            <div class='input-append date input-group' id="durationStart">
                                <label for="durationStart"></label>
                                <input type="date" name="durationStart" class="form-control datepicker" data-date-format="dd-mm-yyyy" value="${loan?.durationStart?.format("dd/MM/yyyy")}"/>
                                <span class="input-group-addon add-on"><i class="icon-calendar"></i></span>&nbsp;&nbsp;&nbsp;to

                            </div>
                        </div>
                        <div class="col-md-5 ${hasErrors(bean: loan, field: 'durationEnd', 'has-error')}">
                            <div class='input-append date input-group' id="durationEnd">
                                <label for="durationEnd"></label>
                                <input type="date" name="durationEnd" class="form-control datepicker" data-date-format="dd-mm-yyyy" value="${loan?.durationEnd?.format("dd/MM/yyyy")}"/>
                                <span class="input-group-addon add-on"><i class="icon-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group ${hasErrors(bean: loan, field: 'income', 'has-error')}">
                    <label for="income" class="col-md-4 control-label"><g:message code="loan.loanApplication.label.income" default="Source of Income"/>

                    </label>

                    <div class="col-md-6">
                        <div class="clearfix">
                            <g:textField name="income" id="income" placeholder="Source of Income" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Source of Income'" class="form-control" value="${loan?.income}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <g:render template="/loan/accountInfo"/>
            </div>
        </div>
    </div>

    <div class="clearfix form-actions">
        <div class="col-md-offset-10 col-md-2">

            <g:if test='${loan?.id!=null}'>
                <button class="btn btn-success" type="submit" name="updateLoan" id="updateLoan"><g:message code="default.button.update.label" default="Update"/></button>
            </g:if>
            <g:else>
                <button class="btn btn-success" type="submit" name="saveLoan" id="saveLoan"><g:message code="default.button.next.label" default="Next"/></button>
            </g:else>


        </div>
    </div>
</g:form>
<script type="text/javascript">
    jQuery(function ($) {

        $("#amount").focusout(function () {
            $("#amountInWord").text('None');
            var amount = $("#amount").val();
            if (amount == 0.00) {
                $("#amountInWord").text('None');
                return false;
            } else {
                var number = amount.replace('.00', '');
                number = number.replace(/,/g, '');
                var balance = toWords(parseInt(number));
                $("#amountInWord").text(balance);
            }
        });
        $("#accountNo").blur(function () {
            var accountNo = $(this).val();
            $.ajax({
                url: "${createLink(controller: 'loan', action: 'checkAccountNo')}?accountNo=" + accountNo,
                type: 'post',
                dataType: 'json',

                success: function (data) {
                    if (data.isError == false) {

                        $("#errorInAccount").removeClass('help-block').hide();
                        $("#accountNoDiv").removeClass('has-error');
                        $('#accountHolderInfo').removeClass('hidden');
                        $('#saveLoan').attr('disabled', false);
                        $('#accountName').val(data.accountInfo.name);
                        $('#name').html(data.accountInfo.name);
                        $('#city').html(data.accountInfo.address);
                        $('#mobileNo').html(data.accountInfo.contactNo);


                    } else {
                        $("#errorInAccount").addClass('help-block').text("Account No.Not Found!").show();
                        $("#accountNoDiv").addClass('has-error');
                        $('#accountHolderInfo').addClass('hidden');
                        $('#saveLoan').attr('disabled', true);

                    }
                }
            })
        });

        var dateF = "${dateFormat}";
        var dateM = "${dateMask}";
        var getDecimal = "${decimalSep}";

        $('#amount').autoNumeric("init", {mDec: getDecimal});

        $(".datepicker").inputmask(dateM);

        $("#durationStart").datepicker({
            format: dateF
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });

        $("#durationEnd").datepicker({
            format: dateF
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#loanForm').validate({

            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                accountNo: {
                    required: true

                },
                accountName: {
                    required: false
                },
                amount: {
                    required: true

                },
                purpose: {
                    required: false

                },
                durationStart: {
                    required: true
                },
                durationEnd: {
                    required: true
                },
                income: {
                    required: false

                }
            },
            messages: {
                accountNo: {
                    required: " "

                },
                accountName: {
                    required: " "
                },
                amount: {
                    required: " "

                },
                purpose: {
                    required: " "

                },
                durationStart: {
                    required: " "
                },
                durationEnd: {
                    required: " "
                },
                income: {
                    required: " "

                }
            },
            errorPlacement: function (error, element) {
                return true
            },
            invalidHandler: function (event, validator) {
                $('.alert-danger', $('.loginForm')).show();
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            submitHandler: function (form) {
                $.ajax({
                    url: "${createLink(controller: 'loan', action: 'save')}",
                    type: 'post',
                    data: $("#loanForm").serialize(),
                    success: function (data) {
                        $('#page-content').html(data);
                    },
                    failure: function (data) {
                    }
                })

            }
        });
    });
</script>
</body>
</html>
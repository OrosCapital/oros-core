<%--
  Created by IntelliJ IDEA.
  User: rabin
  Date: 5/19/14
  Time: 5:08 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>
<script type="text/javascript">
    $(document).ready(function () {
        var getDecimal = "${decimalSep}"; // todo assign variable as configurable
        $('#amount').autoNumeric("init", {mDec: getDecimal});
        $('#amount').autoNumeric('set', $('#amount').val());

        $('#withdrawalAndCloseAcc').click(function () {
            $('#fullWithdrawCloseAcc').removeClass('hidden');
            $('#withdrawAmount').addClass('hidden');
        });
        $('#withdrawOnly').click(function () {
            $('#withdrawAmount').removeClass('hidden');
            $('#fullWithdrawCloseAcc').addClass('hidden');
        });

        $("input[name='withdrawalType']").click(function(){
            var withdrawalType = $("input[name='withdrawalType']:checked").val();
            if (withdrawalType == 'Yes') {
                $('#amount').val(' ');
                var closeOrFullWith = $("input[name='accountClose']:checked").val();
                if (closeOrFullWith == null) {
                    event.preventDefault();
                }
            }
            if (withdrawalType == 'No') {
                $("input[name='accountClose']").prop('checked', false);
                var withdrawAmount = $('#amount').val();
                if (withdrawAmount == '') {
                    event.preventDefault();
                }
            }
        });

            function readURL(input) {

                if (input.files && input.files[0]) {

                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#displaySignature').removeClass('hidden');
                        $('#preview').attr('src', e.target.result);
                    }

                    reader.readAsDataURL(input.files[0]);
                }
            }

            $("#signature").change(function () {
                readURL(this);
            });

    });
</script>

<body>
<div class="widget-box">
    <div class="widget-header">
        <h4 class="smaller"><g:message
                code="coreBanking.operation.cashWithdrawal.title" default="Cash Withdrawal"/></h4>
    </div>

    <div class="widget-body">
        <div class="widget-main">

            <div class="row">
                <g:form class="form-horizontal" id="cashWithdrawalForm" name="cashWithdrawalForm"
                        method="post" role="form" url="[action: 'save', controller: 'cashWithdrawal']"
                        onsubmit="return false;">

                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-6">
                            <div class="col-xs-12 ">
                                <div class="alert alert-success hidden" id="messageDiv">
                                    <i class="icon-bell green">
                                        <b id="message"></b>
                                    </i>
                                </div>
                            </div>

                            <g:hasErrors bean="${cashWithdrawal}">
                                <div class='alert alert-success '>
                                    <ul>
                                        <g:eachError var="err" bean="${cashWithdrawal}">
                                            <li><g:message error="${err}"/></li>
                                        </g:eachError>
                                    </ul>
                                </div>
                            </g:hasErrors>

                            <br><br>

                            <div class="form-group ${hasErrors(bean: cashWithdrawal, field: 'name', 'has-error')}">
                                <label for="accountNo"
                                       class="control-label col-xs-12 col-sm-5 no-padding-right"><g:message
                                        code="coreBanking.operation.cashWithdrawal.accountNo.label"
                                        default="Account Number"/><span class="red">*</span></label>

                                <div class="col-md-4 col-sm-4">
                                    <div class="clearfix">
                                        <input type="text" id="accountNo" name="accountNo" value=""
                                               placeholder="Account Number">
                                    </div>
                                </div>
                            </div>


                            <div class="hidden" id='cashWithdrawInfo'>

                                <g:render template="/coreBanking/settings/operation/cashWithdrawal/withdrawType"/>

                                <div class="form-group ${hasErrors(bean: cashWithdrawal, field: 'chequeNo', 'has-error')}">
                                    <label for="chequeNo"
                                           class="control-label col-xs-12 col-sm-5 no-padding-right"><g:message
                                            code="coreBanking.operation.cashWithdrawal.chequeNumber.label"
                                            default="Cheque Number"/><span class="red">*</span></label>

                                    <div class="col-md-4 col-sm-4">
                                        <div class="clearfix">
                                            <input type="text" id="chequeNo" name="chequeNo" value=""
                                                   placeholder="Cheque Number">
                                        </div>
                                    </div>
                                </div>


                                <label class="control-label col-sm-offset-1"><g:message
                                        code="coreBanking.operation.cashWithdrawal.signature.title"
                                        default="Your Signature"/></label>

                                <div class="form-group ${hasErrors(bean: cashWithdrawal, field: 'name', 'has-error')}">
                                    <label for="name"
                                           class="control-label col-xs-12 col-sm-5 no-padding-right"><g:message
                                            code="coreBanking.operation.cashWithdrawal.name.label"
                                            default="Name"/><span class="red">*</span></label>

                                    <div class="col-md-4 col-sm-4">
                                        <div class="clearfix">
                                            <input type="text" id="name" name="signatureOwner" value=""
                                                   placeholder="Name">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group ${hasErrors(bean: cashWithdrawal, field: 'name', 'has-error')}">
                                    <label for="signature"
                                           class="control-label col-xs-12 col-sm-5 no-padding-right"><g:message
                                            code="coreBanking.operation.cashWithdrawal.signature.label"
                                            default="Signature"/><span class="red">*</span></label>

                                    <div class="col-md-4 col-sm-4">

                                        <input type="file" id="signature" class="btn btn-sm btn-succes col-sm-12"
                                               name="signature" value=""
                                               placeholder="signature">

                                    </div>

                                </div>

                                <div class="col-sm-offset-1">
                                    <g:submitButton name="Submit For Approval" id="saveBtn" class="btn btn-info"/>
                                </div>

                            </div>
                        </div>

                        <g:render template="/coreBanking/settings/operation/cashWithdrawal/accountInfo"/>

                    </div>

                </g:form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {

        $('#accountNo').on('focusout', function (e) {
            var accountNo = $(this).val();
            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                url: '${createLink(controller: 'cashWithdrawal',action: 'accountNoVerify')}?accountNo=' + accountNo,
                success: function (data) {
                    if (data.isError == false) {
                        $("#messageDiv").addClass('hidden');
                        $('#accountHolderInfo').removeClass('hidden');
                        $('#cashWithdrawInfo').removeClass('hidden');
                        $('#accountName').html(data.accountInfo.name);
                        $('#city').html(data.accountInfo.address);
                        $('#mobileNo').html(data.accountInfo.contactNo);
                        return
                    }
                    $('#accountHolderInfo').addClass('hidden');
                    $('#cashWithdrawInfo').addClass('hidden');
                    $("#messageDiv").removeClass('hidden');
                    $("#message").text(data.message);
                }
            });
            e.preventDefault();
        });


        $('#cashWithdrawalForm').validate({

            errorElement: 'small',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                withdrawalType: 'required',
                amount: {
                    required: true
                },
                chequeNo: {
                    required: true
                },
                name: {
                    required: true
                },
                signature: {
                    required: true
                }
            },
            messages: {
                withdrawalType: {
                    required: " "
                },
                amount: {
                    required: " "
                },
                chequeNo: {
                    required: " "
                },
                name: {
                    required: " "
                },
                signature: {
                    required: " "
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#cashWithdrawalForm')).show();
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },
            errorPlacement: function (error, element, event) {
                if (element.is(':checkbox') || element.is(':radio')) {
                    var controls = element.closest('div[class*="col-"]');
                    if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                }
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            submitHandler: function (form) {
                submitForm();
                return false;

            }
        });

        function submitForm(){
            $("#cashWithdrawalForm").submit(function (e) {
                var formData = new FormData(this);
                if (this.checkValidity()) {
                    $.ajax({
                        type: "POST",
                        dataType: "JSON",
                        mimeType: 'multipart/form-data',
                        contentType: false,
                        cache: false,
                        processData: false,
                        url: "${createLink(controller: "cashWithdrawal",action: "save")}",
                        data: formData,
                        success: function (data) {
                            if(data.isError==true){
                                $("#messageDiv").removeClass('hidden');
                                $("#message").text(data.message);
                                return
                            }
                             cleanForm();
                            $("#message").text(data.message);
                        }
                    });
                    return false
                }

           });
        }

        function cleanForm(){
            $('#accountHolderInfo').addClass('hidden');
            $('#cashWithdrawInfo').addClass('hidden');
            $("#messageDiv").removeClass('hidden');
            $("#displaySignature").addClass('hidden');
            $("#withdrawAmount").addClass('hidden');
            $("input[type='text']").val(' ');
            $("input[type='radio']").prop('checked',false);
        }

    });
</script>
</body>
</html>
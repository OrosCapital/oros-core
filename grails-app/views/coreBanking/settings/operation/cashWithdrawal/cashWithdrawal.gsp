<%--
  Created by IntelliJ IDEA.
  User: Mohammed Imran
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
                        if (data.isError == true) {
                            $("#messageDiv").removeClass('hidden');
                            $("#message").text(data.message);
                            return
                        }
                        cleanForm();
                        $("#message").text(data.message);
                    }
                });
            }
            e.preventDefault();
        });

        function cleanForm() {
            $('#accountHolderInfo').addClass('hidden');
            $('#cashWithdrawInfo').addClass('hidden');
            $("#messageDiv").removeClass('hidden');
            $("#displaySignature").addClass('hidden');
            $("input[type='text']").val(' ');

        }


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
<sec:access controller='cashWithdrawal' action='save'>
    <div class="col-xs-12">
    <div class="widget-box">
        <div class="widget-header">
            <h4 class="smaller"><g:message
                    code="coreBanking.operation.cashWithdrawal.title" default="Cash Withdrawal"/></h4>
        </div>

        <div class="widget-body">
            <div class="widget-main">

                <div class="row">
                    <g:form class="form-horizontal" id="cashWithdrawalForm" name="cashWithdrawalForm"
                            enctype="multipart/form-data"
                            method="post" role="form">

                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <div class="col-xs-6">
                                <div class="col-xs-12 ">
                                    <div class="alert alert-success hidden" id="messageDiv">
                                        <i class="icon-bell green">
                                            <b id="message"></b>
                                        </i>
                                    </div>
                                </div>

                                <br><br>

                                <div class="form-group ${hasErrors(bean: cashWithdrawal, field: 'name', 'has-error')}">
                                    <label for="accountNo"
                                           class="control-label col-xs-12 col-sm-5 no-padding-right"><g:message
                                            code="coreBanking.operation.cashWithdrawal.accountNo.label"
                                            default="Account Number"/><span class="red">*</span></label>

                                    <div class="col-md-4 col-sm-4">
                                        <div class="clearfix">
                                            <input type="text" id="accountNo" name="accountNo" value="" required=""
                                                   placeholder="Account Number">
                                        </div>
                                    </div>
                                </div>

                                <div class="hidden" id='cashWithdrawInfo'>
                                    <hr>

                                    <div class="form-group ${hasErrors(bean: cashWithdrawal, field: 'amount', 'has-error')}"
                                         id="withdrawAmount">
                                        <label for="amount"
                                               class="control-label col-xs-12 col-sm-5 no-padding-right"><g:message
                                                code="coreBanking.operation.cashWithdrawal.withdrawAmount.label"
                                                default=" Amount"/><span class="red">*</span></label>

                                        <div class="col-md-4 col-sm-4 ">
                                            <div class="clearfix">
                                                <input type="text" id="amount" name="amount" style="text-align: right"
                                                       required=""
                                                       autocomplete="off"
                                                       placeholder=" Withdrawal Amount">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group ${hasErrors(bean: cashWithdrawal, field: 'chequeNo', 'has-error')}">
                                        <label for="chequeNo"
                                               class="control-label col-xs-12 col-sm-5 no-padding-right"><g:message
                                                code="coreBanking.operation.cashWithdrawal.chequeNumber.label"
                                                default="Cheque Number"/><span class="red">*</span></label>

                                        <div class="col-md-4 col-sm-4">
                                            <div class="clearfix">
                                                <input type="text" id="chequeNo" name="chequeNo" value="" required=""
                                                       placeholder="Cheque Number">
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group ${hasErrors(bean: cashWithdrawal, field: 'signatureOwner', 'has-error')}">
                                        <label for="signatureOwner"
                                               class="control-label col-xs-12 col-sm-5 no-padding-right"><g:message
                                                code="coreBanking.operation.cashWithdrawal.name.label"
                                                default="Name"/><span class="red">*</span></label>

                                        <div class="col-md-4 col-sm-4">
                                            <div class="clearfix">
                                                <input type="text" id="signatureOwner" name="signatureOwner" value=""
                                                       required=""
                                                       placeholder="Name">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group ${hasErrors(bean: cashWithdrawal, field: 'signature', 'has-error')}">
                                        <label for="signature"
                                               class="control-label col-xs-12 col-sm-5 no-padding-right"><g:message
                                                code="coreBanking.operation.cashWithdrawal.signature.label"
                                                default="Signature"/><span class="red">*</span></label>

                                        <div class="col-md-4 col-sm-4">

                                            <input type="file" id="signature" class="btn btn-sm btn-succes col-sm-12"
                                                   required=""
                                                   name="signature" value=""
                                                   placeholder="signature">

                                            <hr>

                                            <div class="col-md-4 col-sm-4 hidden" id="displaySignature">
                                                <div class="form-group">
                                                    <ii:imageTag id="preview" indirect-imagename="#"
                                                                 indirect-filedir="ide/sed"
                                                                 alt="Signature" width="183px" height="70px"/>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <sec:access controller='cashWithdrawal' action='save'>
                                        <div class="col-sm-offset-1">
                                            <g:submitButton name="Submit For Approval" id="approval"
                                                            class="btn btn-info"/>
                                        </div>
                                    </sec:access>


                                </div>
                            </div>

                            <g:render template="/coreBanking/settings/operation/cashWithdrawal/accountInfo"/>

                        </div>

                    </g:form>
                </div>
            </div>
        </div>
    </div>
 </div>
</sec:access>

<script type="text/javascript">

    $('#cashWithdrawalForm').validate({
        errorElement: 'small',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            amount: {
                required: true
            },
            chequeNo: {
                required: true
            },
            signatureOwner: {
                required: true
            },
            signature: {
                required: true
            }
        },
        messages: {
            amount: {
                required: " "
            },
            chequeNo: {
                required: " "
            },
            signatureOwner: {
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
        success: function (e) {
            $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
            $(e).remove();
        }
    });

</script>
</body>
</html>
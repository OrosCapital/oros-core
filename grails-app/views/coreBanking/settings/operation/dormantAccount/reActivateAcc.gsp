<%--
  Created by IntelliJ IDEA.
  User: Mohammed Imran
  Date: 5/29/14
  Time: 2:27 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>
<script type="text/javascript">
    $('#accountNo').on('focusout', function (e) {
        var accountNo = $(this).val();
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: '${createLink(controller: 'dormantAccount',action: 'accountNoVerify')}?accountNo=' + accountNo,
            success: function (data) {
                if (data.isError == false) {
                    $("#messageDiv").addClass('hidden');
                    $('#accountHolderInfo').removeClass('col-xs-6 hidden');
                    $('#processNext').removeClass('hidden');
                    $('#clientId').val(data.clientId);
                    $('#previousAttach').val(data.clientId);
                    $('#accountName').html(data.accountInfo.name);
                    $('#city').html(data.accountInfo.address);
                    $('#mobileNo').html(data.accountInfo.contactNo);
                    return
                }
                $('#accountHolderInfo').addClass('hidden');
                $('#processNext').addClass('hidden');
                $("#messageDiv").removeClass('hidden');

                $("#message").text(data.message);
            }
        });
        e.preventDefault();
    });

    var clientId=${clientId};


    $('#next').click(function(){
        $("#evidenceAttachment").removeClass("disabled");
        $("#evidenceAttach").removeClass("disabled");
        $('#accInfoVerify').removeClass("active");
        $('#accountVerify').removeClass("active");
        $('#evidenceAttachment').addClass("active");
        $('#evidenceAttach').addClass("active");
        $('#evidenceAttach').show();
        return
    });

    function readURL(input) {
        if (input.files && input.files[0]) {

            var reader = new FileReader();

            reader.onload = function (e) {
                $('#displayBankDoc').removeClass('hidden');
                $('#preview').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#bankDocument").change(function () {
        readURL(this);
    });

</script>

<body>
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
                <ul class="nav navbar-nav responsive padding-12 tab-color-blue background-blue">
                    <li class="" id="accInfoVerify">
                        <a href="#accountVerify" data-toggle="tab">
                            <g:message code="coreBanking.dormantAccount.reactivate.accountVerify"
                                       default="Account Verify"/></a>
                    </li>
                    <li class="" id="evidenceAttachment">
                        <a href="#evidenceAttach" data-toggle="tab">
                            <g:message code="coreBanking.dormantAccount.reactivate.evidenceAttachment"
                                       default="Evidence Attachment"/></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="tab-content responsive">

        <div class="tab-pane" id="accountVerify">

                <div class="row">

                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                        <div class="col-xs-6 col-sm-6 col-md-6">

                            <div class="col-xs-12 ">

                                <g:if test='${flash.message}'>
                                    <div class='alert alert-success '>
                                        <i class="icon-bell green"><b>${flash.message}</b></i>
                                    </div>
                                </g:if>

                                <div class="alert alert-success hidden" id="messageDiv">
                                    <i class="icon-bell green">
                                        <b id="message"></b>
                                    </i>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="accountNo"
                                       class="col-sm-4 col-xs-6 control-label no-padding-right"><g:message
                                        code="coreBanking.operation.cashWithdrawal.accountNo.label"
                                        default="Account Number"/><span class="red">*</span></label>

                                <div class="col-md-4 col-sm-4">
                                    <div class="clearfix">
                                        <input type="text" id="accountNo" name="accountNo" value="" required=""
                                               placeholder="Account Number">
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <g:render template="/coreBanking/settings/operation/cashWithdrawal/accountInfo"/>
                        </div>

                    </div>

                </div>

                <div class="clearfix form-actions hidden" id="processNext">
                    <div class="col-md-offset-9 col-md-3">
                        <button class="btn btn-primary btn-sm" type="submit" id="next">
                            <g:message code="default.button.next.label" default="Next"/></button>
                    </div>
                </div>

        </div>

        <div class="tab-pane " id="evidenceAttach">
            <g:render template="/coreBanking/settings/operation/dormantAccount/evidenceAttachment"/>
        </div>

    </div>

</div>

<script type="text/javascript">

    $('#evidenceAttachForm').validate({
        errorElement: 'div',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            caption: {
                required: true
            },
            attachment: {
                required: true
            }
        },

        messages: {
            caption: {
                required: " "
            },
            attachment: {
                required: " "
            }

        },
        errorPlacement: function (error, element) {
            return true
        },
        invalidHandler: function (event, validator) {
            $('.alert-danger', $('#evidenceAttachForm')).show();
        },

        highlight: function (e) {
            $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
        },

        success: function (e) {
            $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
            $(e).remove();
        }
    });

    jQuery(function ($) {
        var tabSelector = "${tabSelectIndicator}";
        if (tabSelector == 1) {
            $('#evidenceAttachment').removeClass("active");
            $('#accInfoVerify').addClass("active");
            $('#accountVerify').addClass("active");
            $('#accountVerify').show();
        }

        $("#evidenceAttachment").click(function(){
            return false;
        });
        $("#accInfoVerify").click(function(){
            return false;
        });


    });
</script>
</body>
</html>
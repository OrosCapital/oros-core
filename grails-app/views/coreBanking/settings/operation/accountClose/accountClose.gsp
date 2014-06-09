<%--
  Created by IntelliJ IDEA.
  User: Mohammed Imran
  Date: 5/26/14
  Time: 4:15 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>
    .form-control, label, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"] {
        font-size: 12px;
    }

    label {
        max-width: 150px;
    }

    </style>
    <script type="text/javascript">
        $('#accountNo').on('focusout', function (e) {
            var accountNo = $(this).val();
            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                url: '${createLink(controller: 'cashWithdrawal',action: 'accountNoVerify')}?accountNo=' + accountNo,
                success: function (data) {
                    if (data.isError == false) {
                        $('#accountHolderInfo').removeClass('col-xs-6 hidden');
                        $('#document').removeClass('hidden');
                        $("#messageDiv").addClass('hidden');
                        $('#accountName').html(data.accountInfo.name);
                        $('#city').html(data.accountInfo.address);
                        $('#mobileNo').html(data.accountInfo.contactNo);
                        return
                    }
                    $('#accountHolderInfo').addClass('col-xs-6 hidden');
                    $('#document').addClass('hidden');
                    $("#messageDiv").removeClass('hidden');
                    $("#message").text(data.message);
                }
            });
            e.preventDefault();
        });

    </script>
    <title></title>
</head>

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
                    <li class="" id="accountInfoAndDocument">
                        <a href="#accountCloseStep1" data-toggle="tab">
                            <g:message code="coreBanking.operation.accountClose.accountVerify.tabLbl"
                                       default="Account Verify"/></a>
                    </li>
                    <li class="disabled" id="accountCloseReason">
                        <a href="#accountCloseStep2" data-toggle="tab">
                            <g:message code="coreBanking.operation.accountClose.reasonForClose.tabLbl"
                                       default="Account Clsose Reason"/></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="tab-content responsive">

        <div class="tab-pane" id="accountCloseStep1">

            <g:form name="accountCloseForm" id="accountCloseForm" method="post" role="form"
                    class="form-horizontal" url="[controller:'accountClose', action:'docCollection']"
                    onsubmit="return false;">

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
                                <label for="accountNo" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.operation.cashWithdrawal.accountNo.label"
                                        default="Account Number"/>
                                    <span class="red">*</span></label>

                                <div class="col-md-4 col-sm-4">
                                    <div class="clearfix">
                                        <input type="text" id="accountNo" name="accountNo" value="" required=""
                                               placeholder="Account Number">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group hidden" id="document">
                                <label for="document" class="col-sm-4 col-xs-4 control-label no-padding-right">
                                    <g:message code="coreBanking.operation.accountClose.docCollect.title"
                                               default="Document Collect"/>
                                    <span class="red">*</span></label>

                                <div class="col-md-7 col-sm-7 col-xs-7">

                                    <div class="checkbox">
                                        <label>
                                            <input name="document" type="checkbox" class="ace ace-checkbox-2" value="Cheque Book" />
                                            <span class="lbl">
                                                <g:message code="coreBanking.operation.accountClose.docCollect.checkBook.lbl"
                                                           default="Cheque Book"/></span>
                                        </label>
                                    </div>

                                    <div class="checkbox">
                                        <label>
                                            <input name="document" type="checkbox" class="ace ace-checkbox-2" value="Card"/>
                                            <span class="lbl">
                                                <g:message code="coreBanking.operation.accountClose.docCollect.card.lbl"
                                                           default="Card"/></span>
                                        </label>
                                    </div>

                                    <div class="checkbox">
                                        <label>
                                            <input name="document" class="ace ace-checkbox-2" type="checkbox" value="Other Bank Document"/>
                                            <span class="lbl">
                                                <g:message code="coreBanking.operation.accountClose.docCollect.other.lbl"
                                                           default="Other Bank Document"/></span>
                                        </label>
                                    </div>

                                </div>
                            </div>

                        </div>

                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <g:render template="/coreBanking/settings/operation/cashWithdrawal/accountInfo"/>
                        </div>

                    </div>

                </div>

                <div class="clearfix form-actions">
                    <div class="col-md-offset-9 col-md-3">
                        <button class="btn btn-primary btn-sm" type="submit" >
                            <g:message code="default.button.next.label"
                                       default="Next"/>
                        </button>
                    </div>
                </div>

            </g:form>

        </div>

        <div class="tab-pane disabled" id="accountCloseStep2">
              <g:render template="/coreBanking/settings/operation/accountClose/accCloseReason"/>
        </div>

    </div>

</div>

<script type="text/javascript">

    jQuery(function ($) {
        var tabSelector = "${tabSelectIndicator}";
        if (tabSelector == 1) {
            $('#accountCloseReason').removeClass("active");
            $('#accountInfoAndDocument').addClass("active");
            $('#accountCloseStep1').addClass("active");
            $('#accountCloseStep1').show();
        }
        else if (tabSelector == 2) {
            $("#accountCloseReason").removeClass("disabled");
            $("#accountCloseStep2").removeClass("disabled");
            $('#accountInfoAndDocument').removeClass("active");
            $('#accountCloseReason').addClass("active");
            $('#accountCloseStep2').addClass("active");
            $('#accountCloseStep2').show();
        }

        $("#accountCloseReason").click(function(){
            return false;
        });
        $("#accountInfoAndDocument").click(function(){
            return false;
        });

        $('#accountCloseForm').validate({

            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                accountNo: {
                    required: true
                },
                document: {
                    required: true
                }
            },
            messages: {
                accountNo: {
                    required: " "
                },
                document: {
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
                if (element.is(':checkbox') || element.is(':radio')) {
                    var controls = element.closest('div[class*="col-"]');
                    if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                }
            },
            submitHandler: function (form) {
                $.ajax({
                    url: "${createLink(controller: 'accountClose', action: 'docCollection')}",
                    type: 'post',
                    data: $("#accountCloseForm").serialize(),
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
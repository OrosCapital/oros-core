<%@ page import="com.gsl.oros.core.banking.settings.State; com.gsl.oros.core.banking.settings.Country" %>
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
    <title>Account Close Reason</title>
</head>


<body>

<g:form name="accCloseReasonForm" id="accCloseReasonForm" method="post" role="form" class="form-horizontal"
        url="[controller: 'accountClose', action: 'saveForApprove']" onsubmit="return false;">

    <div class="row">

        <div class="form-group ${hasErrors(bean: accountClose, field: 'preBalance', 'has-error')}">
            <label for="preBalance" class="col-sm-4 col-xs-6 control-label no-padding-right">
                <g:message code="coreBanking.operation.accountClose.preBalance.lbl"
                           default="Previous Balance"/>
                <span class="red">*</span>
            </label>

            <div class="col-sm-8 col-xs-12">
                <div class="clearfix">
                    <input type="text" id="preBalance" name="preBalance" value="${accountClose?.preBalance}"
                           required="" readonly>
                </div>
            </div>
        </div>

        <div class="form-group ${hasErrors(bean: accountClose, field: 'chargeApply', 'has-error')}">
            <label for="chargeApply" class="col-sm-4 col-xs-6 control-label no-padding-right">
                <g:message code="coreBanking.operation.accountClose.chargeApply.lbl" default="Charge Apply"/><span
                    class="red">*</span>
            </label>

            <div class="col-sm-8 col-xs-12">
                <div class="clearfix">
                    <input type="text" id="chargeApply" name="chargeApply" value="${accountClose?.charge}"
                           required="" readonly>
                </div>
            </div>
        </div>

        <div class="form-group ${hasErrors(bean: accountClose, field: 'getBalance', 'has-error')}">
            <label for="chargeApply" class="col-sm-4 col-xs-6 control-label no-padding-right">
                <g:message code="coreBanking.operation.accountClose.balance.lbl"
                           default="Available Balance"/>
                <span class="red">*</span>
            </label>

            <div class="col-sm-8 col-xs-12">
                <div class="clearfix">
                    <input type="text" id="getBalance" name="getBalance" value="${accountClose?.getBalance}"
                           required="" readonly>
                </div>
            </div>
        </div>


        <div class="form-group" id="reasonForClose">
            <label for="reasonForClose" class="col-sm-4 col-xs-4 control-label no-padding-right">
                <g:message code="coreBanking.operation.accountClose.reason.lbl"
                           default="Reason For Close"/>
                <span class="red">*</span></label>

            <div class="col-md-12 col-sm-12 col-xs-12">

                <div class="col-md-6 col-sm-6 col-xs-6">

                    <div class="checkbox">
                        <label>
                            <input name="accCloseReason" type="checkbox" class="ace ace-checkbox-2"
                                   value="Cheque Book"/>
                            <span class="lbl">
                                <g:message code="coreBanking.operation.accountClose.reason1.lbl"
                                           default="Account moved within oroscapital"/>
                            </span>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input name="accCloseReason" type="checkbox" class="ace ace-checkbox-2" value="Card"/>
                            <span class="lbl">
                                <g:message code="coreBanking.operation.accountClose.reason2.lbl"
                                           default="Inactive account/not being used"/></span>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input name="accCloseReason" class="ace ace-checkbox-2" type="checkbox"
                                   value="Other Bank Document"/>
                            <span class="lbl">
                                <g:message code="coreBanking.operation.accountClose.reason3.lbl"
                                           default="Dissatisfied with the service/product features"/></span>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input name="accCloseReason" class="ace ace-checkbox-2" type="checkbox"
                                   value="Other Bank Document"/>
                            <span class="lbl">
                                <g:message code="coreBanking.operation.accountClose.reason4.lbl"
                                           default="Unable to maintain the minimum balance/charges"/></span>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input name="accCloseReason" class="ace ace-checkbox-2" type="checkbox"
                                   value="Other Bank Document"/>
                            <span class="lbl"><g:message code="coreBanking.operation.accountClose.reason5.lbl"
                                                         default="Moved to non-OrosCapital bank location/inconvenient"/></span>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input name="accCloseReason" class="ace ace-checkbox-2" type="checkbox" id="otherReason"
                                   value="Others"/>
                            <span class="lbl"><g:message code="coreBanking.operation.accountClose.reason9.lbl"
                                                         default="Others please Specify"/></span>

                        </label>
                        <input type="text" name="othersReason" id="reasonField" placeholder="Others Reason"
                               class="hidden"/>
                    </div>

                </div>

                <div class="col-md-6 col-sm-6 col-xs-6">
                    <div class="checkbox">
                        <label>
                            <input name="accCloseReason" type="checkbox" class="ace ace-checkbox-2"
                                   value="Cheque Book"/>
                            <span class="lbl"><g:message code="coreBanking.operation.accountClose.reason6.lbl"
                                                         default="Interest rate not competitive"/></span>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input name="accCloseReason" type="checkbox" class="ace ace-checkbox-2" value="Card"/>
                            <span class="lbl"><g:message code="coreBanking.operation.accountClose.reason7.lbl"
                                                         default="Accountholder deceased"/></span>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input name="accCloseReason" class="ace ace-checkbox-2" type="checkbox"
                                   value="Other Bank Document"/>
                            <span class="lbl"><g:message code="coreBanking.operation.accountClose.reason8.lbl"
                                                         default="Resigned from corporate (salary account)"/></span>
                        </label>
                    </div>
                </div>

            </div>
        </div>

    </div>

    <sec:access controller="accountClose" action="">
        <div class="clearfix form-actions">
            <div class="col-md-offset-8 col-md-4">
                <button class="btn btn-primary btn-sm" type="submit" name="saveDraftPaymentInfo"
                        id="saveDraftPaymentInfo"><g:message code="default.button.submit.label" default="Submit"/></button>
            </div>
        </div>
    </sec:access>

</g:form>

<script type="text/javascript">

    $("#otherReason").click(function () {
        var otherReason = $("#otherReason:checked").val();
        if (otherReason == null) {
            $("#reasonField").addClass("hidden");
        }
        else {
            $("#reasonField").removeClass("hidden");
        }
    });


    $('#accCloseReasonForm').validate({

        errorElement: 'div',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            accCloseReason: {
                required: true
            },
            othersReason: {
                required: "#otherReason:checked"
            }
        },
        messages: {
            accCloseReason: {
                required: " "
            },
            othersReason: {
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
                url: "${createLink(controller: 'accountClose', action: 'saveForApprove')}",
                type: 'post',
                data: $("#accCloseReasonForm").serialize(),
                success: function (data) {
                    $('#page-content').html(data);
                },
                failure: function (data) {
                }
            })

        }
    });
</script>

</body>
</html>
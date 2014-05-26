<%@ page
        contentType="text/html;charset=UTF-8"
        import="com.gsl.oros.core.banking.settings.State; com.gsl.oros.core.banking.settings.Country; com.gsl.oros.core.banking.settings.accounting.VatCategory"
%>
<html>
<head>
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
                    <li class="" id="draftPersonalInfo">
                        <a href="#draftPersonalInfoDiv" data-toggle="tab">Personal Info</a>
                    </li>
                    <li class="" id="draftAccountInfo">
                        <a href="#bankAccountInfo" data-toggle="tab">Bank Account Info</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="tab-content responsive">

        <div class="tab-pane" id="draftPersonalInfoDiv">
            <g:hasErrors bean="${bankDraft}">
                <div class='alert alert-success '>
                    <ul>
                        <g:eachError var="err" bean="${bankDraft}">
                            <li><g:message error="${err}" /></li>
                        </g:eachError>
                    </ul>
                </div>
            </g:hasErrors>
            <g:form name="draftOwnerPersonalInfo" id="draftOwnerPersonalInfo" method="post" role="form" class="form-horizontal" url="[controller:'vendor', action:'saveVendorGeneralAddress']" onsubmit="return false;">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                        <div class="col-xs-6 col-sm-6 col-md-6">

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'firstName','has-error')}">
                                <label for="firstName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.accounting.vendor.basicInfo.firstName" default="First Name"/><span class="red">*</span>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="text" class="col-sm-11 col-xs-12" placeholder="First Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'First Name'" id="firstName"
                                               name="firstName" value="${bankDraft?.firstName}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'mobileNo','has-error')}">
                                <label for="mobileNo" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="default.address.mobile.label" default="Mobile No"/>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="tel" class="col-sm-11 col-xs-12" placeholder="Mobile No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Mobile No'" id="mobileNo"
                                               name="address.mobileNo" value="${bankDraft?.address?.mobileNo}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'addressLine1','has-error')}">
                                <label for="addressLine1" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.accounting.vendor.generalAddress.addressLine1" default="Address Line1"/>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="text" class="col-sm-11 col-xs-12" placeholder="First Address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'First Address'" id="addressLine1"
                                               name="address.addressLine1" value="${bankDraft?.address?.addressLine1}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'state','has-error')}">
                                <label for="draftPersonalInfoState" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="default.state.label" default="State"/>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <g:select id="draftPersonalInfoState" name='address.state' class="col-sm-11 col-xs-12"
                                                  noSelection="${['': 'Select State...']}"
                                                  from='${bankDraft?.address?.country != null ? State.findAllByCountry(bankDraft?.address?.country) : State.findAllByCountry(bankDraft?.address?.country)}'
                                                  value="${bankDraft?.address?.state?.id}"
                                                  optionKey="id" optionValue="name"></g:select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'postCode','has-error')}">
                                <label for="postCode" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="default.address.postCode.label" default="Post Code"/><span class="red">*</span>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="text" class="col-sm-11 col-xs-12" placeholder="Postal Code" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Postal Code'" id="postCode"
                                               name="address.postCode" value="${bankDraft?.address?.postCode}"/>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="col-xs-6 col-sm-6 col-md-6">

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'lastName','has-error')}">
                                <label for="lastName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.accounting.vendor.basicInfo.lastName" default="Last Name"/><span class="red">*</span>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="text" class="col-sm-11 col-xs-12" placeholder="Last Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Last Name'" id="lastName"
                                               name="lastName" value="${bankDraft?.lastName}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'email','has-error')}">
                                <label for="email" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.accounting.vendor.basicInfo.email" default="Email"/>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="email" class="col-sm-11 col-xs-12" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'" id="email"
                                               name="address.email1" value="${bankDraft?.address?.email1}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'country','has-error')}">
                                <label for="draftPersonalInfoCountry" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="default.country.label" default="Country"/><span class="red">*</span>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <g:select id="draftPersonalInfoCountry" name='address.country' class="col-sm-11 col-xs-12"
                                                  noSelection="${['': 'Select Country...']}"
                                                  from='${Country.findAllByStatus(true)}' value="${bankDraft?.address?.country?.id}"
                                                  optionKey="id" optionValue="name">
                                        </g:select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'city','has-error')}">
                                <label for="city" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="default.city.label" default="City"/><span class="red">*</span>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="text" class="col-sm-11 col-xs-12" placeholder="City" onfocus="this.placeholder = ''" onblur="this.placeholder = 'City'" id="city"
                                               name="address.city" value="${bankDraft?.address?.city}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: bankDraft, field: 'nationalID','has-error')}">
                                <label for="nationalID" class="col-sm-4 col-xs-6 control-label no-padding-right">
                                    <g:message code="coreBanking.clients.accountHolder.basicInfo.nationalID" default="National ID"/>
                                </label>
                                <div class="col-sm-8 col-xs-12">
                                    <div class="clearfix">
                                        <input type="text" class="col-sm-11 col-xs-12" placeholder="National Identification No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'National Identification No'" id="nationalID"
                                               name="nationalID" value="${bankDraft?.nationalID}">
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>

                <div class="clearfix form-actions">
                    <div class="col-md-offset-9 col-md-3">
                        <button class="btn btn-primary btn-sm" type="submit" name="saveDraftPersonalInfo" id="saveDraftPersonalInfo">Next</button>
                    </div>
                </div>
            </g:form>
        </div>
        <div class="tab-pane" id="bankAccountInfo">
            <g:render template='/coreBanking/settings/operation/bankDraft/bankAccount'/>
        </div>
    </div>
</div>

<script type="text/javascript">

    jQuery(function ($) {
        var tabSelector = "${tabSelectIndicator}";
        if(tabSelector == 1){
            $('#draftAccountInfo').removeClass("active");
            $('#draftPersonalInfo').addClass("active");
            $('#draftPersonalInfoDiv').addClass("active");
            $('#draftPersonalInfo').show();
        }
        else if(tabSelector == 2){
        $('#draftPersonalInfo').removeClass("active");
        $('#draftAccountInfo').addClass("active");
        $('#bankAccountInfo').addClass("active");
        $('#draftAccountInfo').show();
        }

        var getDecimal = "${decimalSep}";
        alert(getDecimal);
        $('#draftAmount').autoNumeric("init", {mDec: getDecimal});
        var dateF = "${dateFormat}";
        var dateMask = "${dateMask}";
        $(".datepicker").inputmask(dateMask);

        $("#today").datepicker({
            format: dateF,
            gotoCurrent: true,
            autoclose: true
        });

        $("#draftPersonalInfoCountry").change(function () {
            var id = $(this).val();

            $.ajax
            ({
                type: "POST",
                url: "${createLink(controller: "vendor",action: "stateList")}",
                data: {country: id},
                cache: false,
                success: function (html) {
                    $("#draftPersonalInfoState").html(html);
                }
            });
        });

        $('#draftOwnerPersonalInfo').validate({

            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                firstName: {
                    required: true
                },
                lastName: {
                    required: true
                },
                "address.country": {
                    required: true
                },
                "address.city": {
                    required: true
                },
                "address.postCode": {
                    required: true
                }
            } ,
            messages: {
                firstName: {
                    required: " "
                },
                lastName: {
                    required: " "
                },
                "address.postCode": {
                    required: " "
                },
                "address.country": {
                    required: " "
                },
                "address.city": {
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
                    url:"${createLink(controller: 'bankDraft', action: 'savePersonalInfo')}",
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
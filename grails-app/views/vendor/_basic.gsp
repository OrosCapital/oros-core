<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>
    .form-control, label, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"]{font-size: 12px;}
    label{max-width: 150px;}
    </style>
    <title></title>
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
                    <li class="" id="vendorBasicInfo">
                        <a href="#vendorBasic" data-toggle="tab">Basic</a>
                    </li>
                    <li class="" id="vendorGeneralAdd">
                        <a href="#vendorGeneralAddress" data-toggle="tab">General Address</a>
                    </li>
                    <li class="" id="vendorPostalAdd">
                        <a href="#vendorPostalAddress" data-toggle="tab">Postal Address</a>
                    </li>
                    <li class="" id="vendorAccountInfo">
                        <a href="#vendorBankAccountInfo" data-toggle="tab">Bank Account Info</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="tab-content responsive">
        <div class="tab-pane" id="vendorBasic">

            <g:hasErrors bean="${vendorMaster}">
                <div class='alert alert-success '>
                    <ul>
                        <g:eachError var="err" bean="${vendorMaster}">
                            <li><g:message error="${err}"/></li>
                        </g:eachError>
                    </ul>
                </div>
            </g:hasErrors>
        <g:form name="vendorBasicInfoForm" id="vendorBasicInfoForm" method="post" role="form" class="form-horizontal" url="[action: 'saveVendorBasic', controller: 'vendor']">
        <g:hiddenField name="id" value="${vendorMaster?.id}"/>


        <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12">
        <div class="col-xs-6 col-sm-6 col-md-6">

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'vendorCode','has-error')}">
                <label for="vendorCode" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.vendorCode" default="Vendor Code"/><span class="red">*</span>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <input type="text" class="col-sm-11 col-xs-12" placeholder="Vendor Code" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Vendor Code'" id="vendorCode" name="vendorCode" value="${fieldValue(bean:vendorMaster,field:'vendorCode')}"/>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'firstName','has-error')}">
                <label for="firstName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.firstName" default="First Name"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <input type="text" class="col-sm-11 col-xs-12" placeholder="First Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'First Name'" id="firstName"
                               name="firstName" value="${fieldValue(bean:vendorMaster,field:'firstName')}"/>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'lastName','has-error')}">
                <label for="lastName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.lastName" default="Last Name"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <input type="text" class="col-sm-11 col-xs-12" placeholder="Last Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Last Name'" id="lastName"
                               name="lastName" value="${fieldValue(bean:vendorMaster,field:'lastName')}"/>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'email','has-error')}">
                <label for="email" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.email" default="Email"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <input type="email" class="col-sm-11 col-xs-12" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'" id="email"
                               name="email" value="${fieldValue(bean:vendorMaster,field:'email')}"/>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'chamOfCommerce','has-error')}">
                <label for="chamberOfCommerce" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.ChamOfCommerce" default="Chamber of Commerce"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <input type="text" class="col-sm-11 col-xs-12" placeholder="Chamber of Commerce" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Chamber of Commerce'" id="chamberOfCommerce"
                               name="chamOfCommerce" value="${fieldValue(bean:vendorMaster,field:'chamOfCommerce')}"/>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'paymentTermId','has-error')}">
                <label for="paymentTermId" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.paymentTerm" default="Payment Term"/><span class="red">*</span>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <select id="paymentTermId" class="col-sm-11 col-xs-12" name="paymentTermId">
                            <g:if test="${vendorMaster?.paymentTermId != null}">
                                <option  value="${vendorMaster?.paymentTermId}">${vendorMaster?.paymentTermId}SS week</option>
                            </g:if>
                            <option value="">-Select-</option>
                            <option value="1">1SS week</option>
                            <option value="2">2SS week</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'comments','has-error')}">
                <label for="comments" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.comments" default="Comments"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <textarea class="col-sm-11 col-xs-12" placeholder="Comments" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Comments'" id="comments"
                                  name="comments">${fieldValue(bean:vendorMaster,field:'comments')}</textarea>
                    </div>
                </div>
            </div>

        </div>

        <div class="col-xs-6 col-sm-6 col-md-6">

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'vendorName','has-error')}">
                <label for="vendorName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.vendorName" default="Vendor Name"/><span class="red">*</span>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <input type="text" class="col-sm-11 col-xs-12" placeholder="Vendor Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Vendor Name'" id="vendorName"
                               name="vendorName" value="${fieldValue(bean:vendorMaster,field:'vendorName')}"/>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'middleName','has-error')}">
                <label for="middleName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.middleName" default="Middle Name"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <input type="text" class="col-sm-11 col-xs-12" placeholder="Middle Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Middle Name'" id="middleName"
                               name="middleName" value="${fieldValue(bean:vendorMaster,field:'middleName')}"/>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'gender','has-error')}">
                <label for="gender" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.gender" default="Gender"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <select id="gender" class="col-sm-11 col-xs-12" name="gender">
                            <g:if test="${vendorMaster?.gender != null}">
                                <g:if test="${vendorMaster?.gender == "Male"}">
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </g:if>
                                <g:else>
                                    <option value="Female">Female</option>
                                    <option value="Male">Male</option>
                                </g:else>
                            </g:if>
                            <g:else>
                                <option value="">-Select-</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </g:else>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'defaultGlAccount','has-error')}">
                <label for="defaultGlAccount" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.defaultGlAccount" default="Default GI Account"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <select id="defaultGlAccount" class="col-sm-11 col-xs-12" name="defaultGlAccount">
                            <g:if test="${vendorMaster?.defaultGlAccount != null}">
                                <option  value="${vendorMaster?.defaultGlAccount}">${vendorMaster?.defaultGlAccount}</option>
                            </g:if>
                            <option value="">-Select-</option>
                            <option value="4100">4100</option>
                            <option value="4500">4500</option>
                            <option value="7500">7500</option>
                            <option value="7100">7100</option>
                            <g:each var="vendorMaster" in="${vendorMasterList}">
                                <option value="${vendorMaster.defaultGlAccount}">${vendorMaster.defaultGlAccount}</option>
                            </g:each>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'vat','has-error')}">
                <label for="vat" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.vat" default="Vat"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <select id="vat" class="col-sm-11 col-xs-12" name="vat">
                            %{--<g:if test="${vendorMaster?.vat != null}">
                                <option  value="${vendorMaster?.vat}">${vendorMaster?.vat}</option>
                            </g:if>--}%
                            <option value="">-Select Vat-</option>
                            <g:each in="${vatList}">
                                <option value="${it?.rate}">${it.name}(${it.rate})</option>
                            </g:each>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'vendorType','has-error')}">
                <label for="vendorType" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.type" default="Type"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <select id="vendorType" class="col-sm-11 col-xs-12" name="vendorType">
                            <g:if test="${vendorMaster?.vendorType != null}">
                                <option  value="${vendorMaster?.vendorType}">${vendorMaster?.vendorType}</option>
                            </g:if>
                            <option value="">-Select-</option>
                            <option value="vn">vn</option>
                            <option value="bn">bn</option>
                            <option value="rp">rp</option>
                            <option value="sn">sn</option>
                            <g:each var="vendorMaster" in="${vendorMasterList}">
                                <option value="${vendorMaster.vendorType}">${vendorMaster.vendorType}</option>
                            </g:each>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: vendorMaster, field: 'status','has-error')}">
                <label for="status" class="col-sm-4 col-xs-6 control-label no-padding-right">
                    <g:message code="coreBanking.accounting.vendor.basicInfo.status" default="Status"/>
                </label>
                <div class="col-sm-8 col-xs-12">
                    <div class="clearfix">
                        <select id="status" class="col-sm-11 col-xs-12" name="status">
                            <g:if test="${vendorMaster?.status != null}">
                                <g:if test="${vendorMaster?.status == 1}">
                                    <option value="1">Active</option>
                                    <option value="0">Inactive</option>
                                </g:if>
                                <g:else>
                                    <option value="0">Inactive</option>
                                    <option value="1">Active</option>
                                </g:else>
                            </g:if>
                            <g:else>
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </g:else>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        </div><!-- /.col -->
        </div><!-- /.row -->
        <div class="clearfix form-actions">
            <div class="col-md-offset-9 col-md-3">
                <g:if test='${vendorMaster?.id!=null}'>
                    <button class="btn btn-primary btn-sm" type="submit" name="updateVendorBasic" id="updateVendorBasic">Update</button>
                </g:if>
                <g:else>
                    <button class="btn btn-primary btn-sm" type="submit" name="saveVendorBasic" id="saveVendorBasic">Save</button>
                </g:else>
            %{--<g:submitToRemote url="[controller:'vendor', action:'saveVendorBasic']" update="basicInfoForm" class="btn btn-primary btn-sm"  name="next" value="Next"/>--}%
            %{--<g:actionSubmit class="btn btn-primary btn-sm"  name="next" value="Next" id="button-next" controller="vendor" action="saveVendorBasic"/>--}%
            </div>
        </div>


        </g:form>
        </div>
    <div class="tab-pane" id="vendorGeneralAddress">
        <g:render template='/vendor/generalAddress'/>
    </div>
    <div class="tab-pane" id="vendorPostalAddress">
        <g:render template='/vendor/postalAddress'/>
    </div>
    <div class="tab-pane" id="vendorBankAccountInfo">
        <g:render template='/vendor/bankAccount'/>
    </div>
    </div>
</div>

<script type="text/javascript">
    $(".chosen-select").chosen();
    var tabSelector='${tabSelectIndicator}';
    var updateSelector='${updateSelector}';
    jQuery(function ($) {

        if(tabSelector == 1){
            $('#vendorBasicInfo').addClass( "active" );
            $('#vendorBasic').addClass( "active" );
            $('#vendorBasicInfo').show();

            $('#vendorGeneralAdd').removeClass( "active" );
            $('#vendorPostalAdd').removeClass( "active" );
            $('#vendorAccountInfo').removeClass( "active" );

            if(updateSelector == 0){
                $('#vendorGeneralAdd').addClass( "disabled" );
                $('#vendorPostalAdd').addClass( "disabled" );
                $('#vendorAccountInfo').addClass( "disabled" );

                $("#vendorGeneralAdd").click(function(){
                    return false;
                });

                $("#vendorPostalAdd").click(function(){
                    return false;
                });

                $("#vendorAccountInfo").click(function(){
                    return false;
                });
            }

        }
        else if(tabSelector == 2){
            $('#vendorGeneralAdd').addClass( "active" );
            $('#vendorGeneralAddress').addClass( "active" );
            $('#vendorGeneralAdd').show();

            $('#vendorBasicInfo').removeClass( "active" );
            $('#vendorPostalAdd').removeClass( "active" );
            $('#vendorAccountInfo').removeClass( "active" );

        }

        else if(tabSelector == 3){
            $('#vendorPostalAdd').addClass( "active" );
            $('#vendorPostalAddress').addClass( "active" );
            $('#vendorPostalAdd').show();

            $('#vendorBasicInfo').removeClass( "active" );
            $('#vendorGeneralAdd').removeClass( "active" );
            $('#vendorAccountInfo').removeClass( "active" );

        }

        else if(tabSelector == 4){
            $('#vendorAccountInfo').addClass( "active" );
            $('#vendorBankAccountInfo').addClass( "active" );
            $('#vendorAccountInfo').show();

            $('#vendorBasicInfo').removeClass( "active" );
            $('#vendorGeneralAdd').removeClass( "active" );
            $('#vendorPostalAdd').removeClass( "active" );

        }
        $(".chosen-select").css('width','200px').select2({allowClear:true})
                .on('change', function(){
                    $(this).closest('form').validate().element($(this));
                });
        $('#vendorBasicInfoForm').validate({

            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                vendorCode: {
                    required: true
                },
                paymentTermId: {
                    required: true
                },
                vendorName: {
                    required: true
                }
            } ,
            messages: {
                vendorCode: {
                    required: " "
                },
                vendorName: {
                    required: " "
                },
                paymentTermId: {
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
                    url:"${createLink(controller: 'vendor', action: 'saveVendorBasic')}",
                    type:'post',
                    data: $("#vendorBasicInfoForm").serialize(),
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
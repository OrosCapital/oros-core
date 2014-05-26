<%@ page import="com.gsl.oros.core.banking.settings.State; com.gsl.oros.core.banking.settings.Country" %>
<html>
<head>
    <style>
    .form-control, label, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"]{font-size: 12px;}
    label{max-width: 150px;}
    </style>
    <title></title>
</head>
<body>



    <g:hasErrors bean="${vendorGeneralAddress}">
        <div class='alert alert-success '>
            <ul>
                <g:eachError var="err" bean="${vendorGeneralAddress}">
                    <li><g:message error="${err}" /></li>
                </g:eachError>
            </ul>
        </div>
    </g:hasErrors>
    <g:form name="vendorGeneralAddressForm" id="vendorGeneralAddressForm" method="post" role="form" class="form-horizontal" url="[controller:'vendor', action:'saveVendorGeneralAddress']" onsubmit="return false;">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                <div class="col-xs-6 col-sm-6 col-md-6">
                    <g:hiddenField name="id" value="${vendorMaster?.id}"/>
                    <g:hiddenField name="addressId" value="${vendorMaster?.generalAddress?.id}"/>

                    %{--<input type="text" class="col-sm-11 col-xs-12" placeholder="Contact Person Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Contact Person Name'" id="hhh"
                           name="hhgg" value="${vendorMasterID}"/>--}%
                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'contactPersonName','has-error')}">
                        <label for="contactPersonName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="coreBanking.accounting.vendor.generalAddress.contactPersonName" default="Contact Person Name"/><span class="red">*</span>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="text" class="col-sm-11 col-xs-12" placeholder="Contact Person Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Contact Person Name'" id="contactPersonName"
                                       name="contactPersonName" value="${vendorMaster?.generalAddress?.contactPersonName}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'contactDealType','has-error')}">
                        <label for="contactDealType" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="coreBanking.accounting.vendor.generalAddress.contactDealType" default="Contact Deal Type"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="text" class="col-sm-11 col-xs-12" placeholder="Contact Deal Type" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Contact Deal Type'" id="contactDealType"
                                       name="contactDealType" value="${vendorMaster?.generalAddress?.contactDealType}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'phoneNo','has-error')}">
                        <label for="phoneNo" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="default.address.phone.label" default="Phone No"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="tel" class="col-sm-11 col-xs-12" placeholder="Phone No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Phone No'" id="phoneNo"
                                       name="phoneNo" value="${vendorMaster?.generalAddress?.phoneNo}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'websiteUrl','has-error')}">
                        <label for="websiteUrl" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="default.address.websiteUrl" default="Website URL"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="text" class="col-sm-11 col-xs-12" placeholder="Website Address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Website Address'" id="websiteUrl"
                                       name="websiteUrl" value="${vendorMaster?.generalAddress?.websiteUrl}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'addressLine1','has-error')}">
                        <label for="addressLine1" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="coreBanking.accounting.vendor.generalAddress.addressLine1" default="Address Line1"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="text" class="col-sm-11 col-xs-12" placeholder="First Address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'First Address'" id="addressLine1"
                                       name="addressLine1" value="${vendorMaster?.generalAddress?.addressLine1}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'country','has-error')}">
                        <label for="generalAddressCountry" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="default.country.label" default="Country"/><span class="red">*</span>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <g:select id="generalAddressCountry" name='country' class="col-sm-11 col-xs-12"
                                          noSelection="${['': 'Select Country...']}"
                                          from='${Country.findAllByStatus(true)}' value="${vendorMaster?.generalAddress?.country?.id}"
                                          optionKey="id" optionValue="name">
                                </g:select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'city','has-error')}">
                        <label for="city" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="default.city.label" default="City"/><span class="red">*</span>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="text" class="col-sm-11 col-xs-12" placeholder="City" onfocus="this.placeholder = ''" onblur="this.placeholder = 'City'" id="city"
                                       name="city" value="${vendorMaster?.generalAddress?.city}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'status','has-error')}">
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

                <div class="col-xs-6 col-sm-6 col-md-6">

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'contactPersonReference','has-error')}">
                        <label for="contactPersonReference" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="coreBanking.accounting.vendor.generalAddress.contactPersonReference" default="Contact Person Reference"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="text" class="col-sm-11 col-xs-12" placeholder="Contact Person Reference" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Contact Person Reference'" id="contactPersonReference"
                                       name="contactPersonReference" value="${vendorMaster?.generalAddress?.contactPersonReference}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'mobileNo','has-error')}">
                        <label for="mobileNo" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="default.address.mobile.label" default="Mobile No"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="tel" class="col-sm-11 col-xs-12" placeholder="Mobile No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Mobile No'" id="mobileNo"
                                       name="mobileNo" value="${vendorMaster?.generalAddress?.mobileNo}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'email2','has-error')}">
                        <label for="email2" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="default.address.email2" default="Second Email"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="email" class="col-sm-11 col-xs-12" placeholder="Second Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Second Email'" id="email2"
                                       name="email2" value="${vendorMaster?.generalAddress?.email2}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'faxNo','has-error')}">
                        <label for="faxNo" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="default.address.fax.label" default="Fax No"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="text" class="col-sm-11 col-xs-12" placeholder="Fax" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Fax'" id="faxNo"
                                       name="faxNo" value="${vendorMaster?.generalAddress?.faxNo}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'addressLine2','has-error')}">
                        <label for="addressLine2" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="coreBanking.accounting.vendor.generalAddress.addressLine2" default="Address Line2"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="text" class="col-sm-11 col-xs-12" placeholder="Second Address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Second Address'" id="addressLine2"
                                       name="addressLine2" value="${vendorMaster?.generalAddress?.addressLine2}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'state','has-error')}">
                        <label for="generalAddressState" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="default.state.label" default="State"/>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <g:select id="generalAddressState" name='state' class="col-sm-11 col-xs-12"
                                          noSelection="${['': 'Select State...']}"
                                          from='${vendorMaster?.generalAddress?.country != null ? State.findAllByCountry(vendorMaster?.generalAddress?.country) : State.findAllByCountry(vendorMaster?.generalAddress?.country)}'
                                          value="${vendorMaster?.generalAddress?.state?.id}"
                                          optionKey="id" optionValue="name"></g:select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: vendorGeneralAddress, field: 'postCode','has-error')}">
                        <label for="postCode" class="col-sm-4 col-xs-6 control-label no-padding-right">
                            <g:message code="default.address.postCode.label" default="Post Code"/><span class="red">*</span>
                        </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <input type="text" class="col-sm-11 col-xs-12" placeholder="Postal Code" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Postal Code'" id="postCode"
                                       name="postCode" value="${vendorMaster?.generalAddress?.postCode}"/>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>

        <div class="clearfix form-actions">
            <div class="col-md-offset-8 col-md-4">

                <g:if test='${vendorMaster?.generalAddress ?.id!=null}'>
                    <button class="btn btn-primary btn-sm" type="submit" name="updateVendorGeneralAddress" id="updateVendorGeneralAddress">Update</button>
                </g:if>
                <g:else>
                    <button class="btn btn-primary btn-sm" type="submit" name="saveVendorGeneralAddress" id="saveVendorGeneralAddress">Next</button>
                </g:else>

                %{--<button class="btn btn-primary btn-sm" type="button" name="backToBasic" id="backToBasic">Previous</button>--}%
            </div>
        </div>

    </g:form>


    %{--</div>--}%

<script type="text/javascript">
    $(".chosen-select").chosen();

    jQuery(function ($) {
        $("#generalAddressCountry").change(function () {
            var id = $(this).val();

            $.ajax
            ({
                type: "POST",
                url: "${createLink(controller: "vendor",action: "stateList")}",
                data: {country: id},
                cache: false,
                success: function (html) {
                    $("#generalAddressState").html(html);
                }
            });
        });

        $('#vendorGeneralAddressForm').validate({

            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                contactPersonName: {
                    required: true
                },
                country: {
                    required: true
                },
                city: {
                    required: true
                },
                postCode: {
                    required: true
                }
            } ,
            messages: {
                contactPersonName: {
                    required: " "
                },
                postCode: {
                    required: " "
                },
                country: {
                    required: " "
                },
                city: {
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
                    url:"${createLink(controller: 'vendor', action: 'saveVendorGeneralAddress')}",
                    type:'post',
                    data: $("#vendorGeneralAddressForm").serialize(),
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
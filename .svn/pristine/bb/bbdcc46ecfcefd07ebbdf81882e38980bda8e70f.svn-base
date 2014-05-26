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

<g:hasErrors bean="${vendorPostalAddress}">
    <div class='alert alert-success '>
        <ul>
            <g:eachError var="err" bean="${vendorPostalAddress}">
                <li><g:message error="${err}" /></li>
            </g:eachError>
        </ul>
    </div>
</g:hasErrors>
<div id="postalAddressContent">
<g:form name="vendorPostalAddressForm" id="vendorPostalAddressForm" method="post" url="[controller:'vendor', action:'saveVendorPostalAddress']" role="form" class="form-horizontal" onsubmit="return false;">
    <div class="row">
        <g:if test="${vendorMaster?.generalAddress}">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <p>
                    <input class="ace" type="checkbox"  name="genaddSame" id="genaddSame" value="1">
                    <span class="lbl">Same As General Address</span>
                </p>
            </div>
            &nbsp;
        </g:if>
        <g:hiddenField name="id" value="${vendorMaster?.id}"/>
        <g:hiddenField name="addressId" value="${vendorMaster?.postalAddress?.id}"/>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="postalForm">

            <div class="col-xs-6 col-sm-6 col-md-6">



                <div class="form-group ${hasErrors(bean: vendorPostalAddress, field: 'contactPersonName','has-error')}">
                    <label for="VendorPostalContactPersonName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.generalAddress.contactPersonName" default="Contact Person Name"/><span class="red">*</span>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Contact Person Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Contact Person Name'" id="VendorPostalContactPersonName"
                                   name="contactPersonName" value="${vendorMaster?.postalAddress?.contactPersonName}" />
                       </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: vendorPostalAddress, field: 'addressLine2','has-error')}">
                    <label for="VendorPostalAddressLine2" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.generalAddress.addressLine2" default="Address Line2"/>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <g:textArea class="col-sm-11 col-xs-12" placeholder="Second Postal Address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Second Postal Address'" id="VendorPostalAddressLine2"
                                      name="addressLine2">${vendorMaster?.postalAddress?.addressLine2}</g:textArea>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: vendorPostalAddress, field: 'state','has-error')}">
                    <label for="postalAddressState" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="default.state.label" default="State"/>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <g:select id="postalAddressState" name='state' class="col-sm-11 col-xs-12"
                                      noSelection="${['': 'Select State...']}"
                                      from='${vendorMaster?.postalAddress?.country != null ? State.findAllByCountry(vendorMaster?.postalAddress?.country): State.findAllByCountry(vendorMaster?.postalAddress?.country)}'
                                      value="${vendorMaster?.postalAddress?.state?.id}"
                                      optionKey="id" optionValue="name">
                            </g:select>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: vendorPostalAddress, field: 'postCode','has-error')}">
                    <label for="VendorPostalPostCode" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="default.address.postCode.label" default="Post Code"/><span class="red">*</span>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Postal Postcode" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Postal Postcode'" id="VendorPostalPostCode"
                                   name="postCode" value="${vendorMaster?.postalAddress?.postCode}" />
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-xs-6 col-sm-6 col-md-6">
                <div class="form-group ${hasErrors(bean: vendorPostalAddress, field: 'addressLine1','has-error')}">
                    <label for="VendorPostalAddressLine1" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.generalAddress.addressLine1" default="Address Line1"/>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <textarea class="col-sm-11 col-xs-12" placeholder="First Postal Address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'First Postal Address'" id="VendorPostalAddressLine1"
                                      name="addressLine1">${vendorMaster?.postalAddress?.addressLine1}</textarea>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: vendorPostalAddress, field: 'country','has-error')}">
                    <label for="postalAddressCountry" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="default.country.label" default="Country"/><span class="red">*</span>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <g:select id="postalAddressCountry" name='country' class="col-sm-11 col-xs-12"
                                      noSelection="${['': 'Select Country...']}"
                                      from='${Country.findAllByStatus(true)}' value="${vendorMaster?.postalAddress?.country?.id}"
                                      optionKey="id" optionValue="name">
                            </g:select>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: vendorPostalAddress, field: 'city','has-error')}">
                    <label for="VendorPostalCity" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="default.city.label" default="City"/><span class="red">*</span>
                    </label>
                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Postal City" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Postal City'" id="VendorPostalCity"
                                   name="city" value="${vendorMaster?.postalAddress?.city}"/>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: vendorPostalAddress, field: 'status','has-error')}">
                    <label for="vendorPostalStatus"
                           class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.basicInfo.status" default="Status"/>
                    </label>
                        <div class="col-sm-8 col-xs-12">
                            <div class="clearfix">
                                <select id="vendorPostalStatus" class="col-sm-11 col-xs-12" name="status">
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

        </div>
    </div>

    <div class="clearfix form-actions">
        <div class="col-md-offset-10 col-md-2">
            <g:if test='${vendorMaster?.postalAddress?.id!=null}'>
                <button class="btn btn-primary btn-sm" type="submit" name="updateVendorPostalAddress" id="updateVendorPostalAddress">Update</button>
            </g:if>
            <g:else>
                <button class="btn btn-primary btn-sm" type="submit" name="saveVendorPostalAddress" id="saveVendorPostalAddress">Next</button>
            </g:else>
        </div>
    </div>

</g:form>
</div>

<script type="text/javascript">
    $(".chosen-select").chosen();

    jQuery(function ($) {
        $('#genaddSame').attr('checked', false).change(function () {
            if (this.checked) {
                $('#VendorPostalContactPersonName').val('${vendorMaster?.generalAddress?.contactPersonName}');
                $('#VendorPostalAddressLine2').val('${vendorMaster?.generalAddress?.addressLine2}');
                $('#VendorPostalAddressLine1').val('${vendorMaster?.generalAddress?.addressLine1}');
                $('#postalAddressCountry').val('${vendorMaster?.generalAddress?.country?.id}');

                var stateid = '${vendorMaster?.generalAddress?.state?.id}';
                var statename = '${vendorMaster?.generalAddress?.state?.name}';
                $('#postalAddressState').find("option").remove();
                // Create option
                var $option = $("<option />");
                // Add value and text to option
                $option.attr("value", stateid).text(statename);
                // Add option to drop down list
                $('#postalAddressState').append($option);


                $('#VendorPostalPostCode').val('${vendorMaster?.generalAddress?.postCode}');
                $('#VendorPostalCity').val('${vendorMaster?.generalAddress?.city}');

                $('#VendorPostalContactPersonName').attr('disabled', true);
                $('#VendorPostalAddressLine2').attr('disabled', true);
                $('#VendorPostalAddressLine1').attr('disabled', true);
                $('#postalAddressCountry').attr('disabled', true);
                $('#postalAddressState').attr('disabled', true);
                $('#VendorPostalPostCode').attr('disabled', true);
                $('#VendorPostalCity').attr('disabled', true);
                $('#vendorPostalStatus').attr('disabled', true);

            }else{
                $('#VendorPostalContactPersonName').attr('disabled', false);
                $('#VendorPostalAddressLine2').attr('disabled', false);
                $('#VendorPostalAddressLine1').attr('disabled', false);
                $('#postalAddressCountry').attr('disabled', false);
                $('#postalAddressState').attr('disabled', false);
                $('#VendorPostalPostCode').attr('disabled', false);
                $('#VendorPostalCity').attr('disabled', false);
                $('#vendorPostalStatus').attr('disabled', false);

                $('#VendorPostalContactPersonName').val('');
                $('#VendorPostalAddressLine2').val('');
                $('#VendorPostalAddressLine1').val('');
                $('#postalAddressCountry').val('');
                $('#postalAddressState').val('');

                $('#VendorPostalPostCode').val('');
                $('#VendorPostalCity').val('');
            }
        });

        $("#postalAddressCountry").change(function () {
            var id = $(this).val();

            $.ajax
            ({
                type: "POST",
                url: "${createLink(controller: "vendor",action: "stateList")}",
                data: {country: id},
                cache: false,
                success: function (html) {
                    $("#postalAddressState").html(html);
                }
            });
        });

        $('#vendorPostalAddressForm').validate({

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
                    url:"${createLink(controller: 'vendor', action: 'saveVendorPostalAddress')}",
                    type:'post',
                    data: $("#vendorPostalAddressForm").serialize(),
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
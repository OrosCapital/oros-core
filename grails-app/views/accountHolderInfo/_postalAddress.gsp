<%@ page import="com.gsl.oros.core.banking.settings.State; com.gsl.oros.core.banking.settings.Country" %>
<html>
<head></head>

<body>
<g:if test="${accountHolder?.generalAddress}">
<p>
    <input class="ace" type="checkbox" name="payType" id="accSame" value="1">
    <span class="lbl">Same As Contact Address</span>
</p>
&nbsp;
</g:if>
<g:form name="AccountHolderPostalAddressForm" id="AccountHolderPostalAddressForm" method="post" role="form"
        class="form-horizontal" url="[action: 'savePostalAddress', controller: 'accountHolderInfo']">

    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

            <div class="col-xs-6 col-sm-6 col-md-6">
                <g:hiddenField name="id" value="${accountHolder?.id}"/>
                <g:hiddenField name="addressId" value="${accountHolder?.postalAddress?.id}"/>

                <div class="form-group">
                    <label for="accholderContactPersonName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.generalAddress.contactPersonName"
                                   default="Contact Person Name"/><span class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Contact Person Name"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Contact Person Name'"
                                   id="accholderContactPersonName"
                                   name="contactPersonName" value="${accountHolder?.postalAddress?.contactPersonName}">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="accholderAddressLine2" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.generalAddress.addressLine2"
                                   default="Address Line2"/>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <textarea class="col-sm-11 col-xs-12" placeholder="Second Postal Address"
                                      onfocus="this.placeholder = ''"
                                      onblur="this.placeholder = 'Second Postal Address'" id="accholderAddressLine2"
                                      name="addressLine2">${accountHolder?.postalAddress?.addressLine2}</textarea>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="accholderPostalAddressState" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="default.state.label" default="State"/>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <g:select id="accholderPostalAddressState" name='state' class="col-sm-11 col-xs-12"
                                      noSelection="${['': 'Select State...']}"
                                      from='${accountHolder?.postalAddress?.country != null ? State.findAllByCountry(accountHolder?.postalAddress?.country) : State.findAllByCountry(accountHolder?.postalAddress?.country)}'
                                      value="${accountHolder?.postalAddress?.state?.id}"
                                      optionKey="id" optionValue="name">
                            </g:select>

                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="accholderPostCode" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="default.address.postCode.label" default="Post Code"/><span class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Postal Postcode"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Postal Postcode'"
                                   id="accholderPostCode"
                                   name="postCode" value="${accountHolder?.postalAddress?.postCode}">
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-xs-6 col-sm-6 col-md-6">

                <div class="form-group">
                    <label for="accholderAddressLine1" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.generalAddress.addressLine1"
                                   default="Address Line1"/>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <textarea class="col-sm-11 col-xs-12" placeholder="First Postal Address"
                                      onfocus="this.placeholder = ''" onblur="this.placeholder = 'First Postal Address'"
                                      id="accholderAddressLine1"
                                      name="addressLine1">${accountHolder?.postalAddress?.addressLine1}</textarea>
                        </div>
                    </div>
                </div>

                <div class="form-group ">
                    <label for="accholderPostalAddressCountry"
                           class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="default.country.label" default="Country"/><span class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <g:select id="accholderPostalAddressCountry" name='country' class="col-sm-11 col-xs-12"
                                      noSelection="${['': 'Select Country...']}"
                                      from='${Country.findAllByStatus(true)}' value="${accountHolder?.postalAddress?.country?.id}"
                                      optionKey="id" optionValue="name">
                            </g:select>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="accholderCity" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="default.city.label" default="City"/><span class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Postal City"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Postal City'"
                                   id="accholderCity"
                                   name="city" value="${accountHolder?.postalAddress?.city}">
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <label for="accholderStatus" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.basicInfo.status" default="Status"/>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <select id="accholderStatus" class="col-sm-11 col-xs-12" name="status">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>

    <div class="clearfix form-actions">
        <div class="col-md-offset-10 col-md-2">
            <g:if test='${accountHolder?.postalAddress?.id != null}'>
                <button class="btn btn-primary btn-sm" type="submit" name="updateAccountHolderPostalAddress"
                        id="updateAccountHolderPostalAddress">Update</button>
            </g:if>
            <g:else>
                <button class="btn btn-primary btn-sm" type="submit" name="saveAccountHolderPostalAddress"
                        id="saveAccountHolderPostalAddress">Next</button>
            </g:else>
        </div>
    </div>
</g:form>

<script type="text/javascript">

    $('#accSame').attr('checked', false).change(function () {
        if (this.checked) {
            $('#accholderContactPersonName').val('${accountHolder?.generalAddress?.contactPersonName}');
            $('#accholderAddressLine2').val('${accountHolder?.generalAddress?.addressLine2}');
            $('#accholderAddressLine1').val('${accountHolder?.generalAddress?.addressLine1}');
            $('#accholderPostalAddressCountry').val('${accountHolder?.generalAddress?.country?.id}');
            var stateid = '${accountHolder?.generalAddress?.state?.id}';
            var statename = '${accountHolder?.generalAddress?.state?.name}';
            $('#accholderPostalAddressState').find("option").remove();
            // Create option
            var $option = $("<option />");
            // Add value and text to option
            $option.attr("value", stateid).text(statename);
            // Add option to drop down list
            $('#accholderPostalAddressState').append($option);

            $('#accholderPostCode').val('${accountHolder?.generalAddress?.postCode}');
            $('#accholderCity').val('${accountHolder?.generalAddress?.city}');

            $('#accholderContactPersonName').attr('disabled', true);
            $('#accholderAddressLine2').attr('disabled', true);
            $('#accholderAddressLine1').attr('disabled', true);
            $('#accholderPostalAddressCountry').attr('disabled', true);
            $('#accholderPostalAddressState').attr('disabled', true);
            $('#accholderPostCode').attr('disabled', true);
            $('#accholderCity').attr('disabled', true);
            $('#accholderStatus').attr('disabled', true);
        }else{
            $('#accholderContactPersonName').val('');
            $('#accholderAddressLine2').val('');
            $('#accholderAddressLine1').val('');
            $('#accholderPostalAddressCountry').val('');
            $('#accholderPostalAddressState').val('');
            $('#accholderPostCode').val('');
            $('#accholderCity').val('');

            $('#accholderContactPersonName').attr('disabled', false);
            $('#accholderAddressLine2').attr('disabled', false);
            $('#accholderAddressLine1').attr('disabled', false);
            $('#accholderPostalAddressCountry').attr('disabled', false);
            $('#accholderPostalAddressState').attr('disabled', false);
            $('#accholderPostCode').attr('disabled', false);
            $('#accholderCity').attr('disabled', false);
            $('#accholderStatus').attr('disabled', false);
        }
    });


    $("#accountHolderPostalAddressCountry").change(function () {
        var id = $(this).val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: "accountHolderInfo",action: "stateList")}",
            data: {country: id},
            cache: false,
            success: function (html) {
                $("#accpostalAddressState").html(html);
            }
        });
    });

    $('#AccountHolderPostalAddressForm').validate({

        errorElement: 'div',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            contactPersonName: {
                required: true
            },
            postCode: {
                required: true
            },
            city: {
                required: true
            },
            country: {
                required: true

            }
        },

        messages: {
            contactPersonName: {
                required: " "
            },
            postCode: {
                required: " "
            },
            city: {
                required: " "
            },
            country: {
                required: " "

            }
        },
        invalidHandler: function (event, validator) { //display error alert on form submit
            $('.alert-danger', $('.loginForm')).show();
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
            else if (element.is('.select2')) {
                error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
            }
            else if (element.is('.chosen-select')) {
                error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
            }
            else error.insertAfter(element.parent());
        },
        submitHandler: function (form) {
            $.ajax({
                url: "${createLink(controller: 'accountHolderInfo', action: 'savePostalAddress')}",
                type: 'post',
                data: $("#AccountHolderPostalAddressForm").serialize(),
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


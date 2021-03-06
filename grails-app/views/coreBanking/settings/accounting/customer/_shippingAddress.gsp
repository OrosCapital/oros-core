<%@ page import="com.gsl.oros.core.banking.settings.State; com.gsl.oros.core.banking.settings.Country" %>
<g:form name="customerShippingAddressForm" id="customerShippingAddressForm" method="post" role="form" class="form-inline" onSubmit="return false;">

    <g:hiddenField name="customerId" id="customerId" value="${customerMaster?.id}"/>
    <g:hiddenField name="generalAddressId" id="generalAddressId" value="${generalAddress?.id}"/>
    <g:hiddenField name="postalAddressId" id="postalAddressId" value="${postalAddress?.id}"/>
    <g:hiddenField name="id" id="id" value="${shippingAddress?.id}"/>
    <g:hiddenField name="bankAccountId" id="bankAccountId" value="${savedBankAccount?.id}"/>

    <div class="clearfix">
        <div class="form-group">
            <input type="checkbox" name="likePostalAddress" id="likePostalAddress" class="pull-left">
            <label for="likePostalAddress" class="pull-left">As like postal address</label>
        </div>
    </div>

    <div class="form-group ${hasErrors(bean:addressCommand,field:'addressLine2','has-error')}">
        <label for="contactPersonName">Contact Person Name*</label>
        <input type="text" placeholder="Enter Contact Name"
               id="contactPersonName" name="contactPersonName" value="${shippingAddress?.contactPersonName}">
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'addressLine1','has-error')}">
        <label for="addressLine1">Address Line1</label>
        <g:textArea name="addressLine1" id="addressLine1" placeholder="Address Line1" value="${shippingAddress?.addressLine1}" />
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'addressLine2','has-error')}">
        <label for="addressLine2">Address Line2</label>
        <g:textArea name="addressLine2" id="addressLine2" placeholder="Address Line2" value="${shippingAddress?.addressLine2}" />
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'phoneNo','has-error')}">
        <label for="phoneNo">Phone No1</label>
        <input type="text" placeholder="Enter Phone No1"
               id="phoneNo" name="phoneNo" value="${shippingAddress?.phoneNo}">
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'phoneNo2','has-error')}">
        <label for="phoneNo2">Phone No2</label>
        <input type="text" placeholder="Enter Phone No2"
               id="phoneNo2" name="phoneNo2" value="${shippingAddress?.phoneNo2}">
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'faxNo','has-error')}">
        <label for="faxNo">Fax</label>
        <input type="text" placeholder="Enter Fax"
               id="faxNo" name="faxNo" value="${shippingAddress?.faxNo}">
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'email1','has-error')}">
        <label for="email1">Email</label>
        <input type="email" placeholder="Enter Email"
               id="email1" name="email1" value="${shippingAddress?.email1}">
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'websiteUrl','has-error')}">
        <label for="websiteUrl">Website</label>
        <input type="text" placeholder="Enter Website"
               id="websiteUrl" name="websiteUrl" value="${shippingAddress?.websiteUrl}">
    </div>

    <div class="form-group ${hasErrors(bean:addressCommand,field:'country','has-error')}">
        <label for="country">Country*</label>
        <g:select id="shippingAddCountry" name='country'
                  noSelection="${['': 'Select Country...']}"
                  from='${Country.findAllByStatus(true)}'
                  value="${shippingAddress?.country?.id}"
                  optionKey="id" optionValue="name">
        </g:select>
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'state','has-error')}">
        <label for="state">State*</label>
        <g:select id="shippingState" name='state'
                  noSelection="${['': 'Select State...']}"
                  from='${shippingAddress?.country != null ? State.findAllByCountry(shippingAddress?.country) : State.findAllByCountry(shippingAddress?.country)}'
                  value="${shippingAddress?.state?.id}"
                  optionKey="id" optionValue="name">
        </g:select>
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'city','has-error')}">
        <label for="city">City*</label>
        <input type="text" placeholder="Enter City"
               id="city" name="city" value="${shippingAddress?.city}">
    </div>
    <div class="form-group ${hasErrors(bean:addressCommand,field:'postCode','has-error')}">
        <label for="postCode">Post Code*</label>
        <input type="text" placeholder="Enter Post Code"
               id="postCode" name="postCode" value="${shippingAddress?.postCode}">
    </div>

%{--<div class="form-group ${hasErrors(bean:addressCommand,field:'note','has-error')}">--}%
%{--<label for="note">Note*</label>--}%
%{--<g:textArea name="note" id="note" placeholder="Note" value="${shippingAddress?.note}" />--}%
%{--</div>--}%
    <div class="form-group ${hasErrors(bean:addressCommand,field:'status','has-error')}">
        <label for="status">Status</label>
        <select name="status" id="status">
            <option value="1" ${shippingAddress?.status == 1 ? 'selected' : ''}>Active</option>
            <option value="0" ${shippingAddress?.status == 0 ? 'selected' : ''}>Inactive</option>
        </select>
    </div>

    <div class="clearfix form-actions align-right">
        <g:if test="${shippingAddress?.id}">
            <button type="submit" id="basicSubmit" class="btn btn-info">
                <i class="icon-ok bigger-110"></i>Update</button>
        </g:if>
        <g:else>
            <button type="submit" id="basicSubmit" class="btn btn-info">
                <i class="icon-ok bigger-110"></i>Create</button>
        </g:else>
    </div>
</g:form>

<script type="text/javascript">
    $(".chosen-select").chosen();
    $(document).ready(function () {
        $('#likePostalAddress').change(function() {
            if($(this).is(":checked")) {
                $('#customerShippingAddressForm :input#contactPersonName').val('${postalAddress?.contactPersonName}');
                $('#customerShippingAddressForm :input#addressLine1').val('${postalAddress?.addressLine1}');
                $('#customerShippingAddressForm :input#addressLine2').val('${postalAddress?.addressLine2}');
                $('#customerShippingAddressForm :input#shippingAddCountry').val('${postalAddress?.country?.id}');
                $('#customerShippingAddressForm :input#shippingState').val('${postalAddress?.state?.id}');
                $('#customerShippingAddressForm :input#city').val('${postalAddress?.city}');
                $('#customerShippingAddressForm :input#postCode').val('${postalAddress?.postCode}');
            } else{
                $('#customerShippingAddressForm :input#contactPersonName').val('${shippingAddress?.contactPersonName}');
                $('#customerShippingAddressForm :input#addressLine1').val('${shippingAddress?.addressLine1}');
                $('#customerShippingAddressForm :input#addressLine2').val('${shippingAddress?.addressLine2}');
                $('#customerShippingAddressForm :input#shippingAddCountry').val('${shippingAddress?.country?.id}');
                $('#customerShippingAddressForm :input#shippingState').val('${shippingAddress?.state?.id}');
                $('#customerShippingAddressForm :input#city').val('${shippingAddress?.city}');
                $('#customerShippingAddressForm :input#postCode').val('${shippingAddress?.postCode}');
            }
        });
    });
    $("#shippingAddCountry").change(function () {
        var id = $(this).val();
        $.ajax
        ({
            type: "POST",
            url: "${createLink(controller: "customer",action: "stateList")}",
            data: {country: id},
            cache: false,
            success: function (html) {
                $("#shippingState").html(html);
            }
        });
    });
</script>

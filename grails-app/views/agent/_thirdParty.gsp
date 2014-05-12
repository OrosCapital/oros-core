<head>  <%@ page import="com.gsl.oros.core.banking.settings.Country" %></head>
<body>
<p>
    <input class="ace" type="checkbox"  name="payType" id="cash" value="1">
    <span class="lbl"> <g:message code="agent.thirdParty.label.checkbox1" default="Same As Personal Info"/></span>

    <input type="checkbox" class="ace" name="payType" id="cheque" value="2">
    <span class="lbl"><g:message code="agent.thirdParty.label.checkbox2" default="Different From Personal Info"/></span>
</p>
&nbsp;
<div id="thirdPartyContent">
<g:form name="AgentThirdPartyForm" id="AgentThirdPartyForm" method="post" role="form" class="form-horizontal" url="[action: 'saveThirdParty', controller: 'agent']">
    <g:hiddenField name="id" value="${personalInfo?.id}"/>
    <g:hiddenField name="thirdid" value="${thirdParty?.id}"/>
    <div class="row">
         <div class="col-md-12">

        <div class="col-md-6">

            <div class="form-group">
                <label for="name" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.name" default="Contact Name"/>
                    <span class="red">*</span>
                </label>
               <div class="col-sm-7 col-xs-10">
                   %{--<input type="text" class="col-sm-11 col-xs-12" placeholder="Contact Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Contact Name'" id="name" name="name" value="${fieldValue(bean:thirdParty,field:'name')}">--}%
                   <g:textField name="name" id="name" placeholder="Contact Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Contact Name'" class="form-control" value="${fieldValue(bean:thirdParty,field:'name')}"/>
               </div>
            </div>

            <div class="form-group">
                <label for="role" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.role" default="Role"/>
                </label>
               <div class="col-sm-7 col-xs-10">
                   %{--<input type="text" class="col-sm-11 col-xs-12" placeholder="Role" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Role'" id="role" name="role" value="${fieldValue(bean:thirdParty,field:'role')}">--}%
                   <g:textField name="role" id="role" placeholder="Role" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Role'" class="form-control" value="${fieldValue(bean:thirdParty,field:'role')}"/>
               </div>
            </div>

            <div class="form-group">
                <label for="address" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.address" default="Address"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text"  class="col-sm-11 col-xs-12" placeholder="Address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Address'" id="address" name="address" value="${fieldValue(bean:thirdParty,field:'address')}">--}%
                    <g:textArea name="address" id="address" placeholder="Address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Address'" class="form-control" value="${fieldValue(bean:thirdParty,field:'address')}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="nationality3" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.nationality3" default="Nationality"/>
                    <span class="red">*</span></label>

                <div class="col-sm-7 col-xs-10">
                    <g:select id="nationality3" name='nationality3' class=" width-140 form-control"
                              noSelection="${['': 'Select Country...']}"
                              from='${Country.findAllByStatus(true)}'
                              value="${thirdParty?.nationality3?.id}"
                              optionKey="id" optionValue="name"></g:select>
                </div>
                </div>

            <div class="form-group">
                <label for="firm" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.firm" default="Name of Firm"/>

                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-11 col-xs-12" placeholder="Name of Firm" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Name of Firm'" id="firm" name="firm" value="${fieldValue(bean:thirdParty,field:'firm')}">--}%
                    <g:textField name="firm" id="firm" placeholder="Name of Firm" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Name of Firm'" class="form-control" value="${fieldValue(bean:thirdParty,field:'firm')}"/>
                </div>
            </div>




            <div class="form-group">
                <label for="nationalID2" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.nationalID2" default="National ID"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-11 col-xs-12" placeholder="National Identification No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'National Identification No'" id="nationalID2"--}%
                       %{--name="nationalID2" value="${fieldValue(bean:thirdParty,field:'nationalID2')}">--}%
                    <g:textField name="nationalID2" id="nationalID2" placeholder="National Identification No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'National Identification No'" class="form-control" value="${fieldValue(bean:thirdParty,field:'nationalID2')}"/>
                </div>
            </div>
    </div>
    <div class="col-md-6">
            <div class="form-group">
                <label for="countryofBirth2"
                       class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.countryofBirth2" default="Country of Birth"/>

                    <span class="red">*</span></label>

                <div class="col-sm-7 col-xs-10">
                    <g:select id="countryofBirth2" name='countryofBirth2' class=" width-140 form-control"
                                                          noSelection="${['': 'Select Country...']}"
                                                          from='${Country.list(sort: 'id')}'
                                                          value="${thirdParty?.countryofBirth2?.id}"

                                                          optionKey="id" optionValue="name"></g:select>
                </div>
            </div>



            <div class="form-group">
                <label for="email2" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.email2" default="Email"/>

                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-11 col-xs-12" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'" id="email2"--}%
                       %{--name="email2" value="${fieldValue(bean:thirdParty,field:'email2')}">--}%
                    <g:textField name="email2" id="email2" placeholder="Email" class="form-control" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'" value="${fieldValue(bean:thirdParty,field:'email2')}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="phone2" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.phone2" default="Phone No"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-11 col-xs-12" placeholder="Phone No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Phone No'" id="phone2"--}%
                       %{--name="phone2" value="${fieldValue(bean:thirdParty,field:'phone2')}">--}%
                    <g:textField name="phone2" id="phone2" placeholder="Phone No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Phone No'" class="form-control" value="${fieldValue(bean:thirdParty,field:'phone2')}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="postCode2" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.postCode2" default=" Post Code"/>

                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-11 col-xs-12" placeholder="Post Code" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Post Code'" id="postCode2"--}%
                       %{--name="postCode2" value="${fieldValue(bean:thirdParty,field:'postCode2')}">--}%
                    <g:textField name="postCode2" id="postCode2" placeholder="Post Code" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Post Code'" class="form-control" value="${fieldValue(bean:thirdParty,field:'postCode2')}"/>
                </div>
            </div>




            <div class="form-group">
                <label for="residency" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.thirdParty.label.residency" default=" Residency for Tax Purposes"/>

                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-11 col-xs-12" placeholder="Residency for Tax Purposes" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Residency for Tax Purposes'" id="residency"--}%
                       %{--name="residency" value="${fieldValue(bean:thirdParty,field:'residency')}">--}%
                    <g:textField name="residency" id="residency" placeholder="Residency for Tax Purposes" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Residency for Tax Purposes'" class="form-control" value="${fieldValue(bean:thirdParty,field:'residency')}"/>
                </div>
            </div>

        </div>

    </div>
  </div>


<div class="clearfix form-actions">
    <div class="col-md-offset-10 col-md-2">

        <g:if test='${thirdParty?.id!=null}'>
            <button class="btn btn-primary btn-sm" type="submit" name="updateThirdParty" id="updateThirdParty">Update</button>
        </g:if>
        <g:else>
            <button class="btn btn-primary btn-sm" type="submit" name="saveThirdParty" id="saveThirdParty">Next</button>
        </g:else>


    </div>
</div>
</g:form>
</div>
<script type="text/javascript">
    $('#cash').attr('checked', false).change(function () {
    if (this.checked) {
        $("#cheque").prop({ checked: false });
        $('#name').val('${personalInfo?.firstName}');
        $('#address').val('${residentialAddress?.addressLine1}');
        $('#postCode2').val('${residentialAddress?.postCode}');
        $('#email2').val('${contactAddress?.email1}');
        $('#phone2').val('${contactAddress?.phoneNo}');
        $('#countryofBirth2').val('${personalInfo?.countryofBirth?.id}');
        $('#nationality3').val('${personalInfo?.nationality?.id}');
        $('#nationalID2').val('${personalInfo?.nationalID}');
        $('#residency').val('${additionalDetail?.residencyTax}');

        $('#thirdPartyContent').show();


    }
});
$('#cheque').attr('checked', false).change(function () {
    if (this.checked) {
        $("#cash").prop({ checked: false });
        $('#name').val('');
        $('#address').val('');
        $('#postCode2').val('');
        $('#email2').val('');
        $('#phone2').val('');
        $('#countryofBirth2').val('');
        $('#nationality3').val('');
        $('#nationalID2').val('');
        $('#residency').val('');

        $('#thirdPartyContent').show();


    }
});
    $('#AgentThirdPartyForm').validate({

        errorElement: 'div',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            name: {
                required: true

            },
            role: {
                required: false

            },
            address: {
                required: false

            },
            firm: {
                required: false

            },
            nationality3: {
                required: true

            },
            nationalID2: {
                required: false

            },
            countryofBirth2: {
                required: true

            },
            email2: {
                required: false

            },
            phone2: {
                required: false

            },
            postCode2: {
                required: false

            },
            residency: {
                required: false

            }
        } ,
        messages: {
            name: {
                required: " "

            },
            role: {
                required: "Please provide your role"

            },
            address: {
                required: "Please provide your address"

            },
            firm: {
                required: "Please provide your firm name"

            },
            nationality3: {
                required: " "

            },
            nationalID2: {
                required: "Please provide your national id"

            },
            countryofBirth2: {
                required: " "

            },
            email2: {
                required: "Please provide your email"

            },
            phone2: {
                required: "Please provide your phone no."

            },
            postCode2: {
                required: "Please provide your post code"

            },
            residency: {
                required: "Please provide your residency"

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
        submitHandler: function (form) {
            $.ajax({
                url:"${createLink(controller: 'agent', action: 'saveThirdParty')}",
                type:'post',
                data: $("#AgentThirdPartyForm").serialize(),
                success:function(data){
                    $('#page-content').html(data);
                },
                failure:function(data){
                }
            })

        }



    });

</script>
</body>


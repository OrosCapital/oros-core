<html>
<head>
    <%@ page import="com.gsl.cbs.contraints.enums.MaritialStatus; com.gsl.cbs.contraints.enums.GenderType; com.gsl.oros.core.banking.settings.Country" %>


</head>


<body>


<g:form name="agentPersonalInfoForm" id="agentPersonalInfoForm" method="post" role="form" class="form-horizontal" url="[action: 'savePersonalInfo', controller: 'agent']">
    <g:hiddenField name="id" value="${personalInfo?.id}"/>
<div class="row">
    <div class="col-md-12">
    <div class="col-md-6">
            <div class="form-group">
                <label for="firstName" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.personalInfo.label.firstName" default="First Name"/><span class="red">*</span>
                </label>

                <div class="col-sm-7 col-xs-10">
                    <g:textField name="firstName" id="firstName" placeholder="Please insert min 3 characters" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Please insert min 3 characters'" class="form-control" value="${fieldValue(bean:personalInfo,field:'firstName')}"/>
            </div>

            </div>

            <div class="form-group">
                <label for="middleName" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.personalInfo.label.middleName" default="Middle Name"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    <g:textField name="middleName" id="middleName" placeholder="Please insert min 3 characters" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Please insert min 3 characters'" class="form-control" value="${fieldValue(bean:personalInfo,field:'middleName')}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="lastName" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.personalInfo.label.lastName" default="Last Name"/><span class="red">*</span>
                </label>
                <div class="col-sm-7 col-xs-10">
                    <g:textField name="lastName" id="lastName" placeholder="Please insert min 3 characters" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Please insert min 3 characters'" class="form-control" value="${fieldValue(bean:personalInfo,field:'lastName')}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="gender" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.personalInfo.label.gender" default="Gender"/>
                    <span class="red">*</span>
                </label>

                   <div class="col-sm-7 col-xs-10">
                           <g:select name="gender" id="gender" class="chosen-select form-control"
                                     noSelection="['': 'Choose Gender']"
                                     from="${GenderType.values()}"
                                     value="${personalInfo?.gender}"
                                     optionKey="value" optionValue="value"/>

                   </div>
            </div>
            <div class="form-group">

                 <label for="dateOfBirth" class="col-sm-5 col-xs-8 control-label"><g:message code="agent.personalInfo.label.dateOfBirth" default="Date of Birth"/></label>
                <div class='input-append date input-group' id="dateOfBirth">
                    <input type="date" name="dateOfBirth" class="form-control datepicker " data-date-format="dd-mm-yyyy" value="${personalInfo?.dateOfBirth?.format("dd/MM/yyyy")}"/>
                    <span class="input-group-addon add-on"><i class="icon-calendar"></i></span>
                </div>
            </div>

            <div class="form-group">
                <label for="maritalStatus"
                       class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.personalInfo.label.maritalStatus" default="Marital Status"/>
                </label>

               <div class="col-sm-7 col-xs-10">
                       <g:select name="maritalStatus" id="maritalStatus" class="chosen-select"
                                 noSelection="['': 'Choose your marital status']"
                                 from="${MaritialStatus.values()}"
                                 value="${personalInfo?.maritalStatus}"
                                 optionKey="value" optionValue="value"/>
                    </div>

            </div>
        </div>


        <div class="col-md-6">
            <div class="form-group">
                <label for="nationality" class="col-sm-5 col-xs-8 control-label no-padding-right">
                    <g:message code="agent.personalInfo.label.nationality" default="Nationality"/>
                    <span class="red">*</span>
                </label>

                <div class="col-sm-7 col-xs-10">
                    <div class="clearfix">
                        <g:select id="nationality" name='nationality' class="chosen-select width-140 form-control"
                                  noSelection="${['': 'Select Country...']}"
                                  from='${Country.findAllByStatus(true)}'
                                  value="${personalInfo?.nationality?.id}"
                                  optionKey="id" optionValue="name"/>
                    </div>
                </div>

            </div>

        <div class="form-group">
            <label for="nationality2" class="col-sm-5 col-xs-8 control-label">
                <g:message code="agent.personalInfo.label.nationality2" default="Second Nationality"/>
            </label>

            <div class="col-sm-7 col-xs-10">

                <g:select id="nationality2" name='nationality2' class="chosen-select width-140 form-control"
                          noSelection="${['': 'Select Country...']}"
                          from='${Country.list(sort: 'id')}'
                          value="${personalInfo?.nationality2?.id}"
                          optionKey="id" optionValue="name"/>

            </div>
        </div>
        <div class="form-group">
            <label for="countryofBirth"
                   class="col-sm-5 col-xs-8 control-label">
                <g:message code="agent.personalInfo.label.countryofBirth" default="Country of Birth"/>
                <span class="red">*</span>
            </label>

            <div class="col-sm-7 col-xs-10">

                <g:select id="countryofBirth" name='countryofBirth' class="chosen-select width-140 form-control"
                          noSelection="${['': 'Select Country...']}"
                          from='${Country.list(sort: 'id')}'
                          value="${personalInfo?.countryofBirth?.id}"
                          optionKey="id" optionValue="name"/>

            </div> <div>
        </div>
        </div>

            <div class="form-group">
                <label for="nationalID" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.personalInfo.label.nationalID" default="National ID"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    <g:textField name="nationalID" id="nationalID" placeholder="National Identification No" class="form-control" onfocus="this.placeholder = ''" onblur="this.placeholder = 'National Identification No'" value="${fieldValue(bean:personalInfo,field:'nationalID')}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="profession" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.personalInfo.label.profession" default="Profession"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    <g:textField name="profession" id="profession" placeholder="Profession" class="form-control" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Profession'" value="${fieldValue(bean:personalInfo,field:'profession')}"/>
                </div>
            </div>


        </div>

    </div>
</div>

<div class="clearfix form-actions">
    <div class="col-md-offset-10 col-md-2">

        <g:if test='${personalInfo?.id!=null}'>
            <button class="btn btn-primary btn-sm" type="submit" name="updatePersonalInfo" id="updatePersonalInfo">
                <g:message code="default.button.update.label" default="Update"/></button>
        </g:if>
        <g:else>
            <button class="btn btn-primary btn-sm" type="submit" name="savePersonalInfo" id="savePersonalInfo">
                <g:message code="default.button.next.label" default="Next"/></button>
        </g:else>

    </div>
</div>

</g:form>




<script type="text/javascript">

    jQuery(function ($) {
        var dateFormat = "${dateFormat}";
        var dateMask = "${dateMask}" ;
        $(".datepicker").inputmask(dateMask);

        $("#dateOfBirth").datepicker({
            format: dateFormat
        }).on('changeDate', function (ev) {
                    $(this).datepicker('hide');
                });


        $('#agentPersonalInfoForm').validate({

        errorElement: 'div',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            firstName: {
                required: true,
                minlength:3


            },
            lastName: {
                required: true,
                minlength:3


            },
            nationalID: {
                required: false

            },
            profession: {
                required: false

            },
            middleName: {
                required: false

            },
            gender: {
                required: true

            },
            maritalStatus: {
                required: false

            },
            nationality: {
                required: true

            },
            nationality2: {
                required: false

            },
            countryofBirth: {
                required: true

            },
            dateOfBirth: {
                required: false

            }


        },

        messages: {
            firstName: {
                required: " ",
                minlength:" "

            },
            lastName: {
                required: " " ,
                minlength:" "

            },
            middleName: {
                required: " "

            },
            nationalID: {
                required: " "

            },
            profession: {
                required: " "

            },
            gender: {
                required: " "

            } ,
            maritalStatus: {
                required: " "

            },
            nationality: {
                required: " "

            },
            nationality2: {
                required: ""

            },
            countryofBirth: {
                required: " "

            }

        },
        errorPlacement: function(error, element){
            return true
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
                url:"${createLink(controller: 'agent', action: 'savePersonalInfo')}",
                type:'post',
                data: $("#agentPersonalInfoForm").serialize(),
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
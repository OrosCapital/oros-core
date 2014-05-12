<head></head>
<body>

<g:form name="AgentAdditionalDetailForm" id="AgentAdditionalDetailForm" method="post" role="form" class="form-horizontal" url="[action: 'saveAdditionalDetail', controller: 'agent']">
    <g:hiddenField name="id" value="${personalInfo?.id}"/>
    <g:hiddenField name="addid" value="${additionalDetail?.id}"/>
    <div class="row">


        <div class="col-md-6">

            <div class="form-group">
                <label for="residencyTax" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.additionalDetail.label.residencyTax" default="Residency for Tax Purposes"/></label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-7 col-xs-10" placeholder="Residency for Tax Purposes" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Residency for Tax Purposes'" id="residencyTax"--}%
                       %{--name="residencyTax" value="${fieldValue(bean:additionalDetail,field:'residencyTax')}">--}%
                    <g:textField name="residencyTax" id="residencyTax" placeholder="Residency for Tax Purposes"  onfocus="this.placeholder = ''" onblur="this.placeholder = 'Residency for Tax Purposes'" class="form-control" value="${fieldValue(bean:additionalDetail,field:'residencyTax')}"/>
                </div>
            </div>



            <div class="form-group">
                <label for="domicile" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.additionalDetail.label.domicile" default="Domicile"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-7 col-xs-10" placeholder="Domicile" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Domicile'" id="domicile"--}%
                       %{--name="domicile" value="${fieldValue(bean:additionalDetail,field:'domicile')}">--}%
                    <g:textField name="domicile" id="domicile" placeholder="Domicile" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Domicile'" class="form-control" value="${fieldValue(bean:additionalDetail,field:'domicile')}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="incomeTax" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.additionalDetail.label.incomeTax" default="Income Tax Rate"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-7 col-xs-10" placeholder="Income Tax Rate" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Income Tax Rate'" id="incomeTax"--}%
                       %{--name="incomeTax" value="${fieldValue(bean:additionalDetail,field:'incomeTax')}">--}%
                    <g:textField name="incomeTax" id="incomeTax" class="form-control"  placeholder="Income Tax Rate" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Income Tax Rate'" value="${fieldValue(bean:additionalDetail,field:'incomeTax')}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="insurenceNo" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.additionalDetail.label.insurenceNo" default="National Insurance Number"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-7 col-xs-10" placeholder="National Insurance Number" onfocus="this.placeholder = ''" onblur="this.placeholder = 'National Insurance Number'" id="insurenceNo"--}%
                       %{--name="insurenceNo" value="${fieldValue(bean:additionalDetail,field:'insurenceNo')}">--}%
                    <g:textField name="insurenceNo" id="insurenceNo" placeholder="National Insurance Number" onfocus="this.placeholder = ''" onblur="this.placeholder = 'National Insurance Number'" class="form-control" value="${fieldValue(bean:additionalDetail,field:'insurenceNo')}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="taxReference" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.additionalDetail.label.taxReference" default="Tax Reference"/>
                </label>
                <div class="col-sm-7 col-xs-10">
                    %{--<input type="text" class="col-sm-7 col-xs-10" placeholder="Tax Reference" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Tax Reference'" id="taxReference"--}%
                       %{--name="taxReference" value="${fieldValue(bean:additionalDetail,field:'taxReference')}">--}%
                    <g:textField name="taxReference" id="taxReference" placeholder="Tax Reference" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Tax Reference'" class="form-control" value="${fieldValue(bean:additionalDetail,field:'taxReference')}"/>
                </div>
            </div>

        </div>

    </div>






<div class="clearfix form-actions">
    <div class="col-md-offset-10 col-md-2">
        <g:if test='${additionalDetail?.id!=null}'>
            <button class="btn btn-primary btn-sm" type="submit" name="updateAdditionalDetail" id="updateAdditionalDetail">Update</button>
        </g:if>
        <g:else>
            <button class="btn btn-primary btn-sm" type="submit" name="saveAdditionalDetail" id="saveAdditionalDetail">Next</button>
        </g:else>



    </div>
</div>

</g:form>
<script type="text/javascript">

    $('#AgentAdditionalDetailForm').validate({

        errorElement: 'div',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            residencyTax: {
                required: false

            },
            domicile: {
                required: false

            },
            incomeTax: {
                required: false

            },
            insurenceNo: {
                required: false

            },
            taxReference: {
                required: false

            }


        } ,
        messages: {
            residencyTax: {
                required: "Please provide your residency"

            },
            domicile: {
                required: "Please provide domicile"

            },
            incomeTax: {
                required: "Please provide your income tax rate"

            },
            insurenceNo: {
                required: "Please provide your insurence no."

            },
            taxReference: {
                required: "Please provide your tax reference"

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
                url:"${createLink(controller: 'agent', action: 'saveAdditionalDetail')}",
                type:'post',
                data: $("#AgentAdditionalDetailForm").serialize(),
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
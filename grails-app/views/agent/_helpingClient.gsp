<head></head>
<body>

<g:form name="AgentHelpingClientForm" id="AgentHelpingClientForm" method="post" role="form" class="form-horizontal" url="[action: 'saveClientHelp', controller: 'agent']">
    <g:hiddenField name="id" value="${personalInfo?.id}"/>
    <g:hiddenField name="clientid" value="${clientHelp?.id}"/>
    <div class="row">


        <div class="col-md-6">

            <div class="form-group">
                <label for="gross" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.helpingClient.label.gross" default="Gross amount per year"/> </label>
               <div class="col-sm-7 col-xs-10">
                   <g:textField name="gross" id="gross" class="form-control"  placeholder="Gross amount per year" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Gross amount per year'" value="${fieldValue(bean:clientHelp,field:'gross')}"/>
                   %{--<input type="text" class="col-sm-7 col-xs-10" placeholder="Gross amount per year" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Gross amount per year'" name="gross" id="gross" value="${fieldValue(bean:clientHelp,field:'gross')}">--}%
               </div>
            </div>


            <div class="form-group ">
                <label  class=" control-label col-sm-5 col-xs-8" name="investment">
                    <g:message code="agent.helpingClient.label.investment" default="Investment Time horizon "/></label>
                <div class="input-group">
                <label for="horizon1">
                <input type="checkbox" name="horizon1"   value="1" id="horizon1">
                <span class="lbl"><g:message code="agent.helpingClient.label.investment.horizon1" default="1-3 years"/></span>
                </label>
                <label for="horizon2">
                <input type="checkbox" name="horizon2"  value="2" id="horizon2">
                <span class="lbl"><g:message code="agent.helpingClient.label.investment.horizon2" default="3-5 years"/></span>
                </label>
                 <label for="horizon3">
                <input type="checkbox" name="horizon3"  value="3" id="horizon3">
                <span class="lbl"><g:message code="agent.helpingClient.label.investment.horizon3" default="5-10 years"/></span>
                 </label>
                <label for="horizon4">
                <input type="checkbox" name="horizon4"  value="4" id="horizon4">
                <span class="lbl"><g:message code="agent.helpingClient.label.investment.horizon4" default="10+ years"/></span>
                </label>
                 </div>
            </div>

            <div class="form-group">
                <label class="col-sm-5 col-xs-8 control-label" name="risk">
                    <g:message code="agent.helpingClient.label.risk" default="Investment Objectives & Risk Classification"/>
                </label>
                <div class="input-group">
                <label for="risk1">
                    <input type="checkbox" name="riskType"  value="1" id="risk1">
                    <span class="lbl"><g:message code="agent.helpingClient.label.risk.risk1" default="Income Return"/></span>
                </label>

                <label for="risk2">
                    <input type="checkbox" name="riskType"  value="2" id="risk2">
                    <span class="lbl"><g:message code="agent.helpingClient.label.risk.risk2" default="Aggressive Total Return"/></span>
                </label>

                <label for="risk3">
                    <input type="checkbox" name="riskType"  value="3" id="risk3">
                    <span class="lbl"><g:message code="agent.helpingClient.label.risk.risk3" default="Income and Growth Return"/></span>
                </label>

              </div>
              </div>


            <div class="form-group">
                <label for="benchmark" class="col-sm-5 col-xs-8 control-label">
                    <g:message code="agent.helpingClient.label.benchmark" default="Benchmark"/> </label>
                <div class="col-sm-7 col-xs-10">
                    <g:textField name="benchmark" id="benchmark" class="form-control" placeholder="Benchmark" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Benchmark'" value="${fieldValue(bean:clientHelp,field:'benchmark')}"/>
                    %{--<input type="text" class="col-sm-7 col-xs-10" placeholder="Benchmark" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Benchmark'" name="benchmark" id="benchmark" value="${fieldValue(bean:clientHelp,field:'benchmark')}">--}%
                </div>
            </div>

        </div>
    </div>





<div class="clearfix form-actions">
    <div class="col-md-offset-10 col-md-2">

        <g:if test='${clientHelp?.id!=null}'>
            <button class="btn btn-primary btn-sm" type="submit" name="updateClientHelp" id="updateClientHelp">Update</button>
        </g:if>
        <g:else>
            <button class="btn btn-primary btn-sm" type="submit" name="saveClientHelp" id="saveClientHelp">Next</button>
        </g:else>


    </div>
</div>
</g:form>
<script type="text/javascript">
    $('#AgentHelpingClientForm').validate({

        errorElement: 'div',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            gross: {
                required: false

            },
            benchmark: {
                required: false

            }



        } ,
        messages: {
            gross: {
                required: " "

            },
            benchmark: {
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
        submitHandler: function (form) {
            $.ajax({
                url:"${createLink(controller: 'agent', action: 'saveClientHelp')}",
                type:'post',
                data: $("#AgentHelpingClientForm").serialize(),
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
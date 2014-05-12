<html>
<head>
    <title></title>

</head>

<body>

<div class="col-xs-12">
    <g:if test='${flash.message}'>
        <div class='alert alert-success '>
            <i class="icon-bell green"><b>${flash.message}</b></i>
        </div>
    </g:if>
    <g:hasErrors bean="${country}">
        <div class='alert alert-success '>
            <ul>
                <g:eachError var="err" bean="${country}">
                    <li><g:message error="${err}"/></li>
                </g:eachError>
            </ul>
        </div>
    </g:hasErrors>
    <div class="widget-box">
        <div class="widget-header">
            <h4 class="smaller"><g:message
                    code="coreBanking.settings.country.title" default="Create Country"/></h4>
        </div>

        <div class="widget-body">
            <div class="widget-main">

                <div class="row">
                    <g:form class="form-horizontal" id="countryForm" name="countryForm"
                            method="post" role="form" url="[action: 'save', controller: 'country']"
                            onsubmit="return false;">

                        <g:hiddenField name="id" value="${country?.id}"/>

                        <div class="form-group ${hasErrors(bean: country, field: 'name', 'has-error')}">
                            <label for="name"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="default.country.label" default="Country Name"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <input type="text" id="name" name="name" value="${country?.name}"
                                           placeholder="Country Name">
                                </div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: country, field: 'printablename', 'has-error')}">
                            <label for="printablename"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="coreBanking.settings.country.printableName.label"
                                    default="Printable Name"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <input type="text" id="printablename" name="printablename"
                                           value="${country?.printablename}"
                                           placeholder="Printable Name">
                                </div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: country, field: 'numcode', 'has-error')}">
                            <label for="numcode"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="coreBanking.settings.country.numCode.label" default="Num Code"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <input type="number" id="numcode" name="numcode" value="${country?.numcode}"
                                           placeholder="NumCode">
                                </div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: country, field: 'iso2', 'has-error')}">
                            <label for="iso2"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="coreBanking.settings.country.iso2.label" default="ISO2 Name"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <input type="text" id="iso2" name="iso2" value="${country?.iso2}"
                                           placeholder="ISO2 Name">
                                </div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: country, field: 'iso3', 'has-error')}">
                            <label for="iso3"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="coreBanking.settings.country.iso3.label" default="ISO3 Name"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <input type="text" id="iso3" name="iso3" value="${country?.iso3}"
                                           placeholder="ISO3 Name">
                                </div>
                            </div>
                        </div>

                        <div class="clearfix form-actions">
                            <div class="col-md-offset-3 col-md-9">
                                <button class="btn" type="reset">
                                    <i class="icon-undo bigger-110"></i>
                                    <g:message code="default.button.reset.label" default="Reset"/>
                                </button>
                                &nbsp; &nbsp; &nbsp;
                                <g:if test="${country?.id}">
                                    <g:submitButton name="Update" id="saveBtn" class="btn btn-info"/>
                                </g:if>
                                <g:else>
                                    <g:submitButton name="Save" id="saveBtn" class="btn btn-info"/>
                                </g:else>
                            </div>
                        </div>
                    </g:form>
                </div>

            </div>
        </div>
    </div>

</div><!-- /span -->

<script type="text/javascript">
    $('#countryForm').validate({
        errorElement: 'small',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            name: {
                required: true,
                minlength: 5,
                maxlength: 15
            },
            printablename: {
                required: true,
                minlength: 5,
                maxlength: 15
            },
            numcode: {
                required: true,
                number: true
            },
            iso2: {
                required: true,
                minlength: 3,
                maxlength: 5
            },
            iso3: {
                required: true,
                minlength: 3,
                maxlength: 5
            }
        },
        messages: {
            name: {
                required: " "
            },
            printablename: {
                required: " "
            },
            numcode: {
                required: " "
            },
            iso2: {
                required: " "
            },
            iso3: {
                required: " "
            }
        },
        invalidHandler: function (event, validator) { //display error alert on form submit
            $('.alert-danger', $('#countryForm')).show();
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
                url: "${createLink(controller: 'country', action: 'save')}",
                type: 'post',
                data: $("#countryForm").serialize(),
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
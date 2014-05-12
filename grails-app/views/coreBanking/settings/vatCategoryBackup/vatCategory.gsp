<%--
  Created by IntelliJ IDEA.
  User: rabin
  Date: 5/7/14
  Time: 2:30 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
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
    <g:hasErrors bean="${vatCategory}">
        <div class='alert alert-success '>
            <ul>
                <g:eachError var="err" bean="${vatCategory}">
                    <li><g:message error="${err}"/></li>
                </g:eachError>
            </ul>
        </div>
    </g:hasErrors>
    <div class="widget-box">
        <div class="widget-header">
            <h4 class="smaller"><g:message
                    code="coreBanking.setting.vatCategory.title" default="Vat Category"/></h4>
        </div>

        <div class="widget-body">
            <div class="widget-main">

                <div class="row">
                    <g:form class="form-horizontal" id="vatCategoryForm" name="vatCategoryForm"
                            method="post" role="form" url="[action: 'save', controller: 'vatCategory']"
                            onsubmit="return false;">

                        <g:hiddenField name="id" value="${vatCategory?.id}"/>

                        <div class="form-group ${hasErrors(bean: vatCategory, field: 'name', 'has-error')}">
                            <label for="name"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="coreBanking.setting.vatCategory.name.label"
                                    default="Category Name"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <input type="text" id="name" name="name"
                                           value="${vatCategory?.name}"
                                           placeholder="Category Name">
                                </div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: vatCategory, field: 'rate', 'has-error')}">
                            <label for="rate"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="coreBanking.setting.vatCategory.rate.label"
                                    default="Category Rate"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <input type="text" id="rate" name="rate"
                                           value="${vatCategory?.rate}"
                                           placeholder="Category Rate">
                                </div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: vatCategory, field: 'vatGlAccount', 'has-error')}">
                            <label for="vatGlAccount"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="coreBanking.setting.vatCategory.vatGlAccount.label"
                                    default="Vat GL Account"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <g:select id="vatGlAccount" name='vatGlAccount' required="" class="width-80"
                                              noSelection="${['': 'Vat GL Account...']}"
                                              from='${vatGlAcc}'
                                              value="${vatCategory?.vatGlAccount}"
                                              optionKey="accountNum" optionValue="account"></g:select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: vatCategory, field: 'purchaseGlAcc', 'has-error')}">
                            <label for="purchaseGlAcc"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="coreBanking.setting.vatCategory.purchaseGlAcc.label"
                                    default="Purchase GL Account"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <g:select id="purchaseGlAcc" name='purchaseGlAcc' required="" class="width-80"
                                              noSelection="${['': 'Purchase GL Account...']}"
                                              from='${purchaseAcc}'
                                              value="${vatCategory?.purchaseGlAcc}"
                                              optionKey="accountNum" optionValue="account"></g:select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: vatCategory, field: 'iso3', 'has-error')}">
                            <label for="salesGlAcc"
                                   class="control-label col-xs-12 col-sm-3 no-padding-right"><g:message
                                    code="coreBanking.setting.vatCategory.salesGlAcc.label"
                                    default="Sales GL Account"/> *</label>

                            <div class="col-md-4 col-sm-4">
                                <div class="clearfix">
                                    <g:select id="salesGlAcc" name='salesGlAcc' required="" class="width-80"
                                              noSelection="${['': 'Sales GL Account...']}"
                                              from='${salesGlAcc}'
                                              value="${vatCategory?.salesGlAcc}"
                                              optionKey="accountNum" optionValue="account"></g:select>
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
                                <g:if test="${vatCategory?.id}">
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

    $('#vatCategoryForm').validate({
        errorElement: 'small',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            name: {
                required: true,
                minlength: 5,
                maxlength: 15
            },
            rate: {
                required: true,
                minlength: 5,
                maxlength: 15
            },
            vatGlAccount: {
                required: true
            },
            purchaseGlAcc: {
                required: true
            },
            salesGlAcc: {
                required: true
            }
        },
        messages: {
            name: {
                required: " "
            },
            rate: {
                required: " "
            },
            vatGlAccount: {
                required: " "
            },
            purchaseGlAcc: {
                required: " "
            },
            salesGlAcc: {
                required: " "
            }
        },
        invalidHandler: function (event, validator) { //display error alert on form submit
            $('.alert-danger', $('#vatCategoryForm')).show();
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
                url: "${createLink(controller: 'vatCategory', action: 'save')}",
                type: 'post',
                data: $("#vatCategoryForm").serialize(),
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
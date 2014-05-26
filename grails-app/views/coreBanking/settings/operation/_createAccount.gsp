<html>
<head>
<title></title>
<link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'jquery.multiselect.filter.css')}"/>
<link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'jquery.multiselect.css')}"/>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.10/themes/smoothness/jquery-ui.css" rel="stylesheet">

<style>
.ui-multiselect span.ui-icon {
    position: relative;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {

        $("#jointClients").multiselect().multiselectfilter({
            label: '',
            header: "Choose clients below",
            placeholder: "Search clients"
        });

        $('#validation-form').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                clientId: {
                    required: true
                },
                accountCategoryId: {
                    required: true
                },
                accountTypeId: {
                    required: true
                },
                savingsProductId: {
                    required: true
                },
                currentProductId: {
                    required: true
                },
                jointClients: {
                    required: true
                }
            },
            messages: {
                clientId: {
                    required: "Please provide client ID."
                },
                accountCategoryId: {
                    required: "account category required."
                },
                accountTypeId: {
                    required: "account type required."
                },
                savingsProductId: {
                    required: "product required."
                },
                currentProductId: {
                    required: "product required."
                }

            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('.login-form')).show();
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
            }
        });

        $("#clientId").bind('keypress', function (e) {
            if ((e.keyCode == 13) || ( e.keyCode == 9)) {
                e.preventDefault();
                if(!$("#clientId").valid()) return false;
                var clientId = $("#clientId").val().trim();
                jQuery.ajax({
                    type: 'post',
                    dataType: 'json',
                    url: "${createLink(controller:'accountOpen', action: 'showClientInfo')}?clientId=" + clientId,
                    success: function (data, textStatus) {
                        showClientInformation(data);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    },
                    complete: function (XMLHttpRequest, textStatus) {
                        showSpinner(false);
                    }
                });
                return false;
            }
        });

        resetForm();
    });

    var warning = $(".message");

    $("#jointClients").multiselect({
        header: "Choose only 3 clients!",
        noneSelectedText: 'Select Clients',
        position: {
            my: 'center',
            at: 'center'
        },
        open: function (e) {
            $("input[type='search']:first").focus();
        },
        click: function (e) {
            if ($(this).multiselect("widget").find("input:checked").length > 3) {
                warning.addClass("error").removeClass("success").html("You can only select three clients!");
                return false;
            } else {
                warning.addClass("success").removeClass("error").html("");
            }
        }
    });

    $('#account-create-wizard').ace_wizard().on('change',function (e, info) {

        if (info.step == 1 && true) {
            if (!$('#validation-form').valid()) return false;
        }

        if (info.step == 2 && true) {
            if (!$('#validation-form').valid()) return false;
        }
        if (info.step == 3 && true) {
            if (!$('#validation-form').valid()) return false;
            var accountTypeId = $('select#accountTypeId option:selected').val();
            if (accountTypeId == 2) {
                if($("#jointClients").multiselect("widget").find("input:checked").length == 0 ){
                    warning.addClass("error").removeClass("success").html("Please select clients.");
                    return false;
                }
            }
        }
        showConfirmationInfo();

    }).on('finished',function (e) {

                var buildParams = '';
                var clientId =  $("#clientId").val();
                var accountTypeId = $('select#accountTypeId option:selected').val();
                var accountCategoryId = $('select#accountCategoryId option:selected').val();

                buildParams = "?clientId=" + clientId + "&accountTypeId="+ accountTypeId + "&accountCategoryId=" + accountCategoryId;
                var savingsProductId = $("#savingsProductId").val();
                var currentProductId = $("#currentProductId").val();
                if(currentProductId){
                    buildParams = buildParams + "&currentProductId=" + currentProductId;
                } else if(savingsProductId) {
                    buildParams = buildParams + "&savingsProductId=" + savingsProductId;
                }

                if($('#jointClients').val()){
                    var array_of_checked_values = $("#jointClients").val();
                }

                buildParams = buildParams + "&jointIds=" + array_of_checked_values;

                bootbox.confirm({
                    title: 'Creating Account',
                    message: 'Are you sure you want to create account',
                    buttons: {
                        'cancel': {
                            label: 'Cancel',
                            className: 'btn-default'
                        },
                        'confirm': {
                            label: 'Create',
                            className: 'btn btn-primary pull-right'
                        }
                    },
                    callback: function(result) {
                        if (result) {

                            jQuery.ajax({
                                type: 'post',
                                data: jQuery("#validation-form").serialize(),
                                url: "${createLink(controller:'accountOpen', action: 'saveAccount')}",
                                success: function (data, textStatus) {
                                    $("#page-content").html(data);
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                },
                                complete: function (XMLHttpRequest, textStatus) {
                                    showSpinner(false);
                                }
                            });

                        }
                    }
                });
            });

    function showClientInformation(data) {
        if (data.available == false) {
            $('.err-msg').text(data.message).show();
//            $('#notify').html('<div class="alert alert-error"><a class="close" data-dismiss="alert">×</a><span>'+data.message+'</span></div>')
            $('div#error-message-div').show();
            $("#clientId").val('');
            $("#clientId").focus();
            $("#username").text('');
            $("#dateOfBirth").text('');
            $("#contactNo").text('');
            $("#nationality").text('');
            $("#clientBasicInfo").hide();
            return false;
        }
        var client = data.accountHolder
            $("#clientIdFromServer").val(client.id);
            $("#username").text(client.firstName);
            $("#user").text(client.lastName);
            $("#dateOfBirth").text(client.dateOfBirth?client.dateOfBirth:'01/01/2000');
//            $("#contactNo").text(client.contactNo ? client.contactNo :01713955862);
            $("#nationality").text(data.nationalilty);
            $("#clientBasicInfo").show();
    }

    function showAccountCategoryInfo() {
        var accountCategoryId = $('select#accountCategoryId option:selected').val();
        if (accountCategoryId == 1) {
            $("#currentProductDiv").hide();
            $("#savingsProductDiv").show();
        } else if (accountCategoryId == 2) {
            $("#savingsProductDiv").hide();
            $("#currentProductDiv").show();
            $("#currentProductId").show();
        } else {
            $("#savingsProductDiv").hide();
            $("#currentProductDiv").hide();
        }
    }
    function showAccountTypeInfo() {
        var accountTypeId = $('select#accountTypeId option:selected').val();
        if (accountTypeId == 1) {
            $("#jointClients").multiselect("uncheckAll");
            $("#jointClientDiv").hide();
        } else if (accountTypeId == 2) {
            $("#jointClientDiv").show();
            $(".error").text('');
        }
    }

    function showConfirmationInfo() {
        var username = $("#username").text();
        $("#clientName").text(username);
        var selectedValuesArray = $('#jointClients').val();
        if (selectedValuesArray) {
            $("#clientName").append(selectedValuesArray)
        }
        var accountCategoryValue = $('select#accountCategoryId option:selected').text();
        $("#accountCat").text(accountCategoryValue);
        var txtAccountType = $('select#accountTypeId option:selected').text();
        $("#accountType").text(txtAccountType);
        var productNameSavings = $('select#savingsProductId option:selected').text();
        $("#productName").text(productNameSavings);
    }
    function resetForm() {
        $("#clientId").val('');
        $("#clientIdFromServer").val('');
        $("#accountCategoryId").val('');
        $("#currentProductId").hide();
        $("#savingsProductId").val('');
        $("#accountTypeId").val('');
        $(".error").text('');
        $("#jointClients").multiselect("uncheckAll");
    }
</script>
</head>

<body>
<div class="alert alert-danger" id="error-message-div" style="display: none">
    <a class="close" onclick="$('div#error-message-div').hide();">×</a>
    <span class="err-msg">&nbsp;</span>
</div>
<div class="row">
<div class="col-md-12">
<div class="widget-box">
<div class="widget-header widget-header-blue widget-header-flat">
    <h4 class="lighter">
        <g:message code="coreBanking.operation.ac.create.header.lbl" default="Creating Account"/></h4>
</div>

<div class="widget-body">
<div class="widget-main">
<div id="account-create-wizard" class="row-fluid" data-target="#step-container">
    <ul class="wizard-steps">
        <li data-target="#step1" class="active">
            <span class="step">1</span>
            <span class="title"><g:message code="coreBanking.operation.ac.create.step.ac.product.lbl" default="Selecting Product"/> </span>
            %{--<span class="title"><g:message code="coreBanking.operation.ac.create.step.search.client.lbl" default="Searching Client"/></span>--}%
        </li>

        <li data-target="#step2">
            <span class="step">2</span>
            <span class="title"><g:message code="coreBanking.operation.ac.create.step.ac.product.list" default="Product Info"/></span>
        </li>

        <li data-target="#step3">
            <span class="step">3</span>
            <span class="title"><g:message code="coreBanking.operation.ac.create.step.ac.category.lbl" default="Selecting A/C Type"/></span>
        </li>

        <li data-target="#step4">
            <span class="step">4</span>
            <span class="title"><g:message code="coreBanking.operation.ac.create.step.ac.confirmation.lbl" default="Confirmation"/></span>
        </li>
    </ul>
</div>

<hr/>

<div class="step-content row-fluid position-relative" id="step-container">
<form class="form-horizontal show" id="validation-form" method="post" name="createAccount">
    <div class="step-pane active" id="step1">
        <div class="form-group col-md-12" id="acCategoryDiv">
            <label class="control-label col-md-4" for="accountCategoryId">
                <g:message code="coreBanking.operation.ac.create.ac.category.lbl" default="Choose A/C Category"/></label>

            <div class="form-group col-md-4">
                <div class="clearfix">
                    <select class="form-control"id="accountCategoryId" name="accountCategoryId" onchange="showAccountCategoryInfo()">
                        <option value=""><g:message code="coreBanking.operation.ac.create.ac.category.lbl" default="Choose A/C Category"/></option>
                        <option value="1">Savings A/C</option>
                        <option value="2">Current A/C</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>

        <div class="form-group col-md-12" id="savingsProductDiv" style="display: none">
            <label class="control-label col-md-4" for="savingsProductId">
                <g:message code="coreBanking.operation.ac.create.product.category.lbl" default="Choose Product"/></label>

            <div class="form-group col-md-4">
                <div class="clearfix">
                    <select class="form-control" onchange="" required="required" name="savingsProductId" id="savingsProductId">
                        <option value=""><g:message code="coreBanking.operation.ac.create.product.category.lbl" default="Choose Product"/></option>
                        <option value="1">SP A</option>
                        <option value="2">SP B</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>

        <div class="form-group col-md-12" id="currentProductDiv" style="display: none">
            <label class="control-label col-md-4" for="currentProductId">
                <g:message code="coreBanking.operation.ac.create.product.category.lbl" default="Choose Product"/></label>

            <div class="form-group col-md-4 ">
                <div class="clearfix">
                    <select class="form-control" required="required" name="currentProductId" id="currentProductId">
                        <option value=""><g:message code="coreBanking.operation.ac.create.product.category.lbl" default="Choose Product"/></option>
                        <option value="1">CP A</option>
                        <option value="2">CP B</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4">

        %{--<div class="form-group col-md-12">--}%
        %{--<label class="control-label col-md-4" for="clientId">--}%
        %{--<g:message code="coreBanking.operation.ac.create.client.id.lbl" default="Client ID"/></label>--}%

        %{--<div class="col-md-4">--}%
        %{--<div class="clearfix">--}%
        %{--<input type="text" id="clientId" name="clientId" class="form-control" placeholder="Client ID"/>--}%
        %{--</div>--}%
        %{--</div>--}%
        %{--<div class="col-md-4"></div>--}%
        %{--</div>--}%
        %{--<div class="col-md-11 col-md-offset-1">--}%
        %{--<div class="user-profile row" id="clientBasicInfo" style="display: none">--}%
        %{--<div class="col-md-7 col-md-offset-1">--}%
        %{--<div class="profile-user-info profile-user-info-striped">--}%
        %{--<g:hiddenField name="clientIdFromServer" id="clientIdFromServer"/>--}%
        %{--<div class="profile-info-row">--}%
        %{--<div class="profile-info-name">Name of Client</div>--}%

        %{--<div class="profile-info-value">--}%
        %{--<span id="username" name="username" style="display: inline;"></span>--}%
        %{--</div>--}%
        %{--</div>--}%

        %{--<div class="profile-info-row">--}%
        %{--<div class="profile-info-name">Date of Birth</div>--}%

        %{--<div class="profile-info-value">--}%
        %{--<span id="dateOfBirth" style="display: inline;"></span>--}%
        %{--</div>--}%
        %{--</div>--}%

        %{--<div class="profile-info-row">--}%
        %{--<div class="profile-info-name">Contact no:</div>--}%

        %{--<div class="profile-info-value">--}%
        %{--<span id="contactNo"></span>--}%
        %{--</div>--}%
        %{--</div>--}%

        %{--<div class="profile-info-row">--}%
        %{--<div class="profile-info-name">E-mail:</div>--}%

        %{--<div class="profile-info-value">--}%
        %{--<span id="email"></span>--}%
        %{--</div>--}%
        %{--</div>--}%

        %{--<div class="profile-info-row">--}%
        %{--<div class="profile-info-name">Nationality:</div>--}%

        %{--<div class="profile-info-value">--}%
        %{--<span id="nationality"></span>--}%
        %{--</div>--}%
        %{--</div>--}%

        %{--<div class="profile-info-row">--}%
        %{--<div class="profile-info-name">Address:</div>--}%

        %{--<div class="profile-info-value">--}%
        %{--<span id="address"></span>--}%
        %{--</div>--}%
        %{--</div>--}%
        %{--</div>--}%

        %{--</div>--}%
        %{--<div class="col-md-4">--}%
        %{--<span class="profile-picture">--}%
        %{--<img src="/gslcbs/images/default-photo.png" width="200" height="100" alt="Client Avatar" class="img-thumbnail" id="avatar" style="display: block;"/>--}%
        %{--<span id="user" style="display: inline;"></span>--}%
        %{--</span>--}%
        %{--</div>--}%
        %{--</div>--}%
        %{--<div class="space-2"></div>--}%
        %{--</div>--}%

    </div>
        </div>
      </div>

    <div class="step-pane" id="step2">

        <div class="form-group col-md-12">


                <div class="clearfix">
                    <div class="table-responsive">
                   <table class="table table-bordered table-striped table-hover table-condensed">
                       <thead>
                       <tr>
                           <th>Charges</th>
                           <th>Interest</th>
                           <th>Terms & Condition</th>
                       </tr>
                       </thead>
                    <tbody>
                    <tr>
                        <td>1000</td>
                        <td>34%</td>
                        <td></td>
                    </tr>
                    </tbody>
                   </table>
                </div>
            </div>
            </div>
            <div class="col-md-4"></div>
        </div>



    <div class="step-pane" id="step3">
        %{--<form class="form-horizontal show" id="validation-form-3" method="get">--}%
        <div class="form-group col-md-12" id="acTypeDiv">
            <label class="control-label col-md-4" for="accountTypeId">
                <g:message code="coreBanking.operation.ac.create.ac.type.lbl" default="Choose A/C Type"/></label>
            <div class="form-group col-md-4">
                <div class="clearfix">
                    <select class="form-control" id="accountTypeId" name="accountTypeId" required="required" onchange="showAccountTypeInfo()">
                        <option value=""><g:message code="coreBanking.operation.ac.create.ac.type.lbl" default="Choose A/C Type"/></option>
                        <option value="1">Individual A/C</option>
                        <option value="2">Joint A/C</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>


        <div class="form-group col-md-12" id="jointClientDiv" style="display: none">
            <label class="control-label col-md-4" for="jointClients">
                <g:message code="coreBanking.operation.ac.create.joint.client.lbl" default="Choose Joint Client"/></label>

            <div class="form-group col-md-4">
                <div class="clearfix">
                    <select id="jointClients" name="jointClients" multiple="multiple" size="10" required="required" class="form-control">
                        <option value="101200">Imaran Hosen</option>
                        <option value="101201">Md. Robin</option>
                        <option value="101202">Mr. Rumi</option>
                        <option value="101203">Mr. Aminul</option>
                        <option value="101204">Mr. Jakir Hossain</option>
                        <option value="101205">Ms Sania Rahman</option>
                        <option value="101206">Mr. Yasin Jabed</option>
                        <option value="101207">Mr. Arman Shakilll</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4">
                <div class="message success"></div>
            </div>
        </div>
    </div>
</form>



<div class="step-pane" id="step4">
    <div class="center">
        <h3 class="green">You have created new Account with following information</h3>

        <div class="col-xs-12">
            <div class="row well-sm">
                <span id="lblAccountCat">A/C Category:</span> <span id="accountCat"></span></div>

            <div class="row well-sm">
                <span id="lblAccountType">Account Type:</span> <span id="accountType"></span></div>

            <div class="row well-sm">
                <span id="lblProduct">Product:</span> <span id="productName"></span></div>

            <div class="row well-sm">
                <span id="lblClientName">Client(s):</span> <span id="clientName"></span></div>
        </div>
    </div>
</div>
</div>
<hr/>

<div class="row-fluid wizard-actions">
    <button class="btn btn-prev"><i class="icon-arrow-left"></i>
        <g:message code="coreBanking.operation.ac.create.pagination.prev.lbl" default="Prev"/></button>
    <button class="btn btn-success btn-next" data-last="Confirm!">
        <g:message code="coreBanking.operation.ac.create.pagination.next.lbl" default="Next"/><i class="icon-arrow-right icon-on-right"></i></button>
</div>
</div><!-- /widget-main -->
</div>
</div><!-- /widget-body -->
</div>
</div><!-- /.col -->
</div><!-- /.row -->
</body>
</html>

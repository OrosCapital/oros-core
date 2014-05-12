<%--
  Created by IntelliJ IDEA.
  User: Nusrat Jahan Bhuiyan
  Date: 2/25/14
  Time: 12:37 PM
--%>

<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<style>
select, label, textarea, input[type="text"], input[type="password"],
input[type="datetime"], input[type="datetime-local"], input[type="date"],
input[type="month"], input[type="time"], input[type="week"], input[type="number"],
input[type="email"], input[type="url"], input[type="search"], input[type="tel"],
input[type="color"]{font-size: 12px;}

div.form-group{
    margin-bottom: 10px !important;
    vertical-align: top;
}
.form-inline .form-group{
    vertical-align: top;
}
textarea{
    resize: none;
}
label{
    width:155px;
    padding-right:10px;
}
input,select,textarea{
    width: 175px;
    margin-right:20px;
}
.form-group.has-error label{
    border-color: #F09784;
    box-shadow: none;
    color: #D68273;
}
</style>
<title>OrosCapital - Create Customer</title>


</head>

<body>

<div class="page-header">
    <h1>Create New Customer</h1>
</div><!-- /.page-header -->

<g:if test='${flash.message}'>
    <div class='alert alert-success '>
        <i class="icon-bell green"> <b> ${flash.message} </b> </i>
    </div>
</g:if>

<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

        <nav id="customerNav" class="navbar navbar-default">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-1">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="collapse navbar-collapse" id="navbar-collapse-1">
                <ul id="customerFormListTab" class="nav navbar-nav padding-12 tab-color-blue background-blue">
                    <li id="basicTab" class="active"><a href="#basicContent" data-toggle="tab">Basic</a></li>
                    <li id="generalAddTab" class="disabled"><a>General Address</a></li>
                    <li id="postalAddTab" class="disabled"><a>Postal Address</a></li>
                    <li id="shippingAddTab" class="disabled"><a>Shipping Address</a></li>
                    <li id="bankAccountTab" class="disabled"><a>Bank Account Info</a></li>
                </ul>
            </div>
        </nav>

        <div class="tab-content">
            <div class="tab-pane active" id="basicContent">
                <g:render template='/coreBanking/settings/accounting/customer/basic'/>
            </div>
            <div class="tab-pane" id="generalAddContent">
                <g:render template='/coreBanking/settings/accounting/customer/generalAddress'/>
            </div>
            <div class="tab-pane" id="postalAddContent">
                <g:render template='/coreBanking/settings/accounting/customer/postalAddress'/>
            </div>
            <div class="tab-pane" id="shippingAddContent">
                <g:render template='/coreBanking/settings/accounting/customer/shippingAddress'/>
            </div>
            <div class="tab-pane" id="bankAccountContent">
                <g:render template='/coreBanking/settings/accounting/customer/bankAccountInfo'/>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        if('${customerMaster?.id}'){
            $('ul#customerFormListTab li').removeClass('disabled');
            $('li#generalAddTab a').attr('href','#generalAddContent');
            $('li#postalAddTab a').attr('href','#postalAddContent');
            $('li#shippingAddTab a').attr('href','#shippingAddContent');
            $('li#bankAccountTab a').attr('href','#bankAccountContent');
            $('ul#customerFormListTab li a').attr('data-toggle','tab');
        }

        var tabSelector='${tabSelectIndicator}';
        if(tabSelector == 2){
            $('#basicTab').removeClass( "active" );
            $('#generalAddTab').addClass( "active");
            $('#basicContent').removeClass( "active" );
            $('#generalAddContent').addClass( "active" );
        }
        else if(tabSelector == 3){
            $('#basicTab').removeClass( "active" );
            $('#postalAddTab').addClass( "active" );
            $('#basicContent').removeClass( "active" );
            $('#postalAddContent').addClass( "active" );
        }
        else if(tabSelector == 4){
            $('#basicTab').removeClass( "active" );
            $('#shippingAddTab').addClass( "active" );
            $('#basicContent').removeClass( "active" );
            $('#shippingAddContent').addClass( "active" );
        }
        else if(tabSelector == 5){
            $('#basicTab').removeClass( "active" );
            $('#bankAccountTab').addClass( "active" );
            $('#basicContent').removeClass( "active" );
            $('#bankAccountContent').addClass( "active" );
        }

        $('#customerBasicForm').validate({
            errorElement: 'div',
            errorClass: 'help-block hidden',
            focusInvalid: false,
            rules: {
                customerCode: {
                    required: true
                },
                customerName: {
                    required: true
                },
                gender: {
                    required: false
                },
                bankName: {
                    required: false
                },
                firstName: {
                    required: false
                },
                middleName: {
                    required: false
                },
                lastName: {
                    required: false
                },
                email: {
                    required: false
                },
                defaultGlAccount: {
                    required: false
                },
                chamberOfCommerce: {
                    required: false
                },
                customerType: {
                    required: true
                },
                vat: {
                    required: false
                },
                comments: {
                    required: false
                },
                paymentTerm: {
                    required: true
                },
                momentOfSending: {
                    required: false
                },
                status: {
                    required: false
                }
            } ,
            messages: {
                customerCode: {
                    required: "Provide customer code"
                },
                customerName: {
                    required: "Provide customer name"
                },
                customerType: {
                    required: "Select customer type"
                },
                paymentTerm: {
                    required: "Select payment term"

                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#customerBasicForm')).show();
            },
            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },
            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            submitHandler: function (form) {
                var actionurl ="${g.createLink(controller:'customer', action: 'saveCustomerMaster')}";
                $.ajax({
                    url: actionurl,
                    type: 'post',
                    data: $("#customerBasicForm").serialize(),
                    success: function(data) {
                        $('#page-content').html(data);
                    }
                });
            }
        });

        $('#customerGeneralAddressForm').validate({
            errorElement: 'div',
            errorClass: 'help-block hidden',
            focusInvalid: false,
            rules: {
                contactPersonName: {
                    required: true
                },
                contactPersonReference: {
                    required: false
                },
                contactDealType: {
                    required: false
                },
                mobileNo: {
                    required: false
                },
                phoneNo: {
                    required: false
                },
                websiteUrl: {
                    required: false
                },
                addressLine1: {
                    required: false
                },
                addressLine2: {
                    required: false
                },
                email2: {
                    required: false
                },
                state: {
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
                },
                status: {
                    required: false
                }
            } ,
            messages: {
                contactPersonName: {
                    required: "Provide contact person name"
                },
                postCode: {
                    required: "Provide post code"
                },
                state: {
                    required: "Select state"
                },
                city: {
                    required: "Provide city"
                },
                country: {
                    required: "Select country"
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#customerGeneralAddressForm')).show();
            },
            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },
            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            submitHandler: function (form) {
                var actionurl ="${g.createLink(controller:'customer', action: 'saveGeneralAddress')}";
                $.ajax({
                    url: actionurl,
                    type: 'post',
                    data: $("#customerGeneralAddressForm").serialize(),
                    success: function(data) {
                        $('#page-content').html(data);
                    }
                });
            }
        });

        $('#customerPostalAddressForm').validate({
            errorElement: 'div',
            errorClass: 'help-block hidden',
            focusInvalid: false,
            rules: {
                contactPersonName: {
                    required: true
                },
                addressLine1: {
                    required: false
                },
                addressLine2: {
                    required: false
                },
                state: {
                    required: true
                },
                postCode: {
                    required: true
                },
                country: {
                    required: true
                },
                city: {
                    required: true
                },
                status: {
                    required: false
                }
            } ,
            messages: {
                contactPersonName: {
                    required: "Provide contact person name"
                },
                postCode: {
                    required: "Provide post code"
                },
                city: {
                    required: "Provide city"
                },
                country: {
                    required: "Select country"
                },
                state: {
                    required: "Select state"
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#customerPostalAddressForm')).show();
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            submitHandler: function (form) {
                var actionurl ="${g.createLink(controller:'customer', action: 'savePostalAddress')}";
                $.ajax({
                    url: actionurl,
                    type: 'post',
                    data: $("#customerPostalAddressForm").serialize(),
                    success: function(data) {
                        $('#page-content').html(data);
                    }
                });
            }
        });

        $('#customerShippingAddressForm').validate({
            errorElement: 'div',
            errorClass: 'help-block hidden',
            focusInvalid: false,
            rules: {
                contactPersonName: {
                    required: true
                },
                postCode: {
                    required: true
                },
                addressLine1: {
                    required: false
                },
                addressLine2: {
                    required: false
                },
                phoneNo: {
                    required: false
                },
                phoneNo2: {
                    required: false
                },
                faxNo: {
                    required: false
                },
                email1: {
                    required: false
                },
                websiteUrl: {
                    required: false
                },
                city: {
                    required: true
                },
                state: {
                    required: true
                },
                country: {
                    required: true
                },
                note: {
                    required: true
                },
                status: {
                    required: false
                }
            } ,
            messages: {
                contactPersonName: {
                    required: "Provide contact person name"

                },
                postCode: {
                    required: "Provide post code"
                },
                city: {
                    required: "Provide city"
                },
                country: {
                    required: "Select country"
                },
                state: {
                    required: "Select state"
                },
                note: {
                    required: "Provide account no."
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#customerShippingAddressForm')).show();
            },
            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },
            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            submitHandler: function (form) {
                var actionurl ="${g.createLink(controller:'customer', action: 'saveShipmentAddress')}";
                $.ajax({
                    url: actionurl,
                    type: 'post',
                    data: $("#customerShippingAddressForm").serialize(),
                    success: function(data) {
                        $('#page-content').html(data);
                    }
                });
            }
        });

        $('#customerAccountInfoForm').validate({
            errorElement: 'div',
            errorClass: 'help-block hidden',
            focusInvalid: false,
            rules: {
                bankName: {
                    required: true
                },
                bankAccountName: {
                    required: true
                },
                ibanPrefix: {
                    required: true
                },
                bankAccountNo: {
                    required: true
                },
                status: {
                    required: false
                }
            } ,
            messages: {
                bankName: {
                    required: "Provide bank name"
                },
                bankAccountName: {
                    required: "Provide bank account name"
                },
                ibanPrefix: {
                    required: "Provide iban prefix"
                },
                bankAccountNo: {
                    required: "Provide bank account number"
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#customerAccountInfoForm')).show();
            },
            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },
            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            submitHandler: function (form) {
                var actionurl ="${g.createLink(controller:'customer', action: 'saveBankAccount')}";
                $.ajax({
                    url: actionurl,
                    type: 'post',
                    data: $("#customerAccountInfoForm").serialize(),
                    success: function(data) {
                        $('#page-content').html(data);
                    }
                });
            }
        });

    });
</script>
</body>
</html>
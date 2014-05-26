<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>
    .form-control, label, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"] {
        font-size: 12px;
    }

    label {
        max-width: 150px;
    }
    </style>
    <title></title>
</head>

<body>

<g:hasErrors bean="${vendorBankAccount}">
    <div class='alert alert-success '>
        <ul>
            <g:eachError var="err" bean="${vendorBankAccount}">
                <li><g:message error="${err}"/></li>
            </g:eachError>
        </ul>
    </div>
</g:hasErrors>

<div class="col-xs-12 ">
    <div class="alert alert-success hidden" id="messageDiv">
        <i class="icon-bell green">
            <b id="message"></b>
        </i>
    </div>
</div>

<g:form name="vendorBankAccountInfoForm" id="vendorBankAccountInfoForm" method="post"
        url="[controller: 'vendor', action: 'saveVendorBankAccountInfo']" role="form" class="form-horizontal"
        onsubmit="return false;">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="col-xs-6 col-sm-6 col-md-6">
                <g:hiddenField name="id" id="vendorId" value="${vendorMaster?.id}"/>
                <g:hiddenField name="accountID" id="accountID"/>
                <g:hiddenField type="text" name="selectRow" hidden="" value="" id="selectRow"/>

                <div class="form-group ${hasErrors(bean: vendorBankAccount, field: 'bankName', 'has-error')}">
                    <label for="vendorbankName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.bankAccount.bankName" default="Bank Name"/><span
                            class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Bank Name"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Bank Name'"
                                   id="vendorbankName"
                                   name="bankName" value=""/>
                        </div>
                    </div>
                </div>


                <div class="form-group ${hasErrors(bean: vendorBankAccount, field: 'bankAccountNo', 'has-error')}">
                    <label for="vendorBankAccountNo" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.bankAccount.accountNo"
                                   default="Account Number"/><span class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Bank Account No"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Bank Account No'"
                                   id="vendorBankAccountNo"
                                   name="bankAccountNo" value=""/>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: vendorBankAccount, field: 'status', 'has-error')}">
                    <label for="vendorStatus" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.basicInfo.status" default="Status"/>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <select id="vendorStatus" class="col-sm-11 col-xs-12" name="status">
                                <g:if test="${vendorBankAccount?.status != null}">
                                    <g:if test="${vendorBankAccount?.status == 1}">
                                        <option value="1">Active</option>
                                        <option value="0">Inactive</option>
                                    </g:if>
                                    <g:else>
                                        <option value="0">Inactive</option>
                                        <option value="1">Active</option>
                                    </g:else>
                                </g:if>
                                <g:else>
                                    <option value="1">Active</option>
                                    <option value="0">Inactive</option>
                                </g:else>
                            </select>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-xs-6 col-sm-6 col-md-6">

                <div class="form-group ${hasErrors(bean: vendorBankAccount, field: 'bankAccountName', 'has-error')}">
                    <label for="vendorBankAccountName" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.bankAccount.accountName"
                                   default="Account Name"/><span class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Bank Account Name"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Bank Account Name'"
                                   id="vendorBankAccountName"
                                   name="bankAccountName" value=""/>
                        </div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: vendorBankAccount, field: 'ibanPrefix', 'has-error')}">
                    <label for="vendorIbanPrefix" class="col-sm-4 col-xs-6 control-label no-padding-right">
                        <g:message code="coreBanking.accounting.vendor.bankAccount.ibanPrefix"
                                   default="Iban Prefix"/><span class="red">*</span>
                    </label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <input type="text" class="col-sm-11 col-xs-12" placeholder="Iban Prefix"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Iban Prefix'"
                                   id="vendorIbanPrefix"
                                   name="ibanPrefix" value=""/>
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <label for="addBankAccount" class="col-sm-4 col-xs-6 control-label no-padding-right"></label>

                    <div class="col-sm-8 col-xs-12">
                        <div class="clearfix">
                            <g:if test="${vendorMaster?.bankAccountInfo}">
                                <button class="btn btn-primary btn-sm" type="submit" name="addBankAccount"
                                        id="addBankAccount">Add another Account</button>
                            </g:if>
                            <g:else>
                                <button class="btn btn-primary btn-sm" type="submit" name="addBankAccount"
                                        id="addBankAccount">Add Bank Account</button>
                            </g:else>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</g:form>


<div class="clearfix">
    <div class="col-xs-12">
        <div class="table-header">
            Bank Account List
        </div>

        <div class="table-responsive">
            <table id="bank-acconut-list" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>

                    <th class="center">Bank Name</th>
                    <th class="center">Account Name</th>
                    <th class="center">Account No.</th>
                    <th class="center">Iban Prefix</th>
                    <th class="center">Action</th>
                </tr>
                </thead>

                <tbody>
                <g:each status="i" in="${vendorMaster?.bankAccountInfo}" var="bankAccount">
                    <tr>

                        <td id="attCaption">${bankAccount?.bankName}</td>
                        <td id="attName">${bankAccount?.bankAccountName}</td>
                        <td id="attDescription">${bankAccount?.bankAccountNo}</td>
                        <td id="attType">${bankAccount?.ibanPrefix}</td>
                        <td class="actions ">
                            <div class="btn-group">

                                <sec:access controller="vendor" action="editBankAccount">
                                    <a class="btn btn-sm bankaccount-edit-link"
                                       href="#" bankAccountId="${bankAccount?.id}" vendorId="${vendorMaster?.id}"
                                       title="Edit"><i class="glyphicon glyphicon-pencil orange"></i></a>
                                </sec:access>
                                <sec:access controller="vendor" action="deleteBankAccount">
                                    <a class="btn btn-sm delete btn-danger bankaccount-delete-link"
                                       onclick="return confirm('Are you sure delete Account?')"
                                       href="#" bankAccountId="${bankAccount?.id}" vendorId="${vendorMaster?.id}"
                                       title="Delete"><i class="glyphicon glyphicon-remove "></i></a>
                                </sec:access>
                            </div>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>

</div>



<script type="text/javascript">

    jQuery(function ($) {

        var bankAccount = $('#bank-acconut-list').DataTable({
            "sDom": " ",
            "bAutoWidth": true,
            "aoColumns": [

                null,
                null,
                null,
                null,
                { "bSortable": false }
            ]
        });

        $('#vendorBankAccountInfoForm').validate({

            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                bankName: {
                    required: true
                },
                bankAccountName: {
                    required: true
                },
                bankAccountNo: {
                    required: true
                },
                ibanPrefix: {
                    required: true
                }
            },
            messages: {
                bankName: {
                    required: " "
                },
                bankAccountName: {
                    required: " "
                },
                bankAccountNo: {
                    required: " "
                },
                ibanPrefix: {
                    required: " "
                }

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
                    url: "${createLink(controller: 'vendor', action: 'saveVendorBankAccountInfo')}",
                    type: 'post',
                    dataType: 'JSON',
                    data: $("#vendorBankAccountInfoForm").serialize(),
                    success: function (data) {

                        if (data.update == true) {
                            var oTable = $('#bank-acconut-list').dataTable();
                            oTable.fnUpdate([data.bankInfo.bankName], data.selectedRow, 0);
                            oTable.fnUpdate([data.bankInfo.bankAccountName], data.selectedRow, 1);
                            oTable.fnUpdate([data.bankInfo.bankAccountNo], data.selectedRow, 2);
                            oTable.fnUpdate([ data.bankInfo.ibanPrefix], data.selectedRow, 3);
                            oTable.fnUpdate([ "<sec:access controller="vendor" action="editBankAccount"><a class='btn btn-sm bankaccount-edit-link'  href='' bankAccountId=" + data.bankInfo.id + " vendorId=" + data.vandorInfo.id + " title='Edit'><i class='glyphicon glyphicon-pencil orange'></i></a></sec:access>" + "  " +
                                    "<sec:access controller="vendor" action="deleteBankAccount"><a class='btn btn-sm delete btn-danger bankaccount-delete-link' href='' bankAccountId=" + data.bankInfo.id + " vendorId=" + data.vandorInfo.id + " title='Delete'><i class='glyphicon glyphicon-remove'></i></a></sec:access>"], data.selectedRow, 4); // Row

                            $("#messageDiv").removeClass('hidden');
                            $("#message").text(data.message);
                            $("#vendorbankName").val(' ');
                            $("#vendorBankAccountNo").val(' ');
                            $("#vendorBankAccountName").val(' ');
                            $("#vendorIbanPrefix").val(' ');
                            $("#accountID").val(' ');
                            $("#selectRow").val(' ');
                            $('#addBankAccount').html('Add Bank Account');
                            return
                        }
                        bankAccount.row.add([
                            data.bankInfo.bankName,
                            data.bankInfo.bankAccountName,
                            data.bankInfo.bankAccountNo,
                            data.bankInfo.ibanPrefix,
                            "<sec:access controller="vendor" action="editBankAccount"><a class='btn btn-sm bankaccount-edit-link' id=" + data.bankInfo.id + " href='' bankAccountId=" + data.bankInfo.id + " vendorId=" + data.vandorInfo.id + " title='Edit'><i class='glyphicon glyphicon-pencil orange'></i></a></sec:access>" + "  " +
                                    "<sec:access controller="vendor" action="deleteBankAccount"><a class='btn btn-sm delete btn-danger bankaccount-delete-link' href='' bankAccountId=" + data.bankInfo.id + " vendorId=" + data.vandorInfo.id + " title='Delete'><i class='glyphicon glyphicon-remove'></i></a></sec:access>"
                        ]).draw();

                        $("#messageDiv").removeClass('hidden');
                        $("#message").text(data.message);
                        $("#vendorbankName").val(' ');
                        $("#vendorBankAccountNo").val(' ');
                        $("#vendorBankAccountName").val(' ');
                        $("#vendorIbanPrefix").val(' ');
                    },
                    failure: function (data) {
                    }

                })
            }
        });

        $('#bank-acconut-list').on('click', 'a.bankaccount-edit-link', function (e) {

            var bankAccount = $('#bank-acconut-list').DataTable();
            var control = this;
            var bankAccountId = $(control).attr('bankAccountId');
            var vendorId = $(control).attr('vendorId');
            var tr = $(control).parents('tr');
            var selectRow = bankAccount.row(tr).index();

            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'vendor',action: 'editBankAccount')}?id=" + vendorId + "&bankAccountId=" + bankAccountId + "&selectedRow=" + selectRow,
                success: function (data, textStatus) {

                    $("#messageDiv").addClass('hidden');
                    $('#selectRow').val(selectRow);
                    $('#accountID').val(data.id);
                    $('#vendorbankName').val(data.bankName);
                    $('#vendorBankAccountNo').val(data.bankAccountNo);
                    $('#vendorBankAccountName').val(data.bankAccountName);
                    $('#vendorIbanPrefix').val(data.ibanPrefix);
                    $('#addBankAccount').html('Update');


                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            e.preventDefault();

        });

        $('#bank-acconut-list').on('click', 'a.bankaccount-delete-link', function (e) {
            var control = this;
            var bankAccountId = $(control).attr('bankAccountId');
            var vendorId = $(control).attr('vendorId');
            var selectRow = $(control).parents('tr');
            var confirmDel=confirm("Do you want to delete?");
            if(confirmDel==true){
                $.ajax({

                    type: 'POST',
                    dataType: 'JSON',
                    url: "${g.createLink(controller: 'vendor',action: 'deleteBankAccount')}?id=" + vendorId + "&bankAccountId=" + bankAccountId,
                    success: function (data) {
                        if (data.isError == false) {
                            $("#messageDiv").removeClass('hidden');
                            $("#message").text(data.message);
                            $('#bank-acconut-list').DataTable().row(selectRow).remove().draw();
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
            }

            e.preventDefault();
        });
    });

</script>
</body>
</html>
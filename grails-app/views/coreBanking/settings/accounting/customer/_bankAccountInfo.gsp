<style>
#sample-table-2_length label{width: inherit;}
</style>

<g:form id="customerAccountInfoForm" name="customerAccountInfoForm" method="post" role="form" class="form-inline"
        url="[action: 'saveBankAccount', controller: 'customer']" onSubmit="return false;">

    <g:hiddenField name="id" id="customerBankAccountId" value="${bankAccountInfo?.id}"/>
    <g:hiddenField name="customerId" id="customerId" value="${customerMaster?.id}"/>
    <input type="hidden" name="row" id="rowBankAccount" value="">
    %{--<g:hiddenField name="generalAddressId" id="generalAddressId" value="${generalAddress?.id}"/>--}%
    %{--<g:hiddenField name="postalAddressId" id="postalAddressId" value="${postalAddress?.id}"/>--}%
    %{--<g:hiddenField name="shippingAddressId" id="shippingAddressId" value="${shippingAddress?.id}"/>--}%

    <div class="form-group ${hasErrors(bean:customerBankAccountCommand,field:'bankAccountName','has-error')}">
        <label for="bankName">Bank Name*</label>
        <input type="text" placeholder="Enter Bank Name"
               id="bankName" name="bankName"  value="${bankAccountInfo?.bankName}">
    </div>
    <div class="form-group ${hasErrors(bean:customerBankAccountCommand,field:'ibanPrefix','has-error')}">
        <label for="ibanPrefix">Iban Prefix*</label>
        <input type="text" placeholder="Enter Iban Prefix"
               id="ibanPrefix" name="ibanPrefix"  value="${bankAccountInfo?.ibanPrefix}">
    </div>
    <div class="form-group ${hasErrors(bean:customerBankAccountCommand,field:'bankAccountNo','has-error')}">
        <label for="bankAccountNo">Bank Account Number*</label>
        <input type="text" placeholder="Enter Bank Account Number"
               id="bankAccountNo" name="bankAccountNo"  value="${bankAccountInfo?.bankAccountNo}">
    </div>
    <div class="form-group ${hasErrors(bean:customerBankAccountCommand,field:'bankAccountName','has-error')}">
        <label for="bankAccountName">Bank Account Name*</label>
        <input type="text" placeholder="Enter Bank Account Name"
               id="bankAccountName" name="bankAccountName"  value="${bankAccountInfo?.bankAccountName}">
    </div>
    %{--<div class="form-group ${hasErrors(bean:customerBankAccountCommand,field:'status','has-error')}">--}%
        %{--<label for="status">Bank Account Status</label>--}%
        %{--<select name="status" id="status">--}%
            %{--<option value="1" ${bankAccountInfo?.status == 1 ? 'selected' : ''}>Active</option>--}%
            %{--<option value="0" ${bankAccountInfo?.status == 0 ? 'selected' : ''}>Inactive</option>--}%
        %{--</select>--}%
    %{--</div>--}%
    <div class="clearfix form-actions align-right">
        %{--<g:if test="${customerMaster?.bankAccounts}">--}%
            %{--<button type="submit" id="bankAccountSubmit" class="btn btn-info">--}%
                %{--<i class="icon-ok bigger-110"></i>Add More</button>--}%
        %{--</g:if>--}%
        %{--<g:else>--}%
            <button type="submit" id="bankAccountSubmit" class="btn btn-info">
                <i class="icon-ok bigger-110"></i>Add</button>
        %{--</g:else>--}%
    </div>
</g:form>

%{--<div class= "row" id="bankAccountListDiv">--}%
    %{--<g:render template="/coreBanking/settings/accounting/customer/bankAccountList"/>--}%
%{--</div>--}%

<div class= "row" id="bankAccountListDiv">
    <div class= "row">
        <div class="col-sm-12">
            <table id="bankAccountTable" class="table table-bordered table-striped table-hover table-condensed">
                <thead>
                <tr>
                    <th>Bank Name</th>
                    <th>Iban Prefix</th>
                    <th>Bank Account No.</th>
                    <th>Bank Account Name</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody id="bankAccountTableId">
                <g:each in="${customerMaster?.bankAccounts}" var="bankAccount" status="i">

                    <tr>
                        <td id="attBankName">${bankAccount.bankName}</td>
                        <td id="attIbanPrefix">${bankAccount.ibanPrefix}</td>
                        <td id="attAccountNo">${bankAccount.bankAccountNo}</td>
                        <td id="attAccountName">${bankAccount.bankAccountName}</td>

                        <td class="actions ">
                            <div class="btn-group">
                                <sec:access controller="customer" action="editBankAccount">
                                <a class="btn btn-sm bankAccount-edit-link" href="" id="${bankAccount.id}" customerId="${customerMaster?.id}" title="Edit">
                                    <i class="glyphicon glyphicon-pencil"></i>
                                </a>
                                </sec:access>
                                <sec:access controller="customer" action="deleteBankAccount">
                                <a class="btn btn-sm delete btn-danger bankAccount-delete-link" onclick="return confirm('Are you sure delete Bank Account Information?')"
                                   href="" id="${bankAccount.id}" customerId="${customerMaster?.id}" title="Delete"><i class="glyphicon glyphicon-remove "></i>
                                </a>
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
        $(".chosen-select").chosen();

        //var oTable2 = $('#retail-Other-Bank-tbl').dataTable();

        var customerBankAccountTable = $('#bankAccountTable').DataTable({
            "sDom": " ", //<'row'<'col-md-4'><'col-md-4'><'col-md-4'f>r>t<'row'<'col-md-4'l><'col-md-4'i><'col-md-4'p>> ,
            "bAutoWidth": true,
            "aoColumns": [
                null,
                null,
                null,
                null,
                { "bSortable": false }
            ]
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
                $.ajax({
                    url: "${createLink(controller: 'customer', action: 'saveBankAccount')}",
                    type: 'post',
                    dataType: 'json',
                    data: $("#customerAccountInfoForm").serialize(),
                    success: function (data) {
                        if(data.isError == false){
                            if(data.add==true){
                                customerBankAccountTable.row.add( [
//                                    data.bank,
                                    data.customerBankAccount.bankName,
                                    data.customerBankAccount.ibanPrefix,
//                                    data.branch,
                                    data.customerBankAccount.bankAccountNo,
                                    data.customerBankAccount.bankAccountName,
                                    "<div class='btn-group'><a class='btn btn-sm bankAccount-edit-link' href='' id="+data.customerBankAccount.id+" customerId="+data.customerMaster.id+" title='Edit'><i class='glyphicon glyphicon-pencil'></i></a><a class='btn btn-sm delete btn-danger bankAccount-delete-link' href='' id="+data.customerBankAccount.id+" customerId="+data.customerMaster.id+" title='Delete'><i class='glyphicon glyphicon-remove'></i></a></div>"
                                ] ).draw();

                                $(':input','#customerAccountInfoForm').not(':button, :hidden').val('');

                                var success = '<div class="alert alert-success">';
                                success += '<i class="icon-bell green"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                                success += '</div>';
                                $('.successMsg').html(success);
                            }
                            else if(data.update == true){
                                var row = data.row;
                                $('#bankAccountTable').dataTable().fnUpdate( [
//                                    data.bank,
                                    data.customerBankAccount.bankName,
                                    data.customerBankAccount.ibanPrefix,
//                                    data.branch,
                                    data.customerBankAccount.bankAccountNo,
                                    data.customerBankAccount.bankAccountName,
                                    "<div class='btn-group'><a class='btn btn-sm bankAccount-edit-link' href='' id="+data.customerBankAccount.id+" customerId="+data.customerMaster.id+" title='Edit'><i class='glyphicon glyphicon-pencil'></i></a><a class='btn btn-sm delete btn-danger bankAccount-delete-link' href='' id="+data.customerBankAccount.id+" customerId="+data.customerMaster.id+" title='Delete'><i class='glyphicon glyphicon-remove'></i></a></div>"
                                ], row );

                                $(':input,:hidden','#customerAccountInfoForm').not('#customerId').val('');

                                $('#bankAccountSubmit').html('<span class="glyphicon glyphicon-plus"></span> Add More');

                                var success = '<div class="alert alert-success">';
                                success += '<i class="icon-bell green"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                                success += '</div>';
                                $('.successMsg').html(success);

                            }
                        }

                        else{
                            var error = '<div class="alert alert-danger">';
                            error += '<i class="icon-bell red"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                            error += '</div>';
                            $('.successMsg').html(error);
                        }
                    },
                    failure: function (data) {
                    }
                })
            }
            %{--submitHandler: function (form) {--}%
                %{--var actionurl ="${g.createLink(controller:'customer', action: 'saveBankAccount')}";--}%
                %{--$.ajax({--}%
                    %{--url: actionurl,--}%
                    %{--type: 'post',--}%
                    %{--data: $("#customerAccountInfoForm").serialize(),--}%
                    %{--success: function(data) {--}%
                        %{--$('#page-content').html(data);--}%
                    %{--}--}%
                %{--});--}%
            %{--}--}%
        });

        %{--$("#obBank").change(function () {--}%
            %{--var bankId = $(this).val();--}%
            %{--$.ajax({--}%
                %{--url: "${createLink(controller: 'retailClient', action: 'fetchBranch')}?id=" + bankId,--}%
                %{--type: 'post',--}%
                %{--success: function (data) {--}%
                    %{--$("#obBranch").html(data);--}%
                %{--}--}%
            %{--})--}%
        %{--});--}%

        // Delete
        $('#bankAccountTable').on('click', 'a.bankAccount-delete-link', function(e) {
            e.preventDefault();
            var control = this;
            var id = $(control).attr('id');
            var selectRow = $(this).parents('tr');
            var customerId = $(control).attr('customerId');
            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'customer',action: 'deleteBankAccount')}?id="+id+"&customerId="+customerId,
                success: function (data, textStatus) {
                    if(data.isError == false){
                        var success = '<div class="alert alert-success">';
                        success += '<i class="icon-bell green"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                        success += '</div>';
                        $('.successMsg').html(success);
                        $('#bankAccountTable').DataTable().row( selectRow ).remove().draw();
                    }
                    else{
                        var error = '<div class="alert alert-danger">';
                        error += '<i class="icon-bell red"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                        error += '</div>';
                        $('.successMsg').html(error);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });
        });

        // edit
        $('#bankAccountTable').on('click', 'a.bankAccount-edit-link', function(e) {
            e.preventDefault();
            var control = this;
            var id = $(control).attr('id');
            //var retailAccount = $(control).attr('retailAccount');
            var tr = $(this).parents('tr');
            var row = customerBankAccountTable.row( tr ).index();

            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'customer',action: 'editBankAccount')}?id="+id+"&row="+row,
                success: function (data, textStatus) {
                    if(data.isError == false){

//                        $('#obBank').val(data.bank.id);
                        $('#customerAccountInfoForm #bankName').val(data.customerBankAccount.bankName);
                        $('#ibanPrefix').val(data.customerBankAccount.ibanPrefix);
//                        $('#obBranch').val(data.branch.id);
                        $('#bankAccountNo').val(data.customerBankAccount.bankAccountNo);
                        $('#bankAccountName').val(data.customerBankAccount.bankAccountName);
                        $('#customerBankAccountId').val(data.customerBankAccount.id);
                        $('#bankAccountSubmit').html('<span class="glyphicon glyphicon-check"></span>Update');
                        $('#rowBankAccount').val(data.row);
                    }
                    else{
                        var error = '<div class="alert alert-danger">';
                        error += '<i class="icon-bell red"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                        error += '</div>';
                        $('.successMsg').html(error);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });
        });


    });
</script>

<%@ page import="com.gsl.oros.core.banking.settings.Bank" %>
<html>
<head></head>

<body>
<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="widget-box">
            <div class="widget-header widget-header-blue widget-header-flat"><h5 class="lighter">Other Bank Information</h5></div>
            <div class="widget-body">
                <div class="widget-main no-padding">
                    <form name="accountOpenOtherBankInfoForm" id="accountOpenOtherBankInfoForm" class="form-horizontal">
                        <input type="hidden" id="accountObj" name="accountObj" value="${saveAccObj?.id}">
                        <input type="hidden" name="id" id="accOtherBankId" value="">
                        <input type="hidden" name="row" id="rowBank" value="">
                        <fieldset>%{--saveAccObj--}%
                        <div class="form-group col-xs-6 col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label for="otherBank" class="col-sm-4 control-label no-padding-right">Bank Name</label>
                                <div class="col-sm-8 col-xs-8">
                                    <g:select id="otherBank" name='bank' class="form-control" required=""
                                              noSelection="${['': 'Select Bank...']}"
                                              from='${Bank.list(sort: 'name')}' value=""
                                              optionKey="id" optionValue="name">
                                    </g:select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="obBranch" class="col-sm-4 control-label no-padding-right">Branch</label>

                                <div class="col-sm-8 col-xs-8">
                                    <g:select id="obBranch" name='branch' class="form-control" required=""
                                              noSelection="${['': 'Select branch...']}"
                                              from='' value=""
                                              optionKey="id" optionValue="name">
                                    </g:select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label no-padding-right" for="otherBankSortCode">Sort Code</label>

                                <div class="col-sm-8 col-xs-8">
                                    <div class="clearfix">
                                        <input id="otherBankSortCode" class="form-control" type="text" name="sortCode"
                                               placeholder="Sort Code" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Sort Code'"
                                               required>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label no-padding-right" for="accAccountTitle">Account Title</label>

                                <div class="col-sm-8 col-xs-8">
                                    <div class="clearfix">
                                        <input id="accAccountTitle" class="form-control" type="text" name="accountTitle"
                                               placeholder="Title of the Account" required="required">
                                    </div>

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label no-padding-right" for="otherBankAccNo">Account No</label>

                                <div class="col-sm-8 col-xs-8">
                                    <div class="clearfix">
                                        <input id="otherBankAccNo" class="form-control" type="text" name="otherBankAccNo"
                                               placeholder="Account No" onfocus="this.placeholder = ''"
                                               onblur="this.placeholder = 'Account No'"
                                               required>
                                    </div>

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label no-padding-right" for="otherBankType">Type</label>

                                <div class="col-sm-8 col-xs-8">
                                    <div class="clearfix">
                                        <input id="otherBankType" class="form-control" type="text" name="otherBankAccType"
                                               placeholder="Type"
                                               onfocus="this.placeholder = ''" onblur="this.placeholder = 'Type'" required>
                                    </div>

                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-4 control-label no-padding-right"></div>
                                <div class="col-sm-8 col-xs-8" style="float: right">
                                    <button type="submit" name="addOtherBankAccount" id="addOtherBankAccount"  class="btn btn-info btn-sm" value="">
                                        <span class="glyphicon glyphicon-plus"></span> Add
                                    </button>

                                    <button type="button" name="resetOtherBankAccount" id="resetOtherBankAccount"  class="btn btn-info btn-sm" value="">
                                        <span class="glyphicon glyphicon-minus-sign"></span> Reset
                                    </button>
                                </div>
                            </div>

                        </div>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="space-2"></div>
<div class= "row" id="accountOtherBankListDiv">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="widget-box">
            <div class="widget-header widget-header-blue"><h5 class="lighter">Other Bank Information List</h5></div>
            <div class="widget-body">
                <div class="widget-main no-padding">
                    <table id="account-Other-Bank-tbl" class="table table-bordered table-striped table-hover table-condensed ">
                        <thead>
                        <tr>
                            <th>Bank Name</th>
                            <th>Branch</th>
                            <th>Account No.</th>
                            <th>Account Title</th>
                            <th>Type</th>
                            <th>Sort Code</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody id="otherBankAccountTableId">
                        <g:each in="${saveAccObj?.accOtherBank}" var="otherBank" status="i">
                            <tr>
                                <td id="bank">${otherBank.bank.name}</td>
                                <td id="branch">${otherBank.branch.name}</td>
                                <td id="accountNo">${otherBank.otherBankAccNo}</td>
                                <td id="accountName">${otherBank.accountTitle}</td>
                                <td id="type">${otherBank.otherBankAccType}</td>
                                <td id="sortCode">${otherBank.sortCode}</td>

                                <td class="actions ">
                                    <div class="btn-group">
                                        <a class="btn btn-sm" href="" id="${otherBank.id}" accountObj="${saveAccObj?.id}" title="Edit">
                                            <i class="green glyphicon glyphicon-edit"></i></a>

                                        <a class="btn btn-sm delete btn-danger otherBankAccount-delete-link" onclick="return confirm('Are you sure delete Other Bank Account Information?')"
                                           href="" id="${otherBank.id}" accountObj="${saveAccObj?.id}"
                                           title="Delete"><i class="glyphicon glyphicon-remove "></i></a>
                                    </div>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


<script type="text/javascript">

    $(document).ready(function () {
        $('#accountOpenOtherBankInfoForm').validate({
            errorPlacement: function (error, element) {
            },
            focusInvalid: false,
            rules: {
                accAccountTitle: {
                    required: true
                },
                otherBankAccNo: {
                    digits: true,
                    required: true
                },
                otherBankBranch: {
                    required: true
                },
                otherBankType: {
                    required: true
                },
                otherBankSortCode: {
                    required: true
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#accountOpenOtherBankInfoForm')).show();
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            unhighlight: function (e) { // <-- fires when element is valid
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
            }
        });

        var otherBankTable = $('#account-Other-Bank-tbl').DataTable({
            "sDom": " ", //<'row'<'col-md-4'><'col-md-4'><'col-md-4'f>r>t<'row'<'col-md-4'l><'col-md-4'i><'col-md-4'p>> ,
            "bAutoWidth": true,
            "aoColumns": [
                null,
                null,
                null,
                null,
                null,
                null,
                { "bSortable": false }
            ]
        });

        $("#accountOpenOtherBankInfoForm").submit(function (e) {
            if (!$("#accountOpenOtherBankInfoForm").valid()) return false;

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: "${createLink(controller: "accountOpen",action: "otherBankAccInfoSave")}",
                data: $(this).serialize(),
                success: function (data) {
                    if(data.isError == false){
                        if(data.add==true){
                            otherBankTable.row.add( [
                                data.bank,
                                data.branch,
                                data.accountOtherBank.otherBankAccNo,
                                data.accountOtherBank.accountTitle,
                                data.accountOtherBank.otherBankAccType,
                                data.accountOtherBank.sortCode,
                                "<div class='btn-group'><a class='btn btn-sm otherBankAccount-edit-link' href='' id="+data.accountOtherBank.id+" title='Edit'><i class='green glyphicon glyphicon-edit'></i></a><a class='btn btn-sm delete btn-danger otherBankAccount-delete-link' href='' id="+data.accountOtherBank.id+" title='Delete'><i class='glyphicon glyphicon-remove'></i></a></div>"
                            ] ).draw();

                            $(':input','#accountOpenOtherBankInfoForm').not(':button, :hidden').val('');
                            $('#obBranch').html('');
                            var success = '<div class="alert alert-success">';
                            success += '<i class="icon-bell green"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                            success += '</div>';
                            $('.successMsg').html(success);
                        }
                        else if(data.update == true){
                            var row = data.row;
                            $('#account-Other-Bank-tbl').dataTable().fnUpdate( [
                                data.bank,
                                data.branch,
                                data.accountOtherBank.otherBankAccNo,
                                data.accountOtherBank.accountTitle,
                                data.accountOtherBank.otherBankAccType,
                                data.accountOtherBank.sortCode,
                                "<div class='btn-group'><a class='btn btn-sm otherBankAccount-edit-link' href='' id="+data.accountOtherBank.id+" title='Edit'><i class='green glyphicon glyphicon-edit'></i></a><a class='btn btn-sm delete btn-danger otherBankAccount-delete-link' href='' id="+data.accountOtherBank.id+" title='Delete'><i class='glyphicon glyphicon-remove'></i></a></div>"
                            ], row );

//                            $(':input,:hidden','#accountOpenOtherBankInfoForm').not('#accountObj').val('');
                            $(':input, :hidden','#accountOpenOtherBankInfoForm').not('#accountObj').val('');
                            $('#obBranch').html('');
                            $('#addOtherBankAccount').html('<span class="glyphicon glyphicon-plus"></span> Add');

                            var success = '<div class="alert alert-success">';
                            success += '<i class="icon-bell green"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                            success += '</div>';
                            $('.successMsg').html(success);

                        }
                    }else{
                        var error = '<div class="alert alert-danger">';
                        error += '<i class="icon-bell red"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                        error += '</div>';
                        $('.successMsg').html(error);
                    }
                },
                failure: function (data) {}
            });
            return false
            e.preventDefault();
        });

        $("#otherBank").change(function () {
            var bankId = $(this).val();
            $.ajax({
                url: "${createLink(controller: 'accountOpen', action: 'showBankBranch')}?id=" + bankId,
                type: 'post',
                success: function (data) {
                    $("#obBranch").html(data);
                }
            })
        });

        // edit
        $('#account-Other-Bank-tbl').on('click', 'a.otherBankAccount-edit-link', function(e) {
            e.preventDefault();
            var control = this;
            var id = $(control).attr('id');
            var accountObj = $(control).attr('accountObj');
            var tr = $(this).parents('tr');
            var row = otherBankTable.row(tr).index();

            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'accountOpen',action: 'editAccOtherBankAccount')}?id=" + id + "&row=" + row,
                success: function (data, textStatus) {
                    if (data.isError == false) {
                        $('#otherBank').val(data.bank.id);
                        //$('#obBranch').val(data.branch.id);
                        $('#otherBankAccNo').val(data.accOtherBank.otherBankAccNo);
                        $('#accAccountTitle').val(data.accOtherBank.accountTitle);
                        $('#otherBankType').val(data.accOtherBank.otherBankAccType);
                        $('#otherBankSortCode').val(data.accOtherBank.sortCode);
                        $('#accOtherBankId').val(data.accOtherBank.id);
                        $('#addOtherBankAccount').html('<span class="glyphicon glyphicon-check"></span> Update');
                        $('#rowBank').val(data.row);

                        var bankId = data.bank.id;
                        getAllBranch(bankId);



                    } else {
                        var error = '<div class="alert alert-danger">';
                        error += '<i class="icon-bell red"> <b>' + data.message + '</b> </i> <a class="close" data-dismiss="alert">×</a>';
                        error += '</div>';
                        $('.successMsg').html(error);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });
        });

        // Delete
        $('#account-Other-Bank-tbl').on('click', 'a.otherBankAccount-delete-link', function(e) {
            e.preventDefault();
            var control = this;
            var id = $(control).attr('id');
            var selectRow = $(this).parents('tr');
            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'accountOpen',action: 'deleteAccOtherBankAccount')}?id="+id,
                success: function (data, textStatus) {
                    if(data.isError == false){
                        var success = '<div class="alert alert-success">';
                        success += '<i class="icon-bell green"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                        success += '</div>';
                        $('.successMsg').html(success);
                        $('#account-Other-Bank-tbl').DataTable().row( selectRow ).remove().draw();
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

        $("#resetOtherBankAccount").click(function(){
            $("#accountOpenOtherBankInfoForm").validate().resetForm();
            $("input[type=text],input[type=number]").val('');
            $('select#otherBank option:eq(0)').attr('selected','selected');
            $('#obBranch').html('');
            $('#otherBank').val('');

        });

        function getAllBranch (bankId) {
            $.ajax({
                url: "${createLink(controller: 'accountOpen', action: 'showBankBranch')}?id=" + bankId,
                type: 'post',
                success: function (data) {
                    $("#obBranch").html(data);
                }
            })
        }


        jQuery.validator.messages.required = "";
    });
</script>

</body>
</html>
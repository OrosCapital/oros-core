<html>
<head></head>
<body>
<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="widget-box">
            <div class="widget-header widget-header-blue"><h5 class="lighter">Introducer Information</h5></div>
            <div class="widget-body">
                <div class="widget-main no-padding">
                    <form name="accIntroducerInfoForm" id="introducerInfoForm" class="form-horizontal">
                        <!-- <legend>Form</legend> -->
                        <input type="hidden" name="id" value="${accountOpenId}">
                        <input type="hidden" name="accountHolder" value="">
                        <input type="hidden" name="account" value="${accountOpenId}">

                        <fieldset>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label no-padding-right" for="accountId">A/C No</label>

                                <div class="col-sm-8 col-xs-8">
                                    <div class="clearfix">
                                        <input id="accountId" class="form-control" type="text" name="accountId" placeholder="A/C No">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group ${hasErrors(bean: commandObj, field: 'name', 'has-error')}">
                                <label class="col-sm-4 control-label no-padding-right" for="name">Name</label>

                                <div class="col-sm-8 col-xs-8">
                                    <div class="clearfix">
                                        <input id="name" class="form-control" type="text" name="name" placeholder="Name of Introducer" disabled="disabled">
                                    </div>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-4 control-label no-padding-right" for="address">Address</label>

                                <div class="col-sm-8 col-xs-8">
                                    <div class="clearfix">
                                        <input id="address" class="form-control" type="text" name="address" placeholder="Address" disabled="disabled">
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">

                            <div class="form-group">
                                <label class="col-sm-4 control-label no-padding-right" for="contactNo">Contact No</label>

                                <div class="col-sm-8 col-xs-8">
                                    <div class="clearfix">
                                        <input id="contactNo" class="form-control" type="text" name="contactNo" placeholder="Contact No" disabled="disabled">
                                    </div>

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label no-padding-right" for="relAcNo">Relation of A/C Holder</label>
                                <div class="col-sm-8 col-xs-8">
                                    <div class="clearfix">
                                        <input id="relAcNo" class="form-control" type="text" name="relation" placeholder="Relation Of A/C Holder">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-4 control-label no-padding-right"></div>
                                <div class="col-sm-8 col-xs-8" style="float: right">
                                    <button type="submit" name="addIntroducer" id="addIntroducerBtn"  class="btn btn-info btn-sm" value="">
                                        <span class="glyphicon glyphicon-plus"></span> Add
                                    </button>

                                    %{--<button type="button" name="resetIntroducer" id="resetIntroducer"  class="btn btn-info btn-sm" value="">
                                        <span class="glyphicon glyphicon-minus-sign"></span> Reset
                                    </button>--}%
                                </div>
                            </div>

                        </div>

                        </fieldset>

                        %{--<div class="clearfix form-actions">
                            <div class="col-md-12 pull-right">
                                <button class="btn btn-info" type="submit"><i class="icon-ok bigger-110"></i>Save</button>
                                <button class="btn" type="reset"><i class="icon-undo bigger-110"></i>Reset</button>
                            </div>
                        </div>--}%
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="space-2"></div>
<div class= "row" id="introducerListDiv">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="widget-box">
            <div class="widget-header widget-header-blue"><h5 class="lighter">Introducer List</h5></div>
            <div class="widget-body">
                <div class="widget-main no-padding">
                    <table id="accIntroducerListTbl" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Account No.</th>
                            <th>Relation</th>
                            %{--<th>Address</th>
                            <th>Contact No.</th>--}%
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody id="introducerTableId">
                        <g:each in="" var="introducer" status="i">
                            <tr>
                                <td id="attCaption"></td>
                                <td id="attName"></td>

                                <td id="attDescription"></td>
                                <td id="attSize"></td>
                                <td id="attType"></td>


                                <td class="actions ">
                                    <div class="btn-group">
                                        <a class="btn btn-sm delete btn-danger introducer-delete-link" onclick="return confirm('Are you sure delete Introducer Information?')"
                                           href="" id="" retailAccount=""
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

        $('#introducerInfoForm').validate({
            errorPlacement: function (error, element) {
            },
            focusInvalid: false,
            rules: {
                accountId: {
                    digits: true,
                    required: true

                },
                relation: {
                    required: true
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#introducerInfoForm')).show();
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


        var introducerTable = $('#accIntroducerListTbl').DataTable({
            "sDom": " ", //<'row'<'col-md-4'><'col-md-4'><'col-md-4'f>r>t<'row'<'col-md-4'l><'col-md-4'i><'col-md-4'p>> ,
            "bAutoWidth": true,
            "aoColumns": [
                null,
                null,
                null,
                //null,
                //null,
                { "bSortable": false }
            ]
        });

        $("#introducerInfoForm").submit(function (e) {
            if (!$("#introducerInfoForm").valid()) return false;

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: "${createLink(controller: "accountOpen",action: "introducerInfoSave")}",
                data: $(this).serialize(),
                success: function (data) {
                    if (data.isError == true) {
                        var error = '<div class="alert alert-danger">';
                        error += '<i class="icon-bell green"> <b>' + data.message + '</b> </i> <a class="close" data-dismiss="alert">×</a>';
                        error += '</div>';
                        $('.successMsg').html(error);
                        return false;
                    } else {
                        introducerTable.row.add([
                            data.accountHolder.firstName,
                            data.accountHolder.id,
                            data.accountIntroducer.relation,
                            /*data.accountHolder.address,
                            data.accountHolder.contactNo,*/
                            "<div class='btn-group'><a class='btn btn-sm delete btn-danger introducer-delete-link' href='' id=" +  data.accountIntroducer.id + " title='Delete'><i class='glyphicon glyphicon-remove'></i></a>"
                            /*<a class='btn btn-sm account-introducer-edit-link' href='' id="+data.accountIntroducer.id+" title='Edit'><i class='green glyphicon glyphicon-edit'></i></a>*/
                        ]).draw();

                        $('#accountId').val('');
                        $('#name').val('');
                        $('#relAcNo').val('');
                        $('#address').val('');
                        $('#contactNo').val('');
                    }
                }
            });
            return false
            e.preventDefault();
        });

        $("#accountId").bind('keypress', function (e) {
            if ((e.keyCode == 13) || ( e.keyCode == 9)) {
                e.preventDefault();
                if(!$("#accountId").valid()) return false;
                var clientId = $("#accountId").val().trim();
                jQuery.ajax({
                    type: 'post',
                    dataType: 'json',
                    url: "${createLink(controller:'accountOpen', action: 'showClientInfo')}?clientId=" + clientId,
                    success: function (data, textStatus) {
                        showClientInfo(data);
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

        // Delete
        $('#accIntroducerListTbl').on('click', 'a.introducer-delete-link', function(e) {
            e.preventDefault();
            var control = this;
            var id = $(control).attr('id');
            var selectRow = $(this).parents('tr');

            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'accountOpen',action: 'introducerInfoDelete')}?id="+id,
                success: function (data, textStatus) {
                    if(data.isError == false){

                        var success = '<div class="alert alert-success">';
                        success += '<i class="icon-bell green"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                        success += '</div>';
                        $('.successMsg').html(success);
                        $('#accIntroducerListTbl').DataTable().row( selectRow ).remove().draw();
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

        jQuery.validator.messages.required = "";
    });


    function showClientInfo(data) {
        if (data.available == false) {
            $('.err-msg').text(data.message).show();
            $('div#error-message-div').show();
            $("input#accountId").val('');
            $("input#name").val('');
            $("input#address").val('');
            $("input#contactNo").val('');
            $("input#accountHolder").val('');
            $("#accountId").focus();
            return false;
        }
        var client = data.accountHolder
        $("input[name=accountHolder]").val(client.id);
        $("input[name=accountHolder]").val(client.id);
        $("input[name=name]").val(client.firstName);
        $("#address").val(client.address ? client.address :'Mirpur, Dhaka');
        $("#contactNo").val(client.contactNo ? client.contactNo : '01713955862');
    }
</script>
</body>
</html>
<style>
.form-inline .form-group{
    margin-bottom: 10px !important;
    vertical-align: top;
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

<g:form id="educationForm" name="educationForm" method="post" role="form" class="form-inline">

    <g:hiddenField name="id" id="educationId" value="${educationalInfo?.id}"/>
    <g:hiddenField name="accountHolderId" id="accountHolderId" value="${accountHolder?.id}"/>
    <input type="hidden" name="row" id="rowEducation" value="">

    <div class="form-group ${hasErrors(bean:educationalInfoCommand,field:'degreeName','has-error')}">
        <label for="degreeName">Degree*</label>
        <input type="text" placeholder="Enter Degree Name"
               id="degreeName" name="degreeName"  value="${educationalInfo?.degreeName}">
    </div>
    <div class="form-group ${hasErrors(bean:educationalInfoCommand,field:'boardName','has-error')}">
        <label for="boardName">Board Name*</label>
        <input type="text" placeholder="Enter Board Name"
               id="boardName" name="boardName" value="${educationalInfo?.boardName}">
    </div>
    <div class="form-group ${hasErrors(bean:educationalInfoCommand,field:'instituteName','has-error')}">
        <label for="instituteName">Institute Name*</label>
        <input type="text" placeholder="Enter Institute Name"
               id="instituteName" name="instituteName" value="${educationalInfo?.instituteName}">
    </div>
    <div class="form-group ${hasErrors(bean:educationalInfoCommand,field:'achievedResult','has-error')}">
        <label for="achievedResult">Result*</label>
        <input type="text" placeholder="Enter Your Result"
               id="achievedResult" name="achievedResult"  value="${educationalInfo?.achievedResult}">
    </div>
    <div class="clearfix form-actions align-right">
        %{--<g:if test="${accountHolder?.educationalInfo}">--}%
            %{--<button type="submit" id="educationSubmitButton" class="btn btn-info">--}%
                %{--<i class="icon-ok bigger-110"></i>Add More</button>--}%
        %{--</g:if>--}%
        %{--<g:else>--}%
            <button type="submit" id="educationSubmitButton" class="btn btn-info">
                <i class="icon-ok bigger-110"></i>Add</button>
        %{--</g:else>--}%
    </div>
</g:form>

%{--<div class= "row" id="EducationListDiv">--}%
    %{--<g:render template="educationListTable"/>--}%
%{--</div>--}%

<div class= "row" id="educationListDiv">
    <div class= "row">
        <div class="col-sm-12">
            <table id="educationTable" class="table table-bordered table-striped table-hover table-condensed">
                <thead>
                <tr>
                    <th>Degree</th>
                    <th>Institute Name</th>
                    <th>Board Name</th>
                    <th>Result</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody id="educationTableId">
                <g:each in="${accountHolder?.educationalInfo}" var="educationalInfo" status="i">

                    <tr>
                        <td id="attDegree">${educationalInfo.degreeName}</td>
                        <td id="attInstitute">${educationalInfo.instituteName}</td>
                        <td id="attBoard">${educationalInfo.boardName}</td>
                        <td id="attResult">${educationalInfo.achievedResult}</td>

                        <td class="actions ">
                            <div class="btn-group">
                                <sec:access controller="accountHolderInfo" action="editEducationalInfo">
                                    <a class="btn btn-sm education-edit-link" href="" id="${educationalInfo.id}" accountHolderId="${accountHolder?.id}" title="Edit">
                                        <i class="glyphicon glyphicon-pencil"></i>
                                    </a>
                                </sec:access>
                                <sec:access controller="accountHolderInfo" action="deleteEducationalInfo">
                                    <a class="btn btn-sm delete btn-danger education-delete-link" onclick="return confirm('Are you sure delete Bank Account Information?')"
                                       href="" id="${educationalInfo.id}" accountHolderId="${accountHolder?.id}" title="Delete"><i class="glyphicon glyphicon-remove "></i>
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

        var educationTable = $('#educationTable').DataTable({
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

        $('#educationForm').validate({
            errorElement: 'div',
            errorClass: 'help-block hidden',
            focusInvalid: false,
            rules: {
                degreeName: {
                    required: true
                },
                boardName: {
                    required: true
                },
                instituteName: {
                    required: true
                },
                achievedResult: {
                    required: true
                }
            } ,
            messages: {
                degreeName: {
                    required: "Please provide degree"
                },
                boardName: {
                    required: "Please provide board name"
                },
                instituteName: {
                    required: "Please provide institute name"
                },
                achievedResult: {
                    required: "Please provide result"

                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#educationForm')).show();
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
                    url: "${createLink(controller: 'accountHolderInfo', action: 'saveEducation')}",
                    type: 'post',
                    dataType: 'json',
                    data: $("#educationForm").serialize(),
                    success: function (data) {
                        if(data.isError == false){
                            if(data.add==true){
                                educationTable.row.add( [
                                    data.educationalInfo.degreeName,
                                    data.educationalInfo.instituteName,
                                    data.educationalInfo.boardName,
                                    data.educationalInfo.achievedResult,
                                    "<div class='btn-group'><a class='btn btn-sm education-edit-link' href='' id="+data.educationalInfo.id+" title='Edit'><i class='glyphicon glyphicon-pencil'></i></a><a class='btn btn-sm delete btn-danger education-delete-link' href='' id="+data.educationalInfo.id+" accountHolderId="+data.accountHolder.id+" title='Delete'><i class='glyphicon glyphicon-remove'></i></a></div>"
                                ] ).draw();

                                $(':input','#educationForm').not(':button, :hidden').val('');

                                var success = '<div class="alert alert-success">';
                                success += '<i class="icon-bell green"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                                success += '</div>';
                                $('.successMsg').html(success);
                            }
                            else if(data.update == true){
                                var row = data.row;
                                $('#educationTable').dataTable().fnUpdate( [
                                    data.educationalInfo.degreeName,
                                    data.educationalInfo.instituteName,
                                    data.educationalInfo.boardName,
                                    data.educationalInfo.achievedResult,
                                    "<div class='btn-group'><a class='btn btn-sm bankAccount-edit-link' href='' id="+data.educationalInfo.id+" title='Edit'><i class='glyphicon glyphicon-pencil'></i></a><a class='btn btn-sm delete btn-danger bankAccount-delete-link' href='' id="+data.educationalInfo.id+" accountHolderId="+data.accountHolder.id+" title='Delete'><i class='glyphicon glyphicon-remove'></i></a></div>"
                                ], row );

                                $(':input,:hidden','#educationForm').not('#accountHolderId').val('');

                                $('#educationSubmitButton').html('<span class="glyphicon glyphicon-plus"></span> Add More');

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
        });

        // Delete
        $('#educationTable').on('click', 'a.education-delete-link', function(e) {
            e.preventDefault();
            var control = this;
            var id = $(control).attr('id');
            var selectRow = $(this).parents('tr');
            var accountHolderId = $(control).attr('accountHolderId');
            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'accountHolderInfo',action: 'deleteEducationalInfo')}?id="+id+"&accountHolderId="+accountHolderId,
                success: function (data, textStatus) {
                    if(data.isError == false){
                        var success = '<div class="alert alert-success">';
                        success += '<i class="icon-bell green"> <b>'+ data.message +'</b> </i> <a class="close" data-dismiss="alert">×</a>';
                        success += '</div>';
                        $('.successMsg').html(success);
                        $('#educationTable').DataTable().row( selectRow ).remove().draw();
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
        $('#educationTable').on('click', 'a.education-edit-link', function(e) {
            e.preventDefault();
            var control = this;
            var id = $(control).attr('id');
            //var retailAccount = $(control).attr('retailAccount');
            var tr = $(this).parents('tr');
            var row = educationTable.row( tr ).index();

            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'accountHolderInfo',action: 'editEducationalInfo')}?id="+id+"&row="+row,
                success: function (data, textStatus) {
                    if(data.isError == false){

                        $('#degreeName').val(data.educationalInfo.degreeName);
                        $('#instituteName').val(data.educationalInfo.instituteName);
                        $('#boardName').val(data.educationalInfo.boardName);
                        $('#achievedResult').val(data.educationalInfo.achievedResult);
                        $('#educationId').val(data.educationalInfo.id);
                        $('#educationSubmitButton').html('<span class="glyphicon glyphicon-check"></span>Update');
                        $('#rowEducation').val(data.row);
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

%{--<script type="text/javascript">--}%
    %{--$('#educationForm').validate({--}%
        %{--errorElement: 'div',--}%
        %{--errorClass: 'help-block hidden',--}%
        %{--focusInvalid: false,--}%
        %{--rules: {--}%
            %{--degreeName: {--}%
                %{--required: true--}%
            %{--},--}%
            %{--boardName: {--}%
                %{--required: true--}%
            %{--},--}%
            %{--instituteName: {--}%
                %{--required: true--}%
            %{--},--}%
            %{--achievedResult: {--}%
                %{--required: true--}%
            %{--}--}%
        %{--} ,--}%
        %{--messages: {--}%
            %{--degreeName: {--}%
                %{--required: "Please provide degree"--}%
            %{--},--}%
            %{--boardName: {--}%
                %{--required: "Please provide board name"--}%
            %{--},--}%
            %{--instituteName: {--}%
                %{--required: "Please provide institute name"--}%
            %{--},--}%
            %{--achievedResult: {--}%
                %{--required: "Please provide result"--}%

            %{--}--}%
        %{--},--}%
        %{--invalidHandler: function (event, validator) { //display error alert on form submit--}%
            %{--$('.alert-danger', $('#educationForm')).show();--}%
        %{--},--}%
        %{--highlight: function (e) {--}%
            %{--$(e).closest('.form-group').removeClass('has-info').addClass('has-error');--}%
        %{--},--}%
        %{--success: function (e) {--}%
            %{--$(e).closest('.form-group').removeClass('has-error').addClass('has-info');--}%
            %{--$(e).remove();--}%
        %{--},--}%
        %{--submitHandler: function (form) {--}%
            %{----}%
            %{--var actionurl ="${g.createLink(controller:'accountHolderInfo', action: 'saveEducation')}";--}%
            %{--$.ajax({--}%
                %{--url: actionurl,--}%
                %{--type: 'post',--}%
                %{--data: $("#educationForm").serialize(),--}%
                %{--success: function(data) {--}%
%{--//                    $('#educationContent').html(data);--}%
                    %{--$('#EducationListDiv').html(data);--}%
                    %{--clearForm('#educationForm');--}%
%{--//                    $('#identificationForm :input#document').val('');--}%
                    %{--$('#educationForm :input#accountHolderId').val('${accountHolder?.id}');--}%
                    %{--$('#educationSubmitButton').html('<i class="icon-ok bigger-110"></i>Add More');--}%
                %{--}--}%
            %{--});--}%
        %{--}--}%
    %{--});--}%
%{--</script>--}%
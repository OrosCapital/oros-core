<%--
  Created by IntelliJ IDEA.
  User: Nusrat Jahan Bhuiyan
  Date: 5/4/14
  Time: 4:33 PM
--%>

<html>
<head>
    <title>OrosCapital - User List</title>
</head>
<body>

<div class="row">
    <div class="col-xs-12">
        <g:if test='${flash.message}'>
            <div class='alert alert-success '>
                <i class="icon-bell green"><b>${flash.message}</b></i>
            </div>
        </g:if>
    </div>
    <sec:access controller="accountHolderInfo" action="create">
        <div class="col-xs-12">
            <span class="navbar-right"><a href="${g.createLink(controller: 'accountHolderInfo',action: 'create')}" id="createAccountHolderLink" class="btn btn-success">Add Client</a></span>
        </div>
    </sec:access>
    <div class="col-xs-12">
        <div class="table-header">
            Client List
        </div>
        <div class="table-responsive">
            <table id="clients-list" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th class="center">Serial</th>
                    <th class="center">First Name</th>
                    <th class="center">Last Name</th>
                    <th class="center">Country of Birth</th>
                    <th class="center">First Nationality</th>
                    <th class="center">Action</th>
                </tr>
                </thead>
                <g:each in="${dataReturns}" var="clients" status="i">
                    <tr>
                        <td>${clients[0]}</td>
                        <td>${clients[1]}</td>
                        <td>${clients[2]}</td>
                        <td>${clients[3]}</td>
                        <td>${clients[4]}</td>
                        <td>
                            <sec:access controller="accountHolderInfo" action="edit">
                                <span class="col-xs-6"><a href="" accountHolderId="${clients.DT_RowId}" class="edit-accountHolder" title="Edit"><span class="green glyphicon glyphicon-edit"></span></a></span>
                            </sec:access>
                            <sec:access controller="accountHolderInfo" action="delete">
                                <span class="col-xs-6"><a href="" accountHolderId="${clients.DT_RowId}" class="delete-accountHolder" title="Delete"><span class="red glyphicon glyphicon-trash"></span></a></span>
                            </sec:access>
                        </td>
                    </tr>
                </g:each>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    jQuery(function ($) {
        var oTable1 = $('#clients-list').dataTable({
            "sDom": "<'row'<'col-md-4'><'col-md-4'><'col-md-4'f>r>t<'row'<'col-md-4'l><'col-md-4'i><'col-md-4'p>>",
            "bProcessing": false,
            "bAutoWidth": true,
            "bServerSide": true,
            "deferLoading": ${totalCount},
            "sAjaxSource": "${g.createLink(controller: 'accountHolderInfo',action: 'list')}",
            "fnRowCallback": function (nRow, aData, iDisplayIndex) {
                if(aData.DT_RowId ==undefined){
                    return true;
                }
                $('td:eq(5)', nRow).html(getActionButtons(nRow, aData));
                return nRow;
            },
            "aoColumns": [
                null,
                null,
                null,
                null,
                null,
                { "bSortable": false }
            ] });
        $('#createAccountHolderLink').click(function (e) {
            var control = this;
            var url = $(control).attr('href');
            jQuery.ajax({
                type: 'POST',
                url: url,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });
            e.preventDefault();
        });
        $('#clients-list').on('click', 'a.edit-accountHolder', function(e) {
            var control = this;
            var accountHolderId = $(control).attr('accountHolderId');
            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'accountHolderInfo',action: 'edit')}?id="+accountHolderId,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });
            e.preventDefault();
        });

        $('#clients-list').on('click', 'a.delete-accountHolder', function(e) {
            var control = this;
            var accountHolderId = $(control).attr('accountHolderId');
            var selectRow = $(this).parents('tr');
            jQuery.ajax({
                type: 'POST',
                dataType: 'JSON',
                url: "${g.createLink(controller: 'accountHolderInfo',action: 'delete')}?id="+accountHolderId,
                success: function (data) {
                    if(data.isError==false){
                        $("#clients-list").DataTable().row(selectRow).remove().draw();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            e.preventDefault();
        });
    });
    function getActionButtons(nRow, aData) {
        var actionButtons = "";
        actionButtons += '<sec:access controller="accountHolderInfo" action="edit"><span class="col-xs-6"><a href="" accountHolderId="'+aData.DT_RowId+ '" class="edit-accountHolder" title="Edit">';
        actionButtons += '<span class="green glyphicon glyphicon-edit"></span>';
        actionButtons += '</a></span></sec:access>';
        actionButtons += '<sec:access controller="accountHolderInfo" action="delete"><span class="col-xs-6"><a href="" accountHolderId="'+aData.DT_RowId+ '" class="delete-accountHolder" title="Delete">';
        actionButtons += '<span class="red glyphicon glyphicon-trash"></span>';
        actionButtons += '</a></span></sec:access>';
        return actionButtons;
    }
</script>
</body>
</html>
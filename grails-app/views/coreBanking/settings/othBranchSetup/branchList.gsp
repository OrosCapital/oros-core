<%--
  Created by IntelliJ IDEA.
  User: rabin
  Date: 5/4/14
  Time: 10:23 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
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
    <sec:access controller="currency" action="create">
        <div class="col-xs-12">
            <span class="navbar-right">
                <a href="${g.createLink(controller: 'othBranchSetup', action: 'create')}"
                   id="createBranchLink" class="btn btn-success">
                    <g:message code="coreBanking.setting.othBranchSetup.add.button" default="Add Branch"/><span
                        class="glyphicon "></span></a></span>
        </div>
    </sec:access>
    <div class="col-xs-12">
        <div class="table-header">
            <g:message code="coreBanking.setting.othBranchSetup.list.label" default="Branch List"/>
        </div>

        <div class="table-responsive">
            <table id="sample-table-2" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th class="center"><span class="glyphicon glyphicon-list"></span>
                        <g:message code="default.serial.label" default="Serial"/></th>
                    <th class="center">
                        <g:message code="coreBanking.setting.branchSetup.branchFullName"
                                   default="Branch FullName"/></th>
                    <th class="center">
                        <g:message code="coreBanking.setting.branchSetup.branchShortName"
                                   default="Branch ShortName"/></th>
                    <th class="center">
                        <g:message code="coreBanking.setting.othBranchSetup.bankName" default="Bank Name"/></th>
                    <th class="center">
                        <g:message code="default.country.label" default="Country"/></th>
                    <th class="center">
                        <g:message code="default.state.label" default="State"/></th>
                    <th class="center"><span class="glyphicon glyphicon-tasks"></span>
                        <g:message code="default.action.label" default="Action"/></th>
                </tr>
                </thead>

                <tbody>
                <g:each in="${dataReturns}" var="otherBranch" status="i">
                    <tr>
                        <td>${otherBranch[0]}</td>
                        <td>${otherBranch[1]}</td>
                        <td>${otherBranch[2]}</td>
                        <td>${otherBranch[3]}</td>
                        <td>${otherBranch[4]}</td>
                        <td>${otherBranch[5]}</td>
                        <td>
                            <sec:access controller="othBranchSetup" action="update">
                                <span class="col-xs-6"><a href="" referenceId="${otherBranch.DT_RowId}" class="edit-reference" title="Edit"><span class="green glyphicon glyphicon-edit"></span></a></span>
                            </sec:access>
                            <sec:access controller="othBranchSetup" action="delete">
                                <span class="col-xs-6"><a href="" referenceId="${otherBranch.DT_RowId}" class="delete-reference" title="Delete"><span class="red glyphicon glyphicon-trash"></span></a></span>
                            </sec:access>
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
        var oTable1 = $('#sample-table-2').dataTable({
            "sDom": "<'row'<'col-md-4'><'col-md-4'><'col-md-4'f>r>t<'row'<'col-md-4'l><'col-md-4'i><'col-md-4'p>>",
            "bProcessing": false,
            "bAutoWidth": true,
            "bServerSide": true,
            "deferLoading": ${totalCount},
            "sAjaxSource": "${g.createLink(controller: 'othBranchSetup',action: 'list')}",
            "fnRowCallback": function (nRow, aData, iDisplayIndex) {
                if(aData.DT_RowId ==undefined){
                    return true;
                }
                $('td:eq(6)', nRow).html(getActionButtons(nRow, aData));
                return nRow;
            },
            "aoColumns": [
                { "bSortable": false },
                null,
                { "bSortable": false },
                { "bSortable": false },
                { "bSortable": false },
                { "bSortable": false },
                { "bSortable": false }

            ]
        });
        $('#createBranchLink').click(function (e) {
            var control = this;
            var url = $(control).attr('href');
            jQuery.ajax({
                type: 'POST',
                url: url,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            e.preventDefault();
        });
        $('#sample-table-2').on('click', 'a.edit-reference', function (e) {
            var control = this;
            var referenceId = $(control).attr('referenceId');
            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'othBranchSetup',action: 'update')}?id=" + referenceId,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            e.preventDefault();
        });

        $('#sample-table-2').on('click', 'a.delete-reference', function (e) {
            var rowLength = $('#sample-table-2 tbody').children('tr').length;
            var selectRow = $(this).parents('tr');
            var confirmDel = confirm("Do You Want To Delete?");
            if (confirmDel == true) {
                var control = this;
                var referenceId = $(control).attr('referenceId');
                jQuery.ajax({
                    type: 'POST',
                    dataType: 'JSON',
                    url: "${g.createLink(controller: 'othBranchSetup',action: 'delete')}?id=" + referenceId,
                    success: function (data) {
                        if(data.isError==false){
                                $("#sample-table-2").DataTable().row(selectRow).remove().draw();
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
            }
            e.preventDefault();
        });
    });
    function getActionButtons(nRow, aData) {
        var actionButtons = "";
        actionButtons += '<sec:access controller="othBranchSetup" action="update"><span class="col-xs-6"><a href="" referenceId="' + aData.DT_RowId + '" class="edit-reference" title="Edit">';
        actionButtons += '<span class="green glyphicon glyphicon-edit"></span>';
        actionButtons += '</a></span></sec:access>';
        actionButtons += '<sec:access controller="othBranchSetup" action="delete"><span class="col-xs-6"><a href="" referenceId="' + aData.DT_RowId + '" class="delete-reference" title="Delete">';
        actionButtons += '<span class="red glyphicon glyphicon-trash"></span>';
        actionButtons += '</a></span></sec:access>';
        return actionButtons;
    }
</script>
</body>
</html>
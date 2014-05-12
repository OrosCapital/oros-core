<%--
  Created by IntelliJ IDEA.
  User: Mohammed Imran
  Date: 4/24/14
  Time: 11:19 AM
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
        <g:if test='${flash.retailerMessage}'>
            <div class='alert alert-success '>
                <i class="icon-bell green"><b>${flash.retailerMessage}</b></i>
            </div>
        </g:if>
    </div>
    <sec:access controller="currency" action="create">
        <div class="col-xs-12">
            <span class="navbar-right">
                <a href="${g.createLink(controller: 'retailerSetup', action: 'create')}"
                   id="createRetailerLink" class="btn btn-success">
                    <g:message code="coreBanking.setting.retailerSetup.add.button" default="Add Retailer"/><span
                        class="glyphicon "></span></a></span>
        </div>
    </sec:access>
    <div class="col-xs-12">
        <div class="table-header">
            <g:message code="coreBanking.setting.retailerSetup.list.label" default="Retailer List"/>
        </div>

        <div class="table-responsive">
            <table id="sample-table-2" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th class="center"><span class="glyphicon glyphicon-list"></span>
                        <g:message code="default.serial.label" default="Serial"/></th>
                    <th class="center"><g:message code="coreBanking.setting.retailerSetup.retailerName"
                                                  default="Retailer Name "/></th>
                    <th class="center"><g:message code="coreBanking.setting.retailerSetup.retailerCode"
                                                  default="Retailer Code"/></th>
                    <th class="center"><g:message code="coreBanking.setting.retailerSetup.account"
                                                  default="Account"/></th>
                    <th class="center"><g:message code="coreBanking.setting.retailerSetup.branch"
                                                  default="Branch"/></th>
                    <th class="center"><span class="glyphicon glyphicon-tasks"></span>
                        <g:message code="default.action.label" default="Action"/></th>
                </tr>
                </thead>

                <tbody>
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
            "sAjaxSource": "${g.createLink(controller: 'retailerSetup',action: 'list')}",
            "fnRowCallback": function (nRow, aData, iDisplayIndex) {
                $('td:eq(5)', nRow).html(getActionButtons(nRow, aData));
                return nRow;
            },
            "aoColumns": [
                { "bSortable": false },
                null,
                null,
                { "bSortable": false },
                { "bSortable": false },
                { "bSortable": false }

            ]
        });
        $('#createRetailerLink').click(function (e) {
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
        $('#sample-table-2').on('click', 'a.edit-retailer', function (e) {
            var control = this;
            var retailerId = $(control).attr('retailerId');
            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'retailerSetup',action: 'update')}?id=" + retailerId,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            e.preventDefault();
        });

        $('#sample-table-2').on('click', 'a.delete-retailer', function (e) {
            var confirmDel = confirm("Do You Want To Delete?");
            if (confirmDel == true) {
                var control = this;
                var retailerId = $(control).attr('retailerId');
                jQuery.ajax({
                    type: 'POST',
                    url: "${g.createLink(controller: 'retailerSetup',action: 'delete')}?id=" + retailerId,
                    success: function (data, textStatus) {
                        $('#page-content').html(data);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                    }
                });
            }
            e.preventDefault();
        });
    });
    function getActionButtons(nRow, aData) {
        var actionButtons = "";
        actionButtons += '<sec:access controller="retailerSetup" action="update"><span class="col-xs-6"><a href="" retailerId="' + aData.DT_RowId + '" class="edit-retailer" title="Edit">';
        actionButtons += '<span class="green glyphicon glyphicon-edit"></span>';
        actionButtons += '</a></span></sec:access>';
        actionButtons += '<sec:access controller="retailerSetup" action="delete"><span class="col-xs-6"><a href="" retailerId="' + aData.DT_RowId + '" class="delete-retailer" title="Delete">';
        actionButtons += '<span class="red glyphicon glyphicon-trash"></span>';
        actionButtons += '</a></span></sec:access>';
        return actionButtons;
    }
</script>
</body>
</html>
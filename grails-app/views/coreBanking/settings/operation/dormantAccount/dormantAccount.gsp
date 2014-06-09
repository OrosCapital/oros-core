<%--
  Created by IntelliJ IDEA.
  User: Mohammed Imran
  Date: 5/28/14
  Time: 12:55 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title></title>
</head>
<body>
<div class="col-xs-12">
    <div class="table-header">
        Dormant Account List
    </div>

    <div class="table-responsive">
        <table id="sample-table-2" class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th class="center">
                    <span class="glyphicon glyphicon-list"></span>
                    <g:message code="default.serial.label" default="Serial"/>
                </th>
                <th class="center">
                    Name
                </th>
                <th class="center">
                    Account No
                </th>
                <th class="center">
                    Address
                </th>
                <th class="center">
                    Contact No
                </th>
                <th class="center">
                    <span class="glyphicon glyphicon-tasks"></span>
                    <g:message code="default.action.label" default="Action"/>
                </th>
            </tr>
            </thead>
            <g:each in="${dataReturns}" var="dormantAccount" status="i">
                <tr>
                    <td>${dormantAccount[0]}</td>
                    <td>${dormantAccount[1]}</td>
                    <td>${dormantAccount[2]}</td>
                    <td>${dormantAccount[3]}</td>
                    <td>${dormantAccount[4]}</td>
                    <td>
                        <sec:access controller="dormantAccount" action="email">
                            <span class="col-xs-6"><a href="" referenceId="${dormantAccount.DT_RowId}" class="email-reference" title="Email"><span class="green glyphicon glyphicon-envelope"></span></a></span>
                        </sec:access>
                    </td>
                </tr>
            </g:each>
            <tbody>
            </tbody>
        </table>
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
            "sAjaxSource": "${g.createLink(controller: 'dormantAccount',action: 'list')}",
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
                { "bSortable": false },
                { "bSortable": false },
                { "bSortable": false },
                { "bSortable": false }
            ]
        });

    });

    $('#sample-table-2').on('click', 'a.email-reference', function (e) {
        var control = this;
        var referenceId = $(control).attr('referenceId');
        jQuery.ajax({
            type: 'POST',
            dataType:"JSON",
            url: "${g.createLink(controller: 'dormantAccount',action: 'email')}?id=" + referenceId,
            success: function (data) {
                if(data.isError==true){
                     alert(data.message);
                    return
                }
                alert(data.message);
                return
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
        e.preventDefault();
    });

    function getActionButtons(nRow, aData) {
        var actionButtons = "";
        actionButtons += '<sec:access controller="dormantAccount" action="list"><span class="col-xs-6"><a href="" referenceId="' + aData.DT_RowId + '" class="email-reference" title="Email">';
        actionButtons += '<span class="green glyphicon glyphicon-envelope"></span>';
        actionButtons += '</a></span></sec:access>';
        return actionButtons;
    }
</script>
</body>
</html>
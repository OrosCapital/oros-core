<html>
<head>
    <title>OrosCapital - Currency List</title>
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
    <sec:access controller="exchangeRate" action="create">
        <div class="col-xs-12">
            <span class="navbar-right">
                <a href="${g.createLink(controller: 'exchangeRate', action: 'create')}" id="createExcRateLink"
                   class="btn btn-success">
                    <g:message code="coreBanking.settings.exchangerate.add.button" default="Add ExchangeRate "/>
                    <span class="glyphicon "></span></a></span>
        </div>
    </sec:access>
    <div class="col-xs-12">
        <div class="table-header">
            <g:message code="coreBanking.settings.exchangerate.list.title" default="Exchange Rate List "/>
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
                        <g:message code="default.currency.label" default="Currency"/>
                    </th>
                    <th class="center">
                        <g:message code="coreBanking.settings.exchangerate.buyPrice.label"
                                   default="Buy Price"/>
                    </th>
                    <th class="center">
                        <g:message code="coreBanking.settings.exchangerate.sellPrice.label"
                                   default="Sell Price"/>
                    </th>
                    <th class="center">
                        <g:message code="default.date.label"
                                   default="Date"/></th>
                    <th class="center">
                        <span class="glyphicon glyphicon-tasks"></span>
                        <g:message code="default.action.label" default="Action"/>
                    </th>
                </tr>
                </thead>
                <g:each in="${dataReturn}" var="exchangeRate" status="i">
                    <tr>
                        <td>${exchangeRate[0]}</td>
                        <td>${exchangeRate[1]}</td>
                        <td>${exchangeRate[2]}</td>
                        <td>${exchangeRate[3]}</td>
                        <td>${exchangeRate[4]}</td>
                        <td>
                            <sec:access controller="exchangeRate" action="update">
                                <span class="col-xs-6"><a href="" referenceId="${exchangeRate.DT_RowId}"
                                                          class="edit-reference" title="Edit"><span
                                            class="green glyphicon glyphicon-edit"></span></a></span>
                            </sec:access>
                            <sec:access controller="exchangeRate" action="delete">
                                <span class="col-xs-6"><a href="" referenceId="${exchangeRate.DT_RowId}"
                                                          class="delete-reference" title="Delete"><span
                                            class="red glyphicon glyphicon-trash"></span></a></span>
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
        var oTable1 = $('#sample-table-2').dataTable({
            "sDom": "<'row'<'col-md-4'><'col-md-4'><'col-md-4'f>r>t<'row'<'col-md-4'l><'col-md-4'i><'col-md-4'p>>",
            "bProcessing": false,
            "bAutoWidth": true,
            "bServerSide": true,
            "deferLoading": ${totalCount},
            "sAjaxSource": "${g.createLink(controller: 'exchangeRate',action: 'list')}",
            "fnRowCallback": function (nRow, aData, iDisplayIndex) {
                if(aData.DT_RowId ==undefined){
                    return true;
                }
                $('td:eq(5)', nRow).html(getActionButtons(nRow, aData));
                return nRow;
            },
            "aoColumns": [
                { "bSortable": false },
                null,
                { "bSortable": false },
                { "bSortable": false },
                { "bSortable": false },
                { "bSortable": false }

            ]
        });
        $('#createExcRateLink').click(function (e) {
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
                url: "${g.createLink(controller: 'exchangeRate',action: 'update')}?id=" + referenceId,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            e.preventDefault();
        });

        $('#sample-table-2').on('click', 'a.delete-reference', function (e) {
            var confirmDel = confirm("Do You Want To Delete?");
            if (confirmDel == true) {
                var control = this;
                var selectRow = $(control).parents('tr');
                var referenceId = $(control).attr('referenceId');
                jQuery.ajax({
                    type: 'POST',
                    dataType:'JSON',
                    url: "${g.createLink(controller: 'exchangeRate',action: 'delete')}?id=" + referenceId,
                    success: function (data) {
                        if(data.isError==false){
                            alert(data.message);
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
        actionButtons += '<sec:access controller="exchangeRate" action="update"><span class="col-xs-6"><a href="" referenceId="' + aData.DT_RowId + '" class="edit-reference" title="Edit">';
        actionButtons += '<span class="green glyphicon glyphicon-edit"></span>';
        actionButtons += '</a></span></sec:access>';
        actionButtons += '<sec:access controller="exchangeRate" action="delete"><span class="col-xs-6"><a href="" referenceId="' + aData.DT_RowId + '" class="delete-reference" title="Delete">';
        actionButtons += '<span class="red glyphicon glyphicon-trash"></span>';
        actionButtons += '</a></span></sec:access>';
        return actionButtons;
    }
</script>
</body>
</html>
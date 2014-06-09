<html>
<head>
    <title>OrosCapital - Hierarchy List</title>
</head>

<body>
<div class="row">
    <div class="col-xs-12">
        <g:if test='${flash.message}'>
            <div class='alert alert-success '>
                <i class="icon-bell green"> <b> ${flash.message} </b> </i>
            </div>
        </g:if>
    </div>
    <sec:access controller="hierarchy" action="index">
        <div class="col-xs-12">
            <span class="navbar-right"><a href="${g.createLink(controller: 'hierarchy', action: 'create')}"
                                          id="createHierarchy" class="btn btn-success">
                <g:if test="${dataReturns == null}">
                    Assign Hierarchy
                </g:if>
                <g:else>
                    Update Hierarchy
                </g:else>
            <span class="glyphicon "></span></a></span>
        </div>
    </sec:access>

    <div class="col-xs-12">
        <div class="table-header">
            Hierarchy List
        </div>

        <div class="table-responsive">
            <table id="hierarchy-list" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th class="center"><span class="glyphicon glyphicon-list"></span>Serial</th>
                    <th class="center">Username</th>
                    <th class="center">Rank</th>
                    <th class="center">Bankname</th>
                    <th class="center">Branchname</th>
                    %{--<th class="center"><span class="glyphicon glyphicon-tasks"></span>Action</th>--}%
                </tr>
                </thead>
                <g:each in="${dataReturns}" var="hierarchy" status="i">
                    <tr>
                        <td>${hierarchy[0]}</td>
                        <td>${hierarchy[1]}</td>
                        <td>${hierarchy[2]}</td>
                        <td>${hierarchy[3]}</td>
                        <td>${hierarchy[4]}</td>
                        %{--<td>--}%
                            %{--<sec:access controller="hierarchy" action="update">--}%
                                %{--<span class="col-xs-6"><a href="" referenceId="${hierarchy.DT_RowId}" class="edit-hierarchy" title="Edit"><span class="green glyphicon glyphicon-edit"></span></a></span>--}%
                            %{--</sec:access>--}%
                            %{--<sec:access controller="hierarchy" action="delete">--}%
                                %{--<span class="col-xs-6"><a href="" referenceId="${hierarchy.DT_RowId}" class="delete-hierarchy" title="Delete"><span class="red glyphicon glyphicon-trash"></span></a></span>--}%
                            %{--</sec:access>--}%
                        %{--</td>--}%
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
        var oTable1 = $('#hierarchy-list').dataTable({
            "sDom": "<'row'<'col-md-4'><'col-md-4'><'col-md-4'f>r>t<'row'<'col-md-4'l><'col-md-4'i><'col-md-4'p>>",
            "bProcessing": false,
            "bAutoWidth": true,
            "bServerSide": true,
            "deferLoading": ${totalCount},
            "sAjaxSource": "${g.createLink(controller: 'hierarchy',action: 'list')}",
            "fnRowCallback": function (nRow, aData, iDisplayIndex) {
                if(aData.DT_RowId ==undefined){
                    return true;
                }
                $('td:eq(5)');
//                , nRow).html(getActionButtons(nRow, aData)
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
        $('#createHierarchy').click(function (e) {
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
        $('#hierarchy-list').on('click', 'a.edit-hierarchy', function (e) {
            var control = this;
            var referenceId = $(control).attr('referenceId');
            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'hierarchy',action: 'update')}?id=" + referenceId,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            e.preventDefault();
        });

        $('#hierarchy-list').on('click', 'a.delete-hierarchy', function (e) {
            var control = this;
            var referenceId = $(control).attr('referenceId');
            var selectRow = $(this).parents('tr');
            jQuery.ajax({
                type: 'POST',
                dataType: 'JSON',
                url: "${g.createLink(controller: 'hierarchy',action: 'delete')}?id=" + referenceId,
                success: function (data) {
                    if(data.isError==false){
                        $("#hierarchy-list").DataTable().row(selectRow).remove().draw();
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
        actionButtons += '<sec:access controller="hierarchy" action="update"><span class="col-xs-6"><a href="" referenceId="' + aData.DT_RowId + '" class="edit-hierarchy" title="Edit">';
        actionButtons += '<span class="green glyphicon glyphicon-edit"></span>';
        actionButtons += '</a></span></sec:access>';
        %{--actionButtons += '<sec:access controller="hierarchy" action="delete"><span class="col-xs-6"><a href="" referenceId="' + aData.DT_RowId + '" class="delete-hierarchy" title="Delete">';--}%
        %{--actionButtons += '<span class="red glyphicon glyphicon-trash"></span>';--}%
        %{--actionButtons += '</a></span></sec:access>';--}%
        return actionButtons;
    }
</script>
</body>
</html>
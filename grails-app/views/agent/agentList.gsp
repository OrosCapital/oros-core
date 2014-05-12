<html>
<head>

</head>

<body>

<div class="row">

    <div class="col-md-12"></div>
    <sec:access controller="agent" action="create">
        <div class="col-md-12">
            <span class="navbar-right"><a href="${g.createLink(controller: 'agent', action: 'create')}"
                                          id="createAgent" class="btn btn-success">Add Agent<span class="glyphicon"></span></a></span>
        </div>
    </sec:access>
&nbsp;
    <div class="col-md-12">
        <div class="table-header">
            Retail Agent List
        </div>

        <div class="table-responsive">
            <table id="sample-table-2" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th class="center">Serial</th>
                    <th class="center">First Name</th>
                    <th class="center">Nationality</th>
                    <th class="center">Gender</th>
                    <th class="center">Action</th>
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
            "sAjaxSource": "${g.createLink(controller: 'agent',action: 'list')}",
            "fnRowCallback": function (nRow, aData, iDisplayIndex) {
                $('td:eq(4)', nRow).html(getActionButtons(nRow, aData));
                return nRow;
            },
            "aoColumns": [

                 null,
                 null,
                 null,
                 null,
                { "bSortable": false }
            ]
        });
        $('#createAgent').click(function (e) {
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
        $('#sample-table-2').on('click', 'a.edit-agent', function (e){
            var control = this;
            var agentId = $(control).attr('agentId');
            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'agent',action: 'update')}?id=" + agentId,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            e.preventDefault();
        });

        $('#sample-table-2').on('click', 'a.delete-agent', function (e) {
            var control = this;
            var agentId = $(control).attr('agentId');
            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller:'agent',action:'deleteAgent')}?id="+ agentId,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });
            e.preventDefault();
        });
    });
    function getActionButtons(nRow, aData) {
        var actionButtons = "";
        actionButtons += '<sec:access controller="agent" action="update"><span class="col-xs-6"><a href="" agentId="' + aData.DT_RowId + '" class="edit-agent" title="Edit">';
        actionButtons += '<span class="green glyphicon glyphicon-edit"></span>';
        actionButtons += '</a></span></sec:access>';
        actionButtons += '<sec:access controller="agent" action="deleteAgent"><span class="col-xs-6"><a href="" agentId="' + aData.DT_RowId + '" class="delete-agent" title="Delete">';
        actionButtons += '<span class="red glyphicon glyphicon-trash"></span>';
        actionButtons += '</a></span></sec:access>';
        return actionButtons;
    }

</script>
</body>
</html>


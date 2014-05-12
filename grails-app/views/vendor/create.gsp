<html>
<head>
    <title>OrosCapital - Vendor List</title>
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
    <sec:access controller="vendor" action="create">
        <div class="col-xs-12">
            <span class="navbar-right"><a href="${g.createLink(controller: 'vendor', action: 'create')}"
                                          id="createVendor" class="btn btn-success">Add Vendor<span
                        class="glyphicon "></span></a></span>
        </div>
    </sec:access>

    <div class="col-xs-12">
        <div class="table-header">
            Vendor List
        </div>

        <div class="table-responsive">
            <table id="sample-table-2" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th class="center"><span class="glyphicon glyphicon-list"></span>Serial</th>
                    <th class="center">Code</th>
                    <th class="center">Name</th>
                    <th class="center">Email</th>
                    <th class="center">Status</th>
                    <th class="center"><span class="glyphicon glyphicon-tasks"></span>Action</th>
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
            "sAjaxSource": "${g.createLink(controller: 'vendor',action: 'list')}",
            "fnRowCallback": function (nRow, aData, iDisplayIndex) {
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
        $('#createVendor').click(function (e) {
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
        $('#sample-table-2').on('click', 'a.edit-vendor', function (e) {
            var control = this;
            var vendorId = $(control).attr('vendorId');
            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'vendor',action: 'update')}?id=" + vendorId,
                success: function (data, textStatus) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
            e.preventDefault();
        });

        $('#sample-table-2').on('click', 'a.delete-vendor', function (e) {
            var control = this;
            var vendorId = $(control).attr('vendorId');
            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'vendor',action: 'deleteVendor')}?id=" + vendorId,
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
        actionButtons += '<sec:access controller="vendor" action="update"><span class="col-xs-6"><a href="" vendorId="' + aData.DT_RowId + '" class="edit-vendor" title="Edit">';
        actionButtons += '<span class="green glyphicon glyphicon-edit"></span>';
        actionButtons += '</a></span></sec:access>';
        actionButtons += '<sec:access controller="vendor" action="deleteVendor"><span class="col-xs-6"><a href="" vendorId="' + aData.DT_RowId + '" class="delete-vendor" title="Delete">';
        actionButtons += '<span class="red glyphicon glyphicon-trash"></span>';
        actionButtons += '</a></span></sec:access>';
        return actionButtons;
    }
</script>
</body>
</html>
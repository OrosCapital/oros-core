<%--
  Created by IntelliJ IDEA.
  User: rabin
  Date: 5/22/14
  Time: 12:53 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>

<div class="col-xs-12 col-sm-12 col-lg-12 widget-container-span">
    <div class="widget-box">
        <div class="widget-header header-color-blue">
            <h5 class="bigger lighter">
                <i class="icon-table"></i>
                Withdrawal Applicant List
            </h5>
        </div>

        <div class="widget-body">
            <div class="widget-main no-padding">
                <table class="table table-striped table-bordered table-hover" id="withdrawAppTable">
                    <thead class="thin-border-bottom">
                    <tr>
                        <th>
                            <i class="icon-user"></i>
                            <g:message code="coreBanking.operation.cashWithdrawal.approval.list.user.label" default="User"/>
                        </th>

                        <th>
                            <i>@</i>
                            <g:message code="coreBanking.operation.cashWithdrawal.approval.list.accountNo.label" default="Account No"/>
                        </th>

                        <th>
                            <i class="icon-money"></i>
                            <g:message code="coreBanking.operation.cashWithdrawal.approval.list.amount.label" default="Amount"/>
                        </th>

                        <th>
                            <i class="icon-book"></i>
                            <g:message code="coreBanking.operation.cashWithdrawal.approval.list.chequeNo.label" default="Cheque No"/>
                        </th>

                        <th class="hidden-480">
                            <g:message code="coreBanking.operation.cashWithdrawal.approval.list.status.label" default="Status"/> Status
                        </th>

                        <th>
                            <i class="icon-ok"></i>
                            <g:message code="default.action.label" default="Action"/>
                        </th>
                    </tr>
                    </thead>

                    <tbody>
                    <g:each in="${dataReturn}" var="withdrawApplicant" status="i">
                        <tr>
                            <td>${withdrawApplicant[0]}</td>
                            <td>${withdrawApplicant[1]}</td>
                            <td>${withdrawApplicant[2]}</td>
                            <td>${withdrawApplicant[3]}</td>
                            <td><span class="label label-warning">${withdrawApplicant[4]}</span></td>
                            <td>
                                <sec:access controller="withdrawalApprove" action="approve">
                                    <span class="col-xs-6"><a href="" referenceId="${withdrawApplicant.DT_RowId}" class="approve-reference" title="Approve"><span class="green glyphicon glyphicon-edit"></span></a></span>
                                </sec:access>
                                <sec:access controller="country" action="delete">
                                    <span class="col-xs-6"><a href="" referenceId="${withdrawApplicant.DT_RowId}" class="delete-reference" title="Delete"><span class="red glyphicon glyphicon-trash"></span></a></span>
                                </sec:access>
                            </td>
                        </tr>
                    </g:each>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div><!-- /span -->
</div><!-- /row -->

<script type="text/javascript">
     jQuery(function($){
        var oTable1=$('#withdrawAppTable').dataTable({
            "sDom": "<'row'<'col-md-4'><'col-md-4'><'col-md-4'f>r>t<'row'<'col-md-4'l><'col-md-4'i><'col-md-4'p>>",
            "bProcessing": false,
            "bAutoWidth": true,
            "bServerSide": true,
            "deferLoading": ${totalCount},
            "sAjaxSource": "${g.createLink(controller: 'withdrawalApprove',action: 'list')}",
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
     function getActionButtons(nRow, aData) {
         var actionButtons = "";
         actionButtons += '<sec:access controller="withdrawalApprove" action="approve"><span class="col-xs-6"><a href="" referenceId="' + aData.DT_RowId + '" class="approve-reference" title="Approve">';
         actionButtons += '<span class="green glyphicon glyphicon-edit"></span>';
         actionButtons += '</a></span></sec:access>';
         actionButtons += '<sec:access controller="withdrawalApprove" action="delete"><span class="col-xs-6"><a href="" referenceId="' + aData.DT_RowId + '" class="delete-reference" title="Delete">';
         actionButtons += '<span class="red glyphicon glyphicon-trash"></span>';
         actionButtons += '</a></span></sec:access>';
         return actionButtons;
     }
</script>

</body>
</html>
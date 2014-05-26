<%@ page
        contentType="text/html;charset=UTF-8"
        import="com.gsl.oros.core.banking.settings.State; com.gsl.oros.core.banking.settings.Country; com.gsl.oros.core.banking.settings.accounting.VatCategory"
%>
<html>
<head>
    <style>
    .form-control, label, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"]{font-size: 12px;}
    label{max-width: 150px;}
    </style>
    <title>Bank Draft</title>
</head>

<body>
<div class="page-header">
    <h1>Charges List</h1>
</div>

<div class="col-xs-12">
    <g:if test='${flash.message}'>
        <div class='alert alert-success '>
            <i class="icon-bell green"> <b> ${flash.message} </b> </i>
        </div>
    </g:if>
</div>
<div class="clearfix">
    <div class="col-xs-12">

        <div class="table-responsive">
            <table id="bank-acconut-list" class="table table-striped table-bordered table-hover">
                <tbody>
                    <tr>
                        <th class="center" colspan="2">Current Account</th>
                    </tr>
                    <tr>
                        <td class="center">Charges for Opening C/A</td>
                        <td class="center">FREE</td>
                    </tr>
                    <tr>
                        <td class="center">Charges for Closing C/A</td>
                        <td class="center">FREE</td>
                    </tr>
                    <tr>
                        <td class="center">Annual Maintenance Charges</td>
                        <td class="center">$50</td>
                    </tr>
                    <tr>
                        <th class="center" colspan="2">Domestic Payments</th>
                    </tr>
                    <tr>
                        <td class="center">Transfer to others banks</td>
                        <td class="center">$2.00</td>
                    </tr>
                    <tr>
                        <td class="center">Transfer from others banks</td>
                        <td class="center">FREE</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <sec:access controller="bankDraft" action="create">
        <div class="clearfix">
            <div class="col-md-offset-9 col-md-3">
                <span class="navbar-right"><a href="${g.createLink(controller: 'bankDraft', action: 'create')}"
                                              id="createDraft" class="btn btn-success">Next<span
                            class="glyphicon "></span></a></span>
            </div>
        </div>
        </sec:access>
    </div>

</div>

<script type="text/javascript">
    $(".chosen-select").chosen();

    jQuery(function ($) {
        $('#createDraft').click(function (e) {
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




        $(".chosen-select").css('width','200px').select2({allowClear:true})
                .on('change', function(){
                    $(this).closest('form').validate().element($(this));
                });
    });

</script>
</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title></title>
    <style>

    textarea {
        resize: none;
    }</style>
</head>
<body>
<g:form name="loanForm" id="loanForm" method="post" role="form" class="form-horizontal">
    <div class="row">
    <div class="col-md-12">
    <div class="col-md-7">
            <div class="form-group">
                <label for="accNo" class="col-md-4 control-label">
    Account no.<span class="red">*</span>
    </label>

    <div class="col-md-6">
        <g:textField name="accNo" id="accNo" placeholder="Account No." onfocus="this.placeholder = ''" onblur="this.placeholder = 'Account No.'" class="form-control" value=""/>
    </div>

    </div>
        <div class="form-group">
            <label for="loanType" class="col-md-4 control-label">
                Loan Type<span class="red">*</span>
            </label>

            <div class="col-md-6">
                <select class="form-control" id="loanType">
                    <option value="">Select</option>
                    <option value="1">Home Loan</option>
                    <option value="2">Short Term Loan</option>
                    <option value="3">Term Loan</option>
                </select>
            </div>

        </div>
        <div class="form-group">
            <label for="amount" class="col-md-4 control-label">
                Amount Requested<span class="red">*</span>
            </label>

            <div class="col-md-6">
                <g:textField name="amount" id="amount" placeholder="Amount" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Amount'" class="form-control" value=""/>
            </div>

        </div>
        <div class="form-group">
            <label for="purpose" class="col-md-4 control-label">
                Purpose of Loan
            </label>

            <div class="col-md-6">
                <g:textArea name="purpose" id="purpose" placeholder="Purpose of Loan" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Purpose of Loan'" class="form-control" value=""/>
            </div>

        </div>
        <div class="form-group">
            <label  class="col-md-4 control-label">
                Loan Duration<span class="red">*</span>
            </label>

            <div class="col-md-8 form-group">

                <div class="col-md-5">
                <div class='input-append date input-group' id="durationStart">
                    <label for="durationStart"></label>
                    <input type="date" name="durationStart" class="form-control datepicker" data-date-format="dd-mm-yyyy" value="${durationStart}"/>
                    <span class="input-group-addon add-on"><i class="icon-calendar"></i></span><label>to</label>
                </div>
                </div>
                <div class="col-md-5">
                <div class='input-append date input-group' id="durationEnd">
                    <label for="durationEnd"></label>
                    <input type="date" name="durationEnd" class="form-control datepicker" data-date-format="dd-mm-yyyy" value="${durationEnd}"/>
                    <span class="input-group-addon add-on"><i class="icon-calendar"></i></span>
                </div>
            </div>
            </div>
        </div>
        <div class="form-group">
            <label for="income" class="col-md-4 control-label">
                Source of Income<span class="red">*</span>
            </label>

            <div class="col-md-6">
                <g:textField name="income" id="income" placeholder="Source of Income" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Source of Income'" class="form-control" value=""/>
            </div>

        </div>
    </div>
    </div>
    </div>
    <sec:access controller="loan" action="save">
        <div class="clearfix">
            <div class="col-md-offset-6 col-md-3">
                <span class="navbar-right"><a href="${g.createLink(controller: 'loan', action: 'save')}"
                                              id="saveLoan" class="btn btn-success">Save<span
                            class="glyphicon "></span></a></span>
            </div>
        </div>
    </sec:access>
</g:form>
 <script type="text/javascript">
     var dateF = "${dateFormat}"
     var dateM = "${dateMask}"
     var getDecimal = "${decimalSep}";

     $('input:text').autoNumeric("init", {mDec: getDecimal});

     $('#amount').autoNumeric('set', $('#amount').val());

     $(".datepicker").inputmask(dateM);

     $("#durationStart").datepicker({
         format: dateF
     }).on('changeDate', function (ev) {
                 $(this).datepicker('hide');
             });

     $("#durationEnd").datepicker({
         format: dateF
     }).on('changeDate', function (ev) {
                 $(this).datepicker('hide');
             });

     $("#saveLoan").click(function(e){
         jQuery.ajax({
             type: 'POST',
             url: "${createLink(controller: "loan",action: "save")}",
             success: function (data) {
                 $('#page-content').html(data);
             },
             error: function (XMLHttpRequest, textStatus, errorThrown) {

             }
         });
         e.preventDefault();
     });
 </script>
</body>
</html>
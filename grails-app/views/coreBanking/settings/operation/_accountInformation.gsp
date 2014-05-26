<html>
<head></head>
<body>
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="widget-box">
                <div class="widget-header widget-header-blue"><h4 class="lighter">Account Information</h4></div>
                <div class="widget-body">
                    <div class="widget-main no-padding">
                        <form name="accOpenBasicInfoForm" id="accOpenBasicInfoForm" class="form-horizontal">
                            <g:hiddenField name="accountOpenId" value="${accountOpenObj ? accountOpenObj.id:accountOpenId}"/>
                            <g:hiddenField name="accountTitle" value="${accountTitle}"/>
                            <g:hiddenField name="modeOfOperation" value="${accountOpenObj? accountOpenObj.accountCategory:saveAccObj.natureOfOperation}"/>
                            <g:hiddenField name="natureOfOperation" value="${accountOpenObj?accountOpenObj.accountType:saveAccObj.modeOfOperation}"/>
                            <!-- <legend>Form</legend> -->

                            <fieldset>
                            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">

                                <div class="form-group">
                                    <label for="accountTitle" class="col-sm-4 control-label no-padding-right">Title of the Account</label>

                                    <div class="col-sm-8 col-xs-8">
                                        <div class="clearfix">
                                            <input type="text" id="accountTitle" class="form-control"  name="accountTitle" value="${accountTitle}" readonly="true">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 control-label no-padding-right" for="modeOperation">Mode of Operation</label>

                                    <div class="col-sm-8 col-xs-8">
                                        <div class="clearfix">
                                            <input type="text" id="modeOperation" class="form-control"  name="modeOfOperation" value="<g:if test="${accountCategory == 2}"> Joint</g:if><g:else>Individual</g:else>" readonly="true">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="natureOfAccount" class="col-sm-4 control-label">Nature of Account</label>
                                    <div class="col-sm-8 col-xs-8">
                                        <div class="clearfix">
                                            <input type="text" id="natureOfAccount" class="form-control"  name="natureOfOperation" value="<g:if test="${accountType == 2}"> Joint Account</g:if><g:else>Individual Account</g:else>" readonly="true">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 control-label no-padding-right" for="tAndC">Acceptance Terms & Conditions</label>

                                    <div class="col-sm-8 col-xs-8">
                                        <g:checkBox name="tAndC" id="tAndC"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">

                                <div class="form-group">
                                    <label class="col-sm-4 control-label no-padding-right" for="accountPurpose">Opening Purpose</label>

                                    <div class="col-sm-8 col-xs-8">
                                        <div class="clearfix">
                                            <input id="accountPurpose" class="form-control" type="text" name="accountPurpose" value="${saveAccObj ?.accountPurpose}" placeholder="Account Purpose">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 control-label no-padding-right">Opening Date<span class="required-indicator">*</span>
                                    </label>
                                    <div class="col-sm-8 col-xs-8">
                                        <div class="clearfix">
                                            <div class='input-append date input-group' id="openingDate">
                                                <input type="date" name="openingDate" class="form-control datepicker" data-date-format="dd-mm-yyyy" value="${openingDate}"/>
                                                <span class="input-group-addon add-on"><i class="icon-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 control-label no-padding-right" for="initialDeposit">Initial Deposit<span class="required-indicator">*</span></label>

                                    <div class="col-sm-8 col-xs-8">
                                        <div class="clearfix">
                                            <input id="initialDeposit" class="form-control" type="text" name="initialDeposit" value="${saveAccObj?.initialDeposit}" style="text-align: right"
                                                   placeholder="Initial Deposit">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 control-label no-padding-right" for="sourceOfFund">Source of Fund<span class="required-indicator">*</span></label>

                                    <div class="col-sm-8 col-xs-8">
                                        <div class="clearfix">
                                            <input id="sourceOfFund" class="form-control" type="text" name="sourceOfFund" placeholder="Source Of Fund" value="${saveAccObj?.sourceOfFund}">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 control-label no-padding-right" for="monthlyIncome"><span class="required-indicator">*</span>Monthly Income</label>
                                    <div class="col-sm-8 col-xs-8">
                                        <div class="clearfix">
                                            <input id="monthlyIncome" class="form-control" type="text" name="monthlyIncome" value="${saveAccObj?.monthlyIncome}" style="text-align: right"
                                                   placeholder="Monthly Income">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            </fieldset>

                            <div class="clearfix form-actions">
                                <div class="col-md-12 pull-right">
                                    <button class="btn btn-info" type="submit"><i class="icon-ok bigger-110"></i>Save</button>
                                    <button class="btn" type="reset"><i class="icon-undo bigger-110"></i>Reset</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script type="text/javascript">

    $(document).ready(function () {

        var dateF = "${dateFormat}"
        var dateM = " ${dateMask}"

        $('input[name=monthlyIncome]').autoNumeric("init", {mDec: 2});
        $('input[name=initialDeposit]').autoNumeric("init", {mDec: 2});

        $('#monthlyIncome').autoNumeric('set', $('#monthlyIncome').val());
        $('#initialDeposit').autoNumeric('set', $('#initialDeposit').val());

        $(".datepicker").inputmask(dateM);

        $("#openingDate").datepicker({
            format: dateF
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });

        $('#accOpenBasicInfoForm').validate({
            errorPlacement: function (error, element) {
            },
            focusInvalid: false,
            rules: {
                openingDate: {
                    required: true
                },
                accountPurpose: {
                    required: true
                },
                sourceOfFund: {
                    required: true
                },
                monthlyIncome: {
                    required: true

                },
                initialDeposit: {
                    required: true
                },
                tAndC: {
                    required: true
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#accOpenBasicInfoForm')).show();
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            unhighlight: function (e) { // <-- fires when element is valid
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
            }
        });

        jQuery.validator.messages.required = "";
    });

    $("#accOpenBasicInfoForm").submit(function (e) {
        if (!$("#accOpenBasicInfoForm").valid()) return false
        $.ajax({
            type: "POST",
            url: "${createLink(controller: "accountOpen",action: "accOpenBasicInfoSave")}",
            data: $(this).serialize(),
            success: function (data) {
                $("#page-content").html(data);
            }
        });
        return false
        e.preventDefault();
    });

</script>
</body>
</html>

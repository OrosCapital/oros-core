%{--<g:if test="${vendorMaster?.bankAccountInfo}">--}%
    %{--<div class="clearfix">--}%
        %{--<div class="col-xs-12">--}%
            %{--<div class="table-header">--}%
                %{--Bank Account List--}%
            %{--</div>--}%
            %{--<div class="table-responsive">--}%
                %{--<table id="bank-acconut-list" class="table table-striped table-bordered table-hover">--}%
                    %{--<thead>--}%
                    %{--<tr>--}%
                        %{--<th class="center">Serial</th>--}%
                        %{--<th class="center">Bank Name</th>--}%
                        %{--<th class="center">Account Name</th>--}%
                        %{--<th class="center">Account No.</th>--}%
                        %{--<th class="center">Iban Prefix</th>--}%
                        %{--<th class="center">Action</th>--}%
                    %{--</tr>--}%
                    %{--</thead>--}%

                    %{--<tbody>--}%
                    %{--<g:each status="i" in="${vendorMaster?.bankAccountInfo}" var="bankAccount">--}%
                        %{--<tr>--}%
                            %{--<td>${i+1}</td>--}%
                            %{--<td id="attCaption">${bankAccount?.bankName}</td>--}%
                            %{--<td id="attName">${bankAccount?.bankAccountName}</td>--}%

                            %{--<td id="attDescription">${bankAccount?.bankAccountNo}</td>--}%

                            %{--<td id="attType">${bankAccount?.ibanPrefix}</td>--}%



                            %{--<td class="actions ">--}%
                                %{--<div class="btn-group">--}%

                                    %{--<sec:access controller="vendor" action="editBankAccount">--}%
                                        %{--<a class="btn btn-sm bankaccount-edit-link"--}%
                                       %{--href="#" bankAccountId="${bankAccount?.id}" vendorId="${vendorMaster?.id}"--}%
                                       %{--title="Edit"><i class="glyphicon glyphicon-pencil orange"></i></a>--}%
                                    %{--</sec:access>--}%
                                    %{--<sec:access controller="vendor" action="deleteBankAccount">--}%
                                        %{--<a class="btn btn-sm delete btn-danger bankaccount-delete-link" onclick="return confirm('Are you sure delete Account?')"--}%
                                       %{--href="#" bankAccountId="${bankAccount?.id}" vendorId="${vendorMaster?.id}"--}%
                                       %{--title="Delete"><i class="glyphicon glyphicon-remove "></i></a>--}%
                                    %{--</sec:access>--}%
                                %{--</div>--}%
                            %{--</td>--}%
                        %{--</tr>--}%
                    %{--</g:each>--}%
                    %{--</tbody>--}%
                %{--</table>--}%
            %{--</div>--}%
        %{--</div>--}%

    %{--</div>--}%
%{--</g:if>--}%
<script type="text/javascript">

    jQuery(function ($) {

        $('#bank-acconut-list').on('click', 'a.bankaccount-edit-link', function(e) {
//            alert('I am on edit');
            e.preventDefault();
            var control = this;
            var bankAccountId = $(control).attr('bankAccountId');
            var vendorId = $(control).attr('vendorId');
            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'vendor',action: 'editBankAccount')}?id="+vendorId+"&bankAccountId="+bankAccountId,
                success: function (data, textStatus) {
                    $('#accountID').val(data.id);
                    $('#vendorbankName').val(data.bankName);
                    $('#vendorBankAccountNo').val(data.bankAccountNo);
                    $('#vendorBankAccountName').val(data.bankAccountName);
                    $('#vendorIbanPrefix').val(data.ibanPrefix);
                    $('#addBankAccount').html('Update');


                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });

        });

        $('#bank-acconut-list').on('click', 'a.bankaccount-delete-link', function(e) {
            e.preventDefault();
            var control = this;
            var bankAccountId = $(control).attr('bankAccountId');
            var vendorId = $(control).attr('vendorId');
            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'vendor',action: 'deleteBankAccount')}?id="+vendorId+"&bankAccountId="+bankAccountId,
                success: function (data, textStatus) {
                    $('#bankAccountList').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });

        });
    });
</script>
%{--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">--}%
%{--</script>--}%
<html>
<head></head>
<body>


<g:render template='/coreBanking/settings/product/savings/fixedFeesTable'/>
<script type="text/javascript">
    $(document).ready(function(){
        var fixShow = 0;

        validateFixedFeesTable();
        $("#fixedAdd").click(function(){

            var fixedMin = $( "#fixedMin" ).val();
            var fixedMax = $( "#fixedMax" ).val();
            var fixedValue = $( "#fixedValue" ).val();
            var fixedRateTypeValue = $( "#fixedRateType" ).val();
            var fixedRateTypeName = $( "#fixedRateType option:selected" ).html();
            var checkFix = 0;
            var checkFixInt = 0;

            if($('#fixedTableData').find('#fixedMin').val()==''){
                checkFix++;
//                $("#fixedMinMsg").show();
                $('#fixedMin').closest('.form-group').removeClass('has-info').addClass('has-error');
            }
            if(!is_int($('#fixedTableData').find('#fixedMin').val())){
                checkFixInt++;
            }

            if($('#fixedTableData').find('#fixedMax').val()==''){
                checkFix++;
//                $("#fixedMaxMsg").show();
                $('#fixedMax').closest('.form-group').removeClass('has-info').addClass('has-error');
            }
            if(!is_int($('#fixedTableData').find('#fixedMax').val())){
                checkFixInt++;
            }
            if($('#fixedTableData').find('#fixedRateType').val()==''){
                checkFix++;
//                $("#fixedRateTypeMsg").show();
                $('#fixedRateType').closest('.form-group').removeClass('has-info').addClass('has-error');

            }
            if($('#fixedTableData').find('#fixedValue').val()==''){
                checkFix++;
//                $("#fixedValMsg").show();
                $('#fixedValue').closest('.form-group').removeClass('has-info').addClass('has-error');

            }
            if(!is_int($('#fixedTableData').find('#fixedValue').val())){
                checkFixInt++;
            }

            if((checkFix==0)&&(checkFixInt==0)) {

                $("#fixedTableData tbody").append(
                        "<tr>"+
                                "<td><div id='fixed_min'>"+fixedMin+"<input type='hidden' name='fixedMin' value='"+fixedMin+"' /></div></td>"+
                                "<td><div id='fixed_max'>"+fixedMax+"<input type='hidden' name='fixedMax' value='"+fixedMax+"' /></div></td>"+
                                "<td><div id='fixed_rate_type'>"+fixedRateTypeName+"<input type='hidden' name='fixedRateType' value='"+fixedRateTypeValue+"' /></div></td>"+
                                "<td><div id='fixed_value'>"+fixedValue+"<input type='hidden' name='fixedValue' value='"+fixedValue+"' /></div></td>"+
                                "<td>" +
                                "<div class='visible-md visible-lg visible-sm visible-xs action-buttons' id='btnEdit'>"+
                                "<a  href='javascript:void(0);'><i class='icon-pencil bigger-130 green'></i></a>"+
                                "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-add bigger-130'></i></a>"+
                                "</div>"+
                                "</td>"+
                                "</tr>");
                $('#fixedTableData').find('input[type=text]').each(function() {
                    $(this).val('');
                });

                $('#fixedTableData').find('select').each(function() {
                    $(this).val('');
                });
            }
        });
        function validateFixedFeesTable(){



            $("#fixedMin").keyup(function(){
                if(is_int($('#fixedMin').val())){
//                $("#fixedMinMsg").hide();
                $("#fixedMin").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#fixedMin').val())){
//                alert("Enter Number in Start Amount!");
                    $("#fixedMin").closest('.form-group').removeClass('has-info').addClass('has-error');
                }
            });

            $("#fixedMax").keyup(function(){
                if(is_int($('#fixedMax').val())){
//                $("#fixedMaxMsg").hide();
                $("#fixedMax").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#fixedMax').val())){
//                alert("Enter Number in Start Amount!");
                    $("#fixedMax").closest('.form-group').removeClass('has-info').addClass('has-error');
                }
            });
            $("#fixedValue").keyup(function(){
                if(is_int($('#fixedValue').val())){
//                $("#fixedValMsg").hide();
                $("#fixedValue").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#fixedValue').val())){
//                alert("Enter Number in Start Amount!");
                    $("#fixedValue").closest('.form-group').removeClass('has-info').addClass('has-error');
                }
            });
            $("#fixedRateType").mousedown(function(){
//                $("#fixedRateTypeMsg").hide();
                $("#fixedRateType").closest('.form-group').removeClass('has-error').addClass('has-info');
            });


        }

        $('#fixedTableData').on('click','.icon-pencil', function () {
            fixShow++;
            $("#fixedTr").hide();
            var par = $(this).closest('tr'); //tr
            var fixedMin = par.children("td:nth-child(1)");
            var fixedMax = par.children("td:nth-child(2)");
            var fixedRateType = par.children("td:nth-child(3)");
            var fixedValue = par.children("td:nth-child(4)");


            var drop = "<div id='fixed_rate_type'><select name='fixedRateType' style='min-width:90px'>" +
                    "<option value=''>- Select -</option>"+
                    "<option value='1'>Flat</option> " +
                    "<option value='2'>Rate</option></select></div> ";

            var fixedEdit  = par.children("td:nth-child(5)");
            var temp_fixedMin = "<input type='text' size='9' placeholder='0.00' value='"+fixedMin.children("div").children("input[type=hidden]").val()+"'/>";
            fixedMin.children("div").html(temp_fixedMin);

            var temp_fixedMax = "<input type='text' size='9' placeholder='0.00' value='"+fixedMax.children("div").children("input[type=hidden]").val()+"'/>";
            fixedMax.children("div").html(temp_fixedMax);

            var selVal = fixedRateType.children("div").children("input[type=hidden]").val();
            fixedRateType.html(drop);
            fixedRateType.find("select[name='fixedRateType'] option[value='"+selVal+"']").attr("selected","selected");

            var temp_fixedValue = "<input type='text' size='9' placeholder='0.00' value='"+fixedValue.children("div").children("input[type=hidden]").val()+"'/>";
            fixedValue.children("div").html(temp_fixedValue);

            fixedEdit .html("<div class='visible-md visible-lg visible-sm visible-xs action-buttons'>"+
                    "<a  href='javascript:void(0);'><i class='glyphicon glyphicon-floppy-saved bigger-130 green'></i></a>"+
                    "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-edit bigger-130'></i></a>");
            fixedMin.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(fixedMin.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    fixedMin.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(fixedMin.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    fixedMin.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });
            fixedMax.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(fixedMax.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    fixedMax.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(fixedMax.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    fixedMax.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });
            fixedValue.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(fixedValue.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    fixedValue.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(fixedValue.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    fixedValue.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });

        });
        $('#fixedTableData').on('click', '.glyphicon-floppy-saved', function () {


            var par = $(this).closest('tr'); //tr
            var fixedMin = par.children("td:nth-child(1)");
            var fixedMax = par.children("td:nth-child(2)");
            var fixedRateType = par.children("td:nth-child(3)");
            var fixedValue = par.children("td:nth-child(4)");

            var fixedEdit  = par.children("td:nth-child(5)");
            var checkFixSave = 0;
            var checkFixSaveInt = 0;
            if(fixedMin.children("div").children("input[type=text]").val()==''){

                checkFixSave++;
//                var temp_fixedMin =  "<input type='text' size='9' id='temp_fixedMin' placeholder='0.00' class='hasError'/>" +
//                        "<div id='fixedMinMsgSave' class='errorMsg'><span>Please Enter Min</span></div>";
                var temp_fixedMin =  "<input type='text' size='9' id='temp_fixedMin' placeholder='0.00' class='hasError'/>";
                fixedMin.children("div").html(temp_fixedMin);
            }
            else if(!is_int(fixedMin.children("div").children("input[type=text]").val())){
                checkFixSaveInt++;
//                alert("enter num");
            }

            if(fixedMax.children("div").children("input[type=text]").val()==''){
                checkFixSave++;
                var temp_fixedMax =  "<input type='text' size='9' id='temp_fixedMax' placeholder='0.00' class='hasError'/>";
//                var temp_fixedMax =  "<input type='text' size='9' id='temp_fixedMax' placeholder='0.00' class='hasError'/><div id='fixedMaxMsgSave' class='errorMsg'><span>Please Enter Max</span></div>";
                fixedMax.children("div").html(temp_fixedMax);
            }
            else if(!is_int(fixedMax.children("div").children("input[type=text]").val())){
                checkFixSaveInt++;
//                alert("enter num");
            }

            if(fixedRateType.children("div").children("select").val()==''){
                checkFixSave++;//
                var temp_fixedRateType =  "<select id='temp_fixedRateType' class='form-control hasError' name='fixedRateType' style='min-width:70px'>"+
                        "<option value=''>- Select -</option>"+
                        "<option value='1'>Flat</option>" +
                        "<option value='2'>Rate</option>"+
                        "</select>";
//                        "<div id='fixedRateTypeMsgSave' class='errorMsg'><span>Please Enter Rate Type</span></div>";
                fixedRateType.children("div").html(temp_fixedRateType);


            }

            if(fixedValue.children("div").children("input[type=text]").val()==''){
                checkFixSave++;

                var temp_fixedValue =  "<input type='text' size='9' id='temp_fixedValue' placeholder='0.00' class='hasError'/>";
//                        "<div id='fixedValueMsgSave' class='errorMsg'><span>Please Enter Value</span></div>";
                fixedValue.children("div").html(temp_fixedValue);

            }
            else if(!is_int(fixedValue.children("div").children("input[type=text]").val())){
                checkFixSaveInt++;
//                alert("enter num");
            }


            validateFixedFeesSave(par);
            if((checkFixSave==0)&&(checkFixSaveInt==0)){
                fixShow--;
                if(fixShow==0)
                    $("#fixedTr").show();

                var temp_fixedMin = fixedMin.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+fixedMin.children("div").children("input[type=text]").val()+"' name='fixedMin' />";
                fixedMin.children("div").html(temp_fixedMin);

                var temp_fixedMax = fixedMax.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+fixedMax.children("div").children("input[type=text]").val()+"' name='fixedMax' />";
                fixedMax.children("div").html(temp_fixedMax);

                var temp_fixedRateType = fixedRateType.children("div").find("select[name=fixedRateType] option:selected").html() + "<input type='hidden' value='"+fixedRateType.children("div").children("select").val()+"' name='fixedRateType' />";
                fixedRateType.children("div").html(temp_fixedRateType);

                var temp_fixedValue = fixedValue.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+fixedValue.children("div").children("input[type=text]").val()+"' name='fixedValue' />";
                fixedValue.children("div").html(temp_fixedValue);

                fixedEdit.html("<div class='visible-md visible-lg visible-sm visible-xs action-buttons'>"+
                        "<a  href='javascript:void(0);'><i class='icon-pencil bigger-130 green'></i></a>"+
                        "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-add bigger-130'></i></a>");
            }
        });
        function validateFixedFeesSave(par){
            var fixedMin = par.children("td:nth-child(1)");
            var fixedMax = par.children("td:nth-child(2)");
            var fixedRateType = par.children("td:nth-child(3)");
            var fixedValue = par.children("td:nth-child(4)");

            fixedMin.find("#temp_fixedMin").keyup(function(){
//                fixedMin.find("#fixedMinMsgSave").hide();
//                fixedMin.find("#temp_fixedMin").removeClass('hasError');
                if(!is_int((fixedMin.find("#temp_fixedMin").val()))){
//                    alert("enter Num");
                    fixedMin.find("#temp_fixedMin").addClass('hasError');
                }
                if(is_int((fixedMin.find("#temp_fixedMin").val()))){
//                    alert("enter Num");
                    fixedMin.find("#temp_fixedMin").removeClass('hasError');
                }
            });

            fixedMax.find("#temp_fixedMax").keyup(function(){
                if(!is_int((fixedMax.find("#temp_fixedMax").val()))){
//                    alert("enter Num");
                    fixedMax.find("#temp_fixedMax").addClass('hasError');
                }
                if(is_int((fixedMax.find("#temp_fixedMax").val()))){
//                    alert("enter Num");
                    fixedMax.find("#temp_fixedMax").removeClass('hasError');
                }
            });
            fixedValue.find("#temp_fixedValue").keyup(function(){
                if(!is_int((fixedValue.find("#temp_fixedValue").val()))){
//                    alert("enter Num");
                    fixedValue.find("#temp_fixedValue").addClass('hasError');
                }
                if(is_int((fixedValue.find("#temp_fixedValue").val()))){
//                    alert("enter Num");
                    fixedValue.find("#temp_fixedValue").removeClass('hasError');
                }
            });
            fixedRateType.find("#temp_fixedRateType").mousedown(function(){
                $("#fixedRateTypeMsgSave").hide();
                fixedRateType.find("#temp_fixedRateType").removeClass('hasError');
            });

        }
        function is_int(value){
            if( (value>=0) && !isNaN(value)){
                return true;
            } else {
                return false;
            }
        }
        $('#fixedTableData').on('click', '.icon-trash-add', function(){

            if(fixShow==0)
                $("#fixedTr").show();
            $(this).closest ('tr').remove ();
        });

        $('#fixedTableData').on('click', '.icon-trash-edit', function(){
            fixShow--;
            if(fixShow==0)
                $("#fixedTr").show();
            $(this).closest ('tr').remove ();
        });

    });
</script>
</body>

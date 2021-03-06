%{--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">--}%
%{--</script>--}%
<html>
<head></head>
<body>


<g:render template='/coreBanking/settings/product/savings/enrtyFeesTable'/>
<script type="text/javascript">
    $(document).ready(function(){

        var entryShow = 0;
        validateEntryFeesTable();
        $("#entryAdd").click(function(){

            var entryMin = $( "#entryMin" ).val();
            var entryMax = $( "#entryMax" ).val();
            var entryValue = $( "#entryValue" ).val();
            var entryRateTypeValue = $( "#entryRateType" ).val();
            var entryRateTypeName = $( "#entryRateType option:selected" ).html();
            var checkEntry = 0;
            var checkEntryInt = 0;

            if($('#entryTableData').find('#entryMin').val()==''){
                checkEntry++;
//                $("#entryMinMsg").show();
                $('#entryMin').closest('.form-group').removeClass('has-info').addClass('has-error');
            }
            if(!is_int($('#entryTableData').find('#entryMin').val())){
                checkEntryInt++;
            }
            if($('#entryTableData').find('#entryMax').val()==''){
                checkEntry++;
//                $("#entryMaxMsg").show();
                $('#entryMax').closest('.form-group').removeClass('has-info').addClass('has-error');
            }
            if(!is_int($('#entryTableData').find('#entryMax').val())){
                checkEntryInt++;
            }
            if($('#entryTableData').find('#entryRateType').val()==''){
                checkEntry++;
//                $("#entryRateTypeMsg").show();
                $('#entryRateType').closest('.form-group').removeClass('has-info').addClass('has-error');

            }
            if($('#entryTableData').find('#entryValue').val()==''){
                checkEntry++;
//                $("#entryValMsg").show();
                $('#entryValue').closest('.form-group').removeClass('has-info').addClass('has-error');
            }
            if(!is_int($('#entryTableData').find('#entryValue').val())){
                checkEntryInt++;
            }

            if((checkEntry==0)&&(checkEntryInt==0)) {
                $("#entryTableData tbody").append(
                        "<tr>"+
                                "<td><div id='entry_min'>"+entryMin+"<input type='hidden' name='entryMin' value='"+entryMin+"' /></div></td>"+
                                "<td><div id='entry_max'>"+entryMax+"<input type='hidden' name='entryMax' value='"+entryMax+"' /></div></td>"+
                                "<td><div id='entry_rate_type'>"+entryRateTypeName+"<input type='hidden' name='entryRateType' value='"+entryRateTypeValue+"' /></div></td>"+
                                "<td><div id='entry_value'>"+entryValue+"<input type='hidden' name='entryValue' value='"+entryValue+"' /></div></td>"+
                                "<td>" +
                                "<div class='visible-md visible-lg visible-sm visible-xs action-buttons' id='btnEdit'>"+
                                "<a  href='javascript:void(0);'><i class='icon-pencil bigger-130 green'></i></a>"+
                                "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-add bigger-130'></i></a>"+
                                "</div>"+
                                "</td>"+
                                "</tr>");
                $('#entryTableData').find('input[type=text]').each(function() {
                    $(this).val('');
                });

                $('#entryTableData').find('select').each(function() {
                    $(this).val('');
                });
            }




        });
        function validateEntryFeesTable(){

//            $("#entryMinMsg").hide();
//            $("#entryMaxMsg").hide();
//            $("#entryRateTypeMsg").hide();
//            $("#entryValMsg").hide();

            $("#entryMin").keyup(function(){
                if(!is_int($('#entryMin').val())){
//                $("#entryMinMsg").hide();

                    $('#entryMin').closest('.form-group').removeClass('has-info').addClass('has-error');

                }
                else if(is_int($('#entryMin').val())){
//                alert("Enter Number in Start Amount!");
                    $("#entryMin").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
            });

            $("#entryMax").keyup(function(){
                if(is_int($('#entryMax').val())){
//                $("#entryMaxMsg").hide();
                $("#entryMax").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#entryMax').val())){
//                alert("Enter Number in Start Amount!");
                    $("#entryMax").closest('.form-group').removeClass('has-info').addClass('has-error');
                }

            });
            $("#entryValue").keyup(function(){
                if(is_int($('#entryValue').val())){
//                $("#entryValMsg").hide();
                $("#entryValue").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#entryValue').val())){
//                alert("Enter Number in Start Amount!");
                    $("#entryValue").closest('.form-group').removeClass('has-info').addClass('has-error');
                }

            });
            $("#entryRateType").mousedown(function(){
//                $("#entryRateTypeMsg").hide();
                $("#entryRateType").closest('.form-group').removeClass('has-error').addClass('has-info');
            });


        }

        $('#entryTableData').on('click', '.icon-pencil', function () {
            entryShow++;
            $("#entryTr").hide();
            var par = $(this).closest('tr'); //tr
            var entryMin = par.children("td:nth-child(1)");
            var entryMax = par.children("td:nth-child(2)");
            var entryRateType = par.children("td:nth-child(3)");
            var entryValue = par.children("td:nth-child(4)");

            var drop = "<div id='entry_rate_type'><select name='entryRateType' style='min-width:90px'>" +
                    "<option value=''>- Select -</option>"+
                    "<option value='${rateType.FLAT}'>${rateType.FLAT}</option>"+
                    "<option value='${rateType.RATE}'>${rateType.RATE}</option></div> ";

            var entryEdit  = par.children("td:nth-child(5)");
            var temp_entryMin = "<input type='text' size='9' placeholder='0.00' value='"+entryMin.children("div").children("input[type=hidden]").val()+"'/>";
            entryMin.children("div").html(temp_entryMin);

            var temp_entryMax = "<input type='text' size='9' placeholder='0.00' value='"+entryMax.children("div").children("input[type=hidden]").val()+"'/>";
            entryMax.children("div").html(temp_entryMax);

            var selVal = entryRateType.children("div").children("input[type=hidden]").val();
            entryRateType.html(drop);
            entryRateType.find("select[name='entryRateType'] option[value='"+selVal+"']").attr("selected","selected");

            var temp_entryValue = "<input type='text' size='9' placeholder='0.00' value='"+entryValue.children("div").children("input[type=hidden]").val()+"'/>";
            entryValue.children("div").html(temp_entryValue);

            entryEdit .html("<div class='visible-md visible-lg visible-sm visible-xs action-buttons'>"+
                    "<a  href='javascript:void(0);'><i class='glyphicon glyphicon-floppy-saved bigger-130 green'></i></a>"+
                    "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-edit bigger-130'></i></a>");
            entryMin.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(entryMin.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    entryMin.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(entryMin.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    entryMin.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });
            entryMax.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(entryMax.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    entryMax.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(entryMax.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    entryMax.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });
            entryValue.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(entryValue.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    entryValue.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(entryValue.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    entryValue.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });

        });
        $('#entryTableData').on('click', '.glyphicon-floppy-saved', function () {

            var par = $(this).closest('tr'); //tr
            var entryMin = par.children("td:nth-child(1)");
            var entryMax = par.children("td:nth-child(2)");
            var entryRateType = par.children("td:nth-child(3)");
            var entryValue = par.children("td:nth-child(4)");
            var enrtyEdit  = par.children("td:nth-child(5)");
            var checkEntrySave = 0;
            var checkEntrySaveInt = 0;
            if(entryMin.children("div").children("input[type=text]").val()==''){

                checkEntrySave++;
                var temp_entryMin =  "<input type='text' size='9' id='temp_entryMin' placeholder='0.00' class='hasError'/>";
//                        "<div id='entryMinMsgSave' class='errorMsg'><span>Please Enter Min</span></div>";
                entryMin.children("div").html(temp_entryMin);
            }
            else if(!is_int(entryMin.children("div").children("input[type=text]").val())){
                checkEntrySaveInt++;
//                alert("enter num");
            }

            if(entryMax.children("div").children("input[type=text]").val()==''){
                checkEntrySave++;
                var temp_entryMax =  "<input type='text' size='9' id='temp_entryMax' placeholder='0.00' class='hasError'/>";
//                        "<div id='entryMaxMsgSave' class='errorMsg'><span>Please Enter Max</span></div>";
                entryMax.children("div").html(temp_entryMax);
            }
            else if(!is_int(entryMax.children("div").children("input[type=text]").val())){
                checkEntrySaveInt++;
//                alert("enter num");
            }

            if(entryRateType.children("div").children("select").val()==''){
                checkEntrySave++;//
                var temp_entryRateType =   "<select id='temp_entryRateType' class='form-control hasError' name='entryRateType' style='min-width:70px'>"+
                        "<option value=''>- Select -</option>"+
                        "<option value='${rateType.FLAT}'>${rateType.FLAT}</option>"+
                        "<option value='${rateType.RATE}'>${rateType.RATE}</option>"+
                        "</select>";
//                        "<div id='entryRateTypeMsgSave' class='errorMsg'><span>Please Enter Rate Type</span></div>";
                entryRateType.children("div").html(temp_entryRateType);
            }

            if(entryValue.children("div").children("input[type=text]").val()==''){
                checkEntrySave++;

                var temp_entryValue =  "<input type='text' size='9' id='temp_entryValue' placeholder='0.00' class='hasError'/>";
//                        "<div id='entryValueMsgSave' class='errorMsg'><span>Please Enter Value</span></div>";
                entryValue.children("div").html(temp_entryValue);
            }
            else if(!is_int(entryValue.children("div").children("input[type=text]").val())){
                checkEntrySaveInt++;
//                alert("enter num");
            }


            validateEntryFeesSave(par);
            if((checkEntrySave==0)&&(checkEntrySaveInt==0)){
                entryShow--;
                if(entryShow==0) {$("#entryTr").show();}
                var temp_entryMin = entryMin.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+entryMin.children("div").children("input[type=text]").val()+"' name='entryMin' />";
                entryMin.children("div").html(temp_entryMin);

                var temp_entryMax = entryMax.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+entryMax.children("div").children("input[type=text]").val()+"' name='entryMax' />";
                entryMax.children("div").html(temp_entryMax);

                var temp_entryRateType = entryRateType.children("div").find("select[name=entryRateType] option:selected").html() + "<input type='hidden' value='"+entryRateType.children("div").children("select").val()+"' name='entryRateType' />";
                entryRateType.children("div").html(temp_entryRateType);

                var temp_entryValue = entryValue.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+entryValue.children("div").children("input[type=text]").val()+"' name='entryValue' />";
                entryValue.children("div").html(temp_entryValue);

                enrtyEdit.html("<div class='visible-md visible-lg visible-sm visible-xs action-buttons'>"+
                        "<a  href='javascript:void(0);'><i class='icon-pencil bigger-130 green'></i></a>"+
                        "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-add bigger-130'></i></a>");
            }
        });
        function validateEntryFeesSave(par){
            var entryMin = par.children("td:nth-child(1)");
            var entryMax = par.children("td:nth-child(2)");
            var entryRateType = par.children("td:nth-child(3)");
            var entryValue = par.children("td:nth-child(4)");
            entryMin.find("#temp_entryMin").keyup(function(){
//                $("#entryMinMsgSave").hide();
//                $("#temp_entryMin").removeClass('hasError');
                if(!is_int((entryMin.find("#temp_entryMin").val()))){
//                    alert("enter Num");
                    entryMin.find("#temp_entryMin").addClass('hasError');
                }
                if(is_int((entryMin.find("#temp_entryMin").val()))){
//                    alert("enter Num");
                    entryMin.find("#temp_entryMin").removeClass('hasError');
                }
            });

            entryMax.find("#temp_entryMax").keyup(function(){
//                $("#entryMaxMsgSave").hide();
//                $("#temp_entryMax").removeClass('hasError');
                if(!is_int((entryMax.find("#temp_entryMax").val()))){
//                    alert("enter Num");
                    entryMax.find("#temp_entryMax").addClass('hasError');
                }
                if(is_int((entryMax.find("#temp_entryMax").val()))){
//                    alert("enter Num");
                    entryMax.find("#temp_entryMax").removeClass('hasError');
                }
            });
            entryValue.find("#temp_entryValue").keyup(function(){
                if(!is_int((entryValue.find("#temp_entryValue").val()))){
//                    alert("enter Num");
                    entryValue.find("#temp_entryValue").addClass('hasError');
                }
                if(is_int((entryValue.find("#temp_entryValue").val()))){
//                    alert("enter Num");
                    entryValue.find("#temp_entryValue").removeClass('hasError');
                }
            });
            entryRateType.find("#temp_entryRateType").mousedown(function(){
//                $("#entryRateTypeMsgSave").hide();
                entryRateType.find("#temp_entryRateType").removeClass('hasError');
            });

        }
        $('#entryTableData').on('click', '.icon-trash-add', function(){

            if(entryShow==0) $("#entryTr").show();
            $(this).closest ('tr').remove ();
        });


        $('#entryTableData').on('click', '.icon-trash-edit', function(){
            entryShow--;
            if(entryShow==0) $("#entryTr").show();
            $(this).closest ('tr').remove ();
        });
        function is_int(value){
            if( (value>=0) && !isNaN(value)){
                return true;
            } else {
                return false;
            }
        }


    });
</script>
</body></html>

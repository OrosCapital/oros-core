
<html>
<head></head>
<body>


<g:render template='/coreBanking/settings/product/savings/agioFeesTable'/>
<script type="text/javascript">
    $(document).ready(function(){

        validateAgioFeesTable();
        var agioShow = 0;


        $("#agioAdd").click(function(){


            var agioMin = $( "#agioMin" ).val();
            var agioMax = $( "#agioMax" ).val();
            var agioValue = $( "#agioValue" ).val();
            var agioRateTypeValue = $( "#agioRateType" ).val();
            var agioRateTypeName = $( "#agioRateType option:selected" ).html();
            var agioCircleType_name = $( "#agioCircleType option:selected" ).html();
            var agioCircleType_value = $( "#agioCircleType" ).val();
            var checkAgio = 0;
            var checkAgioInt = 0;

            if($('#agioTableData').find('#agioMin').val()==''){
                checkAgio++;

//                $("#agioMinMsg").show();
                $('#agioMin').closest('.form-group').removeClass('has-info').addClass('has-error');
            }
            if(!is_int($('#agioTableData').find('#agioMin').val())){
                checkAgioInt++;
            }
            if($('#agioTableData').find('#agioMax').val()==''){
                checkAgio++;
//                $("#agioMaxMsg").show();
                $('#agioMax').closest('.form-group').removeClass('has-info').addClass('has-error');
            }
            if(!is_int($('#agioTableData').find('#agioMax').val())){
                checkAgioInt++;
            }
            if($('#agioTableData').find('#agioCircleType').val()==''){
                checkAgio++;
//                $("#agioCircleTypeMsg").show();
                $('#agioCircleType').closest('.form-group').removeClass('has-info').addClass('has-error');

            }
            if($('#agioTableData').find('#agioRateType').val()==''){
                checkAgio++;
//                $("#agioRateTypeMsg").show();
                $('#agioRateType').closest('.form-group').removeClass('has-info').addClass('has-error');

            }
            if($('#agioTableData').find('#agioValue').val()==''){
                checkAgio++;
//                $("#agioValMsg").show();
                $('#agioValue').closest('.form-group').removeClass('has-info').addClass('has-error');

            }
            if(!is_int($('#agioTableData').find('#agioValue').val())){
                checkAgioInt++;
            }

            if((checkAgio==0)&&(checkAgioInt==0)) {

                $("#agioTableData tbody").append(
                        "<tr>"+
                                "<td><div id='agio_min'>"+agioMin+"<input type='hidden' name='agioMin' value='"+agioMin+"' /></div></td>"+
                                "<td><div id='agio_max'>"+agioMax+"<input type='hidden' name='agioMax' value='"+agioMax+"' /></div></td>"+
                                "<td><div id='agio_circle_type'>"+agioCircleType_name+"<input type='hidden' name='agioCircleType' value='"+agioCircleType_value+"' /></div></td>"+
                                "<td><div id='agio_rate_type'>"+agioRateTypeName+"<input type='hidden' name='agioRateType' value='"+agioRateTypeValue+"' /></div></td>"+
                                "<td><div id='agio_value'>"+agioValue+"<input type='hidden' name='agioValue' value='"+agioValue+"' /></div></td>"+
                                "<td>" +
                                "<div class='visible-md visible-lg visible-sm visible-xs action-buttons'>"+
                                "<a  href='javascript:void(0);'><i class='icon-pencil bigger-130 green'></i></a>"+
                                "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-add bigger-130'></i></a>"+
                                "</div>"+
                                "</td>"+
                                "</tr>");
                $('#agioTableData').find('input[type=text]').each(function() {
                    $(this).val('');
                });

                $('#agioTableData').find('select').each(function() {
                    $(this).val('');
                });
            }


        });
        function validateAgioFeesTable(){

//            $("#agioMinMsg").hide();
//            $("#agioMaxMsg").hide();
//            $("#agioCircleTypeMsg").hide();
//            $("#agioRateTypeMsg").hide();
//            $("#agioValMsg").hide();

            $("#agioMin").keyup(function(){
                if(!is_int($('#agioMin').val())){
//                $("#agioMinMsg").hide();
                    $("#agioMin").closest('.form-group').removeClass('has-info').addClass('has-error');
                }
                else if(is_int($('#agioMin').val())){
//                alert("Enter Number in Start Amount!");

                    $("#agioMin").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
            });

            $("#agioMax").keyup(function(){
                if(is_int($('#agioMax').val())){
//                $("#agioMaxMsg").hide();
                $("#agioMax").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#agioMax').val())){
//                alert("Enter Number in Start Amount!");
                    $("#agioMax").closest('.form-group').removeClass('has-info').addClass('has-error');
                }

            });
            $("#agioValue").keyup(function(){
                if(is_int($('#agioValue').val())){
//                $("#agioValMsg").hide();
                $("#agioValue").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#agioValue').val())){
//                alert("Enter Number in Start Amount!");
                    $("#agioValue").closest('.form-group').removeClass('has-info').addClass('has-error');
                }
            });
            $("#agioRateType").mousedown(function(){
//                $("#agioRateTypeMsg").hide();
                $("#agioRateType").closest('.form-group').removeClass('has-error').addClass('has-info');
            });
            $("#agioCircleType").mousedown(function(){
//                $("#agioCircleTypeMsg").hide();
                $("#agioCircleType").closest('.form-group').removeClass('has-error').addClass('has-info');
            });


        }

        $('#agioTableData').on('click','.icon-pencil', function () {
            agioShow++;
            $("#agioTr").hide();
            var par = $(this).closest('tr'); //tr
            var agioMin = par.children("td:nth-child(1)");
            var agioMax = par.children("td:nth-child(2)");
            var agioCircleType = par.children("td:nth-child(3)");
            var agioRateType = par.children("td:nth-child(4)");
            var agioValue = par.children("td:nth-child(5)");

            var agioEdit  = par.children("td:nth-child(6)");
            var drop = "<div id='agio_rate_type'><select name='agioRateType'  style='min-width:90px'>" +
                    "<option value=''>- Select -</option>"+
                    "<option value='1'>Flat</option> " +
                    "<option value='2'>Rate</option></select></div> ";
            var dropCircle = "<div id='agio_circle_type'>" +
                    "<select name='agioCircleType' style='min-width:125px'>" +
                    "<option value=''>- Select -</option>"+
                    "<option value='1'>Daily</option>" +
                    "<option value='2'>Weekly</option>" +
                    "<option value='3'>Half Monthly</option>" +
                    "<option value='4'>Monthly</option></select></div>";

            var temp_agioMin = "<input type='text' size='9' placeholder='0.00' value='"+agioMin.children("div").children("input[type=hidden]").val()+"'/>";
            agioMin.children("div").html(temp_agioMin);
            var temp_agioMax = "<input type='text' size='9' placeholder='0.00' value='"+agioMax.children("div").children("input[type=hidden]").val()+"'/>";
            agioMax.children("div").html(temp_agioMax);

            var selValCircle = agioCircleType.children("div").children("input[type=hidden]").val();
            agioCircleType.html(dropCircle);
            agioCircleType.find("select[name='agioCircleType'] option[value='"+selValCircle+"']").attr("selected","selected");

            var selVal = agioRateType.children("div").children("input[type=hidden]").val();
            agioRateType.html(drop);
            agioRateType.find("select[name='agioRateType'] option[value='"+selVal+"']").attr("selected","selected");

            var temp_agioValue = "<input type='text' size='9' placeholder='0.00'  value='"+agioValue.children("div").children("input[type=hidden]").val()+"'/>";
            agioValue.children("div").html(temp_agioValue);

            agioEdit .html("<div class='visible-md visible-lg visible-sm visible-xs action-buttons'>"+
                    "<a  href='javascript:void(0);'><i class='glyphicon glyphicon-floppy-saved bigger-130 green'></i></a>"+
                    "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-edit bigger-130'></i></a>");
            agioMin.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(agioMin.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    agioMin.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(agioMin.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    agioMin.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });
            agioMax.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(agioMax.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    agioMax.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(agioMax.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    agioMax.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });
            agioValue.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(agioValue.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    agioValue.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(agioValue.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    agioValue.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });

        });
        $('#agioTableData').on('click', '.glyphicon-floppy-saved', function () {


            var par = $(this).closest('tr'); //tr
            var agioMin = par.children("td:nth-child(1)");
            var agioMax = par.children("td:nth-child(2)");
            var agioCircleType = par.children("td:nth-child(3)");
            var agioRateType = par.children("td:nth-child(4)");
            var agioValue = par.children("td:nth-child(5)");

            var agioEdit  = par.children("td:nth-child(6)");
            var checkAgioSave = 0;
            var checkAgioSaveInt = 0;
            if(agioMin.children("div").children("input[type=text]").val()==''){

                checkAgioSave++;
                var temp_agioMin =  "<input type='text' size='9' id='temp_agioMin' class='hasError' placeholder='0.00'/>";
//                        "<div id='agioMinMsgSave' class='errorMsg'><span>Please Enter Min</span></div>";
                agioMin.children("div").html(temp_agioMin);
            }
            else if(!is_int(agioMin.children("div").children("input[type=text]").val())){
                checkAgioSaveInt++;
//                alert("enter num");
            }

            if(agioMax.children("div").children("input[type=text]").val()==''){
                checkAgioSave++;
                var temp_agioMax =  "<input type='text' size='9' id='temp_agioMax' class='hasError' placeholder='0.00'/>";
//                        "<div id='agioMaxMsgSave' class='errorMsg'><span>Please Enter Max</span></div>";
                agioMax.children("div").html(temp_agioMax);

            }
            else if(!is_int(agioMax.children("div").children("input[type=text]").val())){
                checkAgioSaveInt++;
//                alert("enter num");
            }

            if(agioCircleType.children("div").children("select").val()==''){
                checkAgioSave++;//
                var temp_agioCircleType =  "<select id='temp_agioCircleType' class='form-control hasError' name='agioCircleType' style='min-width:70px'>"+
                        "<option value=''>- Select -</option>"+
                        "<option value='1'>Daily</option>" +
                        "<option value='2'>Weekly</option>" +
                        "<option value='3'>Half Monthly</option>" +
                        "<option value='4'>Monthly</option>"+
                        "</select>";
//                        "<div id='agioCircleTypeMsgSave' class='errorMsg'><span>Please Enter Circle Type</span></div>";
                agioCircleType.children("div").html(temp_agioCircleType);
            }
            if(agioRateType.children("div").children("select").val()==''){
                checkAgioSave++;//
                var temp_agioRateType ="<select id='temp_agioRateType' class='form-control hasError' name='agioRateType' style='min-width:70px'>"+
                        "<option value=''>- Select -</option>"+
                        "<option value='1'>Flat</option>" +
                        "<option value='2'>Rate</option>"+
                        "</select>";
//                        "<div id='agioRateTypeMsgSave' class='errorMsg'><span>Please Enter Rate Type</span></div>";
                agioRateType.children("div").html(temp_agioRateType);
            }

            if(agioValue.children("div").children("input[type=text]").val()==''){
                checkAgioSave++;

                var temp_agioValue =  "<input type='text' size='9' id='temp_agioValue' class='hasError' placeholder='0.00'/>";
//                        "<div id='agioValueMsgSave' class='errorMsg'><span>Please Enter Value</span></div>";
                agioValue.children("div").html(temp_agioValue);
            }
            else if(!is_int(agioValue.children("div").children("input[type=text]").val())){
                checkAgioSaveInt++;
//                alert("enter num");
            }


            validateAgioFeesSave(par);

            if((checkAgioSave==0)&&(checkAgioSaveInt==0)){
                agioShow--;
                if(agioShow==0) {$("#agioTr").show();}

                var temp_agioMin = agioMin.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+agioMin.children("div").children("input[type=text]").val()+"' name='agioMin' />";
                agioMin.children("div").html(temp_agioMin);
                var temp_agioMax = agioMax.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+agioMax.children("div").children("input[type=text]").val()+"' name='agioMax' />";
                agioMax.children("div").html(temp_agioMax);

                var temp_agioCircleType = agioCircleType.children("div").find("select[name=agioCircleType] option:selected").html() + "<input type='hidden' value='"+agioCircleType.children("div").children("select").val()+"' name='agioCircleType' />";
                agioCircleType.children("div").html(temp_agioCircleType);

                var temp_agioRateType = agioRateType.children("div").find("select[name=agioRateType] option:selected").html() + "<input type='hidden' value='"+agioRateType.children("div").children("select").val()+"' name='agioRateType' />";
                agioRateType.children("div").html(temp_agioRateType);

                var temp_agioValue = agioValue.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+agioValue.children("div").children("input[type=text]").val()+"' name='agioValue' />";
                agioValue.children("div").html(temp_agioValue);

                agioEdit.html("<div class='visible-md visible-lg visible-sm visible-xs action-buttons'>"+
                        "<a  href='javascript:void(0);'><i class='icon-pencil bigger-130 green'></i></a>"+
                        "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-add bigger-130'></i></a>");
            }
        });
        function validateAgioFeesSave(par){
            var agioMin = par.children("td:nth-child(1)");
            var agioMax = par.children("td:nth-child(2)");
            var agioCircleType = par.children("td:nth-child(3)");
            var agioRateType = par.children("td:nth-child(4)");
            var agioValue = par.children("td:nth-child(5)");
            agioMin.find("#temp_agioMin").keyup(function(){
//                $("#agioMinMsgSave").hide();
//                $("#temp_agioMin").removeClass('hasError');
                if(!is_int((agioMin.find("#temp_agioMin").val()))){
//                    alert("enter Num");
                    agioMin.find("#temp_agioMin").addClass('hasError');
                }
                if(is_int((agioMin.find("#temp_agioMin").val()))){
//                    alert("enter Num");
                    agioMin.find("#temp_agioMin").removeClass('hasError');
                }
            });

            agioMax.find("#temp_agioMax").keyup(function(){
                if(!is_int((agioMax.find("#temp_agioMax").val()))){
//                    alert("enter Num");
                    agioMax.find("#temp_agioMax").addClass('hasError');
                }
                if(is_int((agioMax.find("#temp_agioMax").val()))){
//                    alert("enter Num");
                    agioMax.find("#temp_agioMax").removeClass('hasError');
                }
            });
            agioValue.find("#temp_agioValue").keyup(function(){
                if(!is_int((agioValue.find("#temp_agioValue").val()))){
//                    alert("enter Num");
                    agioValue.find("#temp_agioValue").addClass('hasError');
                }
                if(is_int((agioValue.find("#temp_agioValue").val()))){
//                    alert("enter Num");
                    agioValue.find("#temp_agioValue").removeClass('hasError');
                }
            });
            agioRateType.find("#temp_agioRateType").mousedown(function(){
//                $("#agioRateTypeMsgSave").hide();
                agioRateType.find("#temp_agioRateType").removeClass('hasError');
            });
            agioCircleType.find("#temp_agioCircleType").mousedown(function(){
//                $("#agioCircleTypeMsgSave").hide();
                agioCircleType.find("#temp_agioCircleType").removeClass('hasError');
            });

        }
        function is_int(value){
            if( (value>=0) && !isNaN(value)){
                return true;
            } else {
                return false;
            }
        }
        $('#agioTableData').on('click', '.icon-trash-add', function(){

            if(agioShow==0)
                $("#agioTr").show();
            $(this).closest ('tr').remove ();
        });


        $('#agioTableData').on('click', '.icon-trash-edit', function(){
            agioShow--;
            if(agioShow==0)
                $("#agioTr").show();
            $(this).closest ('tr').remove ();
        });

    });
</script>

</body></html>

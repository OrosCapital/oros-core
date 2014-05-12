%{--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">--}%
%{--</script>--}%
<html>
<head></head>
<body>

<g:render template='/coreBanking/settings/product/savings/managementFeesTable'/>
<script type="text/javascript">
    $(document).ready(function(){
        var mngShow = 0;
        validateManagementFeesTable();

        $("#manageAdd").click(function(){

            var manageMin = $( "#manageMin" ).val();
            var manageMax = $( "#manageMax" ).val();
            var manageValue = $( "#manageValue" ).val();
            var manageCircleTypeValue = $( "#manageCircleType" ).val();
            var manageCircleTypeName = $( "#manageCircleType option:selected" ).html();
            var manageRateTypeValue = $( "#manageRateType" ).val();
            var manageRateTypeName = $( "#manageRateType option:selected" ).html();
            var checkMng = 0;
            var checkMngInt = 0;

            if($('#managementTableData').find('#manageMin').val()==''){
                checkMng++;
//                $("#manageMinMsg").show();
                $('#manageMin').closest('.form-group').removeClass('has-info').addClass('has-error');
            }
            if(!is_int($('#managementTableData').find('#manageMin').val())){
                checkMngInt++;
            }
            if($('#managementTableData').find('#manageMax').val()==''){
                checkMng++;
//                $("#manageMaxMsg").show();
                $('#manageMax').closest('.form-group').removeClass('has-info').addClass('has-error');
            }
            if(!is_int($('#managementTableData').find('#manageMax').val())){
                checkMngInt++;
            }
            if($('#managementTableData').find('#manageCircleType').val()==''){
                checkMng++;
//                $("#manageCircleTypeMsg").show();
                $('#manageCircleType').closest('.form-group').removeClass('has-info').addClass('has-error');

            }
            if($('#managementTableData').find('#manageRateType').val()==''){
                checkMng++;
//                $("#manageRateTypeMsg").show();
                $('#manageRateType').closest('.form-group').removeClass('has-info').addClass('has-error');

            }
            if($('#managementTableData').find('#manageValue').val()==''){
                checkMng++;
//                $("#manageValMsg").show();
                $('#manageValue').closest('.form-group').removeClass('has-info').addClass('has-error');

            }
            if(!is_int($('#managementTableData').find('#manageValue').val())){
                checkMngInt++;
            }

            if((checkMng==0)&&(checkMngInt==0)) {

                $("#managementTableData tbody").append(
                        "<tr>"+

                                "<td><div id='manage_min'>"+manageMin+"<input type='hidden' name='manageMin' value='"+manageMin+"' /></div></td>"+
                                "<td><div id='manage_max'>"+manageMax+"<input type='hidden' name='manageMax' value='"+manageMax+"' /></div></td>"+
                                "<td><div id='manage_circle_type'>"+manageCircleTypeName+"<input type='hidden' name='manageCircleType' value='"+manageCircleTypeValue+"' /></div></td>"+
                                "<td><div id='manage_rate_type'>"+manageRateTypeName+"<input type='hidden' name='manageRateType' value='"+manageRateTypeValue+"' /></div></td>"+
                                "<td><div id='fixed_value'>"+manageValue+"<input type='hidden' name='manageValue' value='"+manageValue+"' /></div></td>"+
                                "<td>" +
                                "<div class='visible-md visible-lg visible-sm visible-xs action-buttons' id='btnEdit'>"+
                                "<a  href='javascript:void(0);'><i class='icon-pencil bigger-130 green'></i></a>"+
                                "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-add bigger-130'></i></a>"+
                                "</div>"+
                                "</td>"+
                                "</tr>");
                $('#managementTableData').find('input[type=text]').each(function() {
                    $(this).val('');
                });

                $('#managementTableData').find('select').each(function() {
                    $(this).val('');
                });
            }
        });
        function validateManagementFeesTable(){

//            $("#manageMinMsg").hide();
//            $("#manageMaxMsg").hide();
//            $("#manageCircleTypeMsg").hide();
//            $("#manageRateTypeMsg").hide();
//            $("#manageValMsg").hide();

            $("#manageMin").keyup(function(){
                if(is_int($('#manageMin').val())){
//                $("#manageMinMsg").hide();
                $("#manageMin").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#manageMin').val())){
//                alert("Enter Number in Start Amount!");
                    $("#manageMin").closest('.form-group').removeClass('has-info').addClass('has-error');
                }
            });

            $("#manageMax").keyup(function(){
                if(is_int($('#manageMax').val())){
//                    $("#manageMinMsg").hide();
                    $("#manageMax").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#manageMax').val())){
//                alert("Enter Number in Start Amount!");
                    $("#manageMax").closest('.form-group').removeClass('has-info').addClass('has-error');
                }
            });
            $("#manageValue").keyup(function(){
                if(is_int($('#manageValue').val())){
//                    $("#manageMinMsg").hide();
                    $("#manageValue").closest('.form-group').removeClass('has-error').addClass('has-info');
                }
                else if(!is_int($('#manageValue').val())){
//                alert("Enter Number in Start Amount!");
                    $("#manageValue").closest('.form-group').removeClass('has-info').addClass('has-error');
                }
            });
            $("#manageRateType").mousedown(function(){
//                $("#manageRateTypeMsg").hide();
                $("#manageRateType").closest('.form-group').removeClass('has-error').addClass('has-info');
            });
            $("#manageCircleType").mousedown(function(){
//                $("#manageCircleTypeMsg").hide();
                $("#manageCircleType").closest('.form-group').removeClass('has-error').addClass('has-info');
            });


        }
        $('#managementTableData').on('click', '.icon-pencil', function () {
            mngShow++;
            $("#manageTr").hide();
            var par = $(this).closest('tr'); //tr
            var manageMin = par.children("td:nth-child(1)");
            var manageMax = par.children("td:nth-child(2)");
            var manageCircleType = par.children("td:nth-child(3)");
            var manageRateType = par.children("td:nth-child(4)");
            var manageValue = par.children("td:nth-child(5)");

            var dropRate = "<div id='manage_rate_type'><select name='manageRateType' style='min-width:90px'>" +
                    "<option value=''>- Select -</option>"+
                    "<option value='${rateType.FLAT}'>${rateType.FLAT}</option>" +
                    "<option value='${rateType.RATE}'>${rateType.RATE}</option></select></div> ";
            var dropCircle = "<div id='manage_circle_type'><select name='manageCircleType' style='min-width:125px'>" +
                    "<option value=''>- Select -</option>"+
                    "<option value='${circleName.DAILY}'>${circleName.DAILY}</option>" +
                    "<option value='${circleName.WEEKLY}'>${circleName.WEEKLY}</option>" +
                    "<option value='${circleName.HALFMONTHLY}'>${circleName.HALFMONTHLY}</option>" +
                    "<option value='${circleName.MONTHLY}'>${circleName.MONTHLY}</option></div>";

            var manageEdit  = par.children("td:nth-child(6)");
            var temp_manageMin = "<input type='text' size='9' placeholder='0.00' value='"+manageMin.children("div").children("input[type=hidden]").val()+"'/>";
            manageMin.children("div").html(temp_manageMin);

            var temp_manageMax = "<input type='text' size='9' placeholder='0.00' value='"+manageMax.children("div").children("input[type=hidden]").val()+"'/>";
            manageMax.children("div").html(temp_manageMax);

            var selValCircle = manageCircleType.children("div").children("input[type=hidden]").val();
            manageCircleType.html(dropCircle);
            manageCircleType.find("select[name='manageCircleType'] option[value='"+selValCircle+"']").attr("selected","selected");

            var selValRate = manageRateType.children("div").children("input[type=hidden]").val();
            manageRateType.html(dropRate);
            manageRateType.find("select[name='manageRateType'] option[value='"+selValRate+"']").attr("selected","selected");

            var temp_manageValue = "<input type='text' size='9' placeholder='0.00' value='"+manageValue.children("div").children("input[type=hidden]").val()+"'/>";
            manageValue.children("div").html(temp_manageValue);

            manageEdit .html("<div class='visible-md visible-lg visible-sm visible-xs action-buttons'>"+
                    "<a  href='javascript:void(0);'><i class='glyphicon glyphicon-floppy-saved bigger-130 green'></i></a>"+
                    "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-edit bigger-130'></i></a>");
            manageMin.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(manageMin.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    manageMin.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(manageMin.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    manageMin.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });
            manageMax.children("div").children("input[type=text]").keyup(function(){
                if(!is_int(manageMax.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    manageMax.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int(manageMax.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    manageMax.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });
            manageValue.children("div").children("input[type=text]").keyup(function(){
                if(!is_int( manageValue.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    manageValue.children("div").children("input[type=text]").addClass('hasError');
                }
                if(is_int( manageValue.children("div").children("input[type=text]").val()))
                {
//                    alert("Enter Number");
                    manageValue.children("div").children("input[type=text]").removeClass('hasError');
                }
//
            });

        });
        $('#managementTableData').on('click', '.glyphicon-floppy-saved', function () {

            var par = $(this).closest('tr'); //tr
            var manageMin = par.children("td:nth-child(1)");
            var manageMax = par.children("td:nth-child(2)");
            var manageCircleType = par.children("td:nth-child(3)");
            var manageRateType = par.children("td:nth-child(4)");
            var manageValue = par.children("td:nth-child(5)");

            var manageEdit  = par.children("td:nth-child(6)");
            var checkMngSave = 0;
            var checkMngSaveInt = 0;
            if(manageMin.children("div").children("input[type=text]").val()==''){

                checkMngSave++;
                var temp_manageMin =  "<input type='text' size='9' id='temp_manageMin' placeholder='0.0' class='hasError'/>";
//                        "<div id='manageMinMsgSave' class='errorMsg'><span>Please Enter Min</span></div>";
                manageMin.children("div").html(temp_manageMin);
            }
            else if(!is_int(manageMin.children("div").children("input[type=text]").val())){
                checkMngSaveInt++;
//                alert("enter num");
            }

            if(manageMax.children("div").children("input[type=text]").val()==''){
                checkMngSave++;
                var temp_manageMax =  "<input type='text' size='9' id='temp_manageMax' placeholder='0.00' class='hasError'/>";
//                        "<div id='manageMaxMsgSave' class='errorMsg'><span>Please Enter Max</span></div>";
                manageMax.children("div").html(temp_manageMax);

            }
            else if(!is_int(manageMax.children("div").children("input[type=text]").val())){
                checkMngSaveInt++;
//                alert("enter num");
            }

            if(manageRateType.children("div").children("select").val()==''){
                checkMngSave++;//
                var temp_manageRateType = "<select id='temp_manageRateType' class='form-control hasError' name='manageRateType' style='min-width:70px'>"+
                        "<option value=''>- Select -</option>"+
                        "<option value='${rateType.FLAT}'>${rateType.FLAT}</option>" +
                        "<option value='${rateType.RATE}'>${rateType.RATE}</option>"+
                        "</select>";
//                        "<div id='manageRateTypeMsgSave' class='errorMsg'><span>Please Enter Rate Type</span></div>";
                manageRateType.children("div").html(temp_manageRateType);
            }
            if(manageCircleType.children("div").children("select").val()==''){
                checkMngSave++;//
                var temp_manageCircleType =  "<select id='temp_manageCircleType' class='form-control hasError' name='manageCircleType' style='min-width:70px'>"+
                        "<option value=''>- Select -</option>"+
                        "<option value='${circleName.DAILY}'>${circleName.DAILY}</option>" +
                        "<option value='${circleName.WEEKLY}'>${circleName.WEEKLY}</option>" +
                        "<option value='${circleName.HALFMONTHLY}'>${circleName.HALFMONTHLY}</option>" +
                        "<option value='${circleName.MONTHLY}'>${circleName.MONTHLY}</option>"+
                        "</select>";
//                        "<div id='manageCircleTypeMsgSave' class='errorMsg'><span>Please Enter Circle Type</span></div>";
                manageCircleType.children("div").html(temp_manageCircleType);
            }

            if(manageValue.children("div").children("input[type=text]").val()==''){
                checkMngSave++;

                var temp_manageValue =  "<input type='text' size='9' id='temp_manageValue' placeholder='0.00' class='hasError'/>";
//                        "<div id='manageValueMsgSave' class='errorMsg'><span>Please Enter Value</span></div>";
                manageValue.children("div").html(temp_manageValue);
            }
            else if(!is_int(manageValue.children("div").children("input[type=text]").val())){
                checkMngSaveInt++;
//                alert("enter num");
            }


            validateManagementFeesSave(par);
            if((checkMngSave==0)&&(checkMngSaveInt==0)){
                mngShow--;
                if(mngShow==0)
                    $("#manageTr").show();

                var temp_manageMin = manageMin.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+manageMin.children("div").children("input[type=text]").val()+"' name='manageMin' />";
                manageMin.children("div").html(temp_manageMin);

                var temp_manageMax = manageMax.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+manageMax.children("div").children("input[type=text]").val()+"' name='manageMax' />";
                manageMax.children("div").html(temp_manageMax);

                var temp_manageCircleType = manageCircleType.children("div").find("select[name=manageCircleType] option:selected").html() + "<input type='hidden' value='"+manageCircleType.children("div").children("select").val()+"' name='manageCircleType' />";
                manageCircleType.children("div").html(temp_manageCircleType);

                var temp_manageRateType = manageRateType.children("div").find("select[name=manageRateType] option:selected").html() + "<input type='hidden' value='"+manageRateType.children("div").children("select").val()+"' name='manageRateType' />";
                manageRateType.children("div").html(temp_manageRateType);

                var temp_manageValue = manageValue.children("div").children("input[type=text]").val() + "<input type='hidden' value='"+manageValue.children("div").children("input[type=text]").val()+"' name='manageValue' />";
                manageValue.children("div").html(temp_manageValue);

                manageEdit.html("<div class='visible-md visible-lg visible-sm visible-xs action-buttons'>"+
                        "<a  href='javascript:void(0);'><i class='icon-pencil bigger-130 green'></i></a>"+
                        "<a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-add bigger-130'></i></a>");
            }
        });
        $('#managementTableData').on('click', '.icon-trash-edit', function(){
            mngShow--;
            if(mngShow==0)
                $("#manageTr").show();
            $(this).closest ('tr').remove ();
        });

        $('#managementTableData').on('click', '.icon-trash-add', function(){
            if(mngShow==0)
                $("#manageTr").show();
            $(this).closest ('tr').remove ();
        });
        function validateManagementFeesSave(par){
            var manageMin = par.children("td:nth-child(1)");
            var manageMax = par.children("td:nth-child(2)");
            var manageCircleType = par.children("td:nth-child(3)");
            var manageRateType = par.children("td:nth-child(4)");
            var manageValue = par.children("td:nth-child(5)");
            manageMin.find("#temp_manageMin").keyup(function(){
//                $("#manageMinMsgSave").hide();
//                $("#temp_manageMin").removeClass('hasError');
                if(!is_int((manageMin.find("#temp_manageMin").val()))){
//                    alert("enter Num");
                    manageMin.find("#temp_manageMin").addClass('hasError');
                }
                if(is_int((manageMin.find("#temp_manageMin").val()))){
//                    alert("enter Num");
                    manageMin.find("#temp_manageMin").removeClass('hasError');
                }
            });

            manageMax.find("#temp_manageMax").keyup(function(){
                if(!is_int((manageMax.find("#temp_manageMax").val()))){
//                    alert("enter Num");
                    manageMax.find("#temp_manageMax").addClass('hasError');
                }
                if(is_int((manageMax.find("#temp_manageMax").val()))){
//                    alert("enter Num");
                    manageMax.find("#temp_manageMax").removeClass('hasError');
                }
            });
            manageValue.find("#temp_manageValue").keyup(function(){
                if(!is_int((manageValue.find("#temp_manageValue").val()))){
//                    alert("enter Num");
                    manageValue.find("#temp_manageValue").addClass('hasError');
                }
                if(is_int((manageValue.find("#temp_manageValue").val()))){
//                    alert("enter Num");
                    manageValue.find("#temp_manageValue").removeClass('hasError');
                }
            });
            manageRateType.find("#temp_manageRateType").mousedown(function(){
//                $("#manageRateTypeMsgSave").hide();
                manageRateType.find("#temp_manageRateType").removeClass('hasError');
            });
            manageCircleType.find("#temp_manageCircleType").mousedown(function(){
//                $("#manageCircleTypeMsgSave").hide();
                manageCircleType.find("#temp_manageCircleType").removeClass('hasError');
            });

        }
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

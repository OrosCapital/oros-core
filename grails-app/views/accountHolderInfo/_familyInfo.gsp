<%@ page import="com.gsl.oros.core.banking.settings.Country" %>
<html>
<head>
    <style>
    .form-control, label, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"]{font-size: 12px;}
    label{max-width: 150px;}
    </style>
    <title></title>
</head>
<body>
<div class="col-xs-12 ">
    <div class="alert alert-success hidden" id="messageDiv">
        <i class="icon-bell green">
            <b id="message"></b>
        </i>
    </div>
</div>
<g:form name="AccountHolderSpouseInfoForm" id="AccountHolderSpouseInfoForm" method="post" role="form" class="form-horizontal" url="[action: 'saveSpouseInfo', controller: 'accountHolderInfo']">

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12">
<div class="col-xs-6 col-sm-6 col-md-6">
    <g:hiddenField name="id" id="accHolderId" value="${accountHolder?.id}"/>
    <g:hiddenField name="spouseId" id="spouseId"/>
    <g:hiddenField type="text" name="selectRow" hidden="" value="" id="selectRow"/>

    <div class="form-group">
        <label for="name" class="col-sm-4 col-xs-6 control-label no-padding-right">
            <g:message code="coreBanking.clients.accountHolder.familyInfo.name" default="Name"/><span class="red">*</span>
        </label>
        <div class="col-sm-8 col-xs-12">
            <div class="clearfix">
                <input type="text" class="col-sm-11 col-xs-12" placeholder="Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Name'" id="name"
                       name="name" value="${spouseInfo?.name}"/>
            </div>
        </div>
    </div>



    <div class="form-group ">
        <label for="email" class="col-sm-4 col-xs-6 control-label no-padding-right">
            <g:message code="coreBanking.accounting.vendor.basicInfo.email" default="Email"/>
        </label>
        <div class="col-sm-8 col-xs-12">
            <div class="clearfix">
                <input type="email" class="col-sm-11 col-xs-12" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'" id="email"
                       name="email" value="${spouseInfo?.email}"/>
            </div>
        </div>
    </div>



    <div class="form-group ">
        <label for="birthCountryOfSpouse" class="col-sm-4 col-xs-6 control-label no-padding-right">
            <g:message code="coreBanking.clients.accountHolder.basicInfo.birthCountry" default="Country of Birth"/><span class="red">*</span>
        </label>
        <div class="col-sm-8 col-xs-12">
            <div class="clearfix">
                <g:select id="birthCountryOfSpouse" name='birthCountry' class="col-sm-11 col-xs-12"
                          noSelection="${['': 'Select Country...']}"
                          from='${Country.findAllByStatus(true)}' value="${spouseInfo?.birthCountry?.id}"
                          optionKey="id" optionValue="name">
                </g:select>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label for="nationalId" class="col-sm-4 col-xs-6 control-label no-padding-right">
            <g:message code="coreBanking.clients.accountHolder.basicInfo.nationalID" default="National ID"/>
        </label>
        <div class="col-sm-8 col-xs-12">
            <div class="clearfix">
                <input type="text" class="col-sm-11 col-xs-12" placeholder="National Identification No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'National Identification No'" id="nationalId"
                       name="nationalId" value="${spouseInfo?.nationalId}">
            </div>
        </div>
    </div>

</div>

<div class="col-xs-6 col-sm-6 col-md-6">

    <div class="form-group ">
        <label for="spouseGender"
               class="col-sm-4 col-xs-6 control-label no-padding-right">
            <g:message code="coreBanking.accounting.vendor.basicInfo.gender" default="Gender"/>
        </label>
        <div class="col-sm-8 col-xs-12">
            <div class="clearfix">
                <select id="spouseGender" class="col-sm-11 col-xs-12" name="gender">
                    <g:if test="${spouseInfo?.gender != null}">
                        <g:if test="${spouseInfo?.gender == "Male"}">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </g:if>
                        <g:else>
                            <option value="Female">Female</option>
                            <option value="Male">Male</option>
                        </g:else>
                    </g:if>
                    <g:else>
                        <option value="">-Select-</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                    </g:else>
                </select>
            </div>
        </div>
    </div>

    <div class="form-group ">
        <label for="spousePhoneNo" class="col-sm-4 col-xs-6 control-label no-padding-right">
            <g:message code="default.address.phone.label" default="Phone No"/>
        </label>
        <div class="col-sm-8 col-xs-12">
            <div class="clearfix">
                <input type="tel" class="col-sm-11 col-xs-12" placeholder="Phone No" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Phone No'" id="spousePhoneNo"
                       name="phoneNo" value="${spouseInfo?.phoneNo}"/>
            </div>
        </div>
    </div>

    <div class="form-group ">
        <label for="nationality" class="col-sm-4 col-xs-6 control-label no-padding-right">
            <g:message code="coreBanking.clients.accountHolder.basicInfo.firstNationality" default="First Nationality"/><span class="red">*</span>
        </label>
        <div class="col-sm-8 col-xs-12">
            <div class="clearfix">
                <g:select id="nationality" name='nationality' class="col-sm-11 col-xs-12"
                          noSelection="${['': 'Select Country...']}"
                          from='${Country.findAllByStatus(true)}' value="${spouseInfo?.nationality?.id}"
                          optionKey="id" optionValue="name">
                </g:select>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label for="relation" class="col-sm-4 col-xs-6 control-label no-padding-right">
            <g:message code="coreBanking.clients.accountHolder.familyInfo.relation" default="Relation"/><span class="red">*</span>
        </label>
        <div class="col-sm-8 col-xs-12">
            <div class="clearfix">
                <input type="text" class="col-sm-11 col-xs-12" placeholder="Relation with Account Holder" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Relation with Account Holder'" id="relation"
                       name="relation" value="${spouseInfo?.relation}">
            </div>
        </div>
    </div>

    <div class="form-group">
        <label for="addFamilyMember" class="col-sm-4 col-xs-6 control-label no-padding-right"></label>
        <div class="col-sm-8 col-xs-12">
            <div class="clearfix">
                <g:if test="${accountHolder?.spouse}">
                    <button class="btn btn-primary btn-sm" type="submit" name="addFamilyMember" id="addAnotherMember">Add another Member</button>
                </g:if>
                <g:else>
                    <button class="btn btn-primary btn-sm" type="submit" name="addFamilyMember" id="addFamilyMember">Add Family Member</button>
                </g:else>

            </div>
        </div>
    </div>

</div>
</div><!-- /.col -->
</div><!-- /.row -->
</g:form>

<div class= "row" id="familyInfoList">
    %{--<g:if test="${accountHolder?.spouse}">--}%
        <div class="clearfix">
            <div class="col-xs-12">
                <div class="table-header">
                    Family List
                </div>
                <div class="table-responsive">
                    <table id="family-info-list" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            %{--<th class="center">Serial</th>--}%
                            <th class="center">Name</th>
                            <th class="center">Birth Country</th>
                            <th class="center">Nationality</th>
                            <th class="center">Relation</th>
                            <th class="center">Action</th>
                        </tr>
                        </thead>

                        <tbody>
                        <g:each status="i" in="${accountHolder?.spouse}" var="spouseInfo">
                            <tr>
                                %{--<td>${i+1}</td>--}%
                                <td id="memName">${spouseInfo?.name}</td>
                                <td id="memBdCountry">${spouseInfo?.birthCountry?.name}</td>

                                <td id="memNationality">${spouseInfo?.nationality?.name}</td>

                                <td id="memRelation">${spouseInfo?.relation}</td>



                                <td class="actions ">
                                    <div class="btn-group">

                                        <sec:access controller="accountHolderInfo" action="editSpouseInfo">
                                            <a class="btn btn-sm familyInfo-edit-link"
                                               href="#" memberId="${spouseInfo?.id}" accholderId="${accountHolder?.id}"
                                               title="Edit"><i class="glyphicon glyphicon-pencil orange"></i></a>
                                        </sec:access>
                                        <sec:access controller="accountHolderInfo" action="deleteSpouseInfo">
                                            <a class="btn btn-sm delete btn-danger familyInfo-delete-link" onclick="return confirm('Are you sure to delete?')"
                                               href="#" memberId="${spouseInfo?.id}" accholderId="${accountHolder?.id}"
                                               title="Delete"><i class="glyphicon glyphicon-remove "></i></a>
                                        </sec:access>
                                    </div>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    %{--</g:if>--}%
</div>

%{--</div>--}%

<script type="text/javascript">
    $(".chosen-select").chosen();

    jQuery(function ($) {
        var familyInfoTable = $('#family-info-list').DataTable({
            "sDom": " ", //<'row'<'col-md-4'><'col-md-4'><'col-md-4'f>r>t<'row'<'col-md-4'l><'col-md-4'i><'col-md-4'p>> ,
            "bAutoWidth": true,
            "aoColumns": [
                null,
                { "bSortable": false },
                { "bSortable": false },
                null,
                { "bSortable": false }
            ]
        });

        $('#AccountHolderSpouseInfoForm').validate({

            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                name: {
                    required: true
                },
                birthCountry: {
                    required: true
                },
                nationality: {
                    required: true
                },
                relation: {
                    required: true
                }

            } ,
            messages: {
                name: {
                    required: " "
                },
                birthCountry: {
                    required: " "
                },
                nationality: {
                    required: " "
                },
                relation: {
                    required: " "
                }
            },
            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },
            errorPlacement: function (error, element) {
                if(element.is(':checkbox') || element.is(':radio')) {
                    var controls = element.closest('div[class*="col-"]');
                    if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                }
                else if(element.is('.select2')) {
                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
                }
                else if(element.is('.chosen-select')) {
                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
                }
                else error.insertAfter(element.parent());
            },
            submitHandler: function (form) {
                $.ajax({
                    url:"${createLink(controller: 'accountHolderInfo', action: 'saveSpouseInfo')}",
                    type:'post',
                    dataType: 'json',
                    data: $("#AccountHolderSpouseInfoForm").serialize(),
                    success:function(data){
                        if(data.isError == false){
                            if (data.update == true) {
                                var oTable = $('#family-info-list').dataTable();
                                oTable.fnUpdate([data.spouseInfo.name], data.selectedRow, 0);
                                oTable.fnUpdate([data.bdCountry], data.selectedRow, 1);
                                oTable.fnUpdate([data.nationality], data.selectedRow, 2);
                                oTable.fnUpdate([ data.spouseInfo.relation], data.selectedRow, 3);
                                oTable.fnUpdate([ "<sec:access controller="accountHolderInfo" action="editSpouseInfo"><a class='btn btn-sm familyInfo-edit-link'  href='' accholderId=" + data.accountHolder.id + " memberId=" + data.spouseInfo.id + " title='Edit'><i class='glyphicon glyphicon-pencil orange'></i></a></sec:access>" + "  " +
                                        "<sec:access controller="accountHolderInfo" action="deleteSpouseInfo"><a class='btn btn-sm delete btn-danger familyInfo-delete-link' href='' accholderId=" + data.accountHolder.id + " memberId=" + data.spouseInfo.id + " title='Delete'><i class='glyphicon glyphicon-remove'></i></a></sec:access>"], data.selectedRow, 4); // Row

                                $("#messageDiv").removeClass('hidden');
                                $("#message").text(data.message);
                                var accholderid=data.accountHolder.id;
                                clearForm('#AccountHolderSpouseInfoForm');
                                $('#accHolderId').val(accholderid);
                                $('#addAnotherMember').html('Add another Member');
                                return
                            }
                            familyInfoTable.row.add([
                                data.spouseInfo.name,
                                data.bdCountry,
                                data.nationality,
                                data.spouseInfo.relation,
                                "<sec:access controller="accountHolderInfo" action="editSpouseInfo"><a class='btn btn-sm familyInfo-edit-link'  href='' accholderId=" + data.accountHolder.id + " memberId=" + data.spouseInfo.id + " title='Edit'><i class='glyphicon glyphicon-pencil orange'></i></a></sec:access>" + "  " +
                                        "<sec:access controller="accountHolderInfo" action="deleteSpouseInfo"><a class='btn btn-sm delete btn-danger familyInfo-delete-link' href='' accholderId=" + data.accountHolder.id + " memberId=" + data.spouseInfo.id + " title='Delete'><i class='glyphicon glyphicon-remove'></i></a></sec:access>"
                            ]).draw();

                        $("#messageDiv").removeClass('hidden');
                        $("#message").text(data.message);
                        $("#name").val(' ');
                        var accholderid=data.accountHolder.id;
                        clearForm('#AccountHolderSpouseInfoForm');
                        $('#accHolderId').val(accholderid);
                        $('#addAnotherMember').html('Add another Member');
                        }else{
                            alert('Error found');
                        }

//                        $('#familyInfoList').html(data);

                    },
                    failure:function(data){
                    }
                })

            }
        });
        $('#family-info-list').on('click', 'a.familyInfo-edit-link', function(e) {
//            alert('I am on edit');
            e.preventDefault();
            var control = this;
            var familyInfo = $('#family-info-list').DataTable();
            var memberId = $(control).attr('memberId');
            var accholderId = $(control).attr('accholderId');
            var tr = $(control).parents('tr');
            var selectRow = familyInfo.row(tr).index();
            jQuery.ajax({
                type: 'POST',
                dataType: 'json',
                url: "${g.createLink(controller: 'accountHolderInfo',action: 'editSpouseInfo')}?id="+accholderId+"&memberId="+memberId + "&selectedRow=" + selectRow,
                success: function (data, textStatus) {
                    $("#messageDiv").addClass('hidden');
                    $('#selectRow').val(selectRow);
                    $('#spouseId').val(data.id);
                    $('#name').val(data.name);
                    $('#email').val(data.email);
                    $('#birthCountryOfSpouse').val(data.birthCountry.id);
                    $('#nationalId').val(data.nationalId);
                    $('#spouseGender').val(data.gender);
                    $('#spousePhoneNo').val(data.phoneNo);
                    $('#nationality').val(data.nationality.id);
                    $('#relation').val(data.relation);
                    $('#addAnotherMember').html('Update');


                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });

        });

        $('#family-info-list').on('click', 'a.familyInfo-delete-link', function(e) {
            e.preventDefault();
            var control = this;
            var memberId = $(control).attr('memberId');
            var accholderId = $(control).attr('accholderId');
            var selectRow = $(control).parents('tr');
            jQuery.ajax({
                type: 'POST',
                dataType: 'JSON',
                url: "${g.createLink(controller: 'accountHolderInfo',action: 'deleteSpouseInfo')}?id="+accholderId+"&memberId="+memberId,
                success: function (data, textStatus) {
                    $("#messageDiv").removeClass('hidden');
                    $("#message").text(data.message);
                    $('#family-info-list').DataTable().row(selectRow).remove().draw();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });

        });
    });

</script>
</body>
</html>
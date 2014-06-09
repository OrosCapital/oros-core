<%@ page
        contentType="text/html;charset=UTF-8"
%>
<html>
<head>
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <style>
        .form-control, label, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"]{font-size: 12px;}
        label{max-width: 150px;}
        ul.source, ul.target {
            width: 200px;
            min-height: 50px;
            margin: 0px 25px 10px 0px;
            padding: 2px;
            border-width: 1px;
            border-style: solid;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            list-style-type: none;
            list-style-position: inside;
        }
        ul.source {
            border-color: #f8e0b1;
        }
        ul.target {
            border-color: #add38d;
        }
        .source li, .target li {
            margin: 5px;
            padding: 5px;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
        }
        .source li {
            background-color: #fcf8e3;
            border: 1px solid #fbeed5;
            color: #c09853;
        }
        .target li {
            background-color: #ebf5e6;
            border: 1px solid #d6e9c6;
            color: #468847;
        }
        .sortable-dragging {
            border-color: #ccc !important;
            background-color: #fafafa !important;
            color: #bbb !important;
        }
        .sortable-placeholder {
            height: 40px;
        }
        .source .sortable-placeholder {
            border: 2px dashed #f8e0b1 !important;
            background-color: #fefcf5 !important;
        }
        .target .sortable-placeholder {
            border: 2px dashed #add38d !important;
            background-color: #f6fbf4 !important;
        }
    </style>
    <title>Maker Checker Hierarchy</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#assignHierarchyForm").submit(function (e) {

                var hierarchy = '';
                $("ul.target").children().each(function() {
                    hierarchy +=$(this).attr('data-userid')+'_';
                });

                alert(hierarchy);
                $.ajax({
                    url:"${createLink(controller: 'hierarchy', action: 'assignRank')}?hierarchy="+hierarchy,
                    type: "POST",
                    dataType: "json",
                    success:function(data){
                        $("#successMessageDiv").removeClass('hidden');
                        $("#successMessage").text(data.message);
                    },
                    failure:function(data){
                    }
                })
            });
        });

    </script>

</head>

<body>
<div class="col-xs-12">
    <div class='alert alert-success hidden' id="successMessageDiv">
        <i class="icon-bell green">
            <b id="successMessage"></b>
        </i>
    </div>
</div>
<g:form name="assignHierarchyForm" id="assignHierarchyForm" method="post" role="form" class="form-horizontal" url="[controller:'hierarchy', action:'assignRank']" onsubmit="return false;">
    %{--<div class="row"></div>--}%
        <div class="col-xs-12">
            <div class="col-xs-6">
                <div class="h4">Admin Panel</div>
                <br/>
                <ul class="source connected">
                    <g:each var="user" in="${userList}">
                        <li data-userid='${user.id}'>${user.username}</li>
                    </g:each>
                </ul>
            </div>
            <div class="col-xs-6">
                <div class="h4">Selected Hierarchy</div>
                <br/>
                <ul class="target connected" name="targetHierarchy" id="targetHierarchy">
                </ul>
            </div>
        </div>

    <div class="row">
    %{--<div class="clearfix form-actions"></div>--}%
        <div class="col-md-offset-10 col-md-2">
            <button class="btn btn-primary btn-sm" type="submit" name="submitHierarchy" id="submitHierarchy">Submit</button>
        </div>

    </div>
</g:form>
<script type="text/javascript">
    jQuery(function ($) {
        $(".source, .target").sortable({
            connectWith: ".connected"
        });
//        var list = $('#targetHierarchy li');
//        alert(list.length);
        $('#assignHierarchyForm').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                targetHierarchy: {
                    required: "$('#targetHierarchy li').length>0"
                }
            } ,
            messages: {
                targetHierarchy: {
                    required: " "
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-danger', $('#assignHierarchyForm')).show();
            },
            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            }
        });
    });
</script>
</body>
</html>
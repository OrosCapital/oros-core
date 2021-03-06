<!DOCTYPE html>
<html lang="en">
<head>
    <style>
    div.ui-ios-overlay {
        background: none repeat scroll 0 0 rgb(136, 136, 136);
    }

    #gsl-spinner
    {
        display:none;
        position:fixed;
        top:0;
        left:0;
        background-color: transparent;
        border: 0px solid rgba(0, 0, 0, 0.2);
        box-shadow: 0 0px 0px rgba(0, 0, 0, 0.5);
        /*background:black;*/
        width:100%;
        height:100%;
    }

    #loading-div
    {
        width: 300px;
        height: 200px;
        background-color: transparent;
        /*border: 0px solid rgba(0, 0, 0, 0.2);*/
        /*box-shadow: 0 0px 0px rgba(0, 0, 0, 0.5);*/
        /*background-color: #0c0b0b;*/
        text-align:center;
        position:absolute;
        left: 50%;
        top: 50%;
        margin-left:-150px;
        margin-top: -100px;
    }
    </style>

    <meta charset="utf-8"/>
    <title>Dashboard - OrosCapital</title>

    <meta name="description" content="overview &amp; stats"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- basic styles -->

    <link href="${resource(dir: 'css/uncompressed', file: 'bootstrap.css')}" rel="stylesheet"/>
    <link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'font-awesome.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'select2.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css/jqGrid', file: 'ui.jqgrid.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css/compressed', file: 'jquery-ui-1.10.3.full.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css/compressed', file: 'datepicker.css')}"/>

    <link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'chosen.css')}"/>


    <!--[if IE 7]>
		  <link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'font-awesome-ie7.css')}" />
		<![endif]-->

    <!-- page specific plugin styles -->

    <!-- fonts -->

    <link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'ace-fonts.css')}"/>

    <!-- ace styles -->

    <link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'ace.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'ace-rtl.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'ace-skins.css')}"/>
    %{--<link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'iosOverlay.css')}"/>--}%

    <!--[if lte IE 8]>
		  <link rel="stylesheet" href="${resource(dir: 'css/uncompressed', file: 'ace-ie.css')}" />
		<![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->

    <script src="${resource(dir: 'js/uncompressed', file: 'ace-extra.js')}"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lt IE 9]>
		<script src="${resource(dir: 'js/compressed', file: 'html5shiv.js')}"></script>
		<script src="${resource(dir: 'js/compressed', file: 'respond.min.js')}"></script>

		<![endif]-->

    <g:layoutHead/>
    <r:layoutResources/>

</head>

<body>
<g:render template="/topHeadBar"/>
%{--<g:render template="/orosSpinner"/>--}%
<div class="main-container" id="main-container">
    <script type="text/javascript">
        try {
            ace.settings.check('main-container', 'fixed')
        } catch (e) {
        }
    </script>

    <div class="main-container-inner">
        <a class="menu-toggler" id="menu-toggler" href="#">
            <span class="menu-text"></span>
        </a>

        <g:render template="/leftNavBar"/>

        <div class="main-content">

            <g:render template="/breadcrumbs"/>

            <div class="page-content" id="page-content">

                <g:layoutBody/>

            </div><!-- /.page-content -->
        </div><!-- /.main-content -->

    </div><!-- /.main-container-inner -->

    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="icon-double-angle-up icon-only bigger-110"></i>
    </a>
</div><!-- /.main-container -->

<script src="${resource(dir: 'js/uncompressed', file: 'modalSpinner.js')}"></script>
<!-- basic scripts -->

<!--[if !IE]> -->

<script type="text/javascript">
    window.jQuery || document.write("<script src='${resource(dir: 'js/compressed',file: 'jquery-2.0.3.min.js')}'>" + "<" + "/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${resource(dir: 'js/compressed', file: 'jquery-1.10.2.min.js')}'>"+"<"+"/script>");
</script>
<![endif]-->

%{--<script type="text/javascript">
    if ("ontouchend" in document) document.write("<script src='${resource(dir: 'js/uncompressed',file: 'jquery.mobile.custom.js')}'>" + "<" + "/script>");
</script>--}%


%{--<script src="${resource(dir: 'js/jqGrid', file: 'jquery.jqGrid.min.js')}"></script>--}%
%{--<script src="${resource(dir: 'js/jqGrid/i18n', file: 'grid.locale-en.js')}"></script>--}%

%{--<script src="${resource(dir: 'js/datatable', file: 'jquery.dataTables.min.js')}"></script>--}%
<script src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.js"></script>
<script src="${resource(dir: 'js/datatable', file: 'jquery.dataTables.bootstrap.js')}"></script>

<script src="${resource(dir: 'js/date-time', file: 'bootstrap-datepicker.min.js')}"></script>


<script src="${resource(dir: 'js/uncompressed', file: 'bootstrap.js')}"></script>
<script src="${resource(dir: 'js/compressed', file: 'typeahead-bs2.min.js')}"></script>

<!-- page specific plugin scripts -->

<!-- inline scripts related to this page -->

<!--[if lte IE 8]>
		  <script src="${resource(dir: 'js/uncompressed', file: 'excanvas.js')}"></script>
<![endif]-->


%{--<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>--}%
<script src="${resource(dir: 'js/uncompressed', file: 'jquery-ui-1.10.3.custom.js')}"></script>
<script src="${resource(dir: 'js/uncompressed', file: 'jquery.ui.touch-punch.js')}"></script>

<script src="${resource(dir: 'js/uncompressed', file: 'chosen.jquery.js')}"></script>

<script src="${resource(dir: 'js/uncompressed', file: 'jquery.slimscroll.js')}"></script>
<script src="${resource(dir: 'js/uncompressed', file: 'jquery.easy-pie-chart.js')}"></script>

<script src="${resource(dir: 'js/uncompressed', file: 'jquery.sparkline.js')}"></script>
<script src="${resource(dir: 'js/uncompressed/flot', file: 'jquery.flot.js')}"></script>
<script src="${resource(dir: 'js/uncompressed/flot', file: 'jquery.flot.pie.js')}"></script>

<script src="${resource(dir: 'js/uncompressed/flot', file: 'jquery.flot.resize.js')}"></script>

<!-- ace scripts -->
<script src="${resource(dir: 'js/uncompressed', file: 'fuelux.wizard.min.js')}"></script>
<script src="${resource(dir: 'js/validate', file: 'jquery.validate.min.js')}"></script>
<script src="${resource(dir: 'js/uncompressed', file: 'additional-methods.min.js')}"></script>
<script src="${resource(dir: 'js/uncompressed', file: 'bootbox.min.js')}"></script>
<script src="${resource(dir: 'js/uncompressed', file: 'select2.min.js')}"></script>



<script src="${resource(dir: 'js/uncompressed', file: 'jquery.multiselect.js')}"></script>
<script src="${resource(dir: 'js/uncompressed', file: 'jquery.multiselect.filter.js')}"></script>
%{--<script src="${resource(dir: 'js/uncompressed', file: 'jquery.maskedinput.min.js')}"></script>--}%
<script src="${resource(dir: 'js/uncompressed', file: 'jquery.inputmask.js')}"></script>
<script src="${resource(dir: 'js/uncompressed', file: 'autoNumeric.js')}"></script>
<script src="${resource(dir: 'js/uncompressed', file: 'ace-elements.min.js')}"></script>

%{--<script src="${resource(dir: 'js/uncompressed', file: 'iosOverlay.js')}"></script>--}%
<script src="${resource(dir: 'js/uncompressed', file: 'spin.min.js')}"></script>
<script src="${resource(dir: 'js/uncompressed', file: 'ace.js')}"></script>

%{--<script src="${resource(dir: 'js/uncompressed', file: 'ace-elements.js')}"></script>--}%
%{--<script src="${resource(dir: 'js/uncompressed', file: 'ace.js')}"></script>--}%

<!-- inline scripts related to this page -->


<r:layoutResources/>

<script type="text/javascript">
    $.ajaxSetup({
        timeout:50000,
        statusCode: {
            404: function() {
                bootstrap_alert.error("Ooops.. requested page is not available...");
            },
            401: function() {
                window.location = "${createLink(controller: 'logout')}";
//                bootstrap_alert.error("Ooops.. your session has timeout");
            },
            500: function() {
                bootstrap_alert.error("Ooops.. server has got some problems ...");
            },
            0: function() {
                bootstrap_alert.warning("Ooops.. this is taking much time.. retry"); //alert( "aborted" );
            }/*,
            200:function(){
                bootstrap_alert.success("Done"); //alert( "aborted" );
            }*/
        }
    });
    $(document)
            .ajaxStart(function () {
                showSpinner(true);
            })
            .ajaxStop(function () {
//                $loading.hide();
                showSpinner(false);
            });
    bootstrap_alert = function() {};
    bootstrap_alert.warning = function(message) {
        $('#notify').html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">×</a><span>'+message+'</span></div>')
    };
    bootstrap_alert.error = function(message) {
        $('#notify').html('<div class="alert alert-error"><a class="close" data-dismiss="alert">×</a><span>'+message+'</span></div>')
    };
    bootstrap_alert.success = function(message) {
        $('#notify').html('<div class="alert alert-success"><a class="close" data-dismiss="alert">×</a><span>'+message+'</span></div>')
    };

    $(document).ready(function () {
        $('a.ajax-link').click(function (e) {
            e.preventDefault();
            var control = this;
            var url = $(control).attr('href');
            var updateDiv = $(control).attr('updatediv');
            jQuery.ajax({
                type: 'POST',
                url: url,
                success: function (data, textStatus) {
                    $('#' + updateDiv).html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
//                    $('#'+updateDiv).html(data);
                }
            });

            $('ul.nav').removeClass('active').removeClass('open');
            $('ul.nav').find('*').removeClass('active').removeClass('open');
            $(control).closest('li').addClass('active');

        });
        $("#gsl-spinner").css({ opacity: 0.8 });
    });

/*    function showSpinner(control) {

        var opts = {
            lines: 13, // The number of lines to draw
            length: 20, // The length of each line
            width: 6, // The line thickness
            radius: 10, // The radius of the inner circle
            corners: 1, // Corner roundness (0..1)
            rotate: 0, // The rotation offset
            color: '#FFF', // #rgb or #rrggbb
            speed: 1, // Rounds per second
            trail: 60, // Afterglow percentage
            shadow: false, // Whether to render a shadow
            hwaccel: false, // Whether to use hardware acceleration
            className: 'spinner', // The CSS class to assign to the spinner
            zIndex: 2e9, // The z-index (defaults to 2000000000)
            top: 'auto', // Top position relative to parent in px
            left: 'auto' // Left position relative to parent in px
        };

        var target = document.createElement("div");
        var spinner = new Spinner(opts).spin(target);
        var overlay = '';
        if (control == true) {
            overlay = iosOverlay({
                text: "Loading...",
                spinner: spinner
            });
        } else {
            $("div.ui-ios-overlay").removeClass("ios-overlay-show");
            $("div.ui-ios-overlay").addClass("ios-overlay-hide");
        }
    }*/
    function clearForm(form) {

        $(':input', form).each(function () {
            var type = this.type;
            var tag = this.tagName.toLowerCase(); // normalize case

            // password inputs, and textareas
            if (type == 'text' || type == 'password' || type == 'hidden' || tag == 'textarea' || type == 'email' || type == 'tel') {
                this.value = "";
            }

            // checkboxes and radios need to have their checked state cleared
            else if (type == 'checkbox' || type == 'radio')
                this.checked = false;

            // select elements need to have their 'selectedIndex' property set to -1
            else if (tag == 'select') {
                this.value = '';
            }
        });
    }

   function showSpinner(control){
        if(control){
            $('#gsl-spinner').modal('show');
        }else{
            $('#gsl-spinner').modal('hide');
        }
        return false;
    }
</script>

<div id="gsl-spinner">
    <div id="loading-div" class="ui-corner-all">
        <img style="height:75px;margin:35px;" src="${resource(dir: 'images',file: 'oros_spinner_lg.gif')}" alt="Loading.."/>

        %{--<h2 style="color:gray;font-weight:normal;">Please wait....</h2>--}%
    </div>
</div>
</body>
</html>
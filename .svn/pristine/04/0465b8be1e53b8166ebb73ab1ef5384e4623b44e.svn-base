<html>
<head>

</head>
<body>
<div class="row">
    <div class="col-md-12">
        <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-1">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>

                <div class="collapse navbar-collapse" id="navbar-collapse-1">
                    <ul id="myTab4" class="nav navbar-nav padding-12 tab-color-blue background-blue responsive">
                        <li class="" id="loanApplicationTab"><a href="#loanApplication" data-toggle="tab">
                            <g:message code="loan.loanMain.tab.loanApplication" default="Loan Application"/>
                        </a></li>
                        <li class="" id="attachmentTab"><a href="#attachment" data-toggle="tab" >
                            <g:message code="loan.loanMain.tab.attachments" default="Attachments"/>
                        </a></li>

                    </ul>
                </div>
            </div>
        </nav>


        <div class="tab-content responsive">
            <div class="tab-pane" id="loanApplication">
                <g:render template='/loan/loanApplication'/>
            </div>
            <div class="tab-pane" id="attachment">
                <g:render template='/loan/attachment'/>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    var tabSelector='${tabSelectIndicator}';
    var updateSelector='${updateSelector}';
    $(document).ready(function () {

        if(tabSelector == 1){
            $('#loanApplicationTab').addClass("active");
            $('#loanApplication').addClass("active");
            $('#loanApplicationTab').show();

            $('#attachmentTab').removeClass("active");



            if(updateSelector == 0){
                $('#attachmentTab').addClass("disabled");


                $("#attachmentTab").click(function(){
                    return false;
                });


            }
        }
        else if(tabSelector == 2){
            $('#attachmentTab').addClass("active");
            $('#attachment').addClass("active");
            $('#attachmentTab').show();

            $('#loanApplicationTab').removeClass("active");


        }
    });
 </script>
</body>
</html>
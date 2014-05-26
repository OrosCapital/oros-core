<head></head>
<body>
<h3>Short Term Loan</h3><hr>
<p>
    A short term loan refers to a loan that is scheduled to be repaid within a short time of period, usually less than a year. In some instances its maturity could normally go up to five years depending on the different rates.
</p>
<sec:access controller="loan" action="create">
    <div class="clearfix">
        <div class="col-md-offset-9 col-md-3">
            <span class="navbar-right">
                <a href="${g.createLink(controller: 'loan', action: 'create')}"
                   id="createLoan" class="btn btn-success btn-sm">Next
                </a>
            </span>
        </div>
    </div>
</sec:access>
</body>
<script type="text/javascript">
    jQuery(function ($) {
        $('#createLoan').click(function (e) {
            var control = this;
            var url = $(control).attr('href');
            jQuery.ajax({
                type: 'POST',
                url: url,
                success: function (data) {
                    $('#page-content').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
            e.preventDefault();
        });
    });
</script>
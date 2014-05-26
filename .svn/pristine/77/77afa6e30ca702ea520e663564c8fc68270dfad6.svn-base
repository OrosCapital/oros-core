<head></head>
<body>
<h3>Personal Loan<hr></h3>
<p>
    A personal loan is an unsecured loan, meaning the borrower does not put up any collateral or security to guarantee the repayment of the loan. For this reason, personal loans tend to carry high interest rates. If a borrower owns a home, a lower interest rate alternative is a home equity loan. However, this option requires that the borrower put up his or her home or other real estate property as collateral.
    A loan, whether a personal loan or another type of loan, is typically used to finance a large, one-time purchase or expense. The borrower is given all the money at once and agrees to pay back a certain amount per month until the debt is repaid. The monthly payment includes both principal (the amount you borrowed) and interest.
    Personal loans tend to carry higher interest rates than loans secured by collateral such as a home. The relatively high interest rate compensates for the fact that you aren’t guaranteeing repayment of the personal loan with some kind of asset.
    A personal loan may be the only option for people who have established little credit, or for those who don’t own a house, real estate, or other assets to use as collateral. A personal loan may be a sensible alternative to financing a major expense with credit cards, which may charge even higher interest.
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
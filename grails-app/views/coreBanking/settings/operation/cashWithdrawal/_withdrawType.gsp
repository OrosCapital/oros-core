<hr>

<div class="form-group">
    <label class="control-label col-sm-offset-1"><g:message
            code="coreBanking.operation.cashWithdrawal.fullWithdrawal.label"
            default="Is this a full withdrawal ?"/></label>

    %{--Yes->Account Holder want to withdraw his full Amount--}%

    <div class="radio col-sm-offset-1">
        <label>
            <input name="withdrawalType" type="radio" class="ace" value="Yes"
                   id='withdrawalAndCloseAcc'/>
            <span class="lbl"><g:message
                    code="coreBanking.operation.cashWithdrawal.yes.label"
                    default="Yes"/></span>
        </label>
    </div>

    %{--Ask account holder to close his account or not--}%
    <div class="col-xs-10 col-sm-offset-3 hidden" id="fullWithdrawCloseAcc">
        <label id="closeAccount" class="red"><g:message
                code="coreBanking.operation.cashWithdrawal.askForCloseAccount.label"
                default="Would You Like To Close This Account ?"/></label>

        %{--Yes->Wants to close his account--}%
        <div class="radio">
            <label>
                <input name="accountClose" type="radio" class="ace" value="Yes" />
                <span class="lbl"><g:message
                        code="coreBanking.operation.cashWithdrawal.yes.label"
                        default="Yes"/></span>
            </label>
        </div>
        %{--End Yes--}%

        %{--No->Do not Wants to close his account but withdraw full amount--}%
        <div class="radio">
            <label>
                <input name="accountClose" type="radio" class="ace" value="No" />
                <span class="lbl"><g:message
                        code="coreBanking.operation.cashWithdrawal.no.label"
                        default="No"/></span>
            </label>
        </div>
        %{--End No->--}%
    </div>
    %{--End Ask --}%

    %{--No ->Account Holder withdraw some money--}%
    <div class="radio col-sm-offset-1">
        <label>
            <input name="withdrawalType" type="radio" class="ace" id="withdrawOnly" value="No"/>
            <span class="lbl"><g:message
                    code="coreBanking.operation.cashWithdrawal.no.label"
                    default="No"/></span>
        </label>
    </div>

    <div class="col-xs-10 col-sm-offset-3 hidden " id="withdrawAmount">
        <label for="amount"
               class="control-label col-xs-12 col-sm-5 col-sm-pull-3 red"><g:message
                code="coreBanking.operation.cashWithdrawal.withdrawAmount.label"
                default=" Amount"/><span class="red">*</span></label>

        <div class="col-md-4 col-sm-4 col-sm-pull-3">
            <div class="clearfix">
                <input type="text" id="amount" name="amount" style="text-align: right" autocomplete="off"
                       placeholder=" Withdrawal Amount">
                <span class="red" id="message"> </span>
            </div>
        </div>
    </div>
    %{--End No->--}%

</div>

<hr>
%{--<div class="table-header">Add Item</div>--}%
<div class="table-responsive">
    <table id="agioTableData" class="display dataTable table table-striped table-bordered table-hover">
        <thead>
        <tr>
            <th><g:message code="coreBanking.saving.product.min" default="Min"/><span class="red">*</span></th>
            <th><g:message code="coreBanking.saving.product.max" default="Max"/><span class="red">*</span></th>
            <th><g:message code="coreBanking.saving.product.circleType" default="Circle Type"/><span class="red">*</span></th>
            <th><g:message code="coreBanking.saving.product.rateType" default="Rate Type"/><span class="red">*</span></th>
            <th><g:message code="coreBanking.saving.product.value" default="Value"/><span class="red">*</span></th>
            <th><g:message code="coreBanking.saving.product.action" default="Action"/></th>
        </tr>
        </thead>
        <tbody>
        <tr class="entryFormAgio odd " id="agioTr">
            <td class="sorting_1 form-group">
                <label for="agioMin">
                    <input type="text" id="agioMin" name="agioMinI"  placeholder="0.00" class="input-small amount">
                </label>
                %{--<div id="agioMinMsg" class="errorMsg"><span>Please Enter Min</span></div>--}%
            </td>
            <td class="form-group">
                <label for="agioMax">
                    <input type="text" id="agioMax" name="agioMaxI" placeholder="0.00" class="input-small amount">
                </label>
                %{--<div id="agioMaxMsg" class="errorMsg"><span>Please Enter Max</span></div>--}%
            </td>
            <td class="form-group">
                <label for="agioCircleType">
                    <select id="agioCircleType" class="form-control" name="agioCircleTypeI">
                        <option value="">- Select -</option>
                        <option value="${circleName.DAILY}">${circleName.DAILY}</option>
                        <option value="${circleName.WEEKLY}">${circleName.WEEKLY}</option>
                        <option value="${circleName.HALFMONTHLY}">${circleName.HALFMONTHLY}</option>
                        <option value="${circleName.MONTHLY}">${circleName.MONTHLY}</option>
                    </select>
                </label>
                %{--<div id="agioCircleTypeMsg" class="errorMsg"><span>Please Select Circle Type</span></div>--}%
            </td>
            <td class="form-group">
                <label for="agioRateType">
                    <select id="agioRateType" class="form-control" name="agioRateTypeI">
                        <option value="">- Select -</option>
                        <option value="${rateType.FLAT}">${rateType.FLAT}</option>
                        <option value="${rateType.RATE}">${rateType.RATE}</option>
                    </select>
                </label>
                %{--<div id="agioRateTypeMsg" class="errorMsg"><span>Please Select Rate Type</span></div>--}%
            </td>

            </td>
            <td class="form-group">
                <label for="agioValue">
                    <input type="text" id="agioValue" name="agioValueI" placeholder="0.00" class="input-small amount">
                </label>
                %{--<div id="agioValMsg" class="errorMsg"><span>Please Enter Value</span></div>--}%
            </td>



            <td class="center">
                <button id="agioAdd" class="btn btn-default navbar-btn" type="button">
                    <g:message code="coreBanking.saving.product.button.add" default="Add"/>
                </button>
            </td>
        </tr>
        <g:if test="${agioFeeTable?.id}">
            <g:each in="${agioFeeTable}" var="item">
                <tr>
                    <td><div id='agio_min'>${item.min}<input type='hidden' name='agioMin' value='${item.min}' /></div></td>
                    <td><div id='agio_max'>${item.max}<input type='hidden' name='agioMax' value='${item.max}' /></div></td>
                    <td><div id='agio_circle_type'>${item.circleId}<input type='hidden' name='agioCircleType' value='${item.circleId}' /></div></td>
                    <td><div id='agio_rate_type'>${item.rateType}<input type='hidden' name='agioRateType' value='${item.rateType}' /></div></td>
                    <td><div id='agio_value'>${item.value}<input type='hidden' name='agioValue' value='${item.value}' /></div></td>
                    <td>
                        <div class='visible-md visible-lg visible-sm visible-xs action-buttons'>
                            <a  href='javascript:void(0);'><i class='icon-pencil bigger-130 green'></i></a>
                            <a class='red' href='javascript:void(0);'><i class='icon-trash icon-trash-add bigger-130'></i></a>
                        </div>
                    </td>
                </tr>
            </g:each>
        </g:if>
        </tbody>
    </table>
</div>


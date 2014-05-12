%{--<div class="table-header">Add Item</div>--}%
<div class="table-responsive">
    <table id="closeTableData" class="display dataTable table table-striped table-bordered table-hover">
        <thead>
        <tr>
            <th><g:message code="coreBanking.saving.product.min" default="Min"/><span class="red">*</span></th>
            <th><g:message code="coreBanking.saving.product.max" default="Max"/><span class="red">*</span></th>
            <th><g:message code="coreBanking.saving.product.rateType" default="Rate Type"/><span class="red">*</span></th>
            <th><g:message code="coreBanking.saving.product.value" default="Value"/><span class="red">*</span></th>
            <th><g:message code="coreBanking.saving.product.action" default="Action"/></th>
        </tr>
        </thead>
        <tbody>
        <tr class="entryFormClose odd" id="closeTr">
            <td class="sorting_1 form-group">
                <label for="closeMin">
                    <input type="text" id="closeMin" name="closeMinI" value="" placeholder="0.00" class="input-small amount">
                </label>
                %{--<div id="closeMinMsg" class="errorMsg"><span>Please Enter Min</span></div>--}%
            </td>
            <td class="form-group">
                <label for="closeMax">
                    <input type="text" id="closeMax" name="closeMaxI" placeholder="0.00" class="input-small amount">
                </label>
                %{--<div id="closeMaxMsg" class="errorMsg"><span>Please Enter Max</span></div>--}%
            </td>

            <td class="form-group">
                <label for="closeRateType">
                    <select id="closeRateType" class="form-control" name="closeRateTypeI">
                        <option value="">- Select -</option>
                        <option value="${rateType.FLAT}">${rateType.FLAT}</option>
                        <option value="${rateType.RATE}">${rateType.RATE}</option>
                    </select>
                </label>
                %{--<div id="closeRateTypeMsg" class="errorMsg"><span>Please Select Rate Type</span></div>--}%
            </td>
            <td class="form-group">
                <label for="closeValue">
                    <input type="text" id="closeValue" name="closeValueI" placeholder="0.00" class="input-small amount">
                </label>
                %{--<div id="closeValMsg" class="errorMsg"><span>Please Enter Value</span></div>--}%
            </td>

            <td class="center">
                <button id="closeAdd" class="btn btn-default navbar-btn" type="button">
                    <g:message code="coreBanking.saving.product.button.add" default="Add"/>
                </button>
            </td>
        </tr>
        <g:if test="${closeFeeTable?.id}">
            <g:each in="${closeFeeTable}" var="item">
                <tr>
                    <td><div id='fixed_min'>${item.min}<input type='hidden' name='closeMin' value='${item.min}' /></div></td>
                    <td><div id='fixed_max'>${item.max}<input type='hidden' name='closeMax' value='${item.max}' /></div></td>
                    <td><div id='fixed_rate_type'>${item.rateType}<input type='hidden' name='closeRateType' value='${item.rateType}' /></div></td>
                    <td><div id='fixed_value'>${item.value}<input type='hidden' name='closeValue' value='${item.value}' /></div></td>
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


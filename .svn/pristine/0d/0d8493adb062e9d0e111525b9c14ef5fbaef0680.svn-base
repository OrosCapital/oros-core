<html>
<head>
    <title></title>
    <script type="text/javascript">

        $("#evidenceAttachForm").submit(function (e) {
            var formData = new FormData(this);

            if (this.checkValidity()) {
                $.ajax({
                    type: "POST",
                    dataType: "html",
                    mimeType: 'multipart/form-data',
                    contentType: false,
                    cache: false,
                    processData: false,
                    url: "${createLink(controller: "dormantAccount",action: "attachment")}",
                    data: formData,
                    success: function (data) {
                        $('#attachmentListDiv').html(data);
                        $('#caption').val(' ');
                        $('#displayBankDoc').addClass('hidden');
                        $('#evidenceAttachForm :input#attachment').val('');
                        $('.alert-success').addClass('hidden');
                        $('#attachmentFormButton').html('Add More');
                    }
                });
            }
            e.preventDefault();
        });

        $('#previousAttach').click(function () {
            var clientId = $('#previousAttach').val();
            $.ajax({
                type: "POST",
                dataType: "html",
                url: "${createLink(controller: "dormantAccount",action: "previousAttach")}?clientId=" + clientId,
                success: function (data) {
                    $('#attachmentListDiv').html(data);
                    $('#caption').val(' ');
                    $('#displayBankDoc').addClass('hidden');
                    $('#PreviousAttachDiv').addClass('hidden');
                    $('#evidenceAttachForm :input#attachment').val('');
                    $('#attachmentFormButton').html('Add');
                }
            });
        });

        var clientId =${clientId};
        $('#clientId').val(clientId);

        function readURL(input) {
            if (input.files && input.files[0]) {

                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#displayBankDoc').removeClass('hidden');
                    $('#preview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        $("#attachment").change(function () {
            readURL(this);
        });


    </script>
</head>

<body>

<div class="form-group col-md-4" id="PreviousAttachDiv">
    <label for="caption" class="col-md-4 control-label"></label>

    <div class="checkbox">
        <label>
            <input name="document" type="checkbox" id="previousAttach" class="ace ace-checkbox-2" value=""/>
            <span class="lbl">
                <g:message code="coreBanking.dormantAccount.reactivate.previousAttach"
                           default="Previous Attachment"/></span>
        </label>
    </div>
</div>


<g:form class="form-horizontal" id="evidenceAttachForm" name="evidenceAttachForm"
        enctype="multipart/form-data"
        method="post" role="form">

    <div class="row">
        <div class="col-md-12">

            <input type="text" class="hidden" name="clientId" id="clientId"/>

            <fieldset>

                <div class="form-group col-md-4">
                    <label for="caption" class="col-md-4 control-label">
                        <g:message code="default.attachment.caption.label" default="Caption"/></label>

                    <div class="col-md-8">
                        <input type="text" required="" class="form-control" name="caption" id="caption"
                               placeholder="Caption">
                    </div>
                </div>

                <div class="form-group col-md-4">
                    <label class="col-md-5 control-label" for="attachment">
                        <g:message code="default.attachment.attachment.label" default="Attachment"/></label>

                    <div class="col-md-7">
                        <input type="file" id="attachment" class="btn btn-sm btn-succes col-sm-12"
                               required=""
                               name="attachment" value=""
                               placeholder="Bank Document">

                    </div>
                </div>

                <div class="form-group col-md-offset-3 col-md-4 hidden" id="displayBankDoc">
                    <img id="preview" src="" alt="Bank Document" width="200px"
                         height="70px"/>
                </div>

                <div class="form-group col-md-offset-8 col-md-8">

                    <button type="submit" name="attachmentFormButton" id="attachmentFormButton"
                            class="btn btn-primary btn-sm">
                        <g:message code="coreBanking.dormantAccount.reactivate.addAttachment" default="Add"/></button>

                </div>
            </fieldset>

        </div>
    </div>
</g:form>

<div class="row" id="attachmentListDiv">
    <g:render template="/coreBanking/settings/operation/dormantAccount/evidenceAttachList"/>
</div>

<script type="text/javascript">

    $('#evidenceAttachForm').validate({
        errorElement: 'div',
        errorClass: 'help-block',
        focusInvalid: false,
        rules: {
            caption: {
                required: true
            },
            attachment: {
                required: true
            }
        },

        messages: {
            caption: {
                required: " "
            },
            attachment: {
                required: " "
            }

        },
        errorPlacement: function (error, element) {
            return true
        },
        invalidHandler: function (event, validator) {
            $('.alert-danger', $('#evidenceAttachForm')).show();
        },

        highlight: function (e) {
            $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
        },

        success: function (e) {
            $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
            $(e).remove();
        }
    });

</script>

</body>
</html>
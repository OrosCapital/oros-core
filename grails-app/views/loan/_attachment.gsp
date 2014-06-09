<html>
<head></head>
<body>
<g:form method="post" name="loanAttachmentForm" id="loanAttachmentForm" class="form-horizontal" role="form" enctype="multipart/form-data" onSubmit="return false;">
    <div class="row">
        <div class="col-md-12">
            <g:hiddenField name="loanId" id="loanId" value="${loan?.id}"/>
            <g:hiddenField name="id" id="id" value="${attachment?.id}"/>

            <fieldset>

                <div class="form-group col-md-4">
                    <label for="caption" class="col-md-4 control-label">
                        <g:message code="default.attachment.caption.label" default="Caption"/></label>

                    <div class="col-md-8">
                        <g:textField value="" name="caption" class="form-control" id="caption"
                                     placeholder="Please enter Caption"/>
                    </div>
                </div>

                <div class="form-group col-md-4">
                    <label class="col-md-5 control-label" for="description">
                        <g:message code="default.attachment.description.label" default="Description"/></label>

                    <div class="col-md-7">
                        <g:textArea value="" class="form-control"
                                    name="description" id="description"
                                    placeholder="Please Enter Description"/>
                    </div>
                </div>

                <div class="form-group col-md-4">
                    <label class="col-md-5 control-label" for="attachment">
                        <g:message code="default.attachment.attachment.label" default="Attachment"/></label>

                    <div class="col-md-7">
                        <input type="file" name="attachment" id="attachment"/>
                    </div>
                </div>


                <div class="form-group col-md-offset-8 col-md-8">
                    <button type="reset" class="btn btn-primary btn-sm " name="buttonEight"><g:message code="default.button.reset.label" default="Reset"/></button>
                    <g:if test="${loan?.attachments}">
                        <button type="submit" name="attachmentFormButton" id="attachmentFormButton" class="btn btn-primary btn-sm">
                            <g:message code="default.add.label" default="Add"/></button>
                    </g:if>

                    <g:else>
                        <button type="submit" name="attachmentFormButton" id="attachmentFormButton" class="btn btn-primary btn-sm">
                            <g:message code="default.add.label" default="Add"/></button>
                    </g:else>

                </div>
            </fieldset>

        </div>
    </div>
</g:form>
<div class="row" id="attachmentListDiv">
    <g:render template="attachmentList"/>
</div>
<script type="text/javascript">


    $(document).ready(function () {
        $('#loanAttachmentForm').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                caption: {
                    required:true
                },
                description: {
                    required:false
                },
                attachment: {
                    required:true
                }
            },

            messages: {
                caption: {
                    required: " "
                },
                description: {
                    required: " "
                },
                attachment: {
                    required: " "
                }

            },
            errorPlacement: function(error, element){
                return true
            },
            invalidHandler: function (event, validator) {
                $('.alert-danger', $('#loanAttachmentForm')).show();
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            }
        }),

                $("#loanAttachmentForm").submit(function (e) {
                    var formData = new FormData(this);
                    $.ajax({
                        url: '${createLink(controller: 'loan', action: 'saveAttachment')}',
                        type: 'post',
                        data: formData,
                        dataType: 'html',
                        mimeType: 'multipart/form-data',
                        contentType: false,
                        cache: false,
                        processData: false,
                        success: function (data) {
                            $('#attachmentListDiv').html(data);
                            clearForm('#loanAttachmentForm');
                            $('#loanAttachmentForm :input#attachment').val('');
                            $('#loanAttachmentForm :input#loanId').val('${loan?.id}');
                            $('#attachmentFormButton').html('Add');
                        }
                    });
                    e.preventDefault();
                });

    });


</script>
</body>
</html>
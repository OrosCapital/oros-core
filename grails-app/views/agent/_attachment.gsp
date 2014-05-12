
<head>
    <%@ page import="com.gsl.oros.core.banking.attachments.Attachments" %>
</head>

<body>


       <g:form method="post" name="agentAttachmentForm" id="agentAttachmentForm" class="form-horizontal" role="form" enctype="multipart/form-data" onSubmit="return false;">
                <div class="row">
                    <div class="col-md-12">

                %{--<g:hiddenField name="id"  id ="id" value="${personalInfo?.id}"/>--}%
                %{--<g:hiddenField name="attachmentId" id="attachmentId" value="${attachment?.id}"/>--}%
                <g:hiddenField name="personalInfoId" id="personalInfoId" value="${personalInfo?.id}"/>
                <g:hiddenField name="id" id="id" value="${attachment?.id}"/>

                <fieldset>

                    <div class="form-group col-md-4">
                        <label for="caption" class="col-md-4 control-label">Caption</label>

                        <div class="col-md-8">
                            <g:textField value="" name="caption" class="form-control" id="caption"
                                         placeholder="Please enter Name"/>
                        </div>
                    </div>

                    <div class="form-group col-md-4">
                        <label class="col-md-5 control-label" for="description">Description</label>

                        <div class="col-md-7">
                            <g:textArea value="" class="form-control"
                                        name="description" id="description"
                                        placeholder="Please Enter Description"/>
                        </div>
                    </div>

                    <div class="form-group col-md-4">
                        <label class="col-md-5 control-label" for="attachment">Attachment</label>

                        <div class="col-md-7">
                            <input type="file" name="attachment" id="attachment"/>
                        </div>
                    </div>


                    <div class="form-group col-md-offset-8 col-md-8">



                            <button type="reset" class="btn btn-primary btn-sm " name="buttonEight">Reset</button>


                            %{--<button class="btn btn-primary btn-sm " type="submit" name="buttonSeven"--}%
                                    %{--id="attachmentSubmit">Submit</button>--}%
                        <g:if test="${personalInfo?.attachments}">
                            <button type="submit" name="attachmentFormButton" id="attachmentFormButton" class="btn btn-primary btn-sm">
                              Add More</button>
                        </g:if>

                        <g:else>
                            <button type="submit" name="attachmentFormButton" id="attachmentFormButton" class="btn btn-primary btn-sm">
                                Add</button>
                        </g:else>

                    </div>
                </fieldset>

        </div>
        </div>
       </g:form>

<div class="row" id="attachmentListDiv">
    <g:render template="attachmentListTable"/>
</div>

<script type="text/javascript">


    $(document).ready(function () {
        $('#agentAttachmentForm').validate({
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
                $('.alert-danger', $('#agentAttachmentForm')).show();
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            }
        }),

        $("#agentAttachmentForm").submit(function (e) {
            var formData = new FormData(this);
            $.ajax({
                url: '${createLink(controller: 'agent', action: 'saveAttachment')}',
                type: 'post',
                data: formData,
                dataType: 'html',
                mimeType: 'multipart/form-data',
                contentType: false,
                cache: false,
                processData: false,
                success: function (data) {
                    $('#attachmentListDiv').html(data);
                    clearForm('#agentAttachmentForm');
                    $('#agentAttachmentForm :input#attachment').val('');
                    $('#agentAttachmentForm :input#personalInfoId').val('${personalInfo?.id}');
                    $('#attachmentFormButton').html('Add More');
                }
            });
            e.preventDefault();
        });

    });


</script>

</body>
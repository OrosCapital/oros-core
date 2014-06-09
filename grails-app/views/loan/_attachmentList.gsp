
<g:if test="${loan?.attachments?.status}">
    <div class= "row">
        <div class="col-sm-12">

            <table class="table table-bordered table-striped table-hover table-condensed" id="attachmentList">
                <thead>
                <tr>
                    <th><g:message code="default.attachment.caption.label" default="Caption"/></th>
                    <th><g:message code="default.attachment.fileName.label" default="File Name"/></th>
                    <th><g:message code="default.attachment.description.label" default="Description"/></th>
                    <th><g:message code="default.attachment.type.label" default="Type"/></th>
                    <th><g:message code="default.attachment.size.label" default="Size"/></th>
                    <th><g:message code="default.action.label" default="Action"/></th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${loan?.attachments}" var="attachment">

                    <tr>
                        <td id="attCaption">${attachment.caption}</td>
                        <td id="attName">${attachment.originalName}</td>

                        <td id="attDescription">${attachment.description}</td>

                        <td id="attType">${attachment.type}</td>
                        <td id="attSize">${attachment.size}</td>


                        <td class="actions ">
                            <div class="btn-group">


                                <sec:access controller="loan" action="downloadAttachment">
                                    <a class="btn btn-sm btn-success attachment-download-link"
                                       href="${g.createLink(controller: 'loan', action: 'downloadAttachment', params: [attachmentId: attachment?.id])}" attachmentId="${attachment?.id}" loanId="${loan?.id}"
                                       title="Download"><i class="glyphicon glyphicon-download"></i></a>
                                </sec:access>

                                <sec:access controller="loan" action="deleteAttachment">
                                    <a class="btn btn-sm delete btn-danger attachment-delete-link"

                                       href="#" attachmentId="${attachment?.id}" loanId="${loan?.id}"

                                       title="Delete"><i class="glyphicon glyphicon-trash"></i></a>
                                </sec:access>
                            </div>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>

        </div>
    </div>
</g:if>

<script type="text/javascript">



    $('a.attachment-delete-link').click(function(e) {
        var ans = confirm("Are you sure you want to delete?");
        if(ans==true){

            var control = this;

            var attachmentId = $(control).attr('attachmentId');
            var loanId = $(control).attr('loanId');

            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'loan',action:'deleteAttachment')}?id="+attachmentId+"&loanId="+loanId,
                success: function (data, textStatus) {
                    $('#attachmentList').html(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
        else{

        }
        e.preventDefault();
    });


</script>
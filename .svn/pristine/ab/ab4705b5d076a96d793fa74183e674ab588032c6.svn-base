<g:if test='${flash.message}'>
    <div class='alert alert-success'>
        <i class="icon-bell green"><b>${flash.message}</b></i>
    </div>
</g:if>

<g:if test="${evidenceAttach}">
    <div class="row">
        <div class="col-sm-12">

            <table class="table table-bordered table-striped table-hover table-condensed" id="evidenceAttachList">
                <thead>
                <tr>
                    <th><g:message code="default.attachment.caption.label" default="Caption"/></th>
                    <th><g:message code="default.attachment.fileName.label" default="File Name"/></th>
                    <th><g:message code="default.attachment.type.label" default="Type"/></th>
                    <th><g:message code="default.attachment.size.label" default="Size"/></th>
                    <th><g:message code="default.attachment.attachment.label" default="Attachment"/></th>
                    <th><g:message code="default.action.label" default="Action"/></th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${evidenceAttach.attachments}" var="attachment" status="i">
                    <tr>
                        <td id="attCaption">${attachment.caption}</td>
                        <td id="attName">${attachment.originalName}</td>

                        <td id="attDescription">${attachment.type}</td>

                        <td id="attType">${attachment.size}</td>
                        <td id="attSize"><ii:imageTag indirect-category="${attachment.fileDir}"
                                                      indirect-imagename="${attachment.link}" width="100px"
                                                      height="50px"/></td>


                        <td class="actions ">
                            <sec:access controller="dormantAccount" action="delete">
                                <a class="btn btn-sm delete btn-danger attachment-delete-link"
                                   href="#" attachmentId="${attachment?.id}" clientId="${evidenceAttach?.id}"
                                   title="Delete"><i class="glyphicon glyphicon-trash"></i></a>
                            </sec:access>
                            <sec:access controller="dormantAccount" action="download">
                                <a class="btn btn-sm btn-success attachment-download-link"
                                   href="${g.createLink(controller: 'dormantAccount', action: 'download', params: [attachmentId: attachment?.id])}"
                                   attachmentId="${attachment?.id}" clientId="${evidenceAttach?.id}"
                                   title="Download"><i class="glyphicon glyphicon-download"></i></a>
                            </sec:access>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>

        </div>
    </div>
</g:if>


<script type="text/javascript">

    $('a.attachment-delete-link').click(function () {
        var confirmDel = confirm("Do You Want To Delete?");
        if (confirmDel == true) {

            var control = this;

            var attachmentId = $(control).attr('attachmentId');
            var clientId = $(control).attr('clientId');

            jQuery.ajax({
                type: 'POST',
                url: "${g.createLink(controller: 'dormantAccount',action:'delete')}?attachmentId=" + attachmentId + "&clientId=" + clientId,
                success: function (data) {
                    $('#evidenceAttachList').html(data);
                    return false

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }

            });

        }
    });





</script>

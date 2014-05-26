package com.gsl.plugin.attachments

class OrosAttachment {
    String name                 //Attachment name supplied by user
    String originalName         // Original file name with extension as it is
    String description          // additional description by user
    String fileDir              // optional fileDir for proper hirarchy
    String link = UUID.randomUUID().toString()                 // link (without extension) to show attachment
    String type                 // file type
    Long size                   // size
    String extension            // extension name
    String caption              // optional caption
    String remarks              // optional remarks
    AttachStatus status = AttachStatus.ACTIVE              // Active, Inactive, deleted
    static transients = ['extension']

    String getExtension() {
        return originalName.split('\\.')[-1]
    }
    static constraints = {

        description(nullable: true)
        fileDir(nullable: true)
        caption(nullable: true)
        remarks(nullable: true)
    }
}

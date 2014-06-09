package com.gsl.oros.core.banking.operation.dormantAccount

import com.gsl.oros.core.banking.operation.Client
import com.gsl.plugin.attachments.OrosAttachment

class DorAccReactivate {
    Client client
    static hasMany = [attachments:OrosAttachment]
    static constraints = {
    }
}

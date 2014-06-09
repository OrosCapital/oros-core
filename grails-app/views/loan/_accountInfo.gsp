<div class="col-md-8 hidden" id="accountHolderInfo">

    <div class="center">
        <span class="profile-picture center">
            <img class="editable img-responsive" alt="Alex's Avatar" id="avatar2"
                 src="${resource(dir: '/images/', file: 'default-photo.png')}" width="150px"
                 height="150px"/>
        </span>
    </div>

    <div class="profile-user-info profile-user-info-striped">
        <div class="profile-info-row">
            <div class="profile-info-name"><g:message code="loan.accountInfo.label.accountName" default="Account Name"/></div>

            <div class="profile-info-value">
                <span class="editable" id="name"></span>
            </div>
        </div>


        <div class="profile-info-row">
            <div class="profile-info-name"><g:message code="loan.accountInfo.label.location" default="Location"/></div>

            <div class="profile-info-value">
                <i class="icon-map-marker light-orange bigger-110"></i>
                <span class="editable" id="country">Bangladesh</span>
                <span class="editable" id="city"></span>
            </div>
        </div>

        <div class="profile-info-row">
            <div class="profile-info-name"><g:message code="loan.accountInfo.label.contactNo" default="Contact Number"/></div>

            <div class="profile-info-value">
                <span class="editable" id="mobileNo"></span>
            </div>
        </div>

        <div class="profile-info-row">
            <div class="profile-info-name"><g:message code="loan.accountInfo.label.email" default="Email"/></div>

            <div class="profile-info-value">
                <span class="editable" id="emailId">abc@gmail.com</span>
            </div>
        </div>

    </div>

</div>




<div class="col-xs-6 hidden" id="accountHolderInfo">

    <div class="center">
        <span class="profile-picture center">
            <img class="editable img-responsive" alt="Alex's Avatar" id="avatar2"
                 src="${resource(dir: '/images/', file: 'default-photo.png')}" width="100px"
                 height="100px"/>
        </span>
    </div>

    <div class="profile-user-info profile-user-info-striped">
        <div class="profile-info-row">
            <div class="profile-info-name">Account Name</div>

            <div class="profile-info-value">
                <span class="editable" id="accountName"></span>
            </div>
        </div>

        <div class="profile-info-row">
            <div class="profile-info-name">Branch Name</div>

            <div class="profile-info-value">
                <span class="editable" id="branchName">Mirpur Branch</span>
            </div>
        </div>

        <div class="profile-info-row">
            <div class="profile-info-name">Location</div>

            <div class="profile-info-value">
                <i class="icon-map-marker light-orange bigger-110"></i>
                <span class="editable" id="country">Bangladesh</span>
                <span class="editable" id="city"></span>
            </div>
        </div>

        <div class="profile-info-row">
            <div class="profile-info-name">Mobile Number</div>

            <div class="profile-info-value">
                <span class="editable" id="mobileNo"></span>
            </div>
        </div>

        <div class="profile-info-row">
            <div class="profile-info-name">Email Id</div>

            <div class="profile-info-value">
                <span class="editable" id="emailId">imran@gmail.com</span>
            </div>
        </div>

    </div>

</div>

    <div class="col-sm-6 hidden"  style="position: absolute ;left:400px;bottom: 30px" id="displaySignature">
        <div class="form-group">
            <ii:imageTag id="preview" indirect-imagename="#" indirect-filedir="ide/sed"
                         alt="Signature" width="250px" height="70px"/>
        </div>
    </div>



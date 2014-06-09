<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <style type="text/css">
    .green {
        color: #69aa46 !important;
    }

    h4.smaller {
        font-size: 17px;
    }

    .lighter {
        font-weight: lighter;
    }

    .profile-user-info {
        margin: 0 12px;
    }

    .profile-user-info-striped {
        border: 1px solid #DCEBF7;
    }

    .profile-info-row {
        position: relative;
    }

    .profile-user-info-striped .profile-info-name {
        color: #336199;
        background-color: #EDF3F4;
        border-top: 1px solid #F7FBFF;
    }

    .profile-info-value {
        padding: 6px 4px 6px 6px;
        margin-left: 120px;
        border-top: 1px dotted #D5E4F1;
    }

    .icon-map-marker {
        *zoom: expression( this.runtimeStyle['zoom'] = '1', this.innerHTML = '&#xf041;');
    }

    .light-orange {
        color: #fcac6f !important;
    }

    .bigger-110 {
        font-size: 110%;
    }

    .well {
        min-height: 20px;
        padding: 19px;
        margin-bottom: 20px;
        background-color: #f5f5f5;
        border: 1px solid #e3e3e3;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05)
    }
    </style>

</head>

<body>
<div class="well">
    <h4 style=" color: #69aa46 !important;font-size: 17px;font-weight: lighter;">Dear "${clientInfo?.name}"</h4>

    <h3>We are really sorry to say that your account is not active now.
    We don't know what's the reason for that.If you kindly inform us about the reason we will be very grate full to
    you.It will be help us to improve our banking services.<br>
        We request you to reactivate your account.</h3>

    <div style="margin: 0 12px;border: 1px solid #DCEBF7;">
        <div style="position: relative;">
            <div style="position: absolute; width: 110px;text-align: right;
            padding: 6px 10px 6px 0;
            left: 0;
            top: 0;
            bottom: 0;
            font-weight: normal;
            color: #667E99;
            background-color: transparent;
            border-top: 1px dotted #D5E4F1;">Account Name</div>

            <div style="padding: 6px 4px 6px 6px;
            margin-left: 120px;
            border-top: 1px dotted #D5E4F1;">
                <span id="accountName">${clientInfo?.name}</span>
            </div>
        </div>

        <div style="position: relative;">
            <div style="position: absolute; width: 110px;text-align: right;
            padding: 6px 10px 6px 0;
            left: 0;
            top: 0;
            bottom: 0;
            font-weight: normal;
            color: #667E99;
            background-color: transparent;
            border-top: 1px dotted #D5E4F1;">Branch Name</div>

            <div style="padding: 6px 4px 6px 6px;
            margin-left: 120px;
            border-top: 1px dotted #D5E4F1;">
                <span class="editable" id="branchName">${clientInfo?.address}</span>
            </div>
        </div>

        <div style="position: relative;">
            <div style="position: absolute; width: 110px;text-align: right;
            padding: 6px 10px 6px 0;
            left: 0;
            top: 0;
            bottom: 0;
            font-weight: normal;
            color: #667E99;
            background-color: transparent;
            border-top: 1px dotted #D5E4F1;">Location</div>

            <div style="padding: 6px 4px 6px 6px;
            margin-left: 120px;
            border-top: 1px dotted #D5E4F1;">
                <i style="*zoom: expression( this.runtimeStyle['zoom'] = '1', this.innerHTML = '&#xf041;color: #fcac6f !important;');font-size: 110%;"></i>
                <span id="country">Bangladesh</span>
                <span id="city">${clientInfo?.address}</span>
            </div>
        </div>

        <div style="position: relative;">
            <div style="position: absolute; width: 110px;text-align: right;
            padding: 6px 10px 6px 0;
            left: 0;
            top: 0;
            bottom: 0;
            font-weight: normal;
            color: #667E99;
            background-color: transparent;
            border-top: 1px dotted #D5E4F1;">Mobile Number</div>

            <div style="padding: 6px 4px 6px 6px;
            margin-left: 120px;
            border-top: 1px dotted #D5E4F1;">
                <span id="mobileNo">${clientInfo?.contactNo}</span>
            </div>
        </div>

        <div style="position: relative;">
            <div style="position: absolute; width: 110px;text-align: right;
            padding: 6px 10px 6px 0;
            left: 0;
            top: 0;
            bottom: 0;
            font-weight: normal;
            color: #667E99;
            background-color: transparent;
            border-top: 1px dotted #D5E4F1;">Email</div>

            <div style="padding: 6px 4px 6px 6px;
            margin-left: 120px;
            border-top: 1px dotted #D5E4F1;">
                <span id="emailId">imran@gmail.com</span>
            </div>
        </div>

    </div>

</div>
</body>
</html>
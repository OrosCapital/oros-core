<style>
/*.modal-content-spinner {
    background-color: transparent;
    border: 0px solid rgba(0, 0, 0, 0.2);
    box-shadow: 0 0px 0px rgba(0, 0, 0, 0.5);
}

.modal{
    overflow-y:auto;
}

.modal-backdrop {
    background: #989898;
}*/

#loading-div-background
{
    display:none;
    position:fixed;
    top:0;
    left:0;
    background:black;
    width:100%;
    height:100%;
}

#loading-div
{
    width: 300px;
    height: 200px;
    background-color: #0c0b0b;
    text-align:center;
    position:absolute;
    left: 50%;
    top: 50%;
    margin-left:-150px;
    margin-top: -100px;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        $("#loading-div-background").css({ opacity: 0.8 });

    });

</script>


<div id="loading-div-background">
    <div id="loading-div" class="ui-corner-all">
        <img style="height:100px;margin:50px;" src="${resource(dir: 'images',file: 'loading.gif')}" alt="Loading.."/>

        <h2 style="color:gray;font-weight:normal;">Please wait....</h2>
    </div>
</div>

%{--<div id="gsl-spinner" class="modal fade" tabindex="-1" role="dialog" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content-spinner">
            --}%%{--<div class="modal-body">--}%%{--
                <span id="spinner_center" style="position: absolute;display: block;top: 250px;;left: 50%;"></span>
                --}%%{--<span class="loading-text">loading</span>--}%%{--
            --}%%{--</div>--}%%{--
        </div>
    </div>
</div>--}%





<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Nahranie príloh</title>

    <style>
    html, body {
        height: 100%;
    }

    #actions {
        margin: 2em 0;
    }

    /* Mimic table appearance */
    div.table {
        display: table;
    }

    div.table .file-row {
        display: table-row;
    }

    div.table .file-row > div {
        display: table-cell;
        vertical-align: top;
        border-top: 1px solid #ddd;
        padding: 8px;
    }

    div.table .file-row div > * {
        margin: 0px;
    }

    div.table .file-row:nth-child(odd) {
        background: #f9f9f9;
    }

    /* Hide the progress bar when finished */
    #previews .file-row.dz-success .progress {
        opacity: 0;
        transition: opacity 0.3s linear;
    }

    /* Hide the delete button initially */
    #previews .file-row .delete {
        display: none;
    }

    /* Hide the start and cancel buttons and show the delete button */
    #previews .file-row.dz-success .start, #previews .file-row.dz-success .cancel {
        display: none;
    }

    #previews .file-row.dz-success .delete {
        display: block;
    }

    #previews {

    }
    </style>
</head>

<body>
<div class="page-header">
    <h3>Nové prílohy</h3>
</div>

<div id="actions" class="row">

    <div class="col-md-2">
        <span class="btn btn-success fileinput-button"><i
                class="glyphicon glyphicon-plus"></i> <span>Pridať súbory</span>
        </span>
    </div>

    <div class="col-md-8">
        <div class="text-center">
            <div id="total-progress" class="progress center-block">
                <div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar" aria-valuenow="0"
                     aria-valuemin="0" aria-valuemax="100"
                     style="width: 0%;">
                    <span class="sr-only">0%</span>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="table table-striped" class="files" id="previews">

    <div id="upload" class="file-row">
        <div>
            <p class="name" data-dz-name></p>
            <strong class="error text-danger" data-dz-errormessage></strong>
        </div>

        <div>
            <p class="size" data-dz-size></p>
        </div>

        <div>
            <i data-dz-remove class="btn btn-warning cancel">
                <i class="glyphicon glyphicon-ban-circle"></i>
                <span>Cancel</span>
            </i>
            <button title="Odstrániť súbor" data-dz-remove
                    onclick="return confirm('Naozaj chcete odstrániť tento súbor?');">
                <i class="fa fa-trash-o fa-lg"></i>
            </button>
        </div>
    </div>

</div>

<script>
    var previewNode = document.querySelector("#upload");
    previewNode.id = "";
    var previewTemplate = previewNode.parentNode.innerHTML;
    previewNode.parentNode.removeChild(previewNode);

    var myDropzone = new Dropzone(document.body, {
        url: "${createLink(controller: 'document', action: 'upload')}",
        createImageThumbnails: false,
        parallelUploads: 1,
        previewTemplate: previewTemplate,
        autoQueue: true,
        previewsContainer: "#previews",
        clickable: ".fileinput-button"
    });

    myDropzone.on("totaluploadprogress", function (progress) {
        $('#total-progress .progress-bar').css('width', progress + '%').attr('aria-valuenow', progress);
    });

    myDropzone.on("addedfile", function (file) {
    });

    myDropzone.on("sending", function (file) {
    });

    myDropzone.on("success", function (file, response) {
        file.serverId = response.id;

        var descriptionField = Dropzone.createElement('<div class="input-group"><input id="desc_' + file.serverId + '" class="form-control" placeholder="Popis..." name="description" type="text"></input>');
        var descriptionButton = Dropzone.createElement('<span class="input-group-btn"><button type="button" class="btn btn-default">Zmeniť</button></span></div>');

        descriptionButton.addEventListener("click", function (e) {
            e.preventDefault();
            e.stopPropagation();

            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'document', action: 'description')}/" + file.serverId,
                data: "description=" + $("#desc_" + file.serverId).val(),
            });
        });

        file.previewElement.appendChild(descriptionField);
        file.previewElement.appendChild(descriptionButton);
    });

    myDropzone.on("removedfile", function (file) {
        if (!file.serverId) {
            return;
        }
        $.post("${createLink(controller: 'document', action: 'delete')}/" + file.serverId);
    });
</script>
</body>
</html>
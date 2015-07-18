<html>
<head>
    <meta name="layout" content="main">
    <title>Prílohy</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/ui-lightness/jquery-ui.css"/>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js" type="text/javascript"></script>
    <style>
    body {
        font-size: 140%;
    }

    div.DTTT {
        margin-bottom: 0.5em;
        float: right;
    }

    div.dataTables_wrapper {
        clear: both;
    }

    .pagination-length-inline {
        float: left;
        padding-top: 5px;
    }

    .pagination-pages-inline {
        float: left;
    }

    div.dataTables_paginate {
        text-align: left;
    }

    .pagination-inline {
        min-height: 100%;
    }
    </style>
</head>

<body>
<div class="row" style="margin-top: 20px;">
    <div class="col-md-12">
        <div class="pull-right">
            <div class="btn-group">
                <a class="btn btn-success" href="${createLink(controller: 'document', action: 'create')}"><i
                        class="fa fa-plus"></i>&nbsp; Nová</a>
            </div>
        </div>
    </div>
</div>
<table class="table table-hover table-striped table-bordered" id="table">
    <thead>
    <tr>
        <th><g:checkBox name="checkAll"></g:checkBox></th>
        <th>#</th>
        <th>Meno</th>
        <th>Popis</th>
        <th>Vytvorený</th>
        <th>Vytvoril</th>
        <th>Veľkosť</th>
        <th>MD5</th>
        <th>Akcie</th>
    </tr>
    </thead>
    <tbody>
    <g:each var="document" in="${documents}">
        <tr>
        <td><g:checkBox name="checkbox_${document.id}"/></td>
        <td><g:link action="download" id="${document.id}">
            ${document.id}
        </g:link></td>
        <td><g:link action="download" id="${document.id}">
            ${document.filename}
        </g:link></td>
        <td>${document.description}</td>
        <td><g:formatDate timeStyle="SHORT" date="${document.creationDate}"/></td>
        <td><g:link controller="user" action="show" id="${document.creator.id}"
                    data-toggle="modal" data-target="#modalWindow">
            ${document.creator.username}
        </g:link></td>
        <td>
            ${Math.round((document.size / (1024 * 1024 / 100))) / 100} MiB
        </td>
        <td>${document.md5}</td>
        <td><p>
        <g:link action="download" id="${document.id}">
            <i class="fa fa-download fa-lg"></i>
        </g:link>
        <g:if test="${hasDeletePermission[document]}">
            <g:link action="delete" id="${document.id}"
                    onclick="return confirm('Naozaj chcete vymazať súbor #${document.id} - ${document.filename} ?');">
                &nbsp;<i class="fa fa-trash-o fa-lg"></i>
            </g:link>
        </g:if>
        <g:else>
            <td>&nbsp;</td>
        </g:else>
        </p></td>
</tr>
    </g:each>
    </tbody>
</table>

<!--div class="btn-toolbar" role="toolbar" style="margin: 0;">
    <g:form name="form" controller="document" action="index" class="form-inline">
    <g:hiddenField name="userId" id="userId" value="${userId}"/>
    <div class="btn-group">
    <g:paginate action="index" total="${documentCount}" params="${[userId: userId]}"/>
    </div>

    <div class="btn-group" style="margin: 20px;">
    <g:select name="max" from="${[10, 20, 50, 100, 1000]}" value="${max}"
              class="form-control paginate-max selectWidth" onchange="this.form.submit();"
              title="Počet záznamov na stranu"/>
    </div>
</g:form>
</div-->
<script>
    $('#checkAll').click(function (event) {
        if (this.checked) {
            $("input[id^='checkbox_']").each(function () {
                this.checked = true;
            });
        } else {
            $("input[id^='checkbox_']").each(function () {
                this.checked = false;
            });
        }
    });
    $(document).ready(function () {
        var table = $('#table').DataTable({
            dom: '<"clear">rti<"row pagination-inline"<"col-md-6"<"pagination-pages-inline"p><"col-md-1 pagination-length-inline"l>>>',
            language: {
                "sEmptyTable": "Nie sú k dispozícii žiadne dáta",
                "sInfo": "Záznamy _START_ až _END_ z celkom _TOTAL_",
                "sInfoEmpty": "Záznamy 0 až 0 z celkom 0 ",
                "sInfoFiltered": "(vyfiltrované spomedzi _MAX_ záznamov)",
                "sInfoPostFix": "",
                "sInfoThousands": ",",
                "sLengthMenu": "Zobraz _MENU_ záznamov",
                "sLoadingRecords": "Načítavam...",
                "sProcessing": "Spracovávam...",
                "sSearch": "Hľadať:",
                "sZeroRecords": "Nenašli sa žiadne vyhovujúce záznamy",
                "oPaginate": {
                    "sFirst": "Prvá",
                    "sLast": "Posledná",
                    "sNext": "Nasledujúca",
                    "sPrevious": "Predchádzajúca"
                },
                "oAria": {
                    "sSortAscending": ": aktivujte na zoradenie stĺpca vzostupne",
                    "sSortDescending": ": aktivujte na zoradenie stĺpca zostupne"
                }
            },
            "processing": false,
            "stateSave": false,
            "pagingType": "full_numbers",
            "serverSide": false,
            "columnDefs": [
                {"orderable": false, "targets": [0, 7]}
            ],
            "order": [[1, "asc"]]
        });

        var tt = new $.fn.dataTable.TableTools(table, {
                    "sSwfPath": "${asset.assetPath(src: 'copy_csv_xls_pdf.swf')}",
                    "aButtons": [
                        "csv",
                        "xls",
                        {
                            "sExtends": "pdf",
                            "sPdfOrientation": "landscape"
                        },
                        {
                            "sExtends": "print",
                            "sButtonText": "Print view"
                        }
                    ]
                }
        );

        $(tt.fnContainer()).insertAfter('div.dataTables_wrapper');
    });
</script>
</body>
</html>

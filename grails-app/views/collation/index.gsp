<html>
<head>
    <meta name="layout" content="main">
    <title>Žiadosti</title>
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
                <a class="btn btn-success" data-toggle="modal"
                   href="${createLink(controller: 'collation', action: 'create')}"><i class="fa fa-plus"></i>&nbsp; Nová
                </a>
                <a class="btn btn-default" data-toggle="modal"
                   href="#"><i
                        class="glyphicon glyphicon-import"></i>&nbsp; Importovať</a>
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
        <th>Vytvorený</th>
        <th>Vytvoril</th>
        <th>Upravený</th>
        <th>Upravil</th>
        <th>Akcie</th>
    </tr>
    </thead>
    <tbody>
    <g:each var="collation" in="${collations}">
        <tr>
            <td><g:checkBox name="checkbox_${collation.id}"/></td>
            <td><g:link action="update" id="${collation.id}">
                ${collation.id}
            </g:link></td>
            <td><g:link action="update" id="${collation.id}">
                ${collation.name}
            </g:link></td>
            <td><g:formatDate timeStyle="SHORT" date="${collation.creationDate}"/></td>
            <td><g:link controller="user" action="show" id="${collation.creator.id}"
                        data-toggle="modal" data-target="#modalWindow">
                ${collation.creator.userProfile.name}
            </g:link></td>
            <td><g:formatDate timeStyle="SHORT" date="${collation.updateDate}"/></td>
            <td><g:link controller="user" action="show" id="${collation.updater.id}"
                        data-toggle="modal" data-target="#modalWindow">
                ${collation.updater.userProfile.name}
            </g:link></td>
            <td><p>
                <g:link action="update" id="${collation.id}">
                    <i class="fa fa-pencil fa-lg"></i>
                </g:link>
                <g:link action="getZip" id="${collation.id}">
                    &nbsp; <i class="fa fa-file-archive-o fa-lg"></i>
                </g:link>
                <g:link action="delete" id="${collation.id}"
                        onclick="return confirm('Naozaj chcete vymazať žiadosť #${collation.id} - ${collation.name} ?');">
                    &nbsp; <i class="fa fa-trash-o fa-lg"></i>
                </g:link>
            </p></td>
        </tr>
    </g:each>
    </tbody>
</table>

<script>
    $('#checkAll').click(function (event) {  //on click
        if (this.checked) { // check select status
            $("input[id^='checkbox_']").each(function () { //loop through each checkbox
                this.checked = true;  //select all checkboxes with class "checkbox1"
            });
        } else {
            $("input[id^='checkbox_']").each(function () { //loop through each checkbox
                this.checked = false; //deselect all checkboxes with class "checkbox1"
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
                "sProcessing": "Spracúvam...",
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

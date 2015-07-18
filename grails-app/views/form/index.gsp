<html>
<head>
    <meta name="layout" content="main">
    <title>Formuláre</title>
   <style>
    body { font-size: 140%; }
    div.DTTT { margin-bottom: 0.5em; float: right; }
    div.dataTables_wrapper { clear: both; }
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
    <div class="row" style="margin-top: 20px;">
        <div class="col-md-12">
            <div class="pull-right">
                <div class="btn-group">
                    <a class="btn btn-success" data-toggle="modal"
                       href="${createLink(controller: 'form', action: 'types')}"
                       data-target="#modalWindow"><i class="fa fa-plus"></i>&nbsp; Nový</a>
<a class="btn btn-default" data-toggle="modal"
   href="#"><i
        class="glyphicon glyphicon-import"></i>&nbsp; Importovať</a>
</div>
</div>
</div>
</div>

<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered table-hover table-striped" id="table" cellspacing="0" width="100%">
            <thead>
            <tr>
                <th title="Filter" id="toogle-filter"><i class="fa fa-filter"></i></th>
                <th><g:checkBox name="checkAll"></g:checkBox></th>
                <th>#</th>
                <th>Názov</th>
                <th>Typ</th>
                <th>Vytvorený</th>
                <th>Vytvoril</th>
                <th>Upravený</th>
                <th>Upravil</th>
                <th>Verzia</th>
                <th>Akcie</th>
                <th>Stav</th>
            </tr>
            <tr class="table-filter">
                <th id="tableFilter_0"></th>
                <th></th>
                <th id="tableFilter_1"></th>
                <th id="tableFilter_2"></th>
                <th id="tableFilter_3"></th>
                <th id="tableFilter_4"></th>
                <th id="tableFilter_5"></th>
                <th id="tableFilter_6"></th>
                <th id="tableFilter_7"></th>
                <th id="tableFilter_8"></th>
                <th id="tableFilter_9"></th>
                <th id="tableFilter_10"></th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!--form class="form-inline" style="margin: 20px 10px;">
    <div class="pull-right">
        <div class="btn-group">
            <a class="btn btn-default" data-toggle="modal"
               href="${createLink(controller: 'form', action: 'export')}"><i
                    class="glyphicon glyphicon-export"></i>&nbsp; Exportovať vybrané</a>
        </div>
    </div>
</form-->

<script>
    $('#checkAll').click(function (event) {  //on click
        if (this.checked) { // check select status
            $("input[name^='checkbox_']").each(function () { //loop through each checkbox
                this.checked = true;  //select all checkboxes with class "checkbox1"
            });
        } else {
            $("input[name^='checkbox_']").each(function () { //loop through each checkbox
                this.checked = false; //deselect all checkboxes with class "checkbox1"
            });
        }
    });

    function format(d) {
        // `d` is the original data object for the row
        return '<table class="table table-condensed" cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
                '<tr>' +
                '<td>' + d.row1_label + '</td>' +
                '<td>' + d.row1_data + '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>' + d.row2_label + '</td>' +
                '<td>' + d.row2_data + '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>' + d.row3_label + '</td>' +
                '<td>' + d.row3_data + '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>' + d.row4_label + '</td>' +
                '<td>' + d.row4_data + '</td>' +
                '</tr>' +
                '</table>';
    }

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
            "orderCellsTop": true,
            "columns": [
                {
                    "className": 'details-control',
                    "orderable": false,
                    "data": null,
                    "defaultContent": ''
                },
                {
                    "data": "id",
                    "render": function (data, type, full, meta) {
                        return '<input type="checkbox" name="checkbox_' + data + '"/>'
                    }
                },
                {
                    "data": "id",
                    "render": function (data, type, full, meta) {
                        return '<a href="${createLink(action: "update")}/' + data + '">' + data + '</a>';
                    }
                },
                {
                    "data": "name",
                    "render": function (data, type, full, meta) {
                        return '<a href="${createLink(action: "update")}/' + full.id + '">' + data + '</a>';
                    }
                },
                {"data": "type"},
                {"data": "creationDate"},
                {
                    "data": "creator",
                    "render": function (data, type, full, meta) {
                        return '<a data-toggle="modal" data-target="#modalWindow" href="${createLink(controller: "user", action: "show")}/' + full.creator_id + '">' + data + '</a>';
                    }
                },
                {"data": "updateDate"},
                {
                    "data": "updater",
                    "render": function (data, type, full, meta) {
                        return '<a data-toggle="modal" data-target="#modalWindow" href="${createLink(controller: "user", action: "show")}/' + full.updater_id + '">' + data + '</a>';
                    }
                },
                {
                    "data": "version",
                    "render": function (data, type, full, meta) {
                        return '<a href="${createLink(action: "versions")}/' + full.id + '">' + data + '</a>';
                    }
                },
                {
                    "data": "id",
                    "render": function (data, type, full, meta) {
                        return '<a href="${createLink(action: "update")}/' + data + '">' + '<i class="fa fa-pencil fa-lg"></i>' + '</a>' +
                                '&nbsp; <a href="${createLink(action: "exportPdf")}/' + data + '.pdf">' + '<i class="fa fa-file-pdf-o fa-lg"></i>' + '</a>' +
                                '&nbsp; <a href="${createLink(action: "exportHtml")}/' + data + '">' + '<i class="fa fa-html5 fa-lg"></i>' + '</a>' +
                                '&nbsp; <a href="${createLink(action: "exportXml")}/' + data + '">' + '<i class="fa fa-download fa-lg"></i>' + '</a>' +
                                '&nbsp; <a onclick="return confirm(\'Naozaj chcete vymazať formulár?\');" href="${createLink(action: "delete")}/' + data + '">' + '<i class="fa fa-trash-o fa-lg"></i>' + '</a>';
                    }
                },
                {
                    "data": "status",
                    "render": function (data, type, full, meta) {
                        var ret = "";
                        if (data == "APPROVED") {
                            ret = "Schválený"
                        } else if (data == "REJECTED") {
                            ret = "Zamietnutý"
                        } else if (data == "PENDING") {
                            ret = "Čaká na schválenie"
                        } else if (data == "NONE") {
                            ret = "Nový";
                        }
                        return ret;
                    }
                }
            ],
            "columnDefs": [
                {"orderable": false, "targets": [0, 1, 9, 10]}
            ],
            "order": [[2, "asc"]],
            "ajax": "${createLink(controller: "form", action: "getFormsJSON", params:[userId: userId])}",
            "rowCallback": function (row, data, index) {
                if (data.status == "APPROVED") {
                    row.className += " success";
                } else if (data.status == "REJECTED") {
                    row.className += " danger";
                } else if (data.status == "PENDING") {
                    row.className += " warning";
                }
            }
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

        yadcf.init(table,
                [
                    /*{
                     column_number: 1,
                     filter_type: "range_number",
                     filter_container_id: "tableFilter_1"
                     },*/
                    {
                        column_number: 3,
                        filter_type: "text",
                        filter_container_id: "tableFilter_2",
                        filter_reset_button_text: false,
                        filter_default_label: "Názov"
                    },
                    {
                        column_number: 4,
                        filter_type: "select",
                        filter_container_id: "tableFilter_3",
                        filter_reset_button_text: false,
                        select_type: "choosen",
                        filter_default_label: "Všetko"
                    },
                    {
                        column_number: 5,
                        filter_type: "range_date",
                        filter_container_id: "tableFilter_4",
                        filter_reset_button_text: false,
                        date_format: "yyyy-mm-dd",
                        filter_default_label: [
                            "Od",
                            "Do"
                        ]
                    },
                    {
                        column_number: 6,
                        filter_type: "select",
                        filter_container_id: "tableFilter_5",
                        filter_reset_button_text: false,
                        select_type: "choosen",
                        filter_default_label: "Všetko"
                    },
                    {
                        column_number: 7,
                        filter_type: "range_date",
                        filter_container_id: "tableFilter_6",
                        filter_reset_button_text: false,
                        date_format: "yyyy-mm-dd",
                        filter_default_label: [
                            "Od",
                            "Do"
                        ]
                    },
                    {
                        column_number: 8,
                        filter_type: "select",
                        filter_container_id: "tableFilter_7",
                        filter_reset_button_text: false,
                        select_type: "choosen",
                        filter_default_label: "Všetko"
                    },
                    {
                        column_number: 11,
                        filter_type: "select",
                        filter_container_id: "tableFilter_10",
                        filter_reset_button_text: false,
                        select_type: "choosen",
                        filter_default_label: "Všetko"
                    },
                ]);
        function yadcfAddBootstrapClass() {
            var filterInput = $('.yadcf-filter, .yadcf-filter-range, .yadcf-filter-date'),
                    filterReset = $('.yadcf-filter-reset-button');

            filterInput.addClass('form-control');
            filterReset.addClass('btn btn-default').html('&#10005;');
        };

        yadcfAddBootstrapClass();

        // Add event listener for opening and closing details
        $('#table tbody').on('click', 'td.details-control', function () {
            var tr = $(this).closest('tr');
            var row = table.row(tr);

            if (row.child.isShown()) {
                // This row is already open - close it
                row.child.hide();
                tr.removeClass('shown');
            }
            else {
                // Open this row
                row.child(format(row.data())).show();
                tr.addClass('shown');
            }
        });

        $(".table-filter").hide();

        $("#toogle-filter").click(function () {
            $(".table-filter").toggle();
            return false;
        });
    });
</script>
</body>
</html>

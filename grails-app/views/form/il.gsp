<%@ page import="classifier.Classifier" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Informačný list predmetu</title>
</head>

<body>
<g:form name="form" controller="form" action="save" class="form-horizontal">
    <div class="page-header">
        <h3>Informačný list predmetu</h3>
        <input class="form-control" type="text" name="name" value="${form?.name}" disabled placeholder=""/>
    </div>
    <g:hiddenField name="formId" id="formId" value="${form?.id}"/>
    <g:hiddenField name="type" id="type" value="${type}"/>
    <!--  -->
    <div class="input-group">
        <div class="input-group-addon">Vysoká škola</div>

        <select class="chosen-select form-control" name="vysoka_skola" id="vysoka_skola">
            <option value="">Vysoka skola</option>
        </select>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Fakulta</div>
        <select class="chosen-select form-control" name="fakulta" id="fakulta">
            <option value="">Fakulta</option>
        </select>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Kód predmetu</div>
        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_kod_predmetu_1}" class="form-control"
                     type="text" name="form_kod_predmetu_1" required=""/>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Názov predmetu</div>
        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_nazov_predmetu_1}" class="form-control"
                     type="text" name="form_nazov_predmetu_1" required=""/>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Druh, rozsah a metóda vzdelávacích činností</h3>
        </div>

        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Vzdelávacia činnosť</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Druh</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_druh_1}"
                                     class="form-control"
                                     type="text" name="form_druh_1"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Rozsah týždenne</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_rozsah_tyzdenne}"
                                     class="form-control" type="text" name="form_rozsah_tyzdenne"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Rozsah za semester</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_rozsah_za_semester}"
                                     class="form-control" type="text" name="form_rozsah_za_semester"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Metóda</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_metoda}"
                                     class="form-control"
                                     type="text" name="form_metoda"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Počet kreditov</div>
        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pocet_kreditov}" class="form-control"
                     type="text" name="form_pocet_kreditov"/>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Odporúčaný semester/trimester štúdia</h3>
        </div>

        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Odporúčaný semester štúdia</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Študijný program</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_studijny_program}"
                                     class="form-control" type="text" name="form_studijny_program"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">semester</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_semester}"
                                     class="form-control"
                                     type="text" name="form_semester"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">trimester</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_trimester}"
                                     class="form-control" type="text" name="form_trimester"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Stupeň štúdia</div>
        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_stupen_studia}" class="form-control"
                     type="text" name="form_stupen_studia"/>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Podmieňujúce predmety</h3>
        </div>

        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Podmieňujúci predmet</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Kód predmetu</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_kod_predmetu_2}"
                                     class="form-control" type="text" name="form_kod_predmetu_2"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Názov predmetu</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_nazov_predmetu_2}"
                                     class="form-control" type="text" name="form_nazov_predmetu_2"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Podmienky na absolvovanie predmetu</div>
        <g:textArea value="${form?.fieldsVersion?.getAt(version)?.fields?.form_podmienky_absolvovania}"
                    class="form-control"
                    name="form_podmienky_absolvovania"/>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Výsledky vzdelávania</div>
        <g:textArea value="${form?.fieldsVersion?.getAt(version)?.fields?.form_vysledky_vzdelavania}"
                    class="form-control"
                    name="form_vysledky_vzdelavania"/>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Stručná osnova predmetu</div>
        <g:textArea value="${form?.fieldsVersion?.getAt(version)?.fields?.form_strucna_osnova_predmetu}"
                    class="form-control"
                    name="form_strucna_osnova_predmetu"/>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Odporúčaná literatúra</div>
        <g:textArea value="${form?.fieldsVersion?.getAt(version)?.fields?.form_odporucana_literatura}"
                    class="form-control"
                    name="form_odporucana_literatura"/>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Jazyk, ktorého znalosť je potrebná na absolvovanie predmetu</div>
        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_jazyk_1}" class="form-control"
                     type="text"
                     name="form_jazyk_1"/>
    </div>

    <div class="input-group">
        <div class="input-group-addon">Poznámky</div>
        <g:textArea value="${form?.fieldsVersion?.getAt(version)?.fields?.form_poznamky}" class="form-control"
                    name="form_poznamky"/>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Hodnotenie predmetov</h3>
        </div>

        <div class="panel-body">
            <div class="input-group">
                <div class="input-group-addon">Celkový počet hodnotených študentov</div>
                <g:textField
                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_celkovy_pocet_hodnotenych_studentov}"
                        class="form-control" type="text" name="form_celkovy_pocet_hodnotenych_studentov"/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">A</div>
                <g:textField
                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_percentualny_podiel_hodnotenia_A}"
                        class="form-control" type="text" name="form_percentualny_podiel_hodnotenia_A"/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">B</div>
                <g:textField
                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_percentualny_podiel_hodnotenia_B}"
                        class="form-control" type="text" name="form_percentualny_podiel_hodnotenia_B"/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">C</div>
                <g:textField
                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_percentualny_podiel_hodnotenia_C}"
                        class="form-control" type="text" name="form_percentualny_podiel_hodnotenia_C"/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">D</div>
                <g:textField
                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_percentualny_podiel_hodnotenia_D}"
                        class="form-control" type="text" name="form_percentualny_podiel_hodnotenia_D"/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">E</div>
                <g:textField
                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_percentualny_podiel_hodnotenia_E}"
                        class="form-control" type="text" name="form_percentualny_podiel_hodnotenia_E"/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">FX</div>
                <g:textField
                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_percentualny_podiel_hodnotenia_FX}"
                        class="form-control" type="text" name="form_percentualny_podiel_hodnotenia_FX"/>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Vyučujúci</h3>
        </div>

        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Vyučujúci</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Meno a priezvisko vyučujúceho</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_meno}"
                                     class="form-control"
                                     type="text" name="form_meno"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Druh vzdelávacej činnosti, ktorú vyučujúci v predmete zabezpečuje (prednášky, cvičenia, ...)</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_druh_2}"
                                     class="form-control"
                                     type="text" name="form_druh_2"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Jazyk, v ktorom vyučujúci poskytuje predmet</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_jazyk_2}"
                                     class="form-control"
                                     type="text" name="form_jazyk_2"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--div class="input-group">
        <div class="input-group-addon">Dátum poslednej zmeny</div>
        <input value="${form?.fieldsVersion?.getAt(version)?.fields?.form_datum_poslednej_zmeny}" class="form-control"
               type="date" name="form_datum_poslednej_zmeny"/>
    </div-->

    <!--div class="input-group">
        <div class="input-group-addon">Schválil</div>
    <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_schvalil}" class="form-control" type="text"
                 name="form_schvalil"/>
    </div-->
    <!--  -->
    <p style="margin: 10px">
        <g:submitButton name="submit" value="Uložiť" class="btn btn-primary"/>
    </p>
</g:form>
<script>$(document).ready(function () {
    $(".chosen-select").chosen({
                create_option: true,
                allow_single_deselect: true,
                // persistent_create_option decides if you can add any term, even if part
                // of the term is also found, or only unique, not overlapping terms
                persistent_create_option: true,
                // with the skip_no_results option you can disable the 'No results match..'
                // message, which is somewhat redundant when option adding is enabled
                skip_no_results: true,
                no_results_text: "Nenájdené",
                placeholder_text_multiple: "Vyberte si",
                placeholder_text_single: "Vyberte si"
            }
    );
    $.ajax({
        type: "GET",
        url: "/Forms/classifierLines/university",
        contentType: "application/json",
        dataType: "json",
        success: function (item) {
            $("#vysoka_skola").empty();
            $.each(item, function () {
                $("#vysoka_skola").append($("<option> </option>").val(this['value']).html(this['label']));
            });
            $("#vysoka_skola").trigger("chosen:updated");
        }
    });

    $("#vysoka_skola").change(function () {
        $.ajax({
            type: "GET",
            url: "/Forms/classifierLines/faculty",
            data: {
                name: 'university_code',
                value: $("#vysoka_skola").val()
            },
            contentType: "application/json",
            dataType: "json",
            success: function (item) {
                $("#fakulta").empty();
                $.each(item, function () {
                    $("#fakulta").append($("<option> </option>").val(this['value']).html(this['label']));
                });
                $("#fakulta").trigger("chosen:updated");
            }
        });
    });
});
</script>
</body>
</html>
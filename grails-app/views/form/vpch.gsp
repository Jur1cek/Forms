<%@ page import="grails.plugin.springsecurity.SpringSecurityUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Vedecko-pedagogická alebo umelecko-pedagogická charakteristika fyzickej osoby</title>
    <style>
    #sidebar {
        top: 50px;
        height: 100%;
        width: 400px;
        background-color: #E5F4FF;
        right: -370px;
        position: fixed;
        z-index: 10;
        overflow: scroll;
    }

    .visible {
        right: 0px !important;
    }
    </style>

</head>

<body>
<g:form name="form" controller="form" action="save" class="form-horizontal">
    <g:if test="${form?.status == form.Form.ApprovalStatus.PENDING}">
        <div class="alert alert-warning"
             role="alert">Formulár čaká na schválenie, zmenou formuláru bude žiadosť zrušená</div>
    </g:if>
    <g:elseif test="${form?.status == form.Form.ApprovalStatus.APPROVED}">
        <div class="alert alert-success"
             role="alert">Formulár bol schválený, pri zmene formuláru je potrebné opätovné schválenie</div>
    </g:elseif>
    <g:elseif test="${form?.status == form.Form.ApprovalStatus.REJECTED}">
        <div class="alert alert-danger" role="alert">Formulár bol zamietnutý</div>
    </g:elseif>
    <div class="page-header">
        <h3>Vedecko-pedagogická alebo umelecko-pedagogická charakteristika fyzickej osoby</h3>
        <input class="form-control" type="text" name="name" value="${form?.name}" disabled placeholder=""/>
    </div>
    <g:hiddenField name="formId" id="formId" value="${form?.id}"/>
    <g:hiddenField name="type" id="type" value="${type}"/>
    <!--  -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">I. Základné údaje</h3>
        </div>

        <div class="panel-body">
            <div class="input-group">
                <div class="input-group-addon">I.1 Priezvisko, meno, tituly</div>
                <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_meno?.value}"
                             class="form-control"
                             type="text"
                             name="form_meno" required=""/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">I.2 Rok narodenia</div>
                <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_rok_narodenia?.value}"
                             class="form-control"
                             type="text" name="form_rok_narodenia" required=""/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">I.3 Názov a adresa pracoviska</div>
                <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pracovisko?.value}"
                             class="form-control"
                             type="text" name="form_pracovisko"/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">I.4 E-mailová adresa</div>
                <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_email?.value}"
                             class="form-control"
                             type="text" name="form_email"/>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">II. Informácie o vysokoškolskom vzdelaní a ďalšom kvalifikačnom raste</h3>
        </div>

        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Vysokoškolské vzdelanie druhého stupňa</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Názov vysokej školy alebo inštitúcie</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_nazov_vysokej_skoly?.value}"
                                class="form-control" type="text" name="form_nazov_vysokej_skoly"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Rok</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_rok?.value}"
                                     class="form-control"
                                     type="text" name="form_rok"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Odbor a program</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_odbor_a_program?.value}"
                                     class="form-control" type="text" name="form_odbor_a_program"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Vysokoškolské vzdelanie tretieho stupňa</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Názov vysokej školy alebo inštitúcie</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_nazov_vysokej_skoly_2?.value}"
                                class="form-control" type="text" name="form_nazov_vysokej_skoly_2"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Rok</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_rok_2?.value}"
                                     class="form-control"
                                     type="text" name="form_rok_2"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Odbor a program</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_odbor_a_program_2?.value}"
                                class="form-control" type="text" name="form_odbor_a_program_2"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Titul docent</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Názov vysokej školy alebo inštitúcie</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_nazov_vysokej_skoly_3?.value}"
                                class="form-control" type="text" name="form_nazov_vysokej_skoly_3"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Rok</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_rok_3?.value}"
                                     class="form-control"
                                     type="text" name="form_rok_3"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Odbor a program</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_odbor_a_program_3?.value}"
                                class="form-control" type="text" name="form_odbor_a_program_3"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Titul profesor</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Názov vysokej školy alebo inštitúcie</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_nazov_vysokej_skoly_4?.value}"
                                class="form-control" type="text" name="form_nazov_vysokej_skoly_4"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Rok</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_rok_4?.value}"
                                     class="form-control"
                                     type="text" name="form_rok_4"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Odbor a program</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_odbor_a_program_4?.value}"
                                class="form-control" type="text" name="form_odbor_a_program_4"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Doktor vied</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Názov vysokej školy alebo inštitúcie</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_nazov_vysokej_skoly_5?.value}"
                                class="form-control" type="text" name="form_nazov_vysokej_skoly_5"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Rok</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_rok_5?.value}"
                                     class="form-control"
                                     type="text" name="form_rok_5"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Odbor a program</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_odbor_a_program_5?.value}"
                                class="form-control" type="text" name="form_odbor_a_program_5"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Ďalšie vzdelávanie</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Názov vysokej školy alebo inštitúcie</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_nazov_vysokej_skoly_6?.value}"
                                class="form-control" type="text" name="form_nazov_vysokej_skoly_6"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Rok</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_rok_6?.value}"
                                     class="form-control"
                                     type="text" name="form_rok_6"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Odbor a program</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_odbor_a_program_6?.value}"
                                class="form-control" type="text" name="form_odbor_a_program_6"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">III. Zabezpečované činnosti</h3>
        </div>

        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">III.1 Prehľad o vedených záverečných prácach, ktoré boli obhájené</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Bakalárske práce - Počet</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pocet_vedenych_dizertacnych_prac?.value}"
                                class="form-control" type="text" name="form_pocet_vedenych_bakalarskych_prac"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Diplomové práce - Počet</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pocet_vedenych_diplomovych_prac?.value}"
                                class="form-control" type="text" name="form_pocet_vedenych_diplomovych_prac"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Dizertačné práce - Počet</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pocet_vedenych_dizertacnych_prac?.value}"
                                class="form-control" type="text" name="form_pocet_vedenych_dizertacnych_prac"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">III.2 Aktuálna pedagogická činnosť</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost_2?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost_2"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost_3?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost_3"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost_4?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost_4"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost_5?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost_5"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">III.3 Predchádzajúca pedagogická činnosť</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost_6?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost_6"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost_7?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost_7"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost_8?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost_8"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost_9?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost_9"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Pedagogická činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_pedagogicka_cinnost_10?.value}"
                                class="form-control" type="text" name="form_pedagogicka_cinnost_10"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">III.4 Aktuálna tvorivá činnosť</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Tvorivá činnosť</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_tvoriva_cinnost?.value}"
                                     class="form-control" type="text" name="form_tvoriva_cinnost"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Tvorivá činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_tvoriva_cinnost_2?.value}"
                                class="form-control" type="text" name="form_tvoriva_cinnost_2"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Tvorivá činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_tvoriva_cinnost_3?.value}"
                                class="form-control" type="text" name="form_tvoriva_cinnost_3"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Tvorivá činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_tvoriva_cinnost_4?.value}"
                                class="form-control" type="text" name="form_tvoriva_cinnost_4"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Tvorivá činnosť</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_tvoriva_cinnost_5?.value}"
                                class="form-control" type="text" name="form_tvoriva_cinnost_5"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">IV. Profil kvality tvorivej činnosti</h3>
        </div>

        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">IV.1 Prehľad výstupov</h3>
                </div>

                <div class="panel-body">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Počet výstupov evidovaných vo Web of Science alebo Scopus</h3>
                        </div>

                        <div class="panel-body">
                            <div class="input-group">
                                <div class="input-group-addon">Celkovo</div>
                                <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_celkovo?.value}"
                                             class="form-control" type="text" name="form_celkovo"/>
                            </div>

                            <div class="input-group">
                                <div class="input-group-addon">Za posledných šesť rokov</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_za_6_rokov?.value}"
                                        class="form-control" type="text" name="form_za_6_rokov"/>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Počet výstupov kategórie A</h3>
                        </div>

                        <div class="panel-body">
                            <div class="input-group">
                                <div class="input-group-addon">Celkovo</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_celkovo_2?.value}"
                                        class="form-control" type="text" name="form_celkovo_2"/>
                            </div>

                            <div class="input-group">
                                <div class="input-group-addon">Za posledných šesť rokov</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_za_6_rokov_2?.value}"
                                        class="form-control" type="text" name="form_za_6_rokov_2"/>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Počet výstupov kategórie B</h3>
                        </div>

                        <div class="panel-body">
                            <div class="input-group">
                                <div class="input-group-addon">Celkovo</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_celkovo_3?.value}"
                                        class="form-control" type="text" name="form_celkovo_3"/>
                            </div>

                            <div class="input-group">
                                <div class="input-group-addon">Za posledných šesť rokov</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_za_6_rokov_3?.value}"
                                        class="form-control" type="text" name="form_za_6_rokov_3"/>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Počet citácií Web of Science alebo Scopus, v umeleckých študijných odboroch počet ohlasov v kategórii A</h3>
                        </div>

                        <div class="panel-body">
                            <div class="input-group">
                                <div class="input-group-addon">Celkovo</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_celkovo_4?.value}"
                                        class="form-control" type="text" name="form_celkovo_4"/>
                            </div>

                            <div class="input-group">
                                <div class="input-group-addon">Za posledných šesť rokov</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_za_6_rokov_4?.value}"
                                        class="form-control" type="text" name="form_za_6_rokov_4"/>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Počet projektov získaných na financovanie výskumu, tvorby</h3>
                        </div>

                        <div class="panel-body">
                            <div class="input-group">
                                <div class="input-group-addon">Celkovo</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_celkovo_5?.value}"
                                        class="form-control" type="text" name="form_celkovo_5"/>
                            </div>

                            <div class="input-group">
                                <div class="input-group-addon">Za posledných šesť rokov</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_za_6_rokov_5?.value}"
                                        class="form-control" type="text" name="form_za_6_rokov_5"/>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Počet pozvaných prednášok na medzinárodnej úrovni</h3>
                        </div>

                        <div class="panel-body">
                            <div class="input-group">
                                <div class="input-group-addon">Celkovo</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_celkovo_6?.value}"
                                        class="form-control" type="text" name="form_celkovo_6"/>
                            </div>

                            <div class="input-group">
                                <div class="input-group-addon">Za posledných šesť rokov</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_za_6_rokov_6?.value}"
                                        class="form-control" type="text" name="form_za_6_rokov_6"/>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Počet pozvaných prednášok na národnej úrovni</h3>
                        </div>

                        <div class="panel-body">
                            <div class="input-group">
                                <div class="input-group-addon">Celkovo</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_celkovo_7?.value}"
                                        class="form-control" type="text" name="form_celkovo_7"/>
                            </div>

                            <div class="input-group">
                                <div class="input-group-addon">Za posledných šesť rokov</div>
                                <g:textField
                                        value="${form?.fieldsVersion?.getAt(version)?.fields?.form_za_6_rokov_7?.value}"
                                        class="form-control" type="text" name="form_za_6_rokov_7"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">IV.2 Najvýznamnejšie publikované vedecké práce, verejne realizované alebo prezentované umelecké diela a výkony. Maximálne päť.</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca?.value}"
                                class="form-control" type="text" name="form_publikovana_praca"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca_2?.value}"
                                class="form-control" type="text" name="form_publikovana_praca_2"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca_3?.value}"
                                class="form-control" type="text" name="form_publikovana_praca_3"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca_4?.value}"
                                class="form-control" type="text" name="form_publikovana_praca_4"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca_5?.value}"
                                class="form-control" type="text" name="form_publikovana_praca_5"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">IV.3 Najvýznamnejšie publikované vedecké práce verejne realizované alebo prezentované umelecké diela alebo výkony za posledných šesť rokov. Maximálne päť výstupov.</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca_6?.value}"
                                class="form-control" type="text" name="form_publikovana_praca_6"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca_7?.value}"
                                class="form-control" type="text" name="form_publikovana_praca_7"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca_8?.value}"
                                class="form-control" type="text" name="form_publikovana_praca_8"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca_9?.value}"
                                class="form-control" type="text" name="form_publikovana_praca_9"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Publikovaná práca</div>
                        <g:textField
                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_publikovana_praca_10?.value}"
                                class="form-control" type="text" name="form_publikovana_praca_10"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">IV.4 Účasť na riešení (vedení) najvýznamnejších vedeckých projektov alebo umeleckých projektov za posledných šesť rokov. Maximálne päť projektov.</h3>
                </div>

                <div class="panel-body">
                    <div class="input-group">
                        <div class="input-group-addon">Projekt</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_projekt?.value}"
                                     class="form-control"
                                     type="text" name="form_projekt"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Projekt</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_projekt_2?.value}"
                                     class="form-control" type="text" name="form_projekt_2"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Projekt</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_projekt_3?.value}"
                                     class="form-control" type="text" name="form_projekt_3"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Projekt</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_projekt_4?.value}"
                                     class="form-control" type="text" name="form_projekt_4"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Projekt</div>
                        <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_projekt_5?.value}"
                                     class="form-control" type="text" name="form_projekt_5"/>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">IV.5 Výstupy v oblasti poznania príslušného študijného odboru s najvýznamnejšími ohlasmi a prehľad ohlasov na tieto výstupy. Maximálne päť výstupov a desať najvýznamnejších ohlasov na jeden výstup.</h3>
                </div>

                <div class="panel-body">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Výstupy a ohlasy</h3>
                        </div>

                        <div class="panel-body">
                            <div class="input-group">
                                <div class="input-group-addon">Výstup</div>
                                <g:textField value="${form?.fieldsVersion?.getAt(version)?.fields?.form_vystup?.value}"
                                             class="form-control" type="text" name="form_vystup"/>
                            </div>

                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">Ohlasy</h3>
                                </div>

                                <div class="panel-body">
                                    <div class="input-group">
                                        <div class="input-group-addon">Ohlas na výstup</div>
                                        <g:textField
                                                value="${form?.fieldsVersion?.getAt(version)?.fields?.form_ohlas_na_vystup?.value}"
                                                class="form-control" type="text" name="form_ohlas_na_vystup"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="input-group">
                <div class="input-group-addon">IV.6 Funkcie a členstvo vo vedeckých, odborných a profesijných spoločnostiach</div>
                <g:textArea value="${form?.fieldsVersion?.getAt(version)?.fields?.form_funkcie_a_clenstvo?.value}"
                            class="form-control" name="form_funkcie_a_clenstvo"/>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">V. Doplňujúce informácie</h3>
        </div>

        <div class="panel-body">
            <div class="input-group">
                <div class="input-group-addon">V.1 Charakteristika aktivít súvisiacich s príslušným študijným programom</div>
                <g:textArea value="${form?.fieldsVersion?.getAt(version)?.fields?.form_charakteristika_aktivit?.value}"
                            class="form-control" name="form_charakteristika_aktivit"/>
            </div>

            <div class="input-group">
                <div class="input-group-addon">V.2 Ďalšie aktivity</div>
                <g:textArea value="${form?.fieldsVersion?.getAt(version)?.fields?.form_dalsie_aktivity?.value}"
                            class="form-control"
                            name="form_dalsie_aktivity"/>
            </div>
        </div>
    </div>
    <!--  -->
    <p style="margin: 10px">
        <g:submitButton name="button_save" value="Uložiť" class="btn btn-primary"/>
        <g:if test="${form?.status == form.Form.ApprovalStatus.NONE}">
            <g:submitButton name="button_startApproval" value="Odoslať na schválenie" class="btn btn-default"/>
        </g:if>
        <g:elseif test="${form?.status == form.Form.ApprovalStatus.PENDING}">
            <g:submitButton name="button_stopApproval" value="Zrušiť žiadosť o schválenie" class="btn btn-default"/>
        </g:elseif>
        <g:if test="${form?.status == form.Form.ApprovalStatus.PENDING && (form?.creator?.parent == currentUser || grails.plugin.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_UNIVERSITY'))}">
            <g:submitButton name="button_approve" value="Schváliť" class="btn btn-success"/>
            <g:submitButton name="button_reject" value="Zamietnuť" class="btn btn-danger"/>
        </g:if>
    </p>
</g:form>
<g:if test="${form}">
    <div id="sidebar">
        <i class="fa fa-angle-double-left fa-3x" id="toogle_sidebar"></i>

        <div class="container">
            <div class="col-md-4 text-center">
                <div class="input-group">
                    <input type="text" id="userComment" class="form-control"
                           placeholder="Sem vložte komentár..."/>
                    <span class="input-group-btn" onclick="addComment()">
                        <a href="#" class="btn btn-primary btn-sm"><span
                                class="glyphicon glyphicon-comment"></span> Pridať komentár</a>
                    </span>
                </div>
                <hr>
                <ul id="comments-wrapper" class="list-unstyled ui-sortable">
                    <g:render template="comments" var="comment" collection="${form?.comments}"/>
                </ul>
            </div>
        </div>
    </div>
</g:if>
<script>
    <g:if test="${form}">

    $('#toogle_sidebar').click(function () {
        $('#sidebar').toggleClass('visible', 300, "easeOutSine");
    });
    function addComment() {
        $.ajax({
            type: "POST",
            data: "comment=" + $('#userComment').val(),
            url: "${createLink(controller: "form", action: "comment", id: form?.id)}",
            success: function (data) {
                $('#comments-wrapper').html(data);
                $('#userComment').val("");
            }
        });
    }

    function updateComments() {
        $.ajax({
            type: "GET",
            url: "${createLink(controller: "form", action: "comment", id: form?.id)}",
            success: function (data) {
                $('#comments-wrapper').html(data);
            }
        });
        setTimeout(updateComments, 5000);
    }

    $(document).ready(function () {
        setTimeout(updateComments, 5000);
    });
    </g:if>
</script>
</body>
</html>
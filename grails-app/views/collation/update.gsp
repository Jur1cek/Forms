<%@ page import="collation.Collation" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Žiadosť</title>
</head>

<body>
<div class="row">
    <div class="col-md-12">
        <g:form name="collation-form" controller="collation" action="save">
            <g:hiddenField name="collationId" id="collationId" value="${collation?.id}"/>

            <div class="page-header">
                <h3>Žiadosť</h3>

                <div class="form-group">
                    <input class="form-control" type="text" name="name" value="${collation?.name}"
                           placeholder="Názov"/>
                </div>
            </div>

            <div class="form-group">
                <label for="forms">Hlavný formulár:</label>
                <g:select data-placeholder="Vyberte formulár..." value="${collation?.mainForm?.id}"
                          class="chosen-select form-control" name="mainForm" from="${mainForms}" optionKey="id"
                          optionValue="${{ '#' + it.id + ' ' + it.name }}"/>
            </div>

            <div class="form-group">
                <label for="forms">Formuláre:</label>
                <g:select data-placeholder="Vyberte formuláre..." value="${collation?.forms}"
                          class="chosen-select form-control"
                          name="forms" from="${forms}" optionKey="id" optionValue="${{ '#' + it.id + ' ' + it.name }}"
                          multiple="true"/>
            </div>

            <div class="form-group">
                <label for="documents">Dokumenty:</label>
                <g:select data-placeholder="Vyberte dokumenty..." value="${collation?.documents}"
                          class="chosen-select form-control" name="documents" from="${documents}" optionKey="id"
                          optionValue="${{ '#' + it.id + ' ' + it.filename }}" multiple="true"/>
            </div>

            <p style="margin: 10px">
                <g:submitButton name="submitButton" value="Uložiť" class="btn btn-primary"/>
            </p>

        </g:form>
    </div>
</div>
<script>
    $(document).ready(function () {
        $(".chosen-select").chosen({
            no_results_text: "Nenájdené",
            placeholder_text_multiple: "Vyberte si",
            placeholder_text_single: "Vyberte si"
        });

        $('#collation-form').formValidation({
            framework: 'bootstrap',
            icon: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    validators: {
                        notEmpty: {
                            message: 'Názov nemôže byť prázdny'
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>
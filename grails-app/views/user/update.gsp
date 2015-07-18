<%@ page import="classifier.Classifier" %>
<html>
<head>
    <g:if test="${!xhr}">
        <meta name="layout" content="main">
    </g:if>
    <title>
        ${user?.userProfile?.name}
    </title>
</head>

<body>
<g:if test="${xhr}">
    <g:if test="${flash.error}">
        <div class="alert alert-danger alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            ${flash.error}
        </div>
    </g:if>
    <g:if test="${flash.success}">
        <div class="alert alert-success alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            ${flash.success}
        </div>
    </g:if>
</g:if>
<div class="page-header">
    <h3>Profil</h3>
</div>
<g:form name="form" controller="user" action="save" class="form-horizontal">
    <g:hiddenField name="parentId" id="parentId" value="${parent?.id}"></g:hiddenField>
    <g:hiddenField name="userId" id="userId" value="${user?.id}"></g:hiddenField>

    <div class="form-group">
        <label for="userId1" class="control-label col-md-2">Používateľské ID:</label>

        <div class="col-md-10">
            <g:field class="form-control" name="userId1" value="${user?.id}" type="text" disabled="true"></g:field>
        </div>
    </div>

    <div class="form-group">
        <label for="parent" class="control-label col-md-2">Nadradený používateľ:</label>

        <div class="col-md-10">
            <g:field class="form-control" name="parent" value="${parent?.userProfile?.name}" type="text"
                     disabled="disabled"></g:field>
        </div>
    </div>

    <div class="form-group">
        <label for="username" class="control-label col-md-2">Prihlasovacie meno:</label>

        <div class="col-md-10">
            <g:field class="form-control" name="username" value="${user?.username}" type="text"
                     disabled="${user ? "disabled:" : "false"}"></g:field>
        </div>
    </div>

    <div class="form-group">
        <label for="name" class="control-label col-md-2">Meno a Priezvisko:</label>

        <div class="col-md-10">
            <g:field class="form-control" name="name" value="${user?.userProfile?.name}" type="text"></g:field>
        </div>
    </div>

    <div class="form-group">
        <label for="university" class="control-label col-md-2">Vysoká škola (organizácia):</label>

        <div class="col-md-10">
            <g:select class="chosen-select form-control" value="${user?.userProfile?.university}"
                      optionKey="value" optionValue="value" name="university"
                      from="${classifier.Classifier.findByClassId(1).items}" multiselect="false"
                      noSelection="[' ': ' ']"/>
        </div>
    </div>

    <div class="form-group">
        <label for="faculty" class="control-label col-md-2">Fakulta:</label>

        <div class="col-md-10">
            <g:select class="chosen-select form-control" value="${user?.userProfile?.faculty}"
                      optionKey="value" optionValue="value" name="faculty"
                      from="${classifier.Classifier.findByClassId(2).items}" multiselect="false"
                      noSelection="[' ': ' ']"/>

        </div>
    </div>

    <div class="form-group">
        <label for="email" class="control-label col-md-2">Email:</label>

        <div class="col-md-10">
            <g:field class="form-control" name="email" value="${user?.userProfile?.email}" type="text"></g:field>
        </div>
    </div>

    <div class="form-group">
        <label for="comment" class="control-label col-md-2">Ďalšie informácie:</label>

        <div class="col-md-10">
            <g:field class="form-control" name="comment" value="${user?.userProfile?.comment}" type="text"></g:field>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">Oprávnenia</div>

        <div class="panel-body">
            <g:each var="formType" in="${formTypes}">
                <label title="${formType.name}" class="checkbox-inline">
                    <input type="checkbox" name="formTypes"
                           title="${formType.name}" ${isAdmin[formType] ? "" : "disabled=\"disabled\""} ${formTypeCreatePermission[formType] ? "checked=\"checked\"" : ""}
                           value="${formType.id}">${formType.shortcut}
                </label>
            </g:each>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">Zmena hesla</div>

        <div class="panel-body">
            <div class="form-group">
                <label for="password1" class="control-label col-md-2">Heslo:</label>

                <div class="col-md-10">
                    <g:field class="form-control" name="password1" value="" type="password"></g:field>
                </div>
            </div>

            <div class="form-group">
                <label for="password2" class="control-label col-md-2">Potvrdiť heslo:</label>

                <div class="col-md-10">
                    <g:field class="form-control" name="password2" value="" type="password"></g:field>
                </div>
            </div>
        </div>
    </div>

    <p style="margin: 10px">
        <g:if test="${xhr}">
            <g:submitToRemote url="[controller: 'user', action: 'save']" update="ajax_area"
                              class="btn btn-primary" value="Uložiť"
                              onComplete="setTimeout(function() {\$('#user_tree').jstree(true).refresh()}, 2000)"/>
        </g:if>
        <g:else>
            <g:submitButton name="update" class="btn btn-primary" value="Uložiť"></g:submitButton>
        </g:else>
    </p>
</g:form>
<script>
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
    )
</script>
</body>
</html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Formuláre</title>
</head>

<body>
<div class="row" style="margin-top: 20px;">
    <div class="col-md-12">
        <div class="pull-right">
            <div class="btn-group">
                <a class="btn btn-success" data-toggle="modal" href="${createLink(controller: 'form', action: 'types')}"
                   data-target="#modalWindow"><i class="fa fa-plus"></i>&nbsp; Nový</a>
                <a class="btn btn-default" data-toggle="modal"
                   href="${createLink(controller: 'form', action: 'delete')}"
                   data-target="#modalWindow"><i
                        class="glyphicon glyphicon-import"></i>&nbsp; Importovať</a>
            </div>
        </div>
    </div>
</div>
<table class="table table-hover table-striped" id="table">
    <thead>
    <tr>
        <th><g:checkBox name="checkAll"></g:checkBox></th>
        <g:sortableColumn property="id" title="#" params="${[userId: userId]}"/>
        <g:sortableColumn property="name" title="Názov" params="${[userId: userId]}"/>
        <g:sortableColumn property="type.shortcut" title="Typ" params="${[userId: userId]}"/>
        <g:sortableColumn property="creationDate" title="Vytvorený" params="${[userId: userId]}"/>
        <g:sortableColumn property="creator.username" title="Vytvoril" params="${[userId: userId]}"/>
        <g:sortableColumn property="updateDate" title="Upravený" params="${[userId: userId]}"/>
        <g:sortableColumn property="updater.username" title="Upravil" params="${[userId: userId]}"/>
        <th>Verzia</th>
        <th>Akcie</th>
    </tr>
    </thead>
    <tbody>
    <g:each var="form" in="${forms}">
        <tr>
        <td><g:checkBox name="checkbox_${form.id}"/></td>
        <td><g:link action="update" id="${form.id}">
            ${form.id}
        </g:link></td>
        <td><g:link action="update" id="${form.id}">
            ${form.name}
        </g:link></td>
        <td>
            ${form.type.shortcut}
        </td>
        <td><g:formatDate timeStyle="SHORT" date="${form.creationDate}"/></td>
        <td><g:link controller="user" action="show" id="${form.creator.id}" data-toggle="modal"
                    data-target="#modalWindow">
            ${form.creator.username}
        </g:link></td>
        <td><g:formatDate timeStyle="SHORT" date="${form.updateDate}"/></td>
        <td><g:link controller="user" action="show" id="${form.updater.id}"
                    data-toggle="modal" data-target="#modalWindow">
            ${form.updater.username}
        </g:link></td>
        <td><g:link action="versions" id="${form.id}">
            ${form.fields.size()}
        </g:link>
        <td><p>
        <g:if test="${hasDeletePermission[form]}">
            <g:link action="delete" id="${form.id}"
                    onclick="return confirm('Naozaj chcete vymazať formulár #${form.id} - ${form.name} ?');">
                <i class="fa fa-trash-o fa-lg"></i>
            </g:link>
        </g:if>
        <g:else>
            <td>&nbsp;</td>
        </g:else>

        <g:if test="${hasWritePermission[form]}">
            <g:link action="update" id="${form.id}">
                &nbsp;<i class="fa fa-pencil fa-lg"></i>
            </g:link>
        </g:if>
        <g:else>
            <g:link action="update" id="${form.id}">
                &nbsp;<i class="fa fa-eye fa-lg"></i>
            </g:link>
        </g:else>

        <g:link action="getFormXml" id="${form.id}">
            &nbsp;<i class="fa fa-download fa-lg"></i>
        </g:link>
        </p></td>
</tr>
    </g:each>
    </tbody>
</table>

<div class="btn-toolbar" role="toolbar" style="margin: 0;">
    <g:form name="form" controller="form" action="index" class="form-inline">
        <div class="btn-group">
            <g:paginate action="index" total="${formCount}" params="${[userId: userId]}"/>
        </div>
        <g:hiddenField name="userId" id="userId" value="${userId}"/>
        <div class="btn-group" style="margin: 20px;">
            <g:select name="max" from="${[10, 20, 50, 100, 1000]}" value="${max}"
                      class="form-control paginate-max selectWidth" onchange="this.form.submit();"
                      title="Počet záznamov na stranu"/>
        </div>
    </g:form>
</div>
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
</script>
</body>
</html>

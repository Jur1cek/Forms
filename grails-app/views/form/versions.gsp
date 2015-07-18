<html>
<head>
    <meta name="layout" content="main">
    <title>Verzie dokumentu</title>
</head>

<body>
<div class="page-header">
    <h3>
        Verzie dokumentu <strong>${form.name}
    </strong> -
    ${form.type.name}
    </h3>
</div>
<table class="table">
    <thead>
    <tr>
        <th>Verzia</th>
        <th>Vytvorená</th>
        <th>Vytvoril</th>
        <th>Akcie</th>
    </tr>
    </thead>
    <tbody>
    <% def i = 0 %>
    <g:each var="version" in="${form.fieldsVersion}">
        <tr>
            <td><g:link action="update" id="${form.id}" params="[version: i]">
                ${i}
            </g:link></td>
            <td>
                ${version.date}
            </td>
            <td><g:link controller="user" action="show" id="${version.creator.id}"
                        data-toggle="modal" data-target="#modalWindow">
                ${version.creator.username}
            </g:link>
            <td><p>
                <g:link action="update" id="${form.id}" params="[version: i]">
                    <i class="fa fa-eye fa-lg"></i>
                </g:link>
                <g:link action="exportHtml" id="${form.id}" params="[version: i]">
                    &nbsp; <i class="fa fa-file-pdf-o fa-lg"></i>
                </g:link>
            </p></td>
        </tr>
        <% i++ %>
    </g:each>
    </tbody>
</table>
</body>
</html>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <title>Zvoľte typ</title>
</head>

<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">Zvoľte typ</h4>
</div>

<div class="modal-body">
    <div class="list-group">
        <g:each var="type" in="${types}">
            <g:link action="create" id="${type.id}" class="list-group-item">
                ${type.name}
            </g:link>
        </g:each>
    </div>
</div>

</body>
</html>

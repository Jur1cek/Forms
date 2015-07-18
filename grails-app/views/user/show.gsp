<!DOCTYPE html>
<html>
<head>
    <head>
<g:if test="${!xhr}">
    <meta name="layout" content="main">
</g:if>
<title>
    ${user.userProfile.name}
</title>
</head>
</head>

<body>
<div class="modal-header">
    <g:if test="${!updateTree}"><button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button></g:if>
    <h4 class="modal-title">${user.userProfile.name}     <g:if test="${updateTree}">
        <a class="pull-right" href="#"
           onclick="$('#ajax_area').load('${createLink(action: 'update', id: user.id)}');">&nbsp;<i
                class="fa fa-pencil fa-lg"></i>&nbsp;</a>
    </g:if>
        <g:else>
            <g:link class="pull-right" action="update" id="${user.id}">
                &nbsp;<i class="fa fa-pencil fa-lg"></i>&nbsp;
            </g:link>
        </g:else></h4>
</div>

<div class="modal-body">

    <div class="row">
        <div class="col-md-3 col-lg-3 " align="center">
            <img alt="User Picture"
                 src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=100"
                 class="img-circle">
        </div>

        <div class="col-md-9 col-lg-9">
            <table class="table table-user-information">
                <tbody>
                <tr>
                    <td>Identifikačné číslo:</td>
                    <td>
                        ${user.id}
                    </td>
                </tr>
                <tr>
                    <td>Vysoká škola (organizácia):</td>
                    <td>
                        ${user.userProfile.university}
                    </td>
                </tr>
                <tr>
                    <td>Fakulta:</td>
                    <td>
                        ${user.userProfile.faculty}
                    </td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td><a href="mailto:${user.userProfile.email}">${user.userProfile.email}
                    </a></td>
                </tr>
                <tr>
                    <td>Ďalšie informácie</td>
                    <td>
                        ${user.userProfile.comment}
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal-footer">
    <label>Používateľom vytvorené &nbsp;</label>

    <div class="btn-group" role="group" aria-label="Používateľom vytvorené">
        <a href="${createLink(controller: 'collation', params: [userId: user.id])}"
           class="btn btn-primary">Žiadosti</a>
        <a href="${createLink(controller: 'form', params: [userId: user.id])}"
           class="btn btn-primary">Formuláre</a>
        <a href="${createLink(controller: 'document', params: [userId: user.id])}"
           class="btn btn-primary">Prílohy</a>
    </div>
</div>
</body>
</html>

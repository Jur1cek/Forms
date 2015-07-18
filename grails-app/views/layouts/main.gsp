<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title><g:layoutTitle default="Forms"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon"/>
    <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}"/>
    <link rel="apple-touch-icon" s∂izes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}"/>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <g:layoutHead/>
</head>

<body>
<sec:ifLoggedIn>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                        aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span
                        class="icon-bar"></span> <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#${createLink(controller: 'dashboard')}">Akredkom Forms</a>
            </div>

            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li ${controllerName.equals('collation') ? 'class=active' : ''}><g:link title="Žiadosti">Žiadosti</g:link></li>
                    <li ${controllerName.equals('form') && !actionName.equals('list_test') ? 'class=active' : ''}><g:link
                            controller="form"
                            action="index"
                            title="Formuláre">Formuláre</g:link></li>
                    <!--li ${controllerName.equals('form') && actionName.equals('list_test') ? 'class=active' : ''}><g:link
                            controller="form"
                            action="list_test"
                            title="Formuláre new">Formuláre new</g:link></li-->

                    <li ${controllerName.equals('document') ? 'class=active' : ''}><g:link controller="document"
                                                                                           action="index"
                                                                                           title="Prílohy">Prílohy</g:link></li>

                    <sec:ifAllGranted roles="ROLE_WORKER">
                        <li ${controllerName.equals('user') && actionName.equals('permissions') ? 'class=active' : ''}><g:link
                                controller="user"
                                action="permissions"
                                class="glyphicon glyphicon-cog"
                                title="Administrácia"></g:link></li>
                    </sec:ifAllGranted>
                    <li ${controllerName.equals('user') && actionName.equals('update') ? 'class=active' : ''}><g:link
                            controller="user"
                            action="update"
                            class="glyphicon glyphicon-user"
                            title="Profil"></g:link></li>
                    <!--li ${controllerName.equals('help') ? 'class=active' : ''}><g:link controller="help"
                                                                                          class="glyphicon glyphicon-question-sign"
                                                                                          title="Pomoc"></g:link></li-->
                    <li><g:link controller="logout" class="glyphicon glyphicon-off" title="Odhlásenie"></g:link></li>
                </ul>

                <form class="navbar-form navbar-right">
                    <input type="text" class="form-control" placeholder="Hľadať...">
                </form>
            </div>
        </div>
    </nav>
</sec:ifLoggedIn>
<div class="container-fluid">
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
    <g:layoutBody/>
</div>

<div class="modal fade" id="modalWindow" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content"></div>
    </div>
</div>
<script>
    $('#modalWindow').on('hide.bs.modal', function () {
        $(this).removeData();
    });
</script>
</body>
</html>
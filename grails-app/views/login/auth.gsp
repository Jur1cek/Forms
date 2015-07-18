<html>
<head>
    <meta name='layout' content='main'/>
    <title><g:message code="springSecurity.login.title"/></title>
    <style type='text/css' media='screen'>
    body {
        background-color: #eee;
    }

    .form-signin {
        max-width: 330px;
        padding: 15px;
        margin: 0 auto;
    }

    .form-signin .form-signin-heading, .form-signin .checkbox {
        margin-bottom: 10px;
    }

    .form-signin .checkbox {
        font-weight: normal;
    }

    .form-signin .form-control {
        position: relative;
        height: auto;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        padding: 10px;
        font-size: 16px;
    }

    .form-signin .form-control:focus {
        z-index: 2;
    }

    .form-signin input[type="text"] {
        margin-bottom: -1px;
        border-bottom-right-radius: 0;
        border-bottom-left-radius: 0;
    }

    .form-signin input[type="password"] {
        margin-bottom: 10px;
        border-top-left-radius: 0;
        border-top-right-radius: 0;
    }
    </style>
</head>

<body>
<div class="container">
    <form class="form-signin" action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
        <h2 class="form-signin-heading">
            <g:message code="springSecurity.login.header"/>
        </h2>
        <g:if test='${flash.message}'>
            <div class="alert alert-danger alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                ${flash.message}
            </div>
        </g:if>
        <label for="username" class="sr-only"><g:message code="springSecurity.login.username.label"/></label> <input
            type='text' class='form-control'
            name='j_username' id='username' class="form-control"
            placeholder="${message(code: "springSecurity.login.username.label")}" required autofocus>
        <label for="password" class="sr-only"><g:message code="springSecurity.login.password.label"/></label> <input
            type='password' class='form-control'
            name='j_password' id='password' class="form-control"
            placeholder="${message(code: "springSecurity.login.password.label")}" required>

        <div class="checkbox">
            <label><input type="checkbox" value="remember-me" name='${rememberMeParameter}' id='remember_me'
                          <g:if test='${hasCookie}'>checked='checked'</g:if>> <g:message
                    code="springSecurity.login.remember.me.label"/>
            </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">
            ${message(code: "springSecurity.login.button")}
        </button>
    </form>
</div>
</body>
</html>

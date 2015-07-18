<%--
  Created by IntelliJ IDEA.
  User: Jur1cek
  Date: 08/03/15
  Time: 11:05
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>
<sec:ifAllGranted roles='ROLE_ADMIN'>
    <form action='/Forms/j_spring_security_switch_user' method='POST'>
        Switch: <g:select from="${users}" optionKey="username" optionValue="username"
                          name='j_username'/>&nbsp;<input type='submit' value='Switch'/>
    </form>
</sec:ifAllGranted>
<sec:ifSwitched>
    <a href="${request.contextPath}/j_spring_security_exit_user">
        Resume as <sec:switchedUserOriginalUsername/>
    </a>
</sec:ifSwitched>
</body>
</html>
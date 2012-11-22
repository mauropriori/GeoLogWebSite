<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Geolog - Login Page</title>
    </head>

    <body>
        <p>Immetti le tue credenziali per entrare nel Pannello di Amministrazione.</p>

        <form:form action="login" commandName="userCredential" >
            <fieldset>		
                <legend>Login</legend>
                <p>
                    <form:label for="userName" path="userName">UserName</form:label><br/>
                    <form:input path="userName" /> <form:errors path="userName" />			
                </p>
                <p>	
                    <form:label for="password" path="password">Password</form:label><br/>
                    <form:password path="password" /> <form:errors path="password" />
                </p>
                <p>	
                    <input type="submit" />
                </p>
            </fieldset>
        </form:form>

    </body>
</html>

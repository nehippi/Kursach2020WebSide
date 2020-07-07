<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        <%@include file="styles.css" %>
        .div1 {
            display: inline-block;
        }

    </style>
    <meta charset="UTF-8">
    <title>Please, input your client code</title>
</head>
<body>
<h1>Please, input your client code</h1>

<if test="${violations != null}">
    <forEach items="${violations}" var="violation">
        <p>${violation}.</p>
    </forEach>
</if>



<form name="user" action="${pageContext.request.contextPath}/piano" method="post">
    <input type="text" name="code" id="code" value="${code}">
        <input type="submit" name="signup" value="Sign Up">
</form>
</body>
</html>
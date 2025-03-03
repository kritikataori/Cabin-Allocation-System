<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <link href="css/logout.css" rel="stylesheet">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp"/>

            <div class="content-wrapper">
                <div class="logout-card">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger text-center error-message" role="alert">
                            <c:out value="${errorMessage}"/>
                        </div>
                    </c:if>
                    <div class="text-center">
                        <h3 class="logout-title">Confirm Logout</h3>
                        <p class="logout-message">Are you sure you want to log out?</p>

                        <div class="button-group">
                            <form action="<c:url value='/logout'/>" method="POST">
                                <button type="submit" class="btn btn-danger">
                                    Yes
                                </button>
                            </form>

                            <form action="<c:url value='/logout'/>" method="GET">
                                <button type="submit" class="btn btn-secondary">
                                    Cancel
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp"/>
            <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
        </c:when>
    </c:choose>
</body>
</html>
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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

                    <div class="logout-icon">
                        <i class="fas fa-sign-out-alt"></i>
                    </div>

                    <div class="text-center">
                        <h3 class="logout-title">Confirm Logout</h3>
                        <div class="divider"><span></span></div>
                        <p class="logout-message">Are you sure you want to log out of your account?</p>

                        <div class="button-group">
                            <form action="<c:url value='/logout'/>" method="POST">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-check me-2"></i>Yes, Logout
                                </button>
                            </form>

                            <form action="<c:url value='/logout'/>" method="GET">
                                <button type="submit" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Return to Dashboard
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
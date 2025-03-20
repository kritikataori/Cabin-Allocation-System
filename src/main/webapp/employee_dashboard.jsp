<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/empstyles.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
</head>
<body>
     <c:choose>
            <c:when test="${not empty sessionScope.user && sessionScope.user.role == 'employee'}">
                <jsp:include page="includes/header.jsp" />
                <div class="container py-5">
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success text-center shadow-sm" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <c:out value="${successMessage}"/>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger text-center shadow-sm" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <c:out value="${errorMessage}"/>
                        </div>
                    </c:if>

                    <%
                      request.removeAttribute("successMessage");
                      request.removeAttribute("errorMessage");
                    %>

                    <div class="dashboard-card">
                        <div class="dashboard-header text-center">
                            <h2><i class="bi bi-grid-3x3-gap-fill me-2"></i>Employee Dashboard</h2>
                        </div>
                        <div class="dashboard-actions">
                            <p class="welcome-message">Welcome, ${sessionScope.user.username}</p>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <form action="<c:url value='/view_cabins'/>" method="GET" class="needs-validation" novalidate>
                                        <button type="submit" class="btn btn-primary dashboard-btn">
                                            <i class="bi bi-house-door"></i>
                                            View All Cabins
                                        </button>
                                    </form>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <form action="<c:url value='/requests?timestamp=${System.currentTimeMillis()}'/>" method="GET" class="needs-validation" novalidate>
                                        <button type="submit" class="btn btn-success dashboard-btn">
                                            <i class="bi bi-calendar-plus"></i>
                                            Request a Cabin
                                        </button>
                                    </form>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <form action="<c:url value='/request_status'/>" method="GET" class="needs-validation" novalidate>
                                        <button type="submit" class="btn btn-info dashboard-btn">
                                            <i class="bi bi-clipboard-check"></i>
                                            View Request Status
                                        </button>
                                    </form>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <form action="admin_request.jsp" method="POST" class="needs-validation" novalidate>
                                        <button type="submit" class="btn btn-warning dashboard-btn">
                                            <i class="bi bi-shield-lock"></i>
                                            Request Admin Access
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="includes/footer.jsp" />
                <script src="js/form_validation.js"></script>
                <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
            </c:when>
            <c:when test="${not empty sessionScope.user && sessionScope.user.role == 'admin'}">
                <c:redirect url="/admin_dashboard.jsp"/>
            </c:when>
            <c:otherwise>
                <c:redirect url="login.jsp"/>
            </c:otherwise>
        </c:choose>
</body>
</html>
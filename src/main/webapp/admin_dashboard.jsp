<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/adminstyles.css">
    <title>Admin Dashboard</title>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user && sessionScope.user.role == 'admin'}">
            <jsp:include page="includes/header.jsp" />

                <div class="content">
                    <div class="container py-5">
                        <div class="dashboard-card">
                            <div class="dashboard-header text-center">
                                <h2><i class="bi bi-grid-3x3-gap-fill me-2"></i>Admin Dashboard</h2>
                            </div>
                            <div class="dashboard-actions">
                                <p class="welcome-message">Welcome, ${sessionScope.user.username}</p>

                                <div class="row d-flex justify-content-center">
                                    <div class="col-md-6 mb-3">
                                        <form action="<c:url value='/requests?action=pending'/>" method="GET" class="needs-validation" novalidate>
                                            <input type="hidden" name="action" value="pending">
                                            <button type="submit" class="btn btn-primary dashboard-btn">
                                                <i class="bi bi-list-check"></i>Cabin Requests
                                            </button>
                                        </form>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <form action="<c:url value='/adminRequests'/>" method="GET" class="needs-validation" novalidate>
                                           <button type="submit" class="btn btn-success dashboard-btn">
                                               <i class="bi bi-shield-check"></i>Admin Requests
                                           </button>
                                        </form>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <form action="<c:url value='/manageCabins'/>" method="GET" class="needs-validation" novalidate>
                                             <button type="submit" class="btn btn-info dashboard-btn">
                                                <i class="bi bi-house-door"></i>Manage Cabins
                                             </button>
                                        </form>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <form action="<c:url value='/currentAllocations'/>" method="POST" class="needs-validation" novalidate>
                                            <button type="submit" class="btn btn-warning dashboard-btn">
                                                <i class="bi bi-people"></i>Current Allocations
                                            </button>
                                        </form>
                                    </div>
                                    <div class="col-md-6">
                                        <form action="<c:url value='/allocationHistory'/>" method="GET" class="needs-validation" novalidate>
                                           <button type="submit" class="btn btn-secondary dashboard-btn">
                                               <i class="bi bi-clock-history"></i>Allocation History
                                           </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <jsp:include page="includes/footer.jsp" />
            <script src="js/form_validation.js"></script>
            <script src="bootstrap/js/bootstrap.min.js"></script>
        </c:when>
        <c:when test="${not empty sessionScope.user && sessionScope.user.role == 'employee'}">
            <c:redirect url="/employee_dashboard.jsp"/>
        </c:when>
        <c:otherwise>
            <c:redirect url="login.jsp"/>
        </c:otherwise>
    </c:choose>
</body>
</html>


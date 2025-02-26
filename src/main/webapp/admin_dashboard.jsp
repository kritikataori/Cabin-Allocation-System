<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/adminstyles.css">
    <title>Admin Dashboard</title>
</head>
<body class="bg-light">
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />
                <div class="container admin-container">
                    <h2 class="mb-3 mt-3 text-center">Admin Dashboard</h2>
                    <div class="d-flex flex-column justify-content-center align-items-center">
                        <div class="mb-2">
                            <form action="<c:url value='/requests?action=pending'/>" method="GET" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="pending">
                                <button type="submit" class="btn btn-lg btn-primary dashboard-btn">
                                    <i class="fas fa-clock me-2"></i>Cabin Requests
                                </button>
                            </form>
                        </div>
                        <div class="mb-2">
                            <form action="<c:url value='/adminRequests'/>" method="GET" class="needs-validation" novalidate>
                                <button type="submit" class="btn btn-lg btn-success dashboard-btn">
                                    <i class="fas fa-user-shield me-2"></i>Admin Requests
                                </button>
                            </form>
                        </div>
                        <div class="mb-2">
                            <form action="<c:url value='/manageCabins'/>" method="GET" class="needs-validation" novalidate>
                                <button type="submit" class="btn btn-lg btn-info dashboard-btn">
                                    <i class="fas fa-building me-2"></i>Manage Cabins
                                </button>
                            </form>
                        </div>
                        <div class="mb-2">
                            <form action="<c:url value='/currentAllocations'/>" method="POST" class="needs-validation" novalidate>
                                <button type="submit" class="btn btn-lg btn-warning dashboard-btn">
                                    <i class="fas fa-users me-2"></i>Current Allocations
                                </button>
                            </form>
                        </div>
                        <div class="mb-2">
                            <form action="allocationHistory.jsp" method="GET" class="needs-validation" novalidate>
                                <button type="submit" class="btn btn-lg btn-warning dashboard-btn">
                                    <i class="fas fa-history me-2"></i>Allocation History
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            <jsp:include page="includes/footer.jsp" />
            <script src="js/form_validation.js"></script>
            <script src="bootstrap/js/bootstrap.min.js"></script>
        </c:when>
        <c:otherwise>
            <c:redirect url="login.jsp"/>
        </c:otherwise>
    </c:choose>
</body>
</html>


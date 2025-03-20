<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Admin Access</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/requestCabin.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp"/>

            <div class="page-header">
                <div class="container">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3>Request Admin Access</h3>
                        <a href="employee_dashboard.jsp" class="btn btn-outline-light btn-sm">
                            <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                        </a>
                    </div>
                </div>
            </div>

            <div class="container mt-4">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <form action="/requestAdmin" method="POST" class="needs-validation" novalidate>
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Your Username</label>
                                        <input type="text" class="form-control" id="username" name="username"
                                               value="${sessionScope.user.username}" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label for="reason" class="form-label">Reason for Request</label>
                                        <textarea class="form-control" id="reason" name="reason" rows="3"
                                                placeholder="Please explain why you are requesting admin access..." required></textarea>
                                    </div>
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-paper-plane me-2"></i>Submit Request
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="includes/footer.jsp"/>
            <script src="js/form_validation.js"></script>
            <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
        </c:when>
        <c:otherwise>
            <c:redirect url="login.jsp"/>
        </c:otherwise>
    </c:choose>
</body>
</html>
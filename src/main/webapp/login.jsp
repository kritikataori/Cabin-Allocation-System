<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
    <title>Login - Cabin Allocation System</title>
</head>

<body>
    <jsp:include page="includes/header.jsp" />

    <div class="login-container">
        <div class="login-card">
            <c:if test="${not empty errorMessage}">
                <div class="error-message mb-0" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <c:out value="${errorMessage}"/>
                </div>
            </c:if>

            <div class="login-header">
                <h3><i class="fas fa-door-open me-2"></i>Login</h3>
            </div>

            <div class="login-body">
                <form action="/login" method="POST" class="needs-validation" novalidate>
                    <div class="form-group">
                        <label class="form-label" for="username">Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input class="form-control" type="text" id="username" name="username" placeholder="Enter your username" autofocus required>
                        </div>
                        <div class="invalid-feedback">
                            Please enter your username.
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="password">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input class="form-control" type="password" id="password" name="password" placeholder="Enter your password" required>
                        </div>
                        <div class="invalid-feedback">
                            Please enter your password.
                        </div>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-login">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </button>
                    </div>
                </form>

                <div class="signup-link">
                    <p>Don't have an account? <a href="register.jsp">Sign up now</a></p>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script src="js/form_validation.js"></script>
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
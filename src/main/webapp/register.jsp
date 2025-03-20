<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/register.css">
    <title>Register</title>
</head>

<body>
    <jsp:include page="includes/header.jsp" />

    <div class="register-container">
        <div class="register-card">
            <c:if test="${not empty errorMessage}">
                <div class="error-message" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <c:out value="${errorMessage}"/>
                </div>
            </c:if>

            <div class="register-header">
                <h3><i class="fas fa-user-plus me-2"></i>Register</h3>
            </div>

            <div class="register-body">
                <form action="/register" method="POST" class="needs-validation" novalidate>
                    <div class="form-group">
                        <label class="form-label" for="username">Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input class="form-control" type="text" id="username" name="username" placeholder="Choose a username" autofocus required>
                        </div>
                        <div class="invalid-feedback">
                            Please choose a username.
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="email">Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input class="form-control" type="email" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                        <div class="invalid-feedback">
                            Please enter a valid email.
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="password">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input class="form-control" type="password" id="password" name="password" placeholder="Create a password" required>
                        </div>
                        <div class="invalid-feedback">
                            Please create a password.
                        </div>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-register">
                            <i class="fas fa-user-plus me-2"></i>Create Account
                        </button>
                    </div>
                </form>

                <div class="login-link mb-2">
                    <p class="mb-1">Already have an account? <a href="login.jsp">Log in</a></p>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script src="js/form_validation.js"></script>
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
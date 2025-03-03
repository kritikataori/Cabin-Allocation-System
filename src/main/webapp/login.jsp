<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <title>Login</title>

    <style>
        .custom-card {
            width: 400px;
        }
        .error-message {
            font-size: 0.9rem;
            padding: 10px;
            border: 1px solid #f8d7da; /* Light red border */
            border-radius: 5px;
            margin-bottom: 15px; /* Add margin to bottom */
        }
    </style>
</head>

<body>
    <jsp:include page="includes/header.jsp" />

    <div class="container d-flex justify-content-center align-items-center mt-4">
        <div class="row flex-fill">
            <div class="col-md-6 offset-md-3 col-xl-4 offset-xl-4">
                <div class="card shadow custom-card mb-3">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger text-center error-message" role="alert">
                            <c:out value="${errorMessage}"/>
                        </div>
                    </c:if>
                    <img src="https://www.jobalerts4u.in/wp-content/uploads/2023/05/WhatsApp-Image-2023-05-29-at-6.21.57-PM.jpeg" alt="Login Image" class="card-img-top img-fluid" />
                    <div class="card-body">
                        <h3 class="card-title text-center">Login</h3>
                        <form action="/login" method="POST" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label class="form-label" for="username">Username</label>
                                <input class="form-control" type="text" id="username" name="username" autofocus required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label" for="password">Password</label>
                                <input class="form-control" type="password" id="password" name="password" required>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-success w-100">Login</button>
                            </div>
                        </form>
                        <div class="mt-3">
                            <p class="text-center">Not a user? <a href="register.jsp">Sign up now</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script src="js/form_validation.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
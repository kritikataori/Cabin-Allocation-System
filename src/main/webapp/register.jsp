<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
    <title>Register</title>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <main>
    <div class="container mt-4 col-md-6 justify-content-center align-items-center mb-3">
        <h2 class="text-center">Register</h2>
        <form action="/register" method="POST" class="needs-validation" novalidate>

            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <div class="d-flex justify-content-center">
                <button type="submit" class="btn btn-success w-100">Register</button>
            </div>
        </form>
        <p class="text-center mt-3">Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
    </main>
    <jsp:include page="includes/footer.jsp" />
    <script src="js/form_validation.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
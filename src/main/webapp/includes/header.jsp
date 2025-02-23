<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background-color: #000000;">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Yash Technologies</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${sessionScope.user.role == 'admin'}">
                                <li class="nav-item"><a class="nav-link" href="admin_dashboard.jsp">Admin Dashboard</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item"><a class="nav-link" href="employee_dashboard.jsp">Employee Dashboard</a></li>
                            </c:otherwise>
                        </c:choose>
                        <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<style>
    .navbar-nav .nav-link {
        color: #ffffff; /* Default text color */
        transition: color 0.3s; /* Smooth transition for color change */
    }

    .navbar-nav .nav-link:hover {
        color: #ffcc00; /* Change text color on hover */
    }
</style>
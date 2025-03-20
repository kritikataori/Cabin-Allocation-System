<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top header-main">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <img src="img/yash-logo.png" alt="Yash Technologies Logo" class="brand-logo">
        </a>
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
                        <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<style>
    .header-main {
        background-color: #121212; /* Much darker, almost black but not quite */
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        padding: 0.6rem 0;
    }

    .navbar-brand {
        display: flex;
        align-items: center;
    }

    .brand-logo {
        height: 32px;
        margin-right: 10px;
    }

    .brand-text {
        font-size: 1.3rem;
        font-weight: 600;
        letter-spacing: 0.5px;
        color: #ffffff;
    }

    .navbar-nav .nav-link {
        color: rgba(255, 255, 255, 0.85);
        font-weight: 500;
        padding: 0.5rem 1rem;
        margin: 0 0.2rem;
        border-radius: 6px;
        transition: all 0.3s ease;
    }

    .navbar-nav .nav-link:hover {
        color: #0d6efd; /* Blue accent color on hover to match the theme */
        background-color: rgba(255, 255, 255, 0.08);
    }

    .navbar-nav .nav-link.active {
        color: #0d6efd;
        background-color: rgba(255, 255, 255, 0.08);
    }

    /* For mobile view */
    @media (max-width: 992px) {
        .navbar-nav .nav-link {
            padding: 0.75rem 1rem;
            margin: 0.2rem 0;
        }

        .brand-logo {
            height: 28px;
        }
    }
</style>
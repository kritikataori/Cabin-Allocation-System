<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <p class="copyright">&copy; 2025 Yash Technologies Pvt. Ltd. All Rights Reserved.</p>
        </div>
    </div>
</footer>

<style>
    .footer {
        background-color: #121212;
        color: #ffffff;
        padding: 15px 0;
        text-align: center;
        box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
    }

    .footer-content {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .copyright {
        margin: 0;
        font-size: 0.9rem;
        letter-spacing: 0.5px;
    }

    @media (max-width: 576px) {
        .footer {
            padding: 12px 0;
        }

        .copyright {
            font-size: 0.8rem;
        }
    }
</style>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/adminstyles.css">
    <title>View Admin Requests</title>
</head>
<body class="bg-light">
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />

            <div class="container-fluid py-4">
                <h2 class="mb-4">View Admin Requests</h2>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger text-center error-message" role="alert">
                        <c:out value="${errorMessage}"/>
                    </div>
                </c:if>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Employee ID</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Reason</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${adminRequests}">
                                <tr>
                                    <td><c:out value="${user.id}"/></td>
                                    <td><c:out value="${user.username}"/></td>
                                    <td><c:out value="${user.email}"/></td>
                                    <td><c:out value="${user.reason}"/></td>
                                    <td>
                                        <form action="/adminRequests" method="POST" style="display: inline;" class="needs-validation" novalidate>
                                            <input type="hidden" name="action" value="approve">
                                            <input type="hidden" name="requestId" value="${user.id}">
                                            <button type="submit" class="btn btn-success btn-sm" title="Approve">
                                                <i class="fas fa-check"></i>
                                            </button>
                                        </form>
                                        <form action="/adminRequests" method="POST" style="display: inline;" class="needs-validation" novalidate>
                                            <input type="hidden" name="action" value="reject">
                                            <input type="hidden" name="requestId" value="${user.id}">
                                            <button type="submit" class="btn btn-danger btn-sm" title="Reject">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>

                            </c:forEach>
                        </tbody>
                    </table>
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
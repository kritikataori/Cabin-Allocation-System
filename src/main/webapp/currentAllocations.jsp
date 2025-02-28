<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/adminstyles.css">
    <title>Current Allocations</title>
</head>
<body class="bg-light">
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />
            <div class="container admin-container">
                <h2 class="mb-3 mt-3 text-center">Current Allocations</h2>

                <c:if test="${empty currentAllocations}">
                    <p class="text-center">No current allocations found.</p>
                </c:if>

                <c:if test="${not empty currentAllocations}">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>Allocation ID</th>
                                    <th>Request ID</th>
                                    <th>Employee Name</th>
                                    <th>Cabin Name</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="allocation" items="${currentAllocations}">
                                    <tr>
                                        <td><c:out value="${allocation.id}"/></td>
                                        <td><c:out value="${allocation.requestId}"/></td>
                                        <td><c:out value="${allocation.employeeName}"/></td>
                                        <td><c:out value="${allocation.cabinName}"/></td>
                                        <td><fmt:formatDate value="${allocation.startTime}" pattern="HH:mm:ss"/></td>
                                        <td><fmt:formatDate value="${allocation.endTime}" pattern="HH:mm:ss"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
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
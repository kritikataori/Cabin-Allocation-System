<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Allocation History</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/adminstyles.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp"/>
            <div class="container mt-4">
                <h2 class="mb-4">Allocation History</h2>

                <c:if test="${empty expiredAllocations}">
                    <p class="alert alert-info">No expired allocations found.</p>
                </c:if>

                <c:if test="${not empty expiredAllocations}">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th>Allocation ID</th>
                                    <th>Employee Name</th>
                                    <th>Assigned Cabin ID</th>
                                    <th>Date</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="allocation" items="${expiredAllocations}">
                                    <tr>
                                        <td><c:out value="${allocation.id}"/></td>
                                        <td><c:out value="${allocation.employeeName}"/></td>
                                        <td><c:out value="${allocation.assignedCabinId}"/></td>
                                        <td><c:out value="${allocation.requestDate}"/></td>
                                        <td><c:out value="${allocation.startTime}"/></td>
                                        <td><c:out value="${allocation.endTime}"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>

            <jsp:include page="includes/footer.jsp"/>
            <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
        </c:when>
        <c:otherwise>
            <c:redirect url="login.jsp"/>
        </c:otherwise>
    </c:choose>
</body>
</html>
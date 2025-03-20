<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Allocation History</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/viewCabinRequests.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp"/>

            <div class="content">
                <div class="page-header">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3 class="mb-0">Allocation History</h3>
                            <a href="admin_dashboard.jsp" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                            </a>
                        </div>
                    </div>
                </div>

                <div class="container mt-4">
                    <c:if test="${empty expiredAllocations}">
                        <div class="alert alert-info text-center shadow-sm" role="alert">
                            <i class="fas fa-info-circle me-2"></i>
                            No expired allocations found.
                        </div>
                    </c:if>

                    <c:if test="${not empty expiredAllocations}">
                        <div class="table-container">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th><i class="fas fa-id-card me-2"></i>Allocation ID</th>
                                            <th><i class="fas fa-user me-2"></i>Employee Name</th>
                                            <th><i class="fas fa-building me-2"></i>Cabin ID</th>
                                            <th><i class="fas fa-calendar-alt me-2"></i>Date</th>
                                            <th><i class="fas fa-clock me-2"></i>Start Time</th>
                                            <th><i class="fas fa-hourglass-end me-2"></i>End Time</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="allocation" items="${expiredAllocations}">
                                            <tr>
                                                <td class="allocation-id">#<c:out value="${allocation.id}"/></td>
                                                <td>
                                                    <span class="d-flex align-items-center">
                                                        <c:out value="${allocation.employeeName}"/>
                                                    </span>
                                                </td>
                                                <td><c:out value="${allocation.assignedCabinId}"/></td>
                                                <td><fmt:formatDate value="${allocation.requestDate}" pattern="yyyy-MM-dd" /></td>
                                                <td>
                                                    <span class="badge bg-primary">
                                                        <i class="fas fa-clock me-1"></i>
                                                        <fmt:formatDate value="${allocation.startTime}" pattern="HH:mm:ss"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-info">
                                                        <i class="fas fa-hourglass-end me-1"></i>
                                                        <fmt:formatDate value="${allocation.endTime}" pattern="HH:mm:ss"/>
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>
                </div>
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
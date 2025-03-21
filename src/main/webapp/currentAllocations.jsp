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
    <link rel="stylesheet" href="css/viewCabinRequests.css">
    <title>Current Allocations</title>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />

            <div class="content">
                <div class="page-header">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3 class="mb-0">Current Allocations</h3>
                            <a href="admin_dashboard.jsp" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                            </a>
                        </div>
                    </div>
                </div>

                <div class="container mt-4">
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success text-center shadow-sm" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <c:out value="${sessionScope.successMessage}"/>
                        </div>
                        <% session.removeAttribute("successMessage"); %>
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger text-center shadow-sm" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <c:out value="${sessionScope.errorMessage}"/>
                        </div>
                        <% session.removeAttribute("errorMessage"); %>
                    </c:if>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h5 class="text-muted mb-0">
                                <i class="fas fa-calendar-check me-2"></i>Active Allocations
                            </h5>
                        </div>
                        <div>
                            <form action="currentAllocations" method="post" class="d-inline">
                                <input type="hidden" name="action" value="downloadExcel"/>
                                <button type="submit" class="btn btn-success shadow-sm">
                                    <i class="fas fa-file-excel me-2"></i>Export to Excel
                                </button>
                            </form>
                        </div>
                    </div>

                    <div class="table-container">
                        <c:choose>
                            <c:when test="${not empty currentAllocations}">
                                <div class="card shadow-sm">
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th><i class="fas fa-id-card me-2"></i>Allocation ID</th>
                                                        <th><i class="fas fa-hashtag me-2"></i>Request ID</th>
                                                        <th><i class="fas fa-user me-2"></i>Employee Name</th>
                                                        <th><i class="fas fa-building me-2"></i>Cabin Name</th>
                                                        <th><i class="fas fa-calendar-alt me-2"></i>Date</th>
                                                        <th><i class="fas fa-clock me-2"></i>Start Time</th>
                                                        <th><i class="fas fa-hourglass-end me-2"></i>End Time</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="allocation" items="${currentAllocations}">
                                                        <tr>
                                                            <td class="allocation-id">#<c:out value="${allocation.id}"/></td>
                                                            <td>#<c:out value="${allocation.requestId}"/></td>
                                                            <td>
                                                                <span class="d-flex align-items-center">
                                                                    <c:out value="${allocation.employeeName}"/>
                                                                </span>
                                                            </td>
                                                            <td><c:out value="${allocation.cabinName}"/></td>
                                                            <td><fmt:formatDate value="${allocation.requestDate}" pattern="yyyy-MM-dd"/> </td>
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
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-calendar-check"></i>
                                    <h4>No Current Allocations</h4>
                                    <p class="text-muted">There are no cabin allocations at this time.</p>
                                    <a href="admin_dashboard.jsp" class="btn btn-primary mt-3">
                                        <i class="fas fa-arrow-left me-2"></i>Return to Dashboard
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="card mt-4 mb-4 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-info-circle me-2"></i>Allocation Information</h5>
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <span class="badge bg-primary me-2">
                                            <i class="fas fa-clock"></i>
                                        </span>
                                        <span><strong>Start Time</strong>: When the cabin allocation begins</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <span class="badge bg-info me-2">
                                            <i class="fas fa-hourglass-end"></i>
                                        </span>
                                        <span><strong>End Time</strong>: When the cabin allocation ends</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
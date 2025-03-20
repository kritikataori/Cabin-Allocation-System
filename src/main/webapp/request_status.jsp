<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Status</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/requestStatus.css" rel="stylesheet">
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
                            <h3 class="mb-0">Request Status</h3>
                            <a href="employee_dashboard.jsp" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                            </a>
                        </div>
                        <a href="request_cabin.jsp" class="btn btn-primary mt-3">
                            <i class="fas fa-plus me-2"></i>New Request
                        </a>
                    </div>
                </div>

                <div class="container mt-4">
                    <div class="table-container">
                        <c:choose>
                            <c:when test="${not empty userRequests}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th><i class="fas fa-hashtag me-2"></i>Request ID</th>
                                                <th><i class="fas fa-home me-2"></i>Requested Cabin</th>
                                                <th><i class="fas fa-check-circle me-2"></i>Assigned Cabin</th>
                                                <th><i class="fas fa-calendar me-2"></i>Request Date</th>
                                                <th><i class="fas fa-clock me-2"></i>Duration</th>
                                                <th><i class="fas fa-info-circle me-2"></i>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="request" items="${userRequests}">
                                                <tr>
                                                    <td class="request-id">#REQ<c:out value="${request.id}"/></td>
                                                    <td>
                                                        <span class="d-flex align-items-center">
                                                            <i class="fas fa-cabin me-2 text-muted"></i>
                                                            <c:out value="${request.cabinName}"/>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${request.status == 'approved'}">
                                                                <span class="d-flex align-items-center">
                                                                    <i class="fas fa-check-circle me-2 text-success"></i>
                                                                    <c:out value="${request.assignedCabinName}"/>
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">-</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><c:out value="${request.reqDate}"/></td>
                                                    <td><c:out value="${request.startTime}"/> - <c:out value="${request.endTime}"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${request.status == 'approved'}">
                                                                <span class="badge bg-success">
                                                                    <i class="fas fa-check-circle me-1"></i>
                                                                    <c:out value="${request.status}"/>
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${request.status == 'rejected'}">
                                                                <span class="badge bg-danger">
                                                                    <i class="fas fa-times-circle me-1"></i>
                                                                    <c:out value="${request.status}"/>
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${request.status == 'pending'}">
                                                                <span class="badge bg-warning">
                                                                    <i class="fas fa-clock me-1"></i>
                                                                    <c:out value="${request.status}"/>
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">
                                                                    <i class="fas fa-question-circle me-1"></i>
                                                                    <c:out value="${request.status}"/>
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-clipboard-list"></i>
                                    <h4>No Requests Found</h4>
                                    <p class="text-muted">You haven't made any cabin requests yet.</p>
                                    <a href="request_cabin.jsp" class="btn btn-primary mt-3">
                                        Make Your First Request
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="card mt-4 mb-4">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-info-circle me-2"></i>Request Status Guide</h5>
                            <div class="row mt-3">
                                <div class="col-md-4">
                                    <div class="d-flex align-items-center mb-2">
                                        <span class="badge bg-warning me-2">
                                            <i class="fas fa-clock"></i>
                                        </span>
                                        <span><strong>Pending</strong>: Your request is under review</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="d-flex align-items-center mb-2">
                                        <span class="badge bg-success me-2">
                                            <i class="fas fa-check-circle"></i>
                                        </span>
                                        <span><strong>Approved</strong>: Your cabin is ready</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="d-flex align-items-center mb-2">
                                        <span class="badge bg-danger me-2">
                                            <i class="fas fa-times-circle"></i>
                                        </span>
                                        <span><strong>Rejected</strong>: Request not approved</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/viewCabinRequests.css">
    <title>View Admin Requests</title>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />

            <div class="content">
                <div class="page-header">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3 class="mb-0">Admin Access Requests</h3>
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

                <div class="table-container">
                    <c:choose>
                        <c:when test="${not empty adminRequests}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th><i class="fas fa-id-card me-2"></i>Employee ID</th>
                                            <th><i class="fas fa-user me-2"></i>Username</th>
                                            <th><i class="fas fa-envelope me-2"></i>Email</th>
                                            <th><i class="fas fa-comment me-2"></i>Reason</th>
                                            <th><i class="fas fa-info-circle me-2"></i>Status</th>
                                            <th><i class="fas fa-tools me-2"></i>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${adminRequests}">
                                            <tr>
                                                <td class="request-id">#<c:out value="${user.id}"/></td>
                                                <td>
                                                    <span class="d-flex align-items-center">
                                                        <c:out value="${user.username}"/>
                                                    </span>
                                                </td>
                                                <td><c:out value="${user.email}"/></td>
                                                <td>
                                                    <button type="button" class="btn btn-link p-0 text-decoration-none" data-bs-toggle="modal" data-bs-target="#reasonModal-${user.id}">
                                                        ${user.reason.length() > 20 ? user.reason.substring(0, 20).concat('...') : user.reason}
                                                    </button>
                                                </td>
                                                <td>
                                                    <span class="badge bg-warning">
                                                        Pending
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <form action="/adminRequests" method="POST" style="display: inline;" class="needs-validation" novalidate>
                                                            <input type="hidden" name="action" value="approve">
                                                            <input type="hidden" name="requestId" value="${user.id}">
                                                            <button type="submit" class="btn btn-success btn-sm" title="Approve">
                                                                <i class="fas fa-check"></i> Approve
                                                            </button>
                                                        </form>

                                                        <form action="/adminRequests" method="POST" style="display: inline;" class="needs-validation" novalidate>
                                                            <input type="hidden" name="action" value="reject">
                                                            <input type="hidden" name="requestId" value="${user.id}">
                                                            <button type="submit" class="btn btn-danger btn-sm" title="Reject">
                                                                <i class="fas fa-times"></i> Reject
                                                            </button>
                                                        </form>

                                                        <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#detailsModal-${user.id}" title="View Details">
                                                            <i class="fas fa-eye"></i> Details
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>

                                            <!-- Reason Modal -->
                                            <div class="modal fade" id="reasonModal-${user.id}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header bg-primary text-white">
                                                            <h5 class="modal-title">
                                                                <i class="fas fa-comment me-2"></i>
                                                                Request Reason
                                                            </h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="p-3 bg-light rounded">
                                                                <c:out value="${user.reason}"/>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                                <i class="fas fa-times me-1"></i>Close
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Details Modal -->
                                            <div class="modal fade" id="detailsModal-${user.id}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header bg-info text-white">
                                                            <h5 class="modal-title">
                                                                <i class="fas fa-user-shield me-2"></i>
                                                                Admin Request Details
                                                            </h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="current-selection mb-3 p-2 bg-light rounded">
                                                                <h6 class="mb-3">Employee Information</h6>
                                                                <div class="user-info">
                                                                    <p class="mb-2"><i class="fas fa-id-card me-2"></i> <strong>Employee ID:</strong> <c:out value="${user.id}"/></p>
                                                                    <p class="mb-2"><i class="fas fa-user me-2"></i> <strong>Username:</strong> <c:out value="${user.username}"/></p>
                                                                    <p class="mb-2"><i class="fas fa-envelope me-2"></i> <strong>Email:</strong> <c:out value="${user.email}"/></p>
                                                                </div>
                                                            </div>
                                                            <div class="mb-3">
                                                                <h6 class="mb-2">Request Reason</h6>
                                                                <div class="p-3 bg-light rounded">
                                                                    <c:out value="${user.reason}"/>
                                                                </div>
                                                            </div>
                                                            <div class="mb-3">
                                                                <h6 class="mb-2">Access Information</h6>
                                                                <div class="p-3 bg-light rounded">
                                                                    <p class="mb-0"><i class="fas fa-shield-alt me-2"></i> <strong>Requested Access:</strong> Administrator Rights</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                                <i class="fas fa-times me-1"></i>Close
                                                            </button>
                                                            <form action="/adminRequests" method="POST" style="display: inline;" class="needs-validation" novalidate>
                                                                <input type="hidden" name="action" value="approve">
                                                                <input type="hidden" name="requestId" value="${user.id}">
                                                                <button type="submit" class="btn btn-success" title="Approve">
                                                                    <i class="fas fa-check me-1"></i>Approve
                                                                </button>
                                                            </form>
                                                            <form action="/adminRequests" method="POST" style="display: inline;" class="needs-validation" novalidate>
                                                                <input type="hidden" name="action" value="reject">
                                                                <input type="hidden" name="requestId" value="${user.id}">
                                                                <button type="submit" class="btn btn-danger" title="Reject">
                                                                    <i class="fas fa-times me-1"></i>Reject
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-user-shield"></i>
                                <h4>No Pending Admin Requests</h4>
                                <p class="text-muted">There are no admin access requests waiting for your approval at this time.</p>
                                <a href="admin_dashboard.jsp" class="btn btn-primary mt-3">
                                    <i class="fas fa-arrow-left me-2"></i>Return to Dashboard
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="card mt-4 mb-4">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-info-circle me-2"></i>Admin Request Guidelines</h5>
                        <div class="row mt-3">
                            <div class="col-md-4">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="badge bg-success me-2">
                                        <i class="fas fa-check"></i>
                                    </span>
                                    <span><strong>Approve</strong>: Grant admin access privileges</span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="badge bg-danger me-2">
                                        <i class="fas fa-times"></i>
                                    </span>
                                    <span><strong>Reject</strong>: Deny admin access request</span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="badge bg-info me-2">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                    <span><strong>Details</strong>: View complete request information</span>
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
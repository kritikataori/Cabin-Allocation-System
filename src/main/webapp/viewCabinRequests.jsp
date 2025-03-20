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
    <title>View Cabin Requests</title>
</head>
<body class="bg-light">
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />

            <div class="content">
                <div class="page-header">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3 class="mb-0">Cabin Requests</h3>
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
                        <c:when test="${not empty pendingRequests}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th><i class="fas fa-id-card me-2"></i>Employee ID</th>
                                            <th><i class="fas fa-user me-2"></i>Name</th>
                                            <th><i class="fas fa-calendar me-2"></i>Request Date</th>
                                            <th><i class="fas fa-clock me-2"></i>Duration</th>
                                            <th><i class="fas fa-home me-2"></i>Cabin Requested</th>
                                            <th><i class="fas fa-info-circle me-2"></i>Status</th>
                                            <th><i class="fas fa-tools me-2"></i>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="request" items="${pendingRequests}">
                                            <tr>
                                                <td class="request-id">#<c:out value="${request.empId}"/></td>
                                                <td>
                                                    <span class="d-flex align-items-center">
                                                        <c:out value="${request.username}"/>
                                                    </span>
                                                </td>
                                                <td><c:out value="${request.reqDate}"/></td>
                                                <td><c:out value="${request.startTime}"/> - <c:out value="${request.endTime}"/></td>
                                                <td>
                                                    <span class="d-flex align-items-center">
                                                        <c:out value="${request.cabinName}"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-warning">
                                                        <c:out value="${request.status}"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <form action="/requests" method="POST" style="display: inline;" class="needs-validation" novalidate>
                                                            <input type="hidden" name="action" value="approve">
                                                            <input type="hidden" name="requestId" value="${request.id}">
                                                            <button type="submit" class="btn btn-success btn-sm" title="Approve">
                                                                <i class="fas fa-check"></i> Approve
                                                            </button>
                                                        </form>

                                                        <form action="/requests" method="POST" style="display: inline;" class="needs-validation" novalidate>
                                                            <input type="hidden" name="action" value="reject">
                                                            <input type="hidden" name="requestId" value="${request.id}">
                                                            <button type="submit" class="btn btn-danger btn-sm" title="Reject">
                                                                <i class="fas fa-times"></i> Reject
                                                            </button>
                                                        </form>

                                                        <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#assignOtherModal-${request.id}" title="Assign Other">
                                                            <i class="fas fa-exchange-alt"></i> Reassign
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>

                                            <!-- Modal for each request -->
                                            <div class="modal fade" id="assignOtherModal-${request.id}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header bg-info text-white">
                                                            <h5 class="modal-title">
                                                                <i class="fas fa-exchange-alt me-2"></i>
                                                                Assign Another Cabin
                                                            </h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="current-selection mb-3 p-2 bg-light rounded">
                                                                <p class="mb-1"><strong>Current Request:</strong></p>
                                                                <p class="mb-1"><i class="fas fa-user me-2"></i> <c:out value="${request.username}"/></p>
                                                                <p class="mb-1"><i class="fas fa-calendar me-2"></i> <c:out value="${request.reqDate}"/></p>
                                                                <p class="mb-0"><i class="fas fa-home me-2"></i> <c:out value="${request.cabinName}"/> (Original Request)</p>
                                                            </div>

                                                            <form action="/requests" method="POST" class="needs-validation" novalidate>
                                                                <input type="hidden" name="action" value="assignOther">
                                                                <input type="hidden" name="requestId" value="${request.id}">
                                                                <div class="mb-3">
                                                                    <label for="cabinSelect-${request.id}" class="form-label">Select Alternative Cabin:</label>
                                                                    <select class="form-select" id="cabinSelect-${request.id}" name="cabinId" required>
                                                                        <c:choose>
                                                                            <c:when test="${not empty availableCabins}">
                                                                                <c:forEach var="cabin" items="${availableCabins}">
                                                                                    <option value="${cabin.id}">${cabin.name} (Capacity: ${cabin.capacity})</option>
                                                                                </c:forEach>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <option value="" disabled>No cabins available</option>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </select>
                                                                    <div class="form-text">
                                                                        <i class="fas fa-info-circle me-1"></i>
                                                                        Selecting a cabin will approve this request with the alternative cabin.
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                                        <i class="fas fa-times me-1"></i>Cancel
                                                                    </button>
                                                                    <button type="submit" class="btn btn-primary">
                                                                        <i class="fas fa-check me-1"></i>Assign Cabin
                                                                    </button>
                                                                </div>
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
                                <i class="fas fa-clipboard-check"></i>
                                <h4>No Pending Requests</h4>
                                <p class="text-muted">There are no cabin requests waiting for your approval at this time.</p>
                                <a href="admin_dashboard.jsp" class="btn btn-primary mt-3">
                                    <i class="fas fa-arrow-left me-2"></i>Return to Dashboard
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Status guide card -->
                <div class="card mt-4 mb-4">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-info-circle me-2"></i>Admin Actions Guide</h5>
                        <div class="row mt-3">
                            <div class="col-md-4">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="badge bg-success me-2">
                                        <i class="fas fa-check"></i>
                                    </span>
                                    <span><strong>Approve</strong>: Accept the cabin request as is</span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="badge bg-danger me-2">
                                        <i class="fas fa-times"></i>
                                    </span>
                                    <span><strong>Reject</strong>: Deny the cabin request</span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="badge bg-info me-2">
                                        <i class="fas fa-exchange-alt"></i>
                                    </span>
                                    <span><strong>Reassign</strong>: Offer a different cabin</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
        <script src="js/form_validation.js"></script>
        <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
        <script>
            <c:forEach var="request" items="${pendingRequests}">
                var assignOtherModal = document.getElementById('assignOtherModal-${request.id}');
                assignOtherModal.addEventListener('hidden.bs.modal', function (event) {
                    var cabinSelect = document.getElementById('cabinSelect-${request.id}');
                    cabinSelect.selectedIndex = 0; // Reset the dropdown on modal close
                });
            </c:forEach>
        </script>
    </c:when>
    <c:otherwise>
        <c:redirect url="login.jsp"/>
    </c:otherwise>
</c:choose>





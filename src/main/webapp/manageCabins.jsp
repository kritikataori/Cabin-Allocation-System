<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/manageCabins.css">
    <title>Manage Cabins</title>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />

            <div class="content">
                <div class="page-header">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3 class="mb-0">Manage Cabins</h3>
                            <a href="admin_dashboard.jsp" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                            </a>
                        </div>
                        <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#addCabinModal">
                            <i class="fas fa-plus me-2"></i>Add New Cabin
                        </button>
                    </div>
                </div>

                <div class="container cabin-container mt-4">
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success text-center shadow-sm" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <c:out value="${sessionScope.successMessage}"/>
                        </div>
                        <% session.removeAttribute("successMessage"); %>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger text-center shadow-sm" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <c:out value="${errorMessage}"/>
                        </div>
                    </c:if>

                    <div class="cabin-grid">
                        <c:forEach var="cabin" items="${allCabins}">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title"><c:out value="${cabin.name}"/></h5>

                                    <div class="card-text">
                                        <i class="fas fa-users"></i>
                                        <span>Capacity: <strong><c:out value="${cabin.capacity}"/></strong></span>
                                    </div>

                                    <div class="card-text">
                                        <i class="fas fa-circle-info"></i>
                                        <span>Status:</span>
                                        <div class="status-indicator">
                                            <span class="${cabin.status}"></span>
                                            <span class="badge bg-${cabin.status == 'available' ? 'success' : 'danger'}">
                                                <c:out value="${cabin.status}"/>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="card-actions">
                                        <button type="button" class="btn btn-action edit" data-bs-toggle="modal" data-bs-target="#editCabinModal-${cabin.id}">
                                            <i class="fas fa-edit me-1"></i> Edit
                                        </button>
                                        <form action="/manageCabins" method="POST" style="display: inline;" class="needs-validation" novalidate>
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="cabinId" value="${cabin.id}">
                                            <button type="submit" class="btn btn-action delete">
                                                <i class="fas fa-trash-alt me-1"></i> Delete
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- Edit Cabin Modal -->
                            <div class="modal fade" id="editCabinModal-${cabin.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">
                                                <i class="fas fa-edit me-2"></i>
                                                Update Cabin
                                            </h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="/manageCabins" method="POST" class="needs-validation" novalidate>
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="cabinId" value="${cabin.id}">
                                                <div class="mb-3">
                                                    <label for="cabinName-${cabin.id}" class="form-label">Name</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text"><i class="fas fa-tag"></i></span>
                                                        <input type="text" class="form-control" id="cabinName-${cabin.id}" name="cabinName" value="${cabin.name}" required>
                                                    </div>
                                                    <div class="invalid-feedback">Please enter a cabin name.</div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="capacity-${cabin.id}" class="form-label">Capacity</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text"><i class="fas fa-users"></i></span>
                                                        <input type="number" class="form-control" id="capacity-${cabin.id}" name="capacity" value="${cabin.capacity}" required>
                                                    </div>
                                                    <div class="invalid-feedback">Please enter capacity.</div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="status-${cabin.id}" class="form-label">Status</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text"><i class="fas fa-info-circle"></i></span>
                                                        <select class="form-select" id="status-${cabin.id}" name="status" required>
                                                            <option value="available" ${cabin.status == 'available' ? 'selected' : ''}>Available</option>
                                                            <option value="occupied" ${cabin.status == 'occupied' ? 'selected' : ''}>Occupied</option>
                                                        </select>
                                                    </div>
                                                    <div class="invalid-feedback">Please select a status.</div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                        <i class="fas fa-times me-1"></i>Close
                                                    </button>
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="fas fa-save me-1"></i>Save Changes
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Add New Cabin Modal -->
                    <div class="modal fade" id="addCabinModal" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">
                                        <i class="fas fa-plus me-2"></i>
                                        Add New Cabin
                                    </h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="/manageCabins" method="POST" class="needs-validation" novalidate>
                                        <input type="hidden" name="action" value="create">
                                        <div class="mb-3">
                                            <label for="cabinName" class="form-label">Name</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-tag"></i></span>
                                                <input type="text" class="form-control" id="cabinName" name="cabinName" placeholder="Enter cabin name" required>
                                            </div>
                                            <div class="invalid-feedback">Please enter a cabin name.</div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="capacity" class="form-label">Capacity</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-users"></i></span>
                                                <input type="number" class="form-control" id="capacity" name="capacity" placeholder="Enter capacity" required>
                                            </div>
                                            <div class="invalid-feedback">Please enter capacity.</div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Status</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-info-circle"></i></span>
                                                <select class="form-select" id="status" name="status" required>
                                                    <option value="" disabled selected>Select status</option>
                                                    <option value="available">Available</option>
                                                    <option value="occupied">Occupied</option>
                                                </select>
                                            </div>
                                            <div class="invalid-feedback">Please select a status.</div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                <i class="fas fa-times me-1"></i>Close
                                            </button>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-plus me-1"></i>Add Cabin
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="includes/footer.jsp" />
            <script src="js/form_validation.js"></script>
            <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
        </c:when>
        <c:otherwise>
            <c:redirect url="login.jsp"/>
        </c:otherwise>
    </c:choose>
</body>
</html>
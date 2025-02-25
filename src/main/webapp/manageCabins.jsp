<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Cabins</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/adminstyles.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp"/>
    <div class="container-fluid py-4">
        <h2 class="mb-4">Manage Cabins</h2>

        <div class="mb-4">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCabinModal">
                <i class="fas fa-plus me-2"></i>Add New Cabin
            </button>
        </div>

        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Capacity</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cabin" items="${cabins}">
                        <tr>
                            <td><c:out value="${cabin.id}"/></td>
                            <td><c:out value="${cabin.name}"/></td>
                            <td><c:out value="${cabin.capacity}"/></td>
                            <td><c:out value="${cabin.status}"/></td>
                            <td>
                                <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editCabinModal-${cabin.id}">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <form action="/manageCabins" method="POST" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="cabinId" value="${cabin.id}">
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>

                        <div class="modal fade" id="editCabinModal-${cabin.id}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit Cabin</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="/manageCabins" method="POST">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="cabinId" value="${cabin.id}">
                                            <div class="mb-3">
                                                <label for="cabinName-${cabin.id}" class="form-label">Name</label>
                                                <input type="text" class="form-control" id="cabinName-${cabin.id}" name="cabinName" value="${cabin.name}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="capacity-${cabin.id}" class="form-label">Capacity</label>
                                                <input type="number" class="form-control" id="capacity-${cabin.id}" name="capacity" value="${cabin.capacity}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="status-${cabin.id}" class="form-label">Status</label>
                                                <select class="form-select" id="status-${cabin.id}" name="status" required>
                                                    <option value="available" ${cabin.status == 'available' ? 'selected' : ''}>Available</option>
                                                    <option value="occupied" ${cabin.status == 'occupied' ? 'selected' : ''}>Occupied</option>
                                                </select>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Save Changes</button>
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

        <div class="modal fade" id="addCabinModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New Cabin</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/manageCabins" method="POST">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-3">
                                <label for="cabinName" class="form-label">Name</label>
                                <input type="text" class="form-control" id="cabinName" name="cabinName" required>
                            </div>
                            <div class="mb-3">
                                <label for="capacity" class="form-label">Capacity</label>
                                <input type="number" class="form-control" id="capacity" name="capacity" required>
                            </div>
                            <div class="mb-3">
                                <label for="status" class="form-label">Status</label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="available">Available</option>
                                    <option value="occupied">Occupied</option>
                                </select>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Add Cabin</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="includes/footer.jsp"/>
<script src="bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="js/form_validation.js"></script>
</body>
</html>
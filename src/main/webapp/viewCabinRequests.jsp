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
    <title>View Cabin Requests</title>
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp" />

    <div class="container-fluid py-4">
        <h2 class="mb-4">View Cabin Requests</h2>

        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>Name</th>
                        <th>Request Date</th>
                        <th>Duration</th>
                        <th>Cabin Requested</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="request" items="${pendingRequests}">
                        <tr>
                            <td><c:out value="${request.empId}"/></td>
                            <td><c:out value="${request.username}"/></td>
                            <td><c:out value="${request.reqDate}"/></td>
                            <td><c:out value="${request.startTime}"/> - <c:out value="${request.endTime}"/></td>
                            <td><c:out value="${request.cabinName}"/></td>
                            <td><span class="badge bg-warning status-badge"><c:out value="${request.status}"/></span></td>
                            <td>
                                <form action="/requests" method="POST" style="display: inline;">
                                    <input type="hidden" name="action" value="approve">
                                    <input type="hidden" name="requestId" value="${request.id}">
                                    <button type="submit" class="btn btn-success btn-sm" title="Approve">
                                        <i class="fas fa-check"></i>
                                    </button>
                                </form>

                                <form action="/requests" method="POST" style="display: inline;">
                                    <input type="hidden" name="action" value="reject">
                                    <input type="hidden" name="requestId" value="${request.id}">
                                    <button type="submit" class="btn btn-danger btn-sm" title="Reject">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </form>

                                <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#assignOtherModal-${request.id}" title="Assign Other">
                                    <i class="fas fa-exchange-alt"></i>
                                </button>
                            </td>
                        </tr>

                        <div class="modal fade" id="assignOtherModal-${request.id}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Assign Other Cabin</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="/requests" method="POST">
                                            <input type="hidden" name="action" value="assignOther">
                                            <input type="hidden" name="requestId" value="${request.id}">
                                            <div class="mb-3">
                                                <label for="cabinSelect-${request.id}" class="form-label">Select Cabin</label>
                                                <select class="form-select" id="cabinSelect-${request.id}" name="cabinId" required>
                                                    <c:forEach var="cabin" items="${availableCabins}">
                                                        <option value="${cabin.id}">${cabin.name} (Capacity: ${cabin.capacity})</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Assign</button>
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
    </div>

    <jsp:include page="includes/footer.jsp" />
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script>
        <c:forEach var="request" items="${pendingRequests}">
            var assignOtherModal = document.getElementById('assignOtherModal-${request.id}');
            assignOtherModal.addEventListener('hidden.bs.modal', function (event) {
                var cabinSelect = document.getElementById('cabinSelect-${request.id}');
                cabinSelect.selectedIndex = 0; // Reset the dropdown on modal close
            });
        </c:forEach>
    </script>
</body>
</html>
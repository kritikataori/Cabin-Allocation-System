<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.yash.cabinallotment.domain.Allocations" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Cabin</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/requestCabin.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <jsp:include page="includes/header.jsp" />

                <div class="page-header">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3>Request a Cabin</h3>
                            <a href="employee_dashboard.jsp" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                            </a>
                        </div>
                    </div>
                </div>

                <div class="container">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                            <c:out value="${errorMessage}"/>
                        </div>
                    </c:if>

                    <div class="form-container">
                        <form action="/requests" method="POST" class="needs-validation" novalidate>
                            <input type="hidden" name="action" value="create">
                            <input type="hidden" name="empId" value="${sessionScope.user.id}">

                            <div class="row mb-4">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Employee Name</label>
                                    <input type="text" class="form-control" value="${sessionScope.user.username}" readonly>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Cabin Name</label>
                                    <select class="form-select" name="cabinId" required>
                                        <option value="">Select a cabin</option>
                                        <c:forEach var="cabin" items="${allCabins}">
                                            <c:set var="isAssigned" value="${assignedCabinIds.contains(cabin.id)}" />
                                            <c:set var="isNotAvailable" value="${cabin.status != 'available'}" />
                                            <option value="${cabin.id}"
                                                    ${selectedCabin != null && selectedCabin.id == cabin.id ? 'selected' : ''}
                                                    ${isAssigned || isNotAvailable ? 'disabled' : ''}>
                                                <c:out value="${cabin.name}"/>
                                                ${isAssigned || isNotAvailable ? ' (Not Available)' : ''}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Please select a cabin.</div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Request Date</label>
                                    <input type="date" class="form-control" name="reqDate" pattern="\d{4}-\d{2}-\d{2}" required>
                                    <div class="invalid-feedback">Please select a valid date.</div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Start Time</label>
                                    <input type="time" class="form-control" name="startTime" required>
                                    <div class="invalid-feedback">Please select a start time.</div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">End Time</label>
                                    <input type="time" class="form-control" name="endTime" required>
                                    <div class="invalid-feedback">Please select an end time.</div>
                                </div>
                            </div>

                            <p class="text-muted"> <i class="fas fa-circle-info me-1"></i> Cabin bookings must be for a minimum of 5 minutes.</p>

                            <div class="mt-4">
                                <button type="submit" class="btn btn-primary">
                                    Submit Request
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
                <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="js/form_validation.js"></script>
                <script>
                    // Add date validation for request date
                    document.addEventListener('DOMContentLoaded', function() {
                        const today = new Date();
                        const dd = String(today.getDate()).padStart(2, '0');
                        const mm = String(today.getMonth() + 1).padStart(2, '0');
                        const yyyy = today.getFullYear();

                        const todayString = yyyy + '-' + mm + '-' + dd;
                        document.querySelector('input[name="reqDate"]').setAttribute('min', todayString);

                        // Time validation
                        const startTime = document.querySelector('input[name="startTime"]');
                        const endTime = document.querySelector('input[name="endTime"]');

                        endTime.addEventListener('change', function() {
                            if(startTime.value && endTime.value && startTime.value >= endTime.value) {
                                endTime.setCustomValidity('End time must be after start time');
                            } else {
                                endTime.setCustomValidity('');
                            }
                        });

                        startTime.addEventListener('change', function() {
                            if(endTime.value && startTime.value && startTime.value >= endTime.value) {
                                endTime.setCustomValidity('End time must be after start time');
                            } else {
                                endTime.setCustomValidity('');
                            }
                        });
                    });
                </script>
            </c:when>
            <c:otherwise>
                <c:redirect url="login.jsp"/>
            </c:otherwise>
        </c:choose>
</body>
</html>
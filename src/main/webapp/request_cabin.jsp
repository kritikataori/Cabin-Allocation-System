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
    <link href="css/empstyles.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />

            <div class="container mt-4">
                <h3 class="mb-4">Request a Cabin</h3>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger text-center error-message" role="alert">
                        <c:out value="${errorMessage}"/>
                    </div>
                </c:if>

                <form action="/requests" method="POST" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="empId" value="${sessionScope.user.id}">
                    <div class="row">
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
                                   </option>
                               </c:forEach>

                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Request Date</label>
                            <input type="date" class="form-control" name="reqDate" pattern="\d{4}-\d{2}-\d{2}" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Start Time</label>
                            <input type="time" class="form-control" name="startTime" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">End Time</label>
                            <input type="time" class="form-control" name="endTime" required>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane me-2"></i>Submit Request
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
            <script src="js/form_validation.js"></script>
        </c:when>
        <c:otherwise>
            <c:redirect url="login.jsp"/>
        </c:otherwise>
    </c:choose>
</body>
</html>
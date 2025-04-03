<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Cabins</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/viewCabins.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />
            <div class="content">
                <div class="page-header">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3><i class="fas fa-home me-2"></i>Available Cabins</h3>
                            <a href="employee_dashboard.jsp" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                            </a>
                        </div>
                    </div>
                </div>

                <div class="container">
                    <div class="filter-bar">
                        <div class="row align-items-center mb-2">
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" id="cabinSearch" class="form-control" placeholder="Search cabins...">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="text-md-end mt-2 mt-md-0">
                                    <span class="me-2"><i class="fas fa-info-circle"></i> Click on a cabin to select it</span>
                                </div>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <form action="/requests" method="GET" class="row align-items-center">
                                <div class="col-md-12 mt-2">
                                    <button type="button" class="btn btn-secondary availability-check-btn" data-bs-toggle="modal" data-bs-target="#availabilityModal">
                                        <i class="fas fa-calendar-alt me-2"></i> Filter Cabins
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <c:if test="${empty allCabins}">
                        <div class="no-cabins">
                            <i class="fas fa-mountain"></i>
                            <p>No cabins are currently available. Please check back later.</p>
                        </div>
                    </c:if>

                    <c:if test="${param.reqDate != null && empty availableFilteredCabins}">
                        <div class="no-cabins">
                            <i class="fas fa-mountain"></i>
                            <p>No cabins are available for the selected date and time. Please try a different time.</p>
                        </div>
                    </c:if>

                    <div id="noCabinsFound" style="display: none; text-align: center; padding: 20px; font-size: 1.2em; color: #888;">
                        <i class="fas fa-search-minus"></i>
                        <p>No cabins found matching your search.</p>
                    </div>

                    <div class="row" id="cabinsContainer">
                        <c:choose>
                            <c:when test="${not empty availableFilteredCabins}">
                                <c:forEach var="cabin" items="${availableFilteredCabins}">
                                    <div class="col-lg-4 col-md-6 cabin-item mb-3">
                                        <div class="cabin-card">
                                            <div class="card-img-container">
                                                <img src="${cabin.cabinImageUrl}" class="card-img-top" alt="Cabin Image">
                                            </div>
                                            <div class="card-body">
                                                <div class="status-badge ${cabin.status == 'available' ? 'available' : 'unavailable'}">
                                                    <i class="fas fa-circle me-1 ${cabin.status == 'available' ? 'text-success' : 'text-danger'}"></i>
                                                    <c:out value="${cabin.status}"/>
                                                </div>

                                                <h5 class="card-title"><c:out value="${cabin.name}"/></h5>

                                                <div class="cabin-info">
                                                    <div class="info-item">
                                                        <i class="fas fa-users"></i>
                                                        <span>Capacity: <c:out value="${cabin.capacity}"/></span>
                                                    </div>
                                                </div>

                                                <c:if test="${cabin.status != 'available'}">
                                                    <div class="next-available-time">
                                                        <strong>Next Available Time:</strong>
                                                        <c:out value="${cabin.nextAvailableTime != null ? cabin.nextAvailableTime : 'N/A'}"/>
                                                    </div>
                                                </c:if>

                                                <c:set var="isAssigned" value="${assignedCabinIds.contains(cabin.id)}" />
                                                <c:set var="isNotAvailable" value="${cabin.status != 'available'}" />

                                                <form action="/requests?timestamp=${System.currentTimeMillis()}" method="GET">
                                                    <input type="hidden" name="action" value="requestCabin">
                                                    <input type="hidden" name="cabinId" value="${cabin.id}">
                                                    <button type="submit" class="btn btn-primary book-btn" ${isNotAvailable ? 'disabled' : ''}>
                                                        <i class="fas fa-calendar-check me-1"></i>
                                                        ${isNotAvailable ? 'Not Available' : 'Book Now'}
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="cabin" items="${allCabins}">
                                    <div class="col-lg-4 col-md-6 cabin-item mb-3">
                                        <div class="cabin-card">
                                            <div class="card-img-container">
                                                <img src="${cabin.cabinImageUrl}" class="card-img-top" alt="Cabin Image">
                                            </div>
                                            <div class="card-body">
                                                <div class="status-badge ${cabin.status == 'available' ? 'available' : 'unavailable'}">
                                                    <i class="fas fa-circle me-1 ${cabin.status == 'available' ? 'text-success' : 'text-danger'}"></i>
                                                    <c:out value="${cabin.status}"/>
                                                </div>

                                                <h5 class="card-title"><c:out value="${cabin.name}"/></h5>

                                                <div class="cabin-info">
                                                    <div class="info-item">
                                                        <i class="fas fa-users"></i>
                                                        <span>Capacity: <c:out value="${cabin.capacity}"/></span>
                                                    </div>
                                                </div>

                                                <c:if test="${cabin.status != 'available'}">
                                                    <div class="next-available-time">
                                                        <strong>Next Available Time:</strong>
                                                        <c:out value="${cabin.nextAvailableTime != null ? cabin.nextAvailableTime : 'N/A'}"/>
                                                    </div>
                                                </c:if>

                                                <c:set var="isAssigned" value="${assignedCabinIds.contains(cabin.id)}" />
                                                <c:set var="isNotAvailable" value="${cabin.status != 'available'}" />

                                                <form action="/requests?timestamp=${System.currentTimeMillis()}" method="GET">
                                                    <input type="hidden" name="action" value="requestCabin">
                                                    <input type="hidden" name="cabinId" value="${cabin.id}">
                                                    <button type="submit" class="btn btn-primary book-btn" ${isNotAvailable ? 'disabled' : ''}>
                                                        <i class="fas fa-calendar-check me-1"></i>
                                                        ${isNotAvailable ? 'Not Available' : 'Book Now'}
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="availabilityModal" tabindex="-1" aria-labelledby="availabilityModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="availabilityModalLabel">
                                <i class="fas fa-calendar-check me-2"></i>Check Cabin Availability
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="/requests" method="GET">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="checkAvailability">

                                <div class="mb-3">
                                    <label for="reqDate" class="form-label">
                                        <i class="fas fa-calendar-day me-2"></i>Select Date
                                    </label>
                                    <input type="date" class="form-control" id="reqDate" name="reqDate" value="${param.reqDate}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="startTime" class="form-label">
                                        <i class="fas fa-hourglass-start me-2"></i>Start Time
                                    </label>
                                    <input type="time" class="form-control" id="startTime" name="startTime" value="${param.startTime}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="endTime" class="form-label">
                                        <i class="fas fa-hourglass-end me-2"></i>End Time
                                    </label>
                                    <input type="time" class="form-control" id="endTime" name="endTime" value="${param.endTime}" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                    <i class="fas fa-times me-2"></i>Cancel
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Find Available Cabins
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
            <script>
                // Cabin card selection
                document.querySelectorAll('.cabin-card').forEach(card => {
                    card.addEventListener('click', function(e) {
                        // Do not select if clicking on the button
                        if (e.target.tagName === 'BUTTON' || e.target.closest('button')) {
                            return;
                        }
                        document.querySelectorAll('.cabin-card').forEach(c => c.classList.remove('selected'));
                        this.classList.add('selected');
                    });
                });

                // Simple search functionality
                document.getElementById('cabinSearch').addEventListener('keyup', function() {
                    let searchTerm = this.value.toLowerCase();
                    let cabinItems = document.querySelectorAll('.cabin-item');
                    let found = false; // Flag to track if any cabins are found

                    cabinItems.forEach(item => {
                        const cabinName = item.querySelector('.card-title').textContent.toLowerCase();
                        if (cabinName.includes(searchTerm)) {
                            item.style.display = 'block';
                            found = true;
                        } else {
                            item.style.display = 'none';
                        }
                    });

                    // Display/hide the no cabins found message
                    if (found) {
                        document.getElementById('noCabinsFound').style.display = 'none';
                    } else {
                        document.getElementById('noCabinsFound').style.display = 'block';
                    }
                });

                setTimeout(function() {
                    document.querySelector('.availability-check-btn').classList.add('pulse-animation');
                }, 2000);
            </script>
        </c:when>
        <c:otherwise>
            <c:redirect url="login.jsp"/>
        </c:otherwise>
    </c:choose>
</body>
</html>
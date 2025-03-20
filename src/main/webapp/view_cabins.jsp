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
                        <div class="row align-items-center">
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
                    </div>

                    <c:if test="${empty allCabins}">
                        <div class="no-cabins">
                            <i class="fas fa-mountain"></i>
                            <p>No cabins are currently available. Please check back later.</p>
                        </div>
                    </c:if>

                    <div id="noCabinsFound" style="display: none; text-align: center; padding: 20px; font-size: 1.2em; color: #888;">
                        <i class="fas fa-search-minus"></i>
                        <p>No cabins found matching your search.</p>
                    </div>

                    <div class="row" id="cabinsContainer">
                        <c:forEach var="cabin" items="${allCabins}">
                            <div class="col-lg-4 col-md-6 cabin-item mb-3">
                                <div class="cabin-card">
                                    <div class="card-img-container">
                                        <img src="<c:out value="${cabin.getImageUrl()}"/>" class="card-img-top" alt="Cabin Image">
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
            </script>
        </c:when>
        <c:otherwise>
            <c:redirect url="login.jsp"/>
        </c:otherwise>
    </c:choose>
</body>
</html>
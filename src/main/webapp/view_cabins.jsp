<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Cabins</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/empstyles.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />
            <div class="container mt-4">
                <h3 class="mb-4">Available Cabins</h3>
                <div class="row">
                    <c:if test="${empty availableCabins}">
                        <p>No cabins found.</p>
                    </c:if>
                    <c:forEach var="cabin" items="${availableCabins}">
                        <div class="col-md-4 mb-3">
                            <div class="card cabin-card">
                                <div class="card-img-container">
                                    <img src="img/employeedashboard/viewCabins/img1.jpg" class="card-img-top" alt="Cabin Image">
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title"><c:out value="${cabin.name}"/></h5>
                                    <p class="card-text">
                                        <i class="fas fa-users me-2"></i>Capacity: <c:out value="${cabin.capacity}"/> people<br>
                                        <i class="fas fa-circle <c:out value="${cabin.status == 'AVAILABLE' ? 'text-success' : 'text-danger'}"/> me-2"></i>Status: <c:out value="${cabin.status}"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
            <script>
                // Cabin card selection
                document.querySelectorAll('.cabin-card').forEach(card => {
                    card.addEventListener('click', function() {
                        document.querySelectorAll('.cabin-card').forEach(c => c.classList.remove('selected'));
                        this.classList.add('selected');
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
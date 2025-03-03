<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/empstyles.css" rel="stylesheet">
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <jsp:include page="includes/header.jsp" />
                <div class="container emp-container">

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success text-center error-message mt-3" role="alert">
                            <c:out value="${successMessage}"/>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger text-center error-message mt-3" role="alert">
                            <c:out value="${errorMessage}"/>
                        </div>
                    </c:if>

                    <%
                      request.removeAttribute("successMessage");
                      request.removeAttribute("errorMessage");
                    %>

                    <h2 class="mb-4 mt-4 text-center">Employee Dashboard</h2>
                    <div class="d-flex flex-column justify-content-center align-items-center">
                        <div class="mb-3">
                            <form action="<c:url value='/view_cabins'/>" method="GET" class="needs-validation" novalidate>
                                <button type="submit" class="btn btn-lg btn-primary dashboard-btn">
                                    View All Cabins
                                </button>
                            </form>
                        </div>
                        <div class="mb-3">
                            <form action="<c:url value='/requests'/>" method="GET" class="needs-validation" novalidate>
                                <button type="submit" class="btn btn-lg btn-success dashboard-btn">
                                    Request a Cabin
                                </button>
                            </form>
                        </div>
                        <div class="mb-3">
                            <form action="<c:url value='/request_status'/>" method="GET" class="needs-validation" novalidate>
                                <button type="submit" class="btn btn-lg btn-info dashboard-btn">
                                    View Request Status
                                </button>
                            </form>
                        </div>
                        <div class="mb-3">
                            <form action="admin_request.jsp" method="POST" class="needs-validation" novalidate>
                                <button type="submit" class="btn btn-lg btn-warning dashboard-btn">
                                    Request Admin Access
                                </button>
                            </form>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Status</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/empstyles.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="includes/header.jsp"/>
    <div class="container mt-4">
        <h3 class="mb-4">Request Status</h3>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Request ID</th>
                        <th>Cabin</th>
                        <th>Request Date</th>
                        <th>Duration</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="request" items="${userRequests}">
                        <tr>
                            <td>#REQ<c:out value="${request.id}"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty request.cabinName}">
                                        <c:out value="${request.cabinName}"/>
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${request.reqDate}"/></td>
                            <td><c:out value="${request.startTime}"/> - <c:out value="${request.endTime}"/></td>
                            <td><span class="badge bg-success"><c:out value="${request.status}"/></span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <jsp:include page="includes/footer.jsp"/>
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
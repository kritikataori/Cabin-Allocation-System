<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/app.css">
    <title>Cabin Allocation</title>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <c:if test="${not empty accessDeniedError}">
        <div class="alert alert-danger text-center error-message" role="alert">
            <c:out value="${accessDeniedError}" />
        </div>
    </c:if>

    <!-- Carousel -->
    <div id="cabinsCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="img/landingpage/img1.jpg" class="d-block w-100 img-fluid" alt="Office Cabin 1">
                <div class="hero-text">
                    <a href="<c:url value='/view_cabins'/>" class="btn btn-transparent"><h2>Book Your Cabin Now</h2></a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="img/landingpage/img2.jpg" class="d-block w-100 img-fluid" alt="Office Cabin 2">
                <div class="hero-text">
                    <a href="<c:url value='/view_cabins'/>" class="btn btn-transparent"><h2>Book Your Cabin Now</h2></a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="img/landingpage/img3.jpg" class="d-block w-100 img-fluid" alt="Office Cabin 3">
                <div class="hero-text">
                    <a href="<c:url value='/view_cabins'/>" class="btn btn-transparent"><h2>Book Your Cabin Now</h2></a>                </div>
            </div>
            <div class="carousel-item">
                <img src="img/landingpage/img4.jpg" class="d-block w-100 img-fluid" alt="Office Cabin 4">
                <div class="hero-text">
                    <a href="<c:url value='/view_cabins'/>" class="btn btn-transparent"><h2>Book Your Cabin Now</h2></a>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#cabinsCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#cabinsCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <!-- About Section -->
    <div class="about-section text-center">
        <div class="container">
            <h2>About Us</h2>
            <p>At Yash, we understand the importance of a productive workspace. That is why we offer premium office cabins tailored to your needs. Book now to elevate your business environment!</p>

            <!-- Flashcard Images Section -->
            <div class="row justify-content-center mt-5">
                <div class="col-md-4">
                    <div class="card text-center mb-4" style="border: none; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);">
                        <img src="img/landingpage/desk.jpg" class="card-img-top" style="border-radius: 8px;">
                        <div class="card-body">
                            <h5 class="card-title">Smart Technology Integration</h5>
                            <p class="card-text">Smart TVs, Smart Lighting, Virtual Assistant Devices</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center mb-4" style="border: none; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);">
                        <img src="img/landingpage/amenities.jpg" class="card-img-top" alt="Office" style="border-radius: 8px;">
                        <div class="card-body">
                            <h5 class="card-title">Premium Amenities</h5>
                            <p class="card-text">Whiteboard Walls, Interactive displays, Modular Furniture</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center mb-4" style="border: none; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);">
                        <img src="img/landingpage/garden.jpg" class="card-img-top" alt="Event" style="border-radius: 8px;">
                        <div class="card-body">
                            <h5 class="card-title">Comfort</h5>
                            <p class="card-text">Natural Greenery, Quiet Zones, Recreation Facilities</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Contact Us Section -->
    <div class="container my-5 contact">
        <h2 class="text-center mb-3" style="color: #343a40;">Contact Us</h2>
        <div class="row justify-content-center">
            <div class="col">
                <div class="p-3" style="background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);">
                    <form class="needs-validation" novalidate>
                        <div class="mb-2 row">
                            <div class="col">
                                <label for="name" class="form-label" style="font-size: 0.9rem; color: #343a40;">Name</label>
                                <input type="text" class="form-control form-control-sm" id="name" required style="border-radius: 5px;">
                            </div>
                            <div class="col">
                                <label for="email" class="form-label" style="font-size: 0.9rem; color: #343a40;">Email</label>
                                <input type="email" class="form-control form-control-sm" id="email" required style="border-radius: 5px;">
                            </div>
                        </div>
                        <div class="mb-2">
                            <label for="message" class="form-label" style="font-size: 0.9rem; color: #343a40;">Message</label>
                            <textarea class="form-control form-control-sm" id="message" rows="2" required style="border-radius: 5px;"></textarea>
                        </div>
                        <div>
                            <button type="submit" class="btn btn-success w-100" style="border-radius: 5px;">Send</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script src="js/form_validation.js"></script>
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
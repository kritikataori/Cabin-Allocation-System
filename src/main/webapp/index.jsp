<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/app.css">
    <title>Cabin Allocation System</title>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <c:if test="${not empty accessDeniedError}">
        <div class="alert alert-danger text-center shadow-sm" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <c:out value="${accessDeniedError}" />
        </div>
    </c:if>

    <!-- Hero Carousel -->
    <div id="cabinsCarousel" class="carousel slide hero-carousel" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="img/landingpage/img1.jpg" class="d-block w-100" alt="Office Cabin 1">
                <div class="hero-text">
                    <h1>Elevate Your Workspace Experience</h1>
                    <p>Discover premium office cabins designed for productivity and comfort</p>
                    <a href="<c:url value='/view_cabins'/>" class="btn btn-hero">
                        <i class="fas fa-door-open me-2"></i>Book Your Cabin Now
                    </a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="img/landingpage/img2.jpg" class="d-block w-100" alt="Office Cabin 2">
                <div class="hero-text">
                    <h1>Smart Spaces for Smart Professionals</h1>
                    <p>State-of-the-art cabins with all the amenities you need</p>
                    <a href="<c:url value='/view_cabins'/>" class="btn btn-hero">
                        <i class="fas fa-door-open me-2"></i>Book Your Cabin Now
                    </a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="img/landingpage/img3.jpg" class="d-block w-100" alt="Office Cabin 3">
                <div class="hero-text">
                    <h1>Focus. Collaborate. Succeed.</h1>
                    <p>The perfect environment for your next big idea</p>
                    <a href="<c:url value='/view_cabins'/>" class="btn btn-hero">
                        <i class="fas fa-door-open me-2"></i>Book Your Cabin Now
                    </a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="img/landingpage/img4.jpg" class="d-block w-100" alt="Office Cabin 4">
                <div class="hero-text">
                    <h1>Your Private Space Awaits</h1>
                    <p>Book a cabin that suits your style and requirements</p>
                    <a href="<c:url value='/view_cabins'/>" class="btn btn-hero">
                        <i class="fas fa-door-open me-2"></i>Book Your Cabin Now
                    </a>
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

    <!-- Features Section -->
    <div class="features-section">
        <div class="container">
            <h2 class="section-title text-center">Premium Features</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card card">
                        <img src="img/landingpage/desk.jpg" class="card-img-top" alt="Smart Technology">
                        <div class="card-body text-center">
                            <div class="feature-icon">
                                <i class="fas fa-laptop"></i>
                            </div>
                            <h5 class="card-title">Smart Technology Integration</h5>
                            <p class="card-text">Experience seamless connectivity with smart TVs, intelligent lighting systems, and virtual assistant devices designed to boost your productivity.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card card">
                        <img src="img/landingpage/amenities.jpg" class="card-img-top" alt="Premium Amenities">
                        <div class="card-body text-center">
                            <div class="feature-icon">
                                <i class="fas fa-clipboard-list"></i>
                            </div>
                            <h5 class="card-title">Premium Amenities</h5>
                            <p class="card-text">Transform any meeting with whiteboard walls, interactive displays, and modular furniture that adapts to your specific needs and preferences.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card card">
                        <img src="img/landingpage/garden.jpg" class="card-img-top" alt="Comfort">
                        <div class="card-body text-center">
                            <div class="feature-icon">
                                <i class="fas fa-leaf"></i>
                            </div>
                            <h5 class="card-title">Comfort & Wellbeing</h5>
                            <p class="card-text">Enjoy the perfect balance of work and relaxation with natural greenery, quiet zones, and recreational facilities designed for your wellbeing.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- About Section -->
    <div class="about-section">
        <div class="container">
            <h2 class="section-title text-center">About Us</h2>
            <div class="about-content text-center">
                <p class="lead mb-4">At Yash, we understand the importance of a productive workspace. Our mission is to provide premium office cabins that boost creativity, focus, and collaboration.</p>
                <p>With years of experience in workspace design, we've crafted environments that meet the diverse needs of professionals across industries. Whether you need a quiet space for focused work or a collaborative environment for team meetings, our cabins are tailored to elevate your business experience.</p>
            </div>
        </div>
    </div>

    <!-- Contact Us Section -->
    <div class="contact-section">
        <div class="container">
            <h2 class="section-title text-center">Contact Us</h2>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="contact-form">
                        <form class="needs-validation" novalidate>
                            <div class="row mb-3">
                                <div class="col-md-6 mb-3 mb-md-0">
                                    <label for="name" class="form-label">Full Name</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" class="form-control" id="name" placeholder="Enter your name" required>
                                    </div>
                                    <div class="invalid-feedback">
                                        Please provide your name.
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input type="email" class="form-control" id="email" placeholder="Enter your email" required>
                                    </div>
                                    <div class="invalid-feedback">
                                        Please provide a valid email.
                                    </div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label for="message" class="form-label">Message</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-comment"></i></span>
                                    <textarea class="form-control" id="message" rows="4" placeholder="Enter your message" required></textarea>
                                </div>
                                <div class="invalid-feedback">
                                    Please provide a message.
                                </div>
                            </div>
                            <button type="submit" class="btn btn-submit">
                                <i class="fas fa-paper-plane me-2"></i>Send Message
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script src="js/form_validation.js"></script>
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
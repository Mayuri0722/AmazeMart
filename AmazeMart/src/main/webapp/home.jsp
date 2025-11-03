<%@ page language="java" contentType="text/html; charset=UTF-8" session="true" %>
<%@ page import="java.sql.*, dao.DBConnection" %>
<%
    HttpSession Session = request.getSession(false);
    boolean loggedIn = false;
    String userName = "";
    if (session != null && session.getAttribute("name") != null) {
        loggedIn = true;
        userName = (String) session.getAttribute("name");
    }

    // load categories
    Connection conn = DBConnection.getConnection();
    PreparedStatement catPs = conn.prepareStatement("SELECT DISTINCT category FROM products");
    ResultSet catRs = catPs.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>AmazeMart - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { margin:0; font-family: 'Segoe UI', sans-serif; background: #f6f6f6; }
        .navbar { background: #343a40; padding: 12px 24px; }
        .navbar-brand, .nav-link { color: white !important; font-weight:500; }
        .nav-link:hover { color: #ffd700 !important; }
        .hero { background: linear-gradient(120deg, #4e73df, #1cc88a); color: white; text-align:center; padding:80px 20px; }
        .hero h1 { font-size:3rem; margin-bottom:10px; }
        .hero p { font-size:1.2rem; }
        .hero .btn { margin:8px; }
        .search-area { padding:40px 0; text-align:center; }
        .categories { background: white; padding:40px 0; }
        .category-card { display:inline-block; margin:0 12px 16px; padding:20px 30px; background:#fff; border-radius:10px;
            box-shadow:0 2px 8px rgba(0,0,0,0.1); font-size:1.1rem; cursor:pointer; transition:0.2s; }
        .category-card:hover, .category-card.selected { background:#0d6efd; color:white; }
        .carousel-item img { height:300px; object-fit:cover; }
        .testimonials, .newsletter { padding:50px 20px; }
        .testimonial-card { max-width:400px; margin:auto; }
        .footer { background:#343a40; color:#ddd; padding:30px 0; }
        .footer a { color:#ccc; text-decoration:none; }
        .footer a:hover { color:white; }
        .category-card {
    display: inline-block;
    margin: 0 12px 16px;
    padding: 12px 28px;
    background: white;
    border: 2px solid #0d6efd;
    border-radius: 50px;
    font-size: 1rem;
    color: #0d6efd;
    font-weight: 600;
    text-decoration: none;
    transition: 0.3s ease;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.category-card:hover {
    background-color: #0d6efd;
    color: white;
}

.category-card.selected {
    background-color: #0d6efd;
    color: white;
    box-shadow: 0 0 10px rgba(13, 110, 253, 0.4);
}
        
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="home.jsp">AmazeMart</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <% if (loggedIn) { %>
                    <li class="nav-item"><span class="nav-link">Hi, <%= userName %></span></li>
                    <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="trackOrders.jsp">Track Order</a></li>
                    <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="hero">
    <h1>Welcome to <span style="color:#ffd700;">AmazeMart</span></h1>
    <p>Discover amazing products at unbeatable prices</p>
    <a href="#categories" class="btn btn-light">Shop Now</a>
    <a href="#featured" class="btn btn-outline-light">View Deals</a>
</div>

<section class="search-area">
    <form method="get" action="home.jsp" class="d-flex justify-content-center">
        <input type="text" name="search" class="form-control w-50" placeholder="Search for products..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
        <button type="submit" class="btn btn-primary ms-2">Search</button>
    </form>
</section>

<section class="categories" id="categories">
    <h2 class="text-center mb-4">Shop by Category</h2>
    <div class="text-center">
        <% while (catRs.next()) {
             String cat = catRs.getString("category");
             boolean selected = cat.equals(request.getParameter("category"));
        %>
            <a href="home.jsp?category=<%= java.net.URLEncoder.encode(cat, "UTF-8") %>" class="category-card<%= selected ? " selected" : "" %>">
                <%= cat %>
            </a>
        <% } %>
    </div>
</section>

<section id="featured" class="featured-products py-5">
    <h2 class="text-center mb-4">Featured Products</h2>
    <div id="productCarousel" class="carousel slide container" data-bs-ride="carousel">
        <div class="carousel-inner">
            <%
                // load up to 5 featured products
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM products ORDER BY id DESC LIMIT 5");
                ResultSet rs = ps.executeQuery();
                int idx = 0;
                while (rs.next()) {
                    String img = rs.getString("image_url");
                    if (img == null || img.trim().isEmpty()) img = "https://via.placeholder.com/600x300?text=No+Image";
            %>
            <div class="carousel-item<%= (idx++==0 ? " active" : "") %>">
                <img src="<%= img %>" class="d-block w-100" alt="<%= rs.getString("name") %>">
                <div class="carousel-caption d-none d-md-block">
                    <h5><%= rs.getString("name") %></h5>
                    <p>₹<%= rs.getDouble("price") %></p>
                    <a href="productDetails.jsp?id=<%= rs.getInt("id") %>" class="btn btn-light btn-sm">View</a>
                </div>
            </div>
            <% } rs.close(); ps.close(); conn.close(); %>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</section>

<section class="testimonials bg-white">
    <h2 class="text-center mb-4">What Our Customers Say</h2>
    <div class="container">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <div class="testimonial-card p-4 shadow-sm rounded">
                    <p>“Amazing quality and service. Highly recommend!”</p>
                    <footer>— Priya, Mumbai</footer>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="testimonial-card p-4 shadow-sm rounded">
                    <p>“Fast delivery & unbeatable prices.”</p>
                    <footer>— Rahul, Pune</footer>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="testimonial-card p-4 shadow-sm rounded">
                    <p>“The best online store I’ve used so far.”</p>
                    <footer>— Neha, Delhi</footer>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="newsletter">
    <div class="container text-center">
        <h2>Join Our Newsletter</h2>
        <p>Get deals & updates straight to your inbox</p>
        <form class="d-flex justify-content-center">
            <input type="email" class="form-control w-50" placeholder="Your email..." required>
            <button type="submit" class="btn btn-success ms-2">Subscribe</button>
        </form>
    </div>
</section>

<footer class="footer">
    <div class="container text-center">
        <div class="row">
            <div class="col-md-4"><h5>AmazeMart</h5><p>Shop smart, save big.</p></div>
            <div class="col-md-4"><h5>Customer Service</h5><a href="#">Track Order</a><br><a href="#">Returns</a></div>
            <div class="col-md-4"><h5>Connect</h5><a href="#">Facebook</a><br><a href="#">Twitter</a></div>
        </div>
        <hr>
        <p class="mt-3">&copy; 2025 AmazeMart. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

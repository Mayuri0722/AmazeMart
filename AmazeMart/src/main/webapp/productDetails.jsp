<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, dao.DBConnection" %>

<%
    String id = request.getParameter("id");
    String name = "", description = "", imageUrl = "", stock = "";
    double price = 0.0;
    int quantity = 0;

    try {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE id = ?");
        ps.setInt(1, Integer.parseInt(id));
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            description = rs.getString("description");
            imageUrl = rs.getString("image_url");
            price = rs.getDouble("price");
            quantity = rs.getInt("quantity");
            stock = quantity > 0 ? "In Stock" : "Out of Stock";
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= name %> - AmazeMart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fa;
        }
        .product-container {
            margin-top: 50px;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.08);
        }
        .product-header {
            font-size: 2rem;
            font-weight: bold;
        }
        .stock-status {
            font-size: 1rem;
        }
        .badge-in-stock {
            color: green;
        }
        .badge-out-of-stock {
            color: red;
        }
        .price-section {
            font-size: 1.8rem;
            font-weight: bold;
            color: #ff5722;
        }
        .variant-thumbnails img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 10px;
            cursor: pointer;
        }
        .feature-icon {
            margin-right: 8px;
            color: green;
        }
        .tabs .nav-link {
            color: #6c757d;
        }
        .tabs .nav-link.active {
            color: #ff5722;
            border-bottom: 2px solid #ff5722;
        }
    </style>
</head>
<body>

<div class="container product-container">
    <div class="row">
        <div class="col-md-6">
            <img src="<%= imageUrl %>" class="img-fluid rounded shadow-sm mb-3" alt="<%= name %>">
            <div class="variant-thumbnails d-flex">
                <img src="<%= imageUrl %>" alt="Variant 1">
                <img src="https://via.placeholder.com/80x80?text=Color+2" alt="Variant 2">
                <img src="https://via.placeholder.com/80x80?text=Color+3" alt="Variant 3">
            </div>
        </div>

        <div class="col-md-6">
            <h2 class="product-header"><%= name %></h2>
            <p class="text-muted">4.8 (2,847 reviews) 
                <% if ("In Stock".equals(stock)) { %>
                    <span class="stock-status badge-in-stock ms-2"><%= stock %></span>
                <% } else { %>
                    <span class="stock-status badge-out-of-stock ms-2"><%= stock %></span>
                <% } %>
            </p>

            <div class="price-section mb-2">₹<%= String.format("%.2f", price) %></div>
            <p class="text-success">Save ₹50.00 with this limited-time offer!</p>

            <!-- Form for Add to Cart and Buy Now -->
            <form method="post" action="AddToCartServlet">
                <input type="hidden" name="productId" value="<%= id %>">
                
                <label for="quantity" class="form-label">Quantity:</label>
                <div class="input-group mb-3" style="width:150px;">
                    <button class="btn btn-outline-secondary" type="button" onclick="changeQty(-1)">-</button>
                    <input type="text" class="form-control text-center" name="quantity" id="quantity" value="1">
                    <button class="btn btn-outline-secondary" type="button" onclick="changeQty(1)">+</button>
                </div>

                <div class="d-flex gap-2 mb-3">
                    <button class="btn btn-primary w-50" type="submit">Add to Cart</button>
                    <button class="btn btn-warning w-50" type="submit" formaction="BuyNowServlet">Buy Now</button>
                </div>
            </form>

            <div>
                <h5>Key Features</h5>
                <ul>
                    <li><span class="feature-icon">✔</span>Active Noise Cancellation</li>
                    <li><span class="feature-icon">✔</span>30-hour Battery Life</li>
                    <li><span class="feature-icon">✔</span>Bluetooth 5.0 Connectivity</li>
                    <li><span class="feature-icon">✔</span>Premium Comfort Padding</li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Tabs -->
    <ul class="nav nav-tabs mt-4 tabs" role="tablist">
        <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#desc">Description</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#specs">Specifications</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#reviews">Reviews</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#shipping">Shipping & Returns</a></li>
    </ul>

    <div class="tab-content border-start border-end border-bottom p-4 bg-white shadow-sm rounded-bottom">
        <div id="desc" class="tab-pane fade show active">
            <h5>Product Description</h5>
            <p><%= description %></p>
        </div>
        <div id="specs" class="tab-pane fade">
            <p><em>Specifications will go here...</em></p>
        </div>
        <div id="reviews" class="tab-pane fade">
            <p><em>Customer reviews section...</em></p>
        </div>
        <div id="shipping" class="tab-pane fade">
            <p><em>Shipping & returns info...</em></p>
        </div>
    </div>
</div>

<script>
    function changeQty(val) {
        let qtyInput = document.getElementById("quantity");
        let current = parseInt(qtyInput.value);
        if (!isNaN(current)) {
            let updated = current + val;
            if (updated > 0) {
                qtyInput.value = updated;
            }
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page import="java.util.*, dao.DBConnection, dao.CartItem" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    HttpSession Session = request.getSession(false);
    @SuppressWarnings("unchecked")
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    double total = 0;
    int itemCount = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart - AmazeMart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            background-color: #343a40;
            padding: 12px 24px;
        }

        .navbar-brand {
            font-weight: bold;
            font-size: 1.6rem;
            color: white;
        }

        .navbar .nav-link {
            color: white !important;
            margin-left: 15px;
            font-weight: 500;
        }

        .navbar .nav-link:hover {
            color: #ffd700 !important;
        }

        .container {
            background-color: white;
            padding: 40px;
            margin-top: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.07);
        }

        h3 {
            font-weight: bold;
            color: #2a2d49;
        }

        .cart-table img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
        }

        .form-select {
            width: 80px;
        }

        .btn-remove, .btn-checkout {
            border-radius: 8px;
            font-weight: 600;
            padding: 6px 12px;
        }

        .btn-remove {
            background-color: #dc3545;
            color: white;
            border: none;
        }

        .btn-remove:hover {
            background-color: #b52d3b;
        }

        .btn-checkout {
            background-color: #198754;
            color: white;
            border: none;
            padding: 10px 30px;
            font-size: 1.1rem;
        }

        .btn-checkout:hover {
            background-color: #157347;
        }

        .table thead {
            background-color: #dee2ff;
        }

        .badge {
            font-size: 0.75rem;
        }

        .empty-msg {
            background: #f0f4ff;
            border: 1px solid #d0ddff;
            color: #2a2d49;
            padding: 20px;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="home.jsp">AmazeMart</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                <li class="nav-item">
                    <a class="nav-link position-relative" href="cart.jsp">
                        Cart
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            <%= cart != null ? cart.size() : 0 %>
                        </span>
                    </a>
                </li>
                <li class="nav-item"><a class="nav-link" href="trackOrders.jsp">Track Order</a></li>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Cart Section -->
<div class="container">
    <h3 class="mb-4">🛒 Your Shopping Cart</h3>

    <%
        if (cart == null || cart.isEmpty()) {
    %>
        <div class="empty-msg text-center">Your cart is empty. Browse products and add items!</div>
    <%
        } else {
    %>
        <div class="table-responsive">
            <table class="table table-bordered cart-table align-middle text-center">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = DBConnection.getConnection();
                    for (CartItem item : cart) {
                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE id = ?");
                        ps.setInt(1, item.getProductId());
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            double price = rs.getDouble("price");
                            int quantity = item.getQuantity();
                            double subtotal = price * quantity;
                            total += subtotal;
                            itemCount += quantity;
                            String productName = rs.getString("name");
                            String imageUrl = rs.getString("image_url");
                %>
                    <tr>
                        <td class="text-start">
                            <div class="d-flex align-items-center gap-3">
                                <img src="<%= imageUrl != null ? imageUrl : "https://via.placeholder.com/60x60?text=No+Image" %>" alt="<%= productName %>">
                                <span><%= productName %></span>
                            </div>
                        </td>
                        <td>₹<%= price %></td>
                        <td>
                            <form method="post" action="UpdateCartServlet">
                                <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                                <select name="quantity" class="form-select m-auto" onchange="this.form.submit()">
                                    <% for (int i = 1; i <= 10; i++) { %>
                                        <option value="<%= i %>" <%= i == quantity ? "selected" : "" %>><%= i %></option>
                                    <% } %>
                                </select>
                            </form>
                        </td>
                        <td>₹<%= subtotal %></td>
                        <td>
                            <a href="RemoveFromCartServlet?productId=<%= item.getProductId() %>" class="btn btn-remove">Remove</a>
                        </td>
                    </tr>
                <%
                        }
                        rs.close();
                        ps.close();
                    }
                    conn.close();
                %>
                    <tr class="fw-bold">
                        <td colspan="3" class="text-end">Total</td>
                        <td>₹<%= total %></td>
                        <td><%= itemCount %> items</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="text-end mt-4">
            <a href="PlaceOrderServlet" class="btn btn-checkout">Place Order</a>
        </div>
    <%
        }
    %>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

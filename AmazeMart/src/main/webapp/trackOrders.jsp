<%@ page import="java.sql.*, dao.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    HttpSession Session = request.getSession(false);
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String email = (String) session.getAttribute("email");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Orders - AmazeMart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            margin-top: 50px;
        }

        .order-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .status-pending {
            color: #ffc107;
            font-weight: bold;
        }

        .status-shipped {
            color: #17a2b8;
            font-weight: bold;
        }

        .status-delivered {
            color: #28a745;
            font-weight: bold;
        }

        .btn-cancel {
            background-color: #dc3545;
            color: white;
        }

        .btn-cancel:hover {
            background-color: #c82333;
        }
      
    .btn-outline-primary {
        font-weight: 500;
        border-radius: 5px;
    }
    
    </style>
</head>
<body>
<div class="container mt-3">
    <a href="home.jsp" class="btn btn-outline-primary">
        ← Back to Home
    </a>
</div>

<div class="container">
    <h2 class="mb-4 text-center">📦 Your Orders</h2>

    <%
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT o.*, p.name AS product_name, p.image_url FROM orders o JOIN products p ON o.product_id = p.id WHERE o.user_email = ? ORDER BY o.order_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            boolean hasOrders = false;

            while (rs.next()) {
                hasOrders = true;
                String productName = rs.getString("product_name");
                String imageUrl = rs.getString("image_url");
                int quantity = rs.getInt("quantity");
                String orderDate = rs.getString("order_date");
                String status = rs.getString("status");
                int orderId = rs.getInt("id");

                String statusClass = "";
                switch (status.toLowerCase()) {
                    case "pending": statusClass = "status-pending"; break;
                    case "shipped": statusClass = "status-shipped"; break;
                    case "delivered": statusClass = "status-delivered"; break;
                }
    %>
        <div class="order-card">
            <div class="d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="<%= imageUrl %>" alt="Product Image" class="me-3 rounded" width="70" height="70">
                    <div>
                        <h5><%= productName %></h5>
                        <p class="mb-1">Quantity: <%= quantity %></p>
                        <p class="mb-1">Order Date: <%= orderDate %></p>
                        <p class="<%= statusClass %>">Status: <%= status %></p>
                    </div>
                </div>
                <% if ("Pending".equalsIgnoreCase(status)) { %>
                    <form method="post" action="CancelOrderServlet" onsubmit="return confirm('Are you sure you want to cancel this order?');">
                        <input type="hidden" name="orderId" value="<%= orderId %>">
                        <button type="submit" class="btn btn-cancel">Cancel</button>
                    </form>
                <% } %>
            </div>
        </div>
    <%
            }

            if (!hasOrders) {
    %>
        <div class="alert alert-info text-center">You have not placed any orders yet.</div>
    <%
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
    %>
        <div class="alert alert-danger text-center">Something went wrong while loading your orders.</div>
    <%
        }
    %>
</div>

</body>
</html>

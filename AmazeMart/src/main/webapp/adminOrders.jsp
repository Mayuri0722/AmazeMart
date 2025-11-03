<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Orders | AmazeMart</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f6f6f6;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            background-color: #001f3f;
            padding: 15px 30px;
        }

        .navbar-brand {
            font-weight: bold;
            color: white;
            font-size: 1.5rem;
        }

        .navbar .nav-link {
            color: white !important;
            margin-left: 20px;
        }

        .navbar .nav-link:hover {
            color: #ffd700 !important;
        }

        .footer {
            margin-top: 60px;
            text-align: center;
            font-size: 14px;
            color: #888;
            padding-bottom: 20px;
        }

        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg shadow-sm">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="admin.jsp">AmazeMart Admin</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="admin.jsp">🏠 Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="adminStats.jsp">📊 Stats</a></li>
                <li class="nav-item"><a class="nav-link" href="adminUsers.jsp">👥 Users</a></li>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">🚪 Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Orders Table -->
<div class="container mt-5">
    <h3 class="mb-4 text-center">📦 Customer Orders</h3>

    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-dark text-center">
                <tr>
                    <th>Order ID</th>
                    <th>User</th>
                    <th>Product</th>
                    <th>Qty</th>
                    <th>Status</th>
                    <th>Ordered On</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection conn = DBConnection.getConnection();
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(
                            "SELECT o.id, u.name, p.name, o.quantity, o.status, o.order_date " +
                            "FROM orders o " +
                            "JOIN users u ON o.user_id = u.id " +
                            "JOIN products p ON o.product_id = p.id " +
                            "ORDER BY o.order_date DESC"
                        );

                        boolean hasOrders = false;
                        while (rs.next()) {
                            hasOrders = true;
                %>
                <tr class="text-center">
                    <td><%= rs.getInt(1) %></td>
                    <td><%= rs.getString(2) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><%= rs.getInt(4) %></td>
                    <td>
                        <span class="badge <%= "Delivered".equalsIgnoreCase(rs.getString(5)) ? "bg-success" : "bg-warning text-dark" %>">
                            <%= rs.getString(5) %>
                        </span>
                    </td>
                    <td><%= rs.getTimestamp(6) %></td>
                </tr>
                <%
                        }

                        if (!hasOrders) {
                %>
                <tr><td colspan="6" class="text-center text-muted">No orders found.</td></tr>
                <%
                        }

                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' class='text-danger text-center'>Error loading orders.</td></tr>");
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    &copy; 2025 AmazeMart Admin Panel
</div>

</body>
</html>

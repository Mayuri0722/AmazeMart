<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Site Stats | AmazeMart</title>
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

        .stat-card {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
            text-align: center;
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .footer {
            margin-top: 60px;
            text-align: center;
            font-size: 14px;
            color: #888;
            padding-bottom: 20px;
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
                <li class="nav-item"><a class="nav-link" href="adminOrders.jsp">📦 Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="adminUsers.jsp">👥 Users</a></li>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">🚪 Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Site Stats -->
<div class="container mt-5">
    <h3 class="mb-4 text-center">📊 Site Statistics</h3>
    <%
        Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();

        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM users");
        rs1.next();
        int totalUsers = rs1.getInt(1);

        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM products");
        rs2.next();
        int totalProducts = rs2.getInt(1);

        ResultSet rs3 = stmt.executeQuery("SELECT COUNT(*) FROM orders");
        rs3.next();
        int totalOrders = rs3.getInt(1);

        rs1.close();
        rs2.close();
        rs3.close();
        stmt.close();
        conn.close();
    %>

    <div class="row g-4 justify-content-center">
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon text-primary">👥</div>
                <h5>Total Registered Users</h5>
                <span class="badge bg-primary fs-5 px-3 py-2"><%= totalUsers %></span>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon text-success">🛒</div>
                <h5>Total Products</h5>
                <span class="badge bg-success fs-5 px-3 py-2"><%= totalProducts %></span>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon text-warning">📦</div>
                <h5>Total Orders Placed</h5>
                <span class="badge bg-warning text-dark fs-5 px-3 py-2"><%= totalOrders %></span>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    &copy; 2025 AmazeMart Admin Panel
</div>

</body>
</html>

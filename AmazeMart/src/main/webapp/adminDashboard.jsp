<%@ page import="java.sql.*, dao.DBConnection" %>
<%
    HttpSession Session = request.getSession(false);
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = DBConnection.getConnection();

    int userCount = 0, productCount = 0, orderCount = 0;

    Statement stmt = conn.createStatement();

    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE role='customer'");
    if (rs.next()) userCount = rs.getInt(1);

    rs = stmt.executeQuery("SELECT COUNT(*) FROM products");
    if (rs.next()) productCount = rs.getInt(1);

    rs = stmt.executeQuery("SELECT COUNT(*) FROM orders");
    if (rs.next()) orderCount = rs.getInt(1);
%>

<!DOCTYPE html>
<html>
<head>
<style>
    .stats {
        display: flex;
        gap: 40px;
        margin-top: 30px;
    }
    .stat-box {
        background: #f4f4f4;
        padding: 20px;
        border-radius: 8px;
        flex: 1;
        text-align: center;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .stat-box h4 {
        margin-bottom: 10px;
    }
</style>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="navbar">
    <div><strong>Admin Dashboard</strong></div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="adminViewOrders.jsp">Manage Orders</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<div class="container mt-4">
    <h2>Welcome, Admin!</h2>

    <div class="stats">
        <div class="stat-box">
            <h4>Total Users</h4>
            <p><%= userCount %></p>
        </div>
        <div class="stat-box">
            <h4>Total Products</h4>
            <p><%= productCount %></p>
        </div>
        <div class="stat-box">
            <h4>Total Orders</h4>
            <p><%= orderCount %></p>
        </div>
    </div>
</div>



</body>
</html>

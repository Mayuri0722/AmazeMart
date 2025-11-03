<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, dao.DBConnection" %>
<%
    HttpSession Session = request.getSession(false);
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT o.id, o.user_email, p.name AS product_name, o.quantity, o.order_date, o.status " +
        "FROM orders o JOIN products p ON o.product_id = p.id ORDER BY o.order_date DESC"
    );
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Manage Orders</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="navbar">
    <div><strong>Admin Panel</strong></div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<div class="container mt-4">
    <h2>All Orders</h2>

    <table border="1" cellpadding="10" cellspacing="0" style="width:100%; margin-top:20px;">
        <thead>
            <tr style="background-color:#f0f0f0;">
                <th>Order ID</th>
                <th>Customer Email</th>
                <th>Product</th>
                <th>Quantity</th>
                <th>Date</th>
                <th>Status</th>
                <th>Update</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
        <%
            boolean hasOrders = false;
            while (rs.next()) {
                hasOrders = true;
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("user_email") %></td>
                <td><%= rs.getString("product_name") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getTimestamp("order_date") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <form action="UpdateOrderStatusServlet" method="post" style="display:inline;">
                        <input type="hidden" name="orderId" value="<%= rs.getInt("id") %>">
                        <select name="status">
                            <option value="Pending" <%= "Pending".equals(rs.getString("status")) ? "selected" : "" %>>Pending</option>
                            <option value="Shipped" <%= "Shipped".equals(rs.getString("status")) ? "selected" : "" %>>Shipped</option>
                            <option value="Delivered" <%= "Delivered".equals(rs.getString("status")) ? "selected" : "" %>>Delivered</option>
                            <option value="Cancelled" <%= "Cancelled".equals(rs.getString("status")) ? "selected" : "" %>>Cancelled</option>
                        </select>
                        <input type="submit" value="Update">
                    </form>
                </td>
                <td>
                    <a href="DeleteOrderServlet?id=<%= rs.getInt("id") %>" 
                       onclick="return confirm('Are you sure you want to delete this order?');"
                       style="color:red;">Delete</a>
                </td>
            </tr>
        <%
            }
            if (!hasOrders) {
        %>
            <tr><td colspan="8">No orders available.</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<div class="footer mt-5">
    &copy; 2025 AmazeMart Admin Panel
</div>

</body>
</html>

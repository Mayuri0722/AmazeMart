<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, dao.DBConnection" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar {
            background-color: #001f3f;
            padding: 15px 30px;
        }

        .navbar a {
            color: white !important;
            margin-left: 20px;
            font-weight: 500;
        }

        .navbar a:hover {
            color: #ffd700 !important;
        }

        body {
            background-color: #f6f6f6;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            margin-top: 50px;
        }

        .footer {
            margin-top: 60px;
            text-align: center;
            font-size: 14px;
            color: #888;
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
<div class="container">
    <h3>👥 Registered Users</h3>
    <hr>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>User ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Registered On</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("SELECT id, name, email, role, reg_date FROM users");
                    ResultSet rs = ps.executeQuery();

                    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");

                    while (rs.next()) {
                        Timestamp regDate = rs.getTimestamp("reg_date");
                        String formattedDate = regDate != null ? sdf.format(regDate) : "N/A";
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("role") %></td>
                <td><%= formattedDate %></td>
            </tr>
            <%
                    }

                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='5' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>
</div>

<div class="footer">
    &copy; 2025 AmazeMart Admin Panel
</div>

</body>
</html>

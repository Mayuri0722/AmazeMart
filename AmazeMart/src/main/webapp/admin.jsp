<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - AmazeMart</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap & Custom Styling -->
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
            font-size: 1.8rem;
            font-weight: bold;
            color: #fff;
        }

        .navbar-nav .nav-link {
            color: #fff;
            margin-left: 20px;
            font-weight: 500;
        }

        .navbar-nav .nav-link:hover {
            color: #ffd700;
        }

        .admin-welcome {
            margin-top: 60px;
            text-align: center;
        }

        .admin-welcome h2 {
            font-weight: bold;
        }

        .admin-cards {
            margin-top: 40px;
        }

        .admin-card {
            border-radius: 12px;
            padding: 30px;
            background: #fff;
            box-shadow: 0 0 12px rgba(0,0,0,0.08);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .admin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .admin-card h5 {
            margin-top: 15px;
            font-weight: 600;
        }

        .footer {
            margin-top: 60px;
            padding: 20px;
            text-align: center;
            color: #888;
            font-size: 14px;
        }

        .emoji-icon {
            font-size: 2rem;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg shadow-sm">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="#">AmazeMart Admin</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="home.jsp">🏠 Home</a></li>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">🚪 Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Admin Welcome Section -->
<div class="container admin-welcome">
    <h2>Welcome, Mayuri 👋</h2>
    <p class="text-muted">Manage your AmazeMart store using the tools below.</p>
</div>

<!-- Admin Tools Grid -->
<div class="container admin-cards">
    <div class="row g-4">

        <div class="col-md-4">
            <a href="adminAddProduct.jsp" class="text-decoration-none text-dark">
                <div class="admin-card">
                    <div class="emoji-icon">➕</div>
                    <h5>Add Product</h5>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="adminManageProducts.jsp" class="text-decoration-none text-dark">
                <div class="admin-card">
                    <div class="emoji-icon">🛠️</div>
                    <h5>Manage Products</h5>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="adminStats.jsp" class="text-decoration-none text-dark">
                <div class="admin-card">
                    <div class="emoji-icon">📊</div>
                    <h5>View Stats</h5>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="adminOrders.jsp" class="text-decoration-none text-dark">
                <div class="admin-card">
                    <div class="emoji-icon">📦</div>
                    <h5>Manage Orders</h5>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="adminUsers.jsp" class="text-decoration-none text-dark">
                <div class="admin-card">
                    <div class="emoji-icon">👥</div>
                    <h5>Manage Users</h5>
                </div>
            </a>
        </div>

    </div>
</div>

<!-- Footer -->
<div class="footer">
    &copy; 2025 AmazeMart Admin Panel
</div>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>AmazeMart - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            background-color: #f2f2f2;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 400px;
        }

        .login-container h2 {
            text-align: center;
            color: #001f3f;
            margin-bottom: 25px;
            font-weight: bold;
        }

        .form-control {
            padding: 12px;
            border-radius: 6px;
        }

        .btn-navy {
            background-color: #001f3f;
            color: #ffffff;
            border: none;
            padding: 12px;
            width: 100%;
            font-weight: 600;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }

        .btn-navy:hover {
            background-color: #003366;
        }

        .login-container p {
            margin-top: 20px;
            text-align: center;
        }

        .login-container a {
            color: #001f3f;
            text-decoration: none;
            font-weight: bold;
        }

        .login-container a:hover {
            text-decoration: underline;
        }

        .form-check-label {
            font-size: 0.9rem;
        }

        .alert {
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 6px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Login to AmazeMart</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger text-center">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="LoginServlet" method="post">
        <div class="mb-3">
            <input type="email" name="email" placeholder="Email address" class="form-control" required>
        </div>
        <div class="mb-2">
            <input type="password" id="password" name="password" placeholder="Password" class="form-control" required>
        </div>
        <div class="form-check mb-3">
            <input class="form-check-input" type="checkbox" id="showPassword">
            <label class="form-check-label" for="showPassword">Show Password</label>
        </div>
        <button type="submit" class="btn btn-navy">Login</button>
    </form>

    <p>New to AmazeMart? <a href="register.jsp">Register here</a></p>
</div>

<script>
    // Show/hide password toggle
    document.getElementById("showPassword").addEventListener("change", function () {
        const passwordInput = document.getElementById("password");
        passwordInput.type = this.checked ? "text" : "password";
    });
</script>

</body>
</html>

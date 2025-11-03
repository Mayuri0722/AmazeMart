<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>AmazeMart - Register</title>
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

        .register-container {
            background: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 450px;
        }

        .register-container h2 {
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

        .register-container p {
            text-align: center;
            margin-top: 20px;
        }

        .register-container a {
            color: #001f3f;
            text-decoration: none;
            font-weight: bold;
        }

        .register-container a:hover {
            text-decoration: underline;
        }

        .alert {
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 6px;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Create Your AmazeMart Account</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger text-center">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="RegisterServlet" method="post" onsubmit="return validatePasswords();">
        <div class="mb-3">
            <input type="text" name="name" class="form-control" placeholder="Full Name" required>
        </div>
        <div class="mb-3">
            <input type="email" name="email" class="form-control" placeholder="Email address" required>
        </div>
        <div class="mb-3">
            <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
        </div>
        <div class="mb-3">
            <input type="password" name="confirm_password" id="confirm_password" class="form-control" placeholder="Confirm Password" required>
        </div>
        <button type="submit" class="btn btn-navy">Register</button>
    </form>

    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</div>

<script>
    function validatePasswords() {
        var pass = document.getElementById("password").value;
        var confirm = document.getElementById("confirm_password").value;
        if (pass !== confirm) {
            alert("Passwords do not match!");
            return false;
        }
        return true;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html> 
<html> 
<head> 
<title>Login - Qacha's Nek High School</title> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"> 
<style> body { margin: 0; padding: 0; background: #e3f2fd; }

    .split-container {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        padding: 30px;
        background: linear-gradient(to right, #e8f0fe, #f0f4f8);
    }

    .auth-box {
        display: flex;
        width: 90%;
        max-width: 1000px;
        background: #fff;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .left-pane {
        flex: 1;
        background: url('image/pic.jpg') no-repeat center center;
        background-size: cover;
        position: relative;
    }

    .left-pane::before {
        content: "";
        position: absolute;
        inset: 0;
        background: rgba(0, 0, 0, 0.4); /* overlay */
    }

    .left-pane .overlay {
        position: absolute;
        top: 0;
        left: 0;
        height: 100%;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px;
        z-index: 2;
        text-align: center;
    }

    .left-pane .overlay h2 {
        font-size: 1.8rem;
        font-weight: bold;
        color: #fff;
        text-shadow: 1px 1px 6px rgba(0, 0, 0, 0.6);
    }

    .right-pane {
        flex: 1;
        padding: 40px;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .form-title {
        font-weight: 600;
        font-size: 1.6rem;
        margin-bottom: 20px;
        text-align: center;
        color: #2b2b2b;
    }

    .form-label {
        font-weight: 500;
    }

    .btn-primary {
        background-color: #0069d9;
        border: none;
    }

    .form-footer {
        text-align: center;
        margin-top: 15px;
    }

    .form-footer a {
        color: #007bff;
        text-decoration: none;
    }

    .form-footer a:hover {
        text-decoration: underline;
    }

    .alert {
        font-size: 0.9rem;
    }
</style>
</head> 
<body> 
<div class="split-container">
 <div class="auth-box">
 <!-- Left side with image and overlay text -->
 <div class="left-pane"> <div class="overlay">
 <h2>"Education is the passport to the future, for tomorrow belongs to those who prepare for it today."</h2>
 </div> 
</div>

        <!-- Right side with login form -->
        <div class="right-pane">
            <h4 class="form-title">Login to Qacha's Nek High School</h4>
            <form method="post" action="login">
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Enter your username" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                </div>
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="remember" name="remember">
                        <label class="form-check-label" for="remember">Remind me</label>
                    </div>
                    <a href="#" class="small">Forgot password?</a>
                </div>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
                <% } %>
                <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>
            <div class="form-footer">
                <small>Don't have an account? <a href="register.jsp">Register here</a></small>
            </div>
        </div>
    </div>
</div>
</body>
 </html>
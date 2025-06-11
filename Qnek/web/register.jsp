<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html> 
<html> 
<head>
 <title>Register - Qacha's Nek High School</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
 <style> 
body { margin: 0; padding: 0; background: #e3f2fd; }

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
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .left-pane {
        flex: 1;
        background: url('image/school.jpg') no-repeat center center;
        background-size: cover;
        position: relative;
    }

    .left-pane::before {
        content: "";
        position: absolute;
        inset: 0;
        background: rgba(0, 0, 0, 0.4);
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
        background-color: #f5f5f5; /* Light gray */
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .form-title {
        font-weight: 600;
        font-size: 1.6rem;
        margin-bottom: 20px;
        text-align: center;
        color: #1a4ba0; /* Blue title */
    }

    .form-label {
        font-weight: 500;
        color: #1a4ba0; /* Blue labels */
    }

    .form-control::placeholder {
        color: #6c757d;
    }

    .btn-primary {
        background-color: #1a4ba0;
        border: none;
    }

    .form-footer {
        text-align: center;
        margin-top: 15px;
    }

    .form-footer a {
        color: #1a4ba0;
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
<!-- Left side with image and motivational message --> 
<div class="left-pane"> <div class="overlay"> 
<h2>"Start your journey toward excellence. Your future begins here."</h2> 
</div> 
</div>

        <!-- Right side with registration form -->
        <div class="right-pane">
            <h4 class="form-title">Create Your Account</h4>
            <form method="post" action="register">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">First Name</label>
                        <input type="text" name="firstName" class="form-control" placeholder="e.g. Malomile" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Last Name</label>
                        <input type="text" name="lastName" class="form-control" placeholder="e.g. Ramochele" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" placeholder="e.g. lolo@gmail.com">
                </div>

                <div class="mb-3">
                    <label class="form-label">Phone</label>
                    <input type="text" name="phone" class="form-control" placeholder="e.g. 50001234">
                </div>

                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Create a username" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Choose a strong password" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-select" required>
                        <option value="">Select Role</option>
                        <option value="student">Student</option>
                        <option value="teacher">Teacher</option>
                        <option value="principal">Principal</option>
                    </select>
                </div>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
                <% } %>

                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>

            <div class="form-footer">
                <small>Already have an account? <a href="login.jsp">Login here</a></small>
            </div>
        </div>
    </div>
</div>
</body>
 </html>
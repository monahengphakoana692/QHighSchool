<%-- 
    Document   : dashboard
    Created on : 04 Jun 2025, 17:08:08
    Author     : Malomile Ramochele
--%>

<%@ page import="com.qacha.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Qacha High School</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">Qacha High School - Dashboard</span>
            <span class="text-white">Logged in as <strong><%= user.getUsername() %></strong></span>
        </div>
    </nav>

    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card text-white bg-success">
                    <div class="card-body">
                        <h5 class="card-title">Students</h5>
                        <p class="card-text">Register and manage students</p>
                        <a href="students.jsp" class="btn btn-light">Manage Students</a>
                    </div>
                </div>
            </div>

            <!-- Add more cards here later -->
            <div class="col-md-4">
                <div class="card text-white bg-info">
                    <div class="card-body">
                        <h5 class="card-title">Classes</h5>
                        <p class="card-text">View and edit classes</p>
                        <a href="#" class="btn btn-light">Manage Classes</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

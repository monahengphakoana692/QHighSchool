<%-- 
    Document   : principal_dashboard
    Created on : 11 Jun 2025, 13:38:40
    Author     : Malomile Ramochele
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.qacha.model.User" %>
<%@ page session="true" %>
<%
User user = (User) session.getAttribute("user");
if (user == null || !"principal".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>
 <html> 
<head> 
<title>Principal Dashboard</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
 <style> 
body { margin: 0; background-color: #f4f6f8; font-family: 'Segoe UI', sans-serif; }
 .sidebar { width: 220px; height: 100vh; background-color: #2c3e50; color: #ecf0f1; position: fixed; padding: 20px; }
 .sidebar h4 { font-size: 18px; margin-bottom: 30px; }
 .sidebar a { display: block; color: #bdc3c7; padding: 10px 0; text-decoration: none; font-size: 15px; }
 .sidebar a:hover { color: #ffffff; font-weight: bold; } .main { margin-left: 240px; padding: 30px; }
 .card-box { background-color: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); margin-bottom: 20px; }
 .card-box h5 { margin-bottom: 10px; font-weight: 600; }
 .grid-2 { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; } 
</style> 
</head>
 <body>
 <div class="sidebar">
 <h4>Welcome! , <%= user.getFirstName() %></h4>
 <a href="#">Dashboard</a> <a href="#">Teachers</a>
 <a href="#">Students</a> <a href="#">Announcements</a>
 <a href="#">Classes</a> <a href="#">Reports</a> <a href="logout.jsp">Logout</a>
 </div> <div class="main"> <h3 class="mb-4">Principal Dashboard</h3>

<div class="grid-2">
    <div class="card-box">
        <h5>Manage Teachers</h5>
        <p>View, add, and update teacher information.</p>
        <a href="teachers.jsp" class="btn btn-outline-primary btn-sm">Go</a>
    </div>
    <div class="card-box">
        <h5>Manage Students</h5>
        <p>Monitor student registrations and class assignments.</p>
        <a href="students.jsp" class="btn btn-outline-primary btn-sm">Go</a>
    </div>
    <div class="card-box">
        <h5>Announcements</h5>
        <p>Create and publish school-wide announcements.</p>
        <a href="announcements.jsp" class="btn btn-outline-primary btn-sm">Go</a>
    </div>
    <div class="card-box">
        <h5>Manage Classes</h5>
        <p>Create new classes and assign teachers.</p>
        <a href="classes.jsp" class="btn btn-outline-primary btn-sm">Go</a>
    </div>
    <div class="card-box">
        <h5>Reports</h5>
        <p>Generate reports on attendance and performance.</p>
        <a href="reports.jsp" class="btn btn-outline-primary btn-sm">Go</a>
    </div>
</div>
</div> 
</body>
 </html>

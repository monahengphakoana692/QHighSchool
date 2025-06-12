<%@ page import="java.util.List" %>
<%@ page import="com.qacha.model.Student" %>
<%@ page import="com.qacha.model.User" %>
<%@ page import="com.qacha.dao.StudentDAO" %>
<%
User currentUser = (User) session.getAttribute("user");
if (currentUser == null || !"principal".equals(currentUser.getRole())) {
    response.sendRedirect("login.jsp");
    return;
}
List<Student> studentList = StudentDAO.getAllStudents();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Students</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h3>All Students</h3>

    <!-- Add Student Button -->
    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addStudentModal">+ Add Student</button>

    <!-- Students Table -->
    <table class="table table-bordered">
        <thead class="table-dark">
        <tr>
            <th>Name</th>
            <th>Parent Name</th>
            <th>Phone</th>
            <th>DOB</th>
            <th>Address</th>
            <th>Class</th>
        </tr>
        </thead>
        <tbody>
        <% for (Student s : studentList) { %>
            <tr>
                <td><%= s.getFirstName() %> <%= s.getLastName() %></td>
                <td><%= s.getParentName() %></td>
                <td><%= s.getParentPhone() %></td>
                <td><%= s.getDateOfBirth() %></td>
                <td><%= s.getAddress() %></td>
                <td><%= s.getClassId() %></td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <a href="principal_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>

<!-- Add Student Modal -->
<div class="modal fade" id="addStudentModal" tabindex="-1" aria-labelledby="addStudentLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form method="post" action="student">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addStudentLabel">Add New Student</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <label>First Name</label>
                        <input type="text" name="firstName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Last Name</label>
                        <input type="text" name="lastName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Parent Name</label>
                        <input type="text" name="parentName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Parent Phone</label>
                        <input type="text" name="parentPhone" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label>Date of Birth</label>
                        <input type="date" name="dob" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label>Address</label>
                        <input type="text" name="address" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label>Class ID</label>
                        <input type="text" name="classId" class="form-control">
                    </div>

                    <input type="hidden" name="action" value="add">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

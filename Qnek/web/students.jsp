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
    <h3>Manage Students</h3>

    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addStudentModal">+ Add Student</button>
    <button class="btn btn-success mb-3 ms-2" onclick="exportToCSV()">Download CSV</button>

    <table class="table table-bordered mt-3" id="studentsTable">
        <thead class="table-dark">
        <tr>
            <th>Name</th> <th>Parent</th> <th>Phone</th> <th>DOB</th> <th>Address</th> <th>Class</th> <th>Actions</th>
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
                <td>
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal<%= s.getStudentId() %>">Edit</button>
                    <form method="post" action="student" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="studentId" value="<%= s.getStudentId() %>">
                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Delete student?')">Delete</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <%-- Edit Student Modals --%>
    <% for (Student s : studentList) { %>
        <div class="modal fade" id="editModal<%= s.getStudentId() %>" tabindex="-1">
            <div class="modal-dialog">
                <form method="post" action="student">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5>Edit Student</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="studentId" value="<%= s.getStudentId() %>">

                            <div class="mb-3"><label>First Name</label><input name="firstName" class="form-control" value="<%= s.getFirstName() %>" required></div>
                            <div class="mb-3"><label>Last Name</label><input name="lastName" class="form-control" value="<%= s.getLastName() %>" required></div>
                            <div class="mb-3"><label>Parent Name</label><input name="parentName" class="form-control" value="<%= s.getParentName() %>" required></div>
                            <div class="mb-3"><label>Parent Phone</label><input name="parentPhone" class="form-control" value="<%= s.getParentPhone() %>"></div>
                            <div class="mb-3"><label>Date of Birth</label><input type="date" name="dob" class="form-control" value="<%= s.getDateOfBirth() %>"></div>
                            <div class="mb-3"><label>Address</label><input name="address" class="form-control" value="<%= s.getAddress() %>"></div>
                            <div class="mb-3"><label>Class ID</label><input name="classId" class="form-control" value="<%= s.getClassId() %>"></div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    <% } %>

    <a href="principal_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>

<!-- Add Student Modal -->
<div class="modal fade" id="addStudentModal" tabindex="-1">
    <div class="modal-dialog">
        <form method="post" action="student">
            <div class="modal-content">
                <div class="modal-header">
                    <h5>Add New Student</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-3"><label>First Name</label><input name="firstName" class="form-control" required></div>
                    <div class="mb-3"><label>Last Name</label><input name="lastName" class="form-control" required></div>
                    <div class="mb-3"><label>Parent Name</label><input name="parentName" class="form-control" required></div>
                    <div class="mb-3"><label>Parent Phone</label><input name="parentPhone" class="form-control"></div>
                    <div class="mb-3"><label>Date of Birth</label><input type="date" name="dob" class="form-control"></div>
                    <div class="mb-3"><label>Address</label><input name="address" class="form-control"></div>
                    <div class="mb-3"><label>Class ID</label><input name="classId" class="form-control"></div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
function exportToCSV() {
    let csv = "Name,Parent,Phone,DOB,Address,Class\n";
    const rows = document.querySelectorAll("#studentsTable tbody tr");
    rows.forEach(row => {
        const cells = row.querySelectorAll("td");
        const data = Array.from(cells).slice(0, 6).map(td => td.innerText);
        csv += data.join(",") + "\n";
    });
    const blob = new Blob([csv], { type: 'text/csv' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = "students.csv";
    link.click();
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

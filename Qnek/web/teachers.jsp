<%-- 
    Document   : teachers
    Created on : 04 Jun 2025, 17:10:44
    Author     : Malomile Ramochele
--%>

<%@ page import="java.util.List" %>
<%@ page import="com.qacha.model.User" %>
<%@ page import="com.qacha.dao.TeacherDAO" %>
<%
User currentUser = (User) session.getAttribute("user");
if (currentUser == null || !"principal".equals(currentUser.getRole())) {
response.sendRedirect("login.jsp");
return;
}
List<User> teacherList = TeacherDAO.getAllTeachers();
%>

<!DOCTYPE html>
 <html> 
<head> 
<title>Manage Teachers</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"> </head>
 <body> 
<div class="container mt-4"> <h3>Manage Teachers</h3>

<button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addTeacherModal">+ Add Teacher</button>

<button class="btn btn-success mb-3 ms-2" onclick="exportToCSV()">Download CSV</button>

<table class="table table-bordered mt-3" id="teachersTable">
    <thead class="table-dark">
    <tr>
        <th>Name</th> <th>Email</th> <th>Phone</th> <th>Username</th> <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (User t : teacherList) { %>
        <tr>
  <td><%= t.getFirstName() %> <%= t.getLastName() %></td>
  <td><%= t.getEmail() %></td>
  <td><%= t.getPhone() %></td>
  <td><%= t.getUsername() %></td>
  <td>
    <!-- Edit Button -->
    <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal<%= t.getUserId() %>">Edit</button>

    <!-- Delete Button -->
    <form method="post" action="teacher" style="display:inline;">
      <input type="hidden" name="action" value="delete" />
      <input type="hidden" name="userId" value="<%= t.getUserId() %>" />
      <button type="submit" class="btn btn-danger btn-sm">Delete</button>
    </form>
  </td>
</tr>



    <% } %>
    </tbody>
</table>
</table>

<% for (User t : teacherList) { %>
<div class="modal fade" id="editModal<%= t.getUserId() %>" tabindex="-1" aria-labelledby="editModalLabel<%= t.getUserId() %>" aria-hidden="true">
  <div class="modal-dialog">
    <form method="post" action="teacher">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editModalLabel<%= t.getUserId() %>">Edit Teacher</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="action" value="edit" />
          <input type="hidden" name="userId" value="<%= t.getUserId() %>" />

          <div class="mb-3"><label>First Name</label><input type="text" name="firstName" class="form-control" value="<%= t.getFirstName() %>" required></div>
          <div class="mb-3"><label>Last Name</label><input type="text" name="lastName" class="form-control" value="<%= t.getLastName() %>" required></div>
          <div class="mb-3"><label>Email</label><input type="email" name="email" class="form-control" value="<%= t.getEmail() %>"></div>
          <div class="mb-3"><label>Phone</label><input type="text" name="phone" class="form-control" value="<%= t.getPhone() %>"></div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary">Save Changes</button>
        </div>
      </div>
    </form>
  </div>
</div>
<% } %>

<a href="principal_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div> 
<!-- Add Teacher Modal --> 
<div class="modal fade" id="addTeacherModal" tabindex="-1"> 
<div class="modal-dialog"> <form method="post" action="teacher"> 
<div class="modal-content"> 
<div class="modal-header"> 
<h5 class="modal-title">Add New Teacher</h5> 
<button type="button" class="btn-close" data-bs-dismiss="modal"></button> 
</div> 
<div class="modal-body"> <input type="hidden" name="action" value="add"> 
<div class="mb-3"><label>First Name</label><input type="text" name="firstName" class="form-control" required></div> 
<div class="mb-3"><label>Last Name</label><input type="text" name="lastName" class="form-control" required></div> 
<div class="mb-3"><label>Email</label><input type="email" name="email" class="form-control"></div> 
<div class="mb-3"><label>Phone</label><input type="text" name="phone" class="form-control"></div> 
<div class="mb-3"><label>Username</label><input type="text" name="username" class="form-control" required></div> 
<div class="mb-3"><label>Password</label><input type="password" name="password" class="form-control" required></div> 
<div class="mb-3"><label>Subject Specialization</label><input type="text" name="subject" class="form-control" required></div>
 </div> <div class="modal-footer">
 <button type="submit" class="btn btn-success">Save</button> 
<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
 </div>
 </div>
 </form>
 </div>
 </div>
 <!-- Edit Teacher Modal --> 
<div class="modal fade" id="editTeacherModal" tabindex="-1"> <div class="modal-dialog">
 <form method="post" action="teacher"> <div class="modal-content">
 <div class="modal-header">
 <h5 class="modal-title">Edit Teacher</h5>
 <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
 </div> 
<div class="modal-body">
 <input type="hidden" name="action" value="edit">
 <input type="hidden" name="userId" id="editUserId">
 <div class="mb-3"><label>First Name</label><input type="text" name="firstName" id="editFirstName" class="form-control" required></div>
 <div class="mb-3"><label>Last Name</label><input type="text" name="lastName" id="editLastName" class="form-control" required></div>
 <div class="mb-3"><label>Email</label><input type="email" name="email" id="editEmail" class="form-control"></div>
 <div class="mb-3"><label>Phone</label><input type="text" name="phone" id="editPhone" class="form-control"></div> 
</div> <div class="modal-footer"> <button type="submit" class="btn btn-warning">Update</button> 
<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
 </div>
 </div>
 </form>
 </div>
 </div> 
<script> function openEditModal(id, first, last, email, phone)
 { document.getElementById("editUserId").value = id;
 document.getElementById("editFirstName").value = first; 
document.getElementById("editLastName").value = last; 
document.getElementById("editEmail").value = email; 
document.getElementById("editPhone").value = phone;
 new bootstrap.Modal(document.getElementById('editTeacherModal')).show(); } function exportToCSV()
 { let csv = "Name,Email,Phone,Username\n"; const rows = document.querySelectorAll("#teachersTable tbody tr"); 
rows.forEach(row => { const cells = row.querySelectorAll("td"); const data = [cells[0].innerText, cells[1].innerText, cells[2].innerText, cells[3].innerText]; csv += data.join(",") + "\n"; });
 const blob = new Blob([csv], { type: 'text/csv' }); const link = document.createElement('a');
 link.href = URL.createObjectURL(blob); link.download = "teachers.csv"; link.click(); }
 </script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
 </body>
 </html>
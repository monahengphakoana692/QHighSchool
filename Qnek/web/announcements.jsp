<%-- 
    Document   : announcements
    Created on : 30 Jun 2025, 15:11:48
    Author     : Malomile Ramochele
--%>

<%@ page import="java.util.List" %>
<%@ page import="com.qacha.model.User" %>
<%@ page import="com.qacha.model.Announcement" %>
<%@ page import="com.qacha.dao.AnnouncementDAO" %>
<%
User currentUser = (User) session.getAttribute("user");
if (currentUser == null) {
response.sendRedirect("login.jsp");
return;
}

List<Announcement> announcements = AnnouncementDAO.getAllAnnouncements();
boolean isPrincipal = "principal".equals(currentUser.getRole());
%>

<!DOCTYPE html> <html>
    <head>
        <title>Announcements</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <style> body { background: #f8f9fa; } .announcement-card { border-left: 6px solid #0d6efd; margin-bottom: 1rem; box-shadow: 0 2px 6px rgba(0,0,0,0.08); } .badge.important { background-color: #ffc107; } .badge.urgent { background-color: #dc3545; } .fab { position: fixed; bottom: 40px; right: 40px; background: #0d6efd; color: white; border-radius: 50%; width: 60px; height: 60px; font-size: 28px; text-align: center; line-height: 60px; box-shadow: 0 4px 10px rgba(0,0,0,0.3); cursor: pointer; } 
        </style>
    </head>
    <body>
        <div class="container mt-4"> <h3 class="mb-4">Latest Announcements</h3>

<% for (Announcement a : announcements) { %>
    <div class="card announcement-card">
        <div class="card-body">
            <h5 class="card-title">
                <%= a.getTitle() %>
                <span class="badge text-white 
                    <%= "important".equals(a.getPriority()) ? "important" : 
                        ("urgent".equals(a.getPriority()) ? "urgent" : "bg-secondary") %>">
                    <%= a.getPriority().toUpperCase() %>
                </span>
            </h5>
            <p class="card-text"><%= a.getContent() %></p>
            <p class="text-muted small">
                Posted by User#<%= a.getCreatedBy() %> on <%= a.getCreatedAt() %>
                <% if (a.getExpiryDate() != null) { %> ? Expires: <%= a.getExpiryDate() %> <% } %>
            </p>
            <% if (isPrincipal) { %>
                <form method="post" action="announcement" class="d-inline">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="announcementId" value="<%= a.getAnnouncementId() %>">
                    <button class="btn btn-danger btn-sm">Delete</button>
                </form>
                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal<%= a.getAnnouncementId() %>">Edit</button>
            <% } %>
        </div>
    </div>

    <%-- Edit Modal --%>
    <div class="modal fade" id="editModal<%= a.getAnnouncementId() %>" tabindex="-1">
        <div class="modal-dialog">
            <form method="post" action="announcement">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5>Edit Announcement</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="announcementId" value="<%= a.getAnnouncementId() %>">

                        <div class="mb-3"><label>Title</label><input name="title" class="form-control" value="<%= a.getTitle() %>" required></div>
                        <div class="mb-3"><label>Content</label><textarea name="content" class="form-control" rows="4"><%= a.getContent() %></textarea></div>
                        <div class="mb-3"><label>Priority</label>
                            <select name="priority" class="form-control">
                                <option value="normal" <%= a.getPriority().equals("normal") ? "selected" : "" %>>Normal</option>
                                <option value="important" <%= a.getPriority().equals("important") ? "selected" : "" %>>Important</option>
                                <option value="urgent" <%= a.getPriority().equals("urgent") ? "selected" : "" %>>Urgent</option>
                            </select>
                        </div>
                        <div class="mb-3"><label>Expiry Date</label><input type="date" name="expiryDate" class="form-control" value="<%= a.getExpiryDate() %>"></div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary">Save Changes</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
<% } %>

<% if (isPrincipal) { %>
    <!-- Floating Action Button -->
    <div class="fab" data-bs-toggle="modal" data-bs-target="#addModal">+</div>

    <!-- Add Announcement Modal --> 
    <div class="modal fade" id="addModal" tabindex="-1"> <div class="modal-dialog"> <form method="post" action="announcement"> <div class="modal-content"> <div class="modal-header"> <h5>Add Announcement</h5> <button type="button" class="btn-close" data-bs-dismiss="modal"></button> </div> <div class="modal-body"> <input type="hidden" name="action" value="add">

      <div class="mb-3">
        <label>Title</label>
        <input name="title" class="form-control" required>
      </div>

      <div class="mb-3">
        <label>Content</label>
        <textarea name="content" class="form-control" rows="4" required></textarea>
      </div>

      <div class="mb-3">
        <label>Priority</label>
        <select name="priority" class="form-control">
          <option value="normal">Normal</option>
          <option value="important">Important</option>
          <option value="urgent">Urgent</option>
        </select>
      </div>

      <div class="mb-3">
        <label>Target Type</label>
        <select name="targetType" class="form-control" id="targetTypeSelect" onchange="toggleTargetValue()">
          <option value="all">All</option>
          <option value="teachers">Teachers</option>
          <option value="students">Students</option>
          <option value="class">Specific Class</option>
          <option value="department">Specific Department</option>
        </select>
      </div>

      <div class="mb-3" id="targetValueContainer" style="display:none;">
        <label>Target Value (e.g. Class ID)</label>
        <input type="number" name="targetValue" class="form-control">
      </div>

      <div class="mb-3">
        <label>Expiry Date</label>
        <input type="date" name="expiryDate" class="form-control">
      </div>

    </div>
    <div class="modal-footer">
      <button class="btn btn-success">Post</button>
    </div>
  </div>
</form>
</div> </div>
<% } %>

<a href="principal_dashboard.jsp" class="btn btn-secondary mt-4">Back to Dashboard</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
</script>  
    <script> 
        function toggleTargetValue() { const select = document.getElementById("targetTypeSelect");
            const valueContainer = document.getElementById("targetValueContainer"); 
        if (select.value === "class" || select.value === "department") { valueContainer.style.display = "block"; }
        else { valueContainer.style.display = "none"; } } </script>
    </body> </html>
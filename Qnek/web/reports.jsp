<%-- 
    Document   : reports
    Created on : 04 Jun 2025, 17:12:23
    Author     : Malomile Ramochele
--%>

<%@ page import="java.util.List" %>
<%@ page import="com.qacha.model.User" %>
<%@ page import="com.qacha.model.Grade" %>
<%@ page import="com.qacha.dao.GradeDAO" %>
<%@ page import="com.qacha.dao.StudentDAO" %>
<%
User currentUser = (User) session.getAttribute("user");
if (currentUser == null) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html> <html> <head> <title>Performance Report</title> <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"> <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script> </head> <body> <div class="container mt-4"> <h3>Student Performance Report</h3>

<!-- Student selector -->
<form method="get" action="reports.jsp" class="mb-4">
    <label>Select Student ID:</label>
    <input type="text" name="studentId" class="form-control w-25 d-inline-block" value="<%= request.getParameter("studentId") != null ? request.getParameter("studentId") : "" %>">
    <button type="submit" class="btn btn-primary ms-2">View</button>
</form>
<%
String sid = request.getParameter("studentId");
if (sid != null) {
int studentId = Integer.parseInt(sid);
List<Grade> gradeList = GradeDAO.getGradesByStudent(studentId);
%>

<!-- Table -->
<table class="table table-bordered">
    <thead class="table-dark">
    <tr><th>Subject</th><th>Grade</th><th>Term</th><th>Year</th></tr>
    </thead>
    <tbody>
    <% for (Grade g : gradeList) { %>
        <tr>
            <td><%= g.getSubjectName() %></td>
            <td><%= g.getGradeValue() %></td>
            <td><%= g.getTerm() %></td>
            <td><%= g.getAcademicYear() %></td>
        </tr>
    <% } %>
    </tbody>
</table>

<!-- Chart -->
<canvas id="gradeChart" width="400" height="200"></canvas>

<!-- Export button -->
<button class="btn btn-success mt-3" onclick="exportPDF()">Download PDF</button>

<script>
const labels = [<% for (Grade g : gradeList) { %>"<%= g.getSubjectName() %>",<% } %>];
const data = [<% for (Grade g : gradeList) { %><%= g.getGradeValue() %>,<% } %>];

const ctx = document.getElementById('gradeChart').getContext('2d');
const gradeChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: 'Grades',
            data: data,
            backgroundColor: '#007bff'
        }]
    },
    options: {
        scales: {
            y: { beginAtZero: true }
        }
    }
});

function exportPDF() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();
    doc.text("Student Performance Report", 20, 10);
    doc.text("Student ID: " + "<%= studentId %>", 20, 20);
    doc.html(document.querySelector("table"), {
        callback: function () {
            doc.addPage();
            doc.addImage(gradeChart.toBase64Image(), 'PNG', 15, 40, 180, 100);
            doc.save("performance_report.pdf");
        }
    });
}
</script>
<% } else { %>
<div class="alert alert-info">Please enter a student ID above to view the report.</div>
<% } %>

<a href="principal_dashboard.jsp" class="btn btn-secondary mt-4">Back to Dashboard</a>

</div> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script> </body> </html>
<%-- 
    Document   : logout
    Created on : 04 Jun 2025, 21:41:24
    Author     : Malomile Ramochele
--%>

<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>

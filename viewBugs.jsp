<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">

<!-- Navigation -->
<nav class="top-nav">
    <div class="nav-left">
        <h1 class="brand">Bug Mini</h1>
    </div>

    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="addBug.jsp">Add Bug</a>
        <a href="updateBug.jsp">Update Bug</a>
    </div>
</nav>
<h2>All Bugs</h2>

<%
    String path = application.getRealPath("/data/bugs.txt");
    List<String> lines = FileHelper.readAll(path);

    if (lines.isEmpty()) {
        out.println("<p>No bugs found.</p>");
    } else {
%>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Severity</th>
    </tr>

<%
        for (String s : lines) {
           String[] p = s.split("\\|");

%>
<tr>
    <td><%= p[0] %></td>
    <td><%= p[1] %></td>
    <td><%= p[2] %></td>
    <td><%= p[3] %></td>
</tr>
<%
        }
    }
%>
</table>

<br>


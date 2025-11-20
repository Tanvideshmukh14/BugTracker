<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">

<nav class="top-nav">
    <div class="nav-left">
        <h1 class="brand">Developer Panel</h1>
    </div>

    <div class="nav-links">
        <a href="devViewBugs.jsp">View Bugs</a>
    </div>
</nav>

<h2 style="text-align:center;">All Reported Bugs</h2>

<%
    String path = application.getRealPath("/data/bugs.txt");
    List<String> lines = FileHelper.readAll(path);

    if (lines.isEmpty()) {
%>
        <p>No bugs found.</p>
<%
    } else {
%>

<table border="1" style="width:90%; margin:auto;">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Severity</th>
        <th>Actions</th>
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
    <td>
        <a href="devAddComment.jsp?id=<%= p[0] %>">Add Comment</a>
    </td>
</tr>

<%
        }
    }
%>
</table>

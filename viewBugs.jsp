<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">

<nav class="top-nav">
    <div class="nav-left"><h1 class="brand">Bug Mini</h1></div>
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
        <th>Comments</th>
    </tr>

<%
        for (String s : lines) {
           String[] p = s.split("\\|");

           // Trim for safety
           for (int i = 0; i < p.length; i++) p[i] = p[i].trim();
%>

<tr>
    <td><%= p[0] %></td>
    <td><%= p[1] %></td>
    <td><%= p[2] %></td>
    <td><%= p[3] %></td>
    <td><%= p.length > 4 ? p[4] : "No comments" %></td>

    <td>
        <form action="viewComments.jsp" method="get">
            <input type="hidden" name="id" value="<%= p[0] %>">
            <button type="submit">View Comments</button>
        </form>
    </td>
</tr>

<%
        }
    }
%>

</table>

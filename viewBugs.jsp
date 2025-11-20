<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">

<%
    // Handle Delete Request
    String deleteId = request.getParameter("deleteId");
    if (deleteId != null && !deleteId.trim().isEmpty()) {
        deleteId = deleteId.trim();

        // Remove from bugs.txt
        String path = application.getRealPath("/data/bugs.txt");
        List<String> lines = FileHelper.readAll(path);
        List<String> updatedBugs = new ArrayList<>();

        for (String s : lines) {
            String[] p = s.split("\\|");
            if (p.length >= 1 && !p[0].trim().equals(deleteId)) {
                updatedBugs.add(s);
            }
        }
        FileHelper.writeAll(path, updatedBugs);

        // Remove related comments
        String commentsPath = application.getRealPath("/data/comments.txt");
        List<String> commentLines = FileHelper.readAll(commentsPath);
        List<String> updatedComments = new ArrayList<>();
        for (String c : commentLines) {
            String[] pc = c.split("\\|");
            if (pc.length >= 1 && !pc[0].trim().equals(deleteId)) {
                updatedComments.add(c);
            }
        }
        FileHelper.writeAll(commentsPath, updatedComments);

        out.println("<p style='color:green; text-align:center;'>Bug ID " + deleteId + " deleted successfully!</p>");
    }
%>

<nav class="top-nav">
    <div class="nav-left"><h1 class="brand">Bug Mini</h1></div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="addBug.jsp">Add Bug</a>
        <a href="updateBug.jsp">Update Bug</a>
    </div>
</nav>

<h2 style="text-align:center;">All Bugs</h2>

<%
    // Read Bugs
    String path = application.getRealPath("/data/bugs.txt");
    List<String> lines = FileHelper.readAll(path);

    // Read Comments
    String commentsPath = application.getRealPath("/data/comments.txt");
    List<String> commentLines = FileHelper.readAll(commentsPath);

    // Map to store bugId → number of comments
    Map<String, Integer> commentCount = new HashMap<>();
    for (String c : commentLines) {
        String[] pc = c.split("\\|");
        if (pc.length >= 2) {
            String id = pc[0].trim();
            if (!id.equals("") && !id.equals("null")) {
                commentCount.put(id, commentCount.getOrDefault(id, 0) + 1);
            }
        }
    }

    if (lines.isEmpty()) {
        out.println("<p style='text-align:center;'>No bugs found.</p>");
    } else {
%>

<table border="1" style="width:90%; margin:auto;">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Severity</th>
        <th>Comments</th>
        <th>Actions</th>
    </tr>

<%
        for (String s : lines) {
           String[] p = s.split("\\|");
           for (int i = 0; i < p.length; i++) p[i] = p[i].trim();
           String id = p[0];
           int count = commentCount.getOrDefault(id, 0);
%>

<tr>
    <td><%= id %></td>
    <td><%= p[1] %></td>
    <td><%= p[2] %></td>
    <td><%= p[3] %></td>
    <td>
        <p><%= count %> Comments</p>
        <form action="viewComments.jsp" method="get">
            <input type="hidden" name="id" value="<%= id %>">
            <button type="submit">View Comments</button>
        </form>
    </td>
    <td>
        <form method="get">
            <input type="hidden" name="deleteId" value="<%= id %>">
            <button type="submit" style="background:red;color:white;">Delete Bug</button>
        </form>
    </td>
</tr>

<%
        }
%>
</table>
<%
    }
%>

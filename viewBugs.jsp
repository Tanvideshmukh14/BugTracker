<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    /* Page background */
body {
    margin: 0;
    font-family: "Segoe UI", sans-serif;
    background: #e5ddd5; /* WhatsApp chat background */

}

/* NAVBAR */
.top-nav {
    background: #075e54;
    color: white;
    padding: 15px 25px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 6px rgba(0,0,0,0.2);
}
.nav-links a {
  margin-left: 15px;
  padding: 8px 14px;
  font-weight: 600;
  color: #000;
  border: 1px solid white;
  border-radius: 8px;
  text-decoration: none;
  transition: 0.2s;
}
.nav-links a:hover {
  background: white;
  color: #075e54;
  box-shadow: 0 4px 12px rgba(37,99,235,0.2);
}

.top-nav .brand {
    margin: 0;
    font-size: 24px;
}
.brand{
    color: white;
}

.top-nav a {
    color: white;
    text-decoration: none;
    margin-left: 20px;
    font-size: 16px;
    font-weight: 500;
}

.top-nav a:hover {
    text-decoration: underline;
}

/* TITLE */
h2 {
    margin-top: 25px;
    color: #333;
}

/* TABLE WRAPPER */
table {
    width: 90%;
    margin: 25px auto;
    border-collapse: collapse;
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 3px 12px rgba(0,0,0,0.1);
}

/* TABLE HEADER */
table th {
    background: #075e54;
    color: white;
    padding: 12px;
    font-size: 15px;
    text-align: left;
}

/* TABLE ROW */
table tr {
    border-bottom: 1px solid #eee;
}

table td {
    padding: 12px;
    font-size: 15px;
    color: #333;
}

/* HOVER EFFECT */
table tr:hover {
    background: #a2fcca2d;
}

/* STATUS BADGES */
.status-badge {
    padding: 5px 10px;
    border-radius: 20px;
    color: white;
    font-weight: bold;
    font-size: 13px;
}

.status-open { background: #e74c3c; }
.status-progress { background: #f1c40f; color:black; }
.status-resolved { background: #2ecc71; }
.status-pending { background: #7f8c8d; }

/* Buttons */
button {
    padding: 8px 12px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 14px;
}

button:hover {
    opacity: 0.85;
}

.view-btn {
    background: #0A84FF;
    color: white;
}

.delete-btn {
    background: #e74c3c;
    color: white;
}

</style>

<%
    // Handle Delete
    String deleteId = request.getParameter("deleteId");
    if (deleteId != null && !deleteId.trim().isEmpty()) {
        deleteId = deleteId.trim();

        // Delete from bugs.txt
        String path = application.getRealPath("/data/bugs.txt");
        List<String> lines = FileHelper.readAll(path);
        List<String> updatedBugs = new ArrayList<>();
        for (String s : lines) {
            String[] p = s.split("\\|");
            if (!p[0].trim().equals(deleteId)) updatedBugs.add(s);
        }
        FileHelper.writeAll(path, updatedBugs);

        // Delete related comments
        String commentsPath = application.getRealPath("/data/comments.txt");
        List<String> commentLines = FileHelper.readAll(commentsPath);
        List<String> updatedComments = new ArrayList<>();
        for (String c : commentLines) {
            String[] pc = c.split("\\|");
            if (!pc[0].trim().equals(deleteId)) updatedComments.add(c);
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
    String path = application.getRealPath("/data/bugs.txt");
    List<String> lines = FileHelper.readAll(path);

    String commentsPath = application.getRealPath("/data/comments.txt");
    List<String> commentLines = FileHelper.readAll(commentsPath);
    Map<String, Integer> commentCount = new HashMap<>();
    for (String c : commentLines) {
        String[] pc = c.split("\\|");
        if (pc.length >= 2) {
            String id = pc[0].trim();
            commentCount.put(id, commentCount.getOrDefault(id, 0) + 1);
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
        <th>Status</th>
        <th>Comments</th>
        <th>Actions</th>
    </tr>

<%
    for (String s : lines) {
        String[] p = s.split("\\|");
        for (int i = 0; i < p.length; i++) p[i] = p[i].trim();
        String id = p[0];
        String status = (p.length >= 5) ? p[4] : "Pending";
        int count = commentCount.getOrDefault(id, 0);
%>

<tr>
    <td><%= id %></td>
    <td><%= p[1] %></td>
    <td><%= p[2] %></td>
    <td><%= p[3] %></td>
    <td><%= status %></td>
    <td>
        <p><%= count %> Comments</p>
        <form action="viewComments.jsp" method="get">
            <input type="hidden" name="id" value="<%= id %>">
            <button type="submit">View Comments</button>
        </form>
    </td>
    <td>
        <form method="get" style="display:inline;">
            <input type="hidden" name="deleteId" value="<%= id %>">
            <button class="delete-btn"><i class="fa-solid fa-trash"></i></button>
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

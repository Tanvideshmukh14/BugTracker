<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">

<nav class="top-nav">
    <div class="nav-left"><h1 class="brand">Developer Panel</h1></div>
    <div class="nav-links"><a href="devViewBugs.jsp">View Bugs</a></div>
</nav>

<h2 style="text-align:center;">All Reported Bugs</h2>

<%
    // Handle Status Update
    String updateId = request.getParameter("updateId");
    String newStatus = request.getParameter("status");
    if (updateId != null && newStatus != null) {
        updateId = updateId.trim();
        newStatus = newStatus.trim();

        String bugPath = application.getRealPath("/data/bugs.txt");
        List<String> lines = FileHelper.readAll(bugPath);
        List<String> updatedBugs = new ArrayList<>();

        for (String s : lines) {
            String[] p = s.split("\\|");
            for (int i=0;i<p.length;i++) p[i] = p[i].trim();
            if (p[0].equals(updateId)) {
                // Keep other fields and update status
                String updatedLine = p[0] + "|" + p[1] + "|" + p[2] + "|" + p[3] + "|" + newStatus;
                updatedBugs.add(updatedLine);
            } else {
                updatedBugs.add(s);
            }
        }
        FileHelper.writeAll(bugPath, updatedBugs);
        out.println("<p style='color:green; text-align:center;'>Bug ID " + updateId + " status updated to " + newStatus + "!</p>");
    }

    // Read bugs to display
    String path = application.getRealPath("/data/bugs.txt");
    List<String> lines = FileHelper.readAll(path);

    if (lines.isEmpty()) { %>
        <p style="text-align:center;">No bugs found.</p>
<%  } else { %>

<table border="1" style="width:90%; margin:auto;">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Severity</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>

<%
    for (String s : lines) {
        String[] p = s.split("\\|");
        for (int i=0;i<p.length;i++) p[i] = p[i].trim();
        String status = (p.length>=5)?p[4]:"Pending";
%>

<tr>
    <td><%= p[0] %></td>
    <td><%= p[1] %></td>
    <td><%= p[2] %></td>
    <td><%= p[3] %></td>
    <td>
        <form method="get" style="margin:0;">
            <input type="hidden" name="updateId" value="<%= p[0] %>">
            <select name="status" onchange="this.form.submit()">
                <option value="Pending" <%= "Pending".equals(status)?"selected":"" %>>Pending</option>
                <option value="In Progress" <%= "In Progress".equals(status)?"selected":"" %>>In Progress</option>
                <option value="Completed" <%= "Completed".equals(status)?"selected":"" %>>Completed</option>
            </select>
        </form>
    </td>
    <td>
        <a href="devAddComment.jsp?id=<%= p[0] %>">Add Comment</a>
    </td>
</tr>

<%
    }
%>
</table>
<%
    }
%>

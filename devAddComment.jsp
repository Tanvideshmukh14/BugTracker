<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">

<nav class="top-nav">
    <div class="nav-left">
        <h1 class="brand">Developer Panel</h1>
    </div>

    <div class="nav-links">
        <a href="devViewBugs.jsp">Back to Bugs</a>
    </div>
</nav>

<%
    String bugId = request.getParameter("id");
    if (bugId != null) bugId = bugId.trim();

    String bugTitle = "Unknown Bug";

    String bugPath = application.getRealPath("/data/bugs.txt");
    List<String> bugList = FileHelper.readAll(bugPath);

    // ✅ Fetch Bug Title (TRIM FIX APPLIED)
    for (String b : bugList) {

        if (b.trim().isEmpty()) continue;

        String[] p = b.split("\\|");

        if (p.length >= 2) {
            String fileId = p[0].trim();     // Trim spaces
            String title = p[1].trim();      // Trim spaces

            if (fileId.equals(bugId)) {
                bugTitle = title;
                break;
            }
        }
    }

    String commentsPath = application.getRealPath("/data/comments.txt");

    // Handle Comment Submission
    if ("POST".equals(request.getMethod())) {
        String comment = request.getParameter("comment");
        String record = bugId + "|" + comment + "|" + new Date().toString();

        FileHelper.writeLine(commentsPath, record);
%>
        <p class="success-msg">Comment Added Successfully!</p>
<%
    }
%>

<div class="form-wrapper">
    <div class="form-card">
        <h2>Add Comment for: <span style="color:#0077cc;"><%= bugTitle %></span></h2>

        <form method="post">
            <textarea name="comment" required placeholder="Enter your solution or comment"></textarea>
            <br><br>
            <button type="submit">Submit Comment</button>
        </form>
    </div>
</div>

<h3 style="text-align:center;">Previous Comments</h3>

<%
    List<String> list = FileHelper.readAll(commentsPath);
    boolean hasComments = false;

    for (String c : list) {

        if (c.trim().isEmpty()) continue;

        String[] p = c.split("\\|");

        if (p.length >= 3) {
            if (p[0].trim().equals(bugId)) {
                hasComments = true;
%>

<div class="card" style="max-width:600px;margin:10px auto;">
    <p><strong>Comment:</strong> <%= p[1] %></p>
    <p class="text-muted"><%= p[2] %></p>
</div>

<%
            }
        }
    }

    if (!hasComments) {
%>
        <p style="text-align:center;" class="text-muted">No comments yet.</p>
<%
    }
%>

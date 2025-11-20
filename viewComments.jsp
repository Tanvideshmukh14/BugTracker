<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">

<style>
body { margin:0; padding:0; display:flex; flex-direction:column; height:100vh; background:#f7f7f7; }
.comments-container { flex:1; overflow-y:auto; padding:20px; margin-bottom:120px; }
.comment-bubble { max-width:70%; padding:12px 15px; border-radius:10px; margin:10px 0; box-shadow:0 2px 5px rgba(0,0,0,0.1); }
.comment-time { font-size:12px; color:#989696; margin-top:5px; }

/* USER SIDE ALIGNMENT */
.comment-dev { background:#c3e6ff; color:rgb(0, 0, 0); margin-right:auto; text-align:left; }  /* DEV = left side */
.comment-user { background:#e0e0e0; color:black; margin-left:auto; text-align:right; }  /* USER = right side */

.bottom-input { position:fixed; bottom:0; left:0; width:100%; background:white; padding:15px; border-top:2px solid #ddd; display:flex; gap:10px; align-items:center; }
.bottom-input textarea { flex:1; height:60px; resize:none; padding:10px; border-radius:8px; border:1px solid #ccc; }
.bottom-input button { background:#0077cc; color:white; padding:10px 20px; border:none; border-radius:8px; cursor:pointer; }

.top-nav { background:#0077cc; color:white; padding:15px 20px; display:flex; justify-content:space-between; align-items:center; }
</style>

<nav class="top-nav">
    <div><h2 style="margin:0;">Bug Comments</h2></div>
    <div><a href="viewBugs.jsp" style="color:white; text-decoration:none;">Back</a></div>
</nav>

<%
String bugId = request.getParameter("id");
if (bugId != null) bugId = bugId.trim();
if (bugId == null || bugId.isEmpty()) { out.print("<p style='text-align:center;margin-top:20px;'>No bug selected.</p>"); return; }

// Get bug title
String bugPath = application.getRealPath("/data/bugs.txt");
List<String> bugs = FileHelper.readAll(bugPath);
String bugTitle = "Unknown Bug";
for (String s : bugs) {
    if (s.trim().isEmpty()) continue;
    String[] p = s.split("\\|");
    if (p.length >= 2 && p[0].trim().equals(bugId)) { bugTitle = p[1].trim(); break; }
}

// Load comments path
String commentsPath = application.getRealPath("/data/comments.txt");

// Handle user comment submission
if ("POST".equals(request.getMethod())) {
    String comment = request.getParameter("comment").trim();
    if (!comment.isEmpty()) {
        String record = bugId + "|USER|" + comment + "|" + new Date().toString();
        FileHelper.writeLine(commentsPath, record);
    }
}

// Reload comments
List<String> allComments = FileHelper.readAll(commentsPath);
%>

<div class="comments-container">
    <h3 style="text-align:center;">Bug: <%= bugTitle %> (ID: <%= bugId %>)</h3>

<%
boolean hasComments = false;
for (String c : allComments) {
    if (c.trim().isEmpty()) continue;
    String[] p = c.split("\\|");
    if (p.length >= 4 && p[0].trim().equals(bugId)) {
        hasComments = true;
        String type = p[1].trim();
        String msg = p[2].trim();
        String time = p[3].trim();
%>
    <div class="comment-bubble <%= type.equals("DEV") ? "comment-dev" : "comment-user" %>">
        <%= msg %>
        <div class="comment-time"><%= time %></div>
    </div>
<%
    }
}

if (!hasComments) {
%>
<p style="text-align:center; color:#666;">No comments yet.</p>
<%
}
%>
</div>

<!-- Bottom input for user comment -->
<form method="post" class="bottom-input">
    <textarea name="comment" required placeholder="Write a message..."></textarea>
    <button type="submit">Send</button>
</form>

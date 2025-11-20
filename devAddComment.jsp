<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">

<style>
body { margin:0; padding:0; display:flex; flex-direction:column; height:100vh; background:#f7f7f7; }
.comments-container { flex:1; overflow-y:auto; padding:20px; margin-bottom:120px; }
.comment-bubble { max-width:70%; padding:12px 15px; border-radius:10px; margin:10px 0; box-shadow:0 2px 5px rgba(0,0,0,0.1); }
.comment-time { font-size:12px; color:#777; margin-top:5px; }
.comment-dev { background:#e0e0e0; color:rgb(0, 0, 0); margin-left:auto; text-align:right; }  /* Right side for DEV */
.comment-user { background:#c3e6ff; color:black; margin-right:auto; text-align:left; }  /* Left side for USER */
.bottom-input { position:fixed; bottom:0; left:0; width:100%; background:white; padding:15px; border-top:2px solid #ddd; display:flex; gap:10px; align-items:center; }
.bottom-input textarea { flex:1; height:60px; resize:none; padding:10px; border-radius:8px; border:1px solid #ccc; }
.bottom-input button { background:#0077cc; color:white; padding:10px 20px; border:none; border-radius:8px; cursor:pointer; }
.top-nav { background:#0077cc; color:white; padding:15px 20px; display:flex; justify-content:space-between; align-items:center; }
</style>

<nav class="top-nav">
    <div><h2 style="margin:0;">Bug Comments</h2></div>
    <div><a href="devViewBugs.jsp" style="color:white; text-decoration:none;">Back</a></div>
</nav>

<%
String bugId = request.getParameter("id");
if (bugId != null) bugId = bugId.trim();

String bugTitle = "Unknown Bug";
String bugPath = application.getRealPath("/data/bugs.txt");
List<String> bugList = FileHelper.readAll(bugPath);
for (String b : bugList) {
    if (b.trim().isEmpty()) continue;
    String[] p = b.split("\\|");
    if (p.length >= 2 && p[0].trim().equals(bugId)) { bugTitle = p[1].trim(); break; }
}

String commentsPath = application.getRealPath("/data/comments.txt");

// Handle developer comment submission
if ("POST".equals(request.getMethod())) {
    String comment = request.getParameter("comment").trim();
    if (!comment.isEmpty()) {
        String record = bugId + "|DEV|" + comment + "|" + new Date().toString();
        FileHelper.writeLine(commentsPath, record);
    }
}

// Reload all comments
List<String> allComments = FileHelper.readAll(commentsPath);
%>

<div class="comments-container">
    <h3>Bug: <%= bugTitle %> (ID: <%= bugId %>)</h3>

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
<p class="text-muted" style="text-align:center;">No comments yet.</p>
<%
}
%>
</div>

<form method="post" class="bottom-input">
    <textarea name="comment" required placeholder="Write a message..."></textarea>
    <button type="submit">Send</button>
</form>

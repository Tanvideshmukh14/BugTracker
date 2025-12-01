<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">

<style>
    body {
    margin: 0;
    padding: 0 10%;
    display: flex;
    flex-direction: column;
    height: 100vh;
    font-family: "Segoe UI", sans-serif;
    background: #e5ddd5; /* WhatsApp chat background */
}

/* TOP NAV (WhatsApp style header) */
.top-nav {
    background: #075e54;
    color: white;
    padding: 15px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 6px rgba(0,0,0,0.3);
}

.top-nav h2 {
    margin: 0;
    font-size: 20px;
    font-weight: 500;
}

.top-nav a {
    color: white;
    text-decoration: none;
    font-weight: 500;
}

/* MAIN CHAT AREA */
.comments-container {
    flex: 1;
    overflow-y: auto;
    padding: 20px;
    margin-bottom: 100px;
    background-image: url("commentsbg.jpg"); 
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
}

/* CHAT BUBBLES */
.comment-bubble {
    display: block;           /* forces each bubble to its own line */
    width: fit-content;       /* bubble shrinks to message width */
    max-width: 55%;           /* WhatsApp-style width */
    padding: 10px 14px;
    margin: 10px 0;
    border-radius: 12px;
    line-height: 1.5;
    font-size: 14px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.2);
}

/* USER (right side) */
.comment-user {
    background: #dcf8c6;
    margin-left: auto;        /* push to right */
    margin-right: 12px;
    border-top-right-radius: 0;
}

/* DEV (left side) */
.comment-dev {
    background: #ffffff;
    margin-right: auto;       /* push to left */
    margin-left: 12px;
    border-top-left-radius: 0;
}

/* TIME */
.comment-time {
    font-size: 11px;
    color: #65737e;
    margin-top: 5px;
    text-align: right;
}

/* BOTTOM INPUT BAR */
.bottom-input {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    background: #f0f0f0;
    padding: 10px 15px;
    border-top: 1px solid #ddd;
    display: flex;
    gap: 10px;
    align-items: center;
}

.bottom-input textarea {
    flex: 1;
    height: 45px;
    resize: none;
    padding: 10px;
    border-radius: 20px;
    border: 1px solid #ccc;
    outline: none;
    background: white;
    font-size: 14px;
}

/* SEND BUTTON */
.bottom-input button {
    background: #128c7e;
    color: white;
    padding: 10px 18px;
    border: none;
    border-radius: 50px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: 0.25s;
}

.bottom-input button:hover {
    background: #0d7d71;
}

</style>

<nav class="top-nav">
    <div><h2 style="margin:0;">Bug Comments</h2></div>
    <div><a href="viewBugs.jsp" style="color:white; text-decoration:none;">X</a></div>
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

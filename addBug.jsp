<%@ page import="model.Bug, utils.FileHelper, java.util.*" %>
<link rel="stylesheet" href="css/styles.css">
<!-- Navigation -->
<nav class="top-nav">
    <div class="nav-left">
        <h1 class="brand">Bug Mini</h1>
    </div>

    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="updateBug.jsp">Update Bug</a>
        <a href="viewBugs.jsp">View Bugs</a>
    </div>
</nav>

<%
    String path = application.getRealPath("/data/bugs.txt");

    if (request.getMethod().equals("POST")) {
        String title = request.getParameter("title");
        String desc = request.getParameter("desc");
        String severity = request.getParameter("severity");

        List<String> lines = FileHelper.readAll(path);
        int nextId = lines.size() + 1;

        Bug b = new Bug(nextId, title, desc, severity);

        String record = nextId + "|" + title + "|" + desc + "|" + severity;
        FileHelper.writeLine(path, record);

        out.println("<h3>Bug Added Successfully!</h3>");
    }
%>


<div class="form-wrapper">
    
    <div class="form-card">
        <h2 style="text-align: center;">Add Bug</h2>
        <form method="post">
            Title: <input type="text" name="title"><br><br>

            Description: <input type="text" name="desc"><br><br>

            Severity:
            <select name="severity">
                <option>Low</option>
                <option>Medium</option>
                <option>High</option>
            </select><br><br>

            <button type="submit">Save Bug</button>
        </form>
    </div>
</div>


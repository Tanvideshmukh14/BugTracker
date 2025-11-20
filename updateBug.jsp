<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">
<!-- Navigation -->
<nav class="top-nav">
    <div class="nav-left">
        <h1 class="brand">Bug Mini</h1>
    </div>

    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="addBug.jsp">Add Bug</a>
        <a href="viewBugs.jsp">View Bugs</a>
    </div>
</nav>
<%
    String path = application.getRealPath("/data/bugs.txt");

    // When form submitted
    if ("POST".equals(request.getMethod())) {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String desc = request.getParameter("desc");
        String severity = request.getParameter("severity");

        List<String> lines = FileHelper.readAll(path);
        List<String> updated = new ArrayList<>();

        for (String line : lines) {
            String[] p = line.split("\\|");
            if (p[0].equals(id)) {
                updated.add(id + "|" + title + "|" + desc + "|" + severity);
            } else {
                updated.add(line);
            }
        }

        FileHelper.writeAll(path, updated);
%>
    <p class="success-msg">Bug Updated Successfully!</p>
<%
    }
%>
<div class="form-wrapper">
    <div class="form-card">

        <h2 style="text-align:center;">Update Bug</h2>

        <form method="post">

            <label>Enter Bug ID to Update:</label>
            <input type="number" name="id" required><br><br>

            <label>New Title:</label>
            <input type="text" name="title" required><br><br>

            <label>New Description:</label>
            <input type="text" name="desc" required><br><br>

            <label>New Severity:</label>
            <select name="severity">
                <option>Low</option>
                <option>Medium</option>
                <option>High</option>
            </select><br><br>

            <button type="submit">Update Bug</button>

        </form>

    </div>
</div>



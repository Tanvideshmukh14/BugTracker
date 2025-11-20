<%@ page import="java.util.*, utils.FileHelper" %>

<link rel="stylesheet" href="css/styles.css">

<h2>Bug Comments</h2>

<%
    String bugId = request.getParameter("id");

    if (bugId == null) {
        out.print("<p>No bug selected.</p>");
        return;
    }

    String path = application.getRealPath("/data/bugs.txt");
    List<String> lines = FileHelper.readAll(path);

    String foundComment = null;
    String title = "";

    for (String s : lines) {
        String[] p = s.split("\\|");
        for (int i = 0; i < p.length; i++) p[i] = p[i].trim();

        if (p[0].equals(bugId)) {
            title = p[1];
            if (p.length > 4) {
                foundComment = p[4];
            }
            break;
        }
    }
%>

<h3>Bug ID: <%= bugId %></h3>
<h3>Title: <%= title %></h3>

<p><strong>Comments:</strong></p>

<p style="background:#f2f2f2; padding:10px; border-radius:5px;">
<%= foundComment != null ? foundComment : "No comments for this bug." %>
</p>

<br>

<a href="viewBugs.jsp">Back to Bugs</a>

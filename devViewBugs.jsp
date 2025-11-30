<%@ page import="java.util.*, utils.FileHelper" %>
<link rel="stylesheet" href="css/styles.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
/* ---- GLOBAL ---- */
body {
    font-family: Arial, sans-serif;
    background: #f6f7fb;
    margin: 0;
    padding: 0;
}

/* ---- TOP NAV ---- */
.top-nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #0d7d71;
    color: #fff;
    padding: 12px 30px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.top-nav .brand {
    margin: 0;
}
.top-nav .nav-links a {
    color: #fff;
    margin-left: 20px;
    text-decoration: none;
    font-weight: 600;
    border: 1px solid white;
    padding: 6px 14px;
    border-radius: 5px;
}

.top-nav .nav-links a:hover {
    background: black;
    color: white;
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.35);
}


/* ---- TABLE ---- */
table {
    width: 90%;
    margin: 25px auto;
    border-collapse: collapse;
    background: #fff;
    border-radius: 8px;
    overflow: hidden;
}

table th {
    background: #0d7d71;
    color: white;
    padding: 12px;
    text-align: center;
}

table td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

tr:hover {
    background: #dbf9c753;
}

/* ---- STATUS DROPDOWN ---- */
select {
    padding: 6px;
    border-radius: 5px;
    border: 1px solid #b2bec3;
    background: #fff;
}

select:focus {
    outline: none;
    border-color: grey;
}

/* ---- ACTION LINK ---- */
td a {
    text-decoration: none;
    background: #d7d7d7 ;
    color: black;
    padding: 6px 12px;
    border-radius: 5px;
    font-size: 14px;
}

td a:hover {
    background: #0d7d71;
    color:white;
}

/* ---- SUCCESS MESSAGE ---- */
.success-msg {
    text-align: center;
    color: green;
    font-weight: bold;
}
.brand{
    color: white;
}
.logout-btn {
        text-decoration: none;
        padding: 10px 20px;
        background: #e5ddd5;
        color: #075e54;
        font-weight: 600;
        border-radius: 10px;
        transition: 0.3s ease;
        border: 1px solid white;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }

    .logout-btn:hover {
        background: black;
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.35);
    }
    /* 🔥 Top Navigation Bar — Matching Tester Panel */
.top-nav {
    position: fixed;
    top: 0;
    width: 100%;
    background: #075e54;   /* Same tester panel green */
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 5px 20px rgba(0,0,0,0.3);
    z-index: 1000;
}

.top-nav .brand {
    color: #fff;
    font-size: 26px;
    font-weight: 700;
}

.logout-btn {
    text-decoration: none;
    padding: 10px 20px;
    background: white;
    color: #075e54;
    font-weight: 600;
    border-radius: 10px;
    transition: 0.3s ease;
    border: 1px solid white;
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
}

.logout-btn:hover {
    background: black;
    color: white;
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.35);
}

/* Page padding so content doesn't hide behind fixed nav */
body {
    padding-top: 90px;
}

</style>

<nav class="top-nav">
    <h1 class="brand">Developer Panel</h1>
    <a href="login.html" class="logout-btn">
        <i class="fa-solid fa-right-from-bracket"></i> Logout
    </a>
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

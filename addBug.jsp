<%@ page import="model.Bug, utils.FileHelper, java.util.*" %>
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #e5ddd5;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .form-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        padding: 20px;

    }

    .form-card {
        background: #075e54;
        padding: 40px 50px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        backdrop-filter: blur(15px);
        width: 100%;
        max-width: 450px;
        color: #fff;
        text-align: center;
        animation: fadeIn 1s ease forwards;
    }

    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(-20px);}
        to {opacity: 1; transform: translateY(0);}
    }

    .form-card h2 {
        margin-bottom: 25px;
        font-size: 28px;
        text-shadow: 1px 1px 5px rgba(0,0,0,0.3);
    }

    .form-card input[type="text"],
    .form-card select {
        width: 100%;
        padding: 12px 15px;
        margin: 10px 0 20px;
        border-radius: 10px;
        border: none;
        outline: none;
        font-size: 16px;
        transition: 0.3s;
    }

    .form-card input[type="text"]:focus,
    .form-card select:focus {
        box-shadow: 0 0 10px rgba(255,255,255,0.5);
        background: rgba(255,255,255,0.2);
    }

    .form-card button {
        background: #e5ddd5;
        color: #075e54;
        border: none;
        border-radius: 12px;
        padding: 12px 25px;
        font-size: 18px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }

    .form-card button:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        background: black;
        color: white;
    }

    h3 {
        margin-top: 20px;
        color: #00ff99;
        text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
    }
    /* Navigation Styling */
.top-nav {
    background: #075e54;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    border-radius: 0 0 20px 20px;
}

.top-nav .nav-left .brand {
    color: #fff;
    font-size: 26px;
    font-weight: 700;
    letter-spacing: 1px;
    text-shadow: 1px 1px 5px rgba(0,0,0,0.3);
}

.top-nav .nav-links a {
    color: #fff;
    text-decoration: none;
    font-weight: 600;
    margin-left: 20px;
    padding: 8px 18px;
    border-radius: 12px;
    transition: all 0.3s ease;
    background: rgba(255, 255, 255, 0.1);
    box-shadow: 0 3px 10px rgba(0,0,0,0.2);
    border: 1px solid white
}

.top-nav .nav-links a:hover {
    background: white;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    transform: translateY(-3px);
    color: #075e54;
}

/* Optional: active page highlight */
.top-nav .nav-links a.active {
    background: linear-gradient(135deg, #ff6a3a, #ffb77b);
    box-shadow: 0 5px 15px rgba(0,0,0,0.4);
}


</style>
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


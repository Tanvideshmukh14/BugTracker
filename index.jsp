<link rel="stylesheet" href="css/styles.css">

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bug Tracker Home</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

    body {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        background: #e0e0e0;
        color: #fff;
        padding-top: 90px; /* so the nav doesn't overlap */
    }

    /* 🔥 Top Navigation Bar */
    .top-nav {
        position: fixed;
        top: 0;
        width: 100%;
        background: #075e54;
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

    .home-container {
        background: #075e54d5;
        padding: 60px 50px;
        border-radius: 20px;
        text-align: center;
        width: 90%;
        max-width: 900px;
        box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        backdrop-filter: blur(15px);
        animation: fadeIn 1s ease forwards;
    }

    @keyframes fadeIn {
        from {opacity:0; transform: translateY(-30px);}
        to {opacity:1; transform: translateY(0);}
    }

    .title { font-size:48px; font-weight:700; margin-bottom:10px; }

    .subtitle {
        font-size:18px; margin-bottom:50px; color:#e0e0e0; line-height:1.5;
    }

    .home-buttons {
        display:flex; justify-content:space-between; gap:20px; flex-wrap:nowrap;
    }

    .home-btn {
        display:flex; flex-direction:column; align-items:center; justify-content:center;
        text-decoration:none;
        padding:25px 20px;
        border-radius:15px;
        background:#e5ddd5;
        color:#0d7d71;
        font-weight:600;
        font-size:18px;
        transition:all 0.4s ease;
        box-shadow:0 8px 25px rgba(0,0,0,0.3);
        width:28%;
        min-width:150px;
        height:150px;
    }

    .home-btn i { font-size:36px; margin-bottom:10px; transition:0.3s; }

    .home-btn:hover {
        transform:translateY(-8px);
        background:black;
        color:#e0e0e0;
        box-shadow:0 15px 35px rgba(0,0,0,0.4);
    }

    .home-btn:hover i {
        transform:rotate(20deg) scale(1.2);
        color:#e5ddd5;
    }

    .soft-divider {
        height:3px;
        width:60%;
        margin:50px auto 0;
        background:rgba(255,255,255,0.2);
        border-radius:5px;
    }

    @media(max-width:800px){
        .home-buttons { flex-direction:column; }
        .home-btn { width:100%; }
    }

</style>
</head>

<body>

<!-- 🔥 Top Navigation with Logout -->
<nav class="top-nav">
    <h1 class="brand">Tester panel</h1>
    <a href="login.html" class="logout-btn">
        <i class="fa-solid fa-right-from-bracket"></i> Logout
    </a>
</nav>

<div class="home-container">
    <h1 class="title">Bug Tracker</h1>
    <p class="subtitle">Manage, track, and update bugs easily in your project.</p>

    <div class="home-buttons">
        <a class="home-btn" href="addBug.jsp">
            <i class="fa-solid fa-bug"></i>
            Add Bug
        </a>
        <a class="home-btn" href="viewBugs.jsp">
            <i class="fa-solid fa-eye"></i>
            View Bugs
        </a>
        <a class="home-btn" href="updateBug.jsp">
            <i class="fa-solid fa-pen-to-square"></i>
            Update Bugs
        </a>
    </div>

    <div class="soft-divider"></div>
</div>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Placement Portal</title>
 
  <link rel="stylesheet" href="./Landing_page/landinge_page_Style/style.css"/>
</head>
<body>
  <nav>
    <div class="logo">PLACEMENT PORTAL</div>

    <div class="menu-toggle" onclick="toggleMenu()">
      <span></span>
      <span></span>
      <span></span>
    </div>

    <div class="nav-links">
      <a href="./Company/companyhome.jsp">Company</a>
      <a href="#">About Us</a>
      <a href="#"> Blog </a>
    </div>

    <button class="download-btn">
      <span><a href="./Student_registration/registration.jsp">Register</a></span>
      <span> / </span>
      <span><a href="./Student_Login/StudentLogin.jsp">Login</a></span>
    </button>
  </nav>

  <section class="hero">
    <h1>Secure & <span>Easy-to-Get</span><br /> Placement</h1>
    <p>Job, Get & Search<br />in best companies</p>
    <button class="cta-btn"><a href="./Student_Login/StudentLogin.jsp">Get Started</a></button>
    <div class="download-badges">
      <img src="https://upload.wikimedia.org/wikipedia/commons/3/3c/Download_on_the_App_Store_Badge.svg" alt="App Store" class="badge" />
      <img src="https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_Store_badge_EN.svg" alt="Google Play" class="badge" />
    </div>
  </section>

  <script>
    function toggleMenu() {
      const navLinks = document.querySelector('.nav-links');
      navLinks.classList.toggle('active');
    }
  </script>
</body>
</html>

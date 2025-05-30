<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login Form</title>
  <link rel="stylesheet" href="./Student_Login_css/style.css">
 
 <link rel="stylesheet" href="${pageContext.request.contextPath}/Student_Login/Student_Login_css/style.css">
 
    
 
</head>
<body>
 
  <form class="form" action="${pageContext.request.contextPath}/StudentLogin" method="post">
    <div class="flex-column">
      <label>Email</label>
    </div>
    <div class="inputForm">
      <svg height="20" width="20" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
        <g><path d="M30.853 13.87a15 15 0 0 0-29.729 4.082 15.1 15.1 0 0 0 12.876 12.918 15.6 15.6 0 0 0 2.016.13 14.85 14.85 0 0 0 7.715-2.145 1 1 0 1 0-1.031-1.711 13.007 13.007 0 1 1 5.458-6.529 2.149 2.149 0 0 1-4.158-.759v-10.856a1 1 0 0 0-2 0v1.726a8 8 0 1 0 .2 10.325 4.135 4.135 0 0 0 7.83.274 15.2 15.2 0 0 0 .823-7.455zm-14.853 8.13a6 6 0 1 1 6-6 6.006 6.006 0 0 1-6 6z"/></g>
      </svg>
      <input type="text" placeholder="Enter your Email" name="email" required>
    </div>

    <div class="flex-column">
      <label>Password</label>
    </div>
    <div class="inputForm">
      <svg height="20" width="20" viewBox="-64 0 512 512" xmlns="http://www.w3.org/2000/svg">
        <path d="M336 512H48c-26.5 0-48-21.5-48-48V240c0-26.5 21.5-48 48-48h288c26.5 0 48 21.5 48 48v224c0 26.5-21.5 48-48 48zM48 224c-8.8 0-16 7.2-16 16v224c0 8.8 7.2 16 16 16h288c8.8 0 16-7.2 16-16V240c0-8.8-7.2-16-16-16z"/>
        <path d="M304 224c-8.8 0-16-7.2-16-16v-80c0-52.9-43.1-96-96-96s-96 43.1-96 96v80c0 8.8-7.2 16-16 16s-16-7.2-16-16v-80c0-70.6 57.4-128 128-128s128 57.4 128 128v80c0 8.8-7.2 16-16 16z"/>
      </svg>
      <input type="password" placeholder="Enter your Password" name="password" required>
    </div>

    <div class="flex-row">
      <div>
        <input type="checkbox" id="remember">
        <label for="remember">Remember me</label>
      </div>
      <span class="span">Forgot password?</span>
    </div>

    <button type="submit" class="button-submit">Sign In</button>

    <p class="p">Don't have an account? <span class="span"><a href="${pageContext.request.contextPath}/Student_registration/registration.jsp">Sign Up</a></span></p>
    <p class="p line">Or With</p>

    <div class="flex-row">
      <button type="button" class="btn google">Google</button>
      <button type="button" class="btn apple">Apple</button>
    </div>
  </form>

  <%-- Display alert if errorMessage attribute exists --%>
  <%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
  %>
      <script>
          alert("<%= errorMessage.replace("\"", "\\\"") %>");
      </script>
  <%
    }
  %>

</body>
</html>

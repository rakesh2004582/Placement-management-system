<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(120deg, #8e44ad, #3498db);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      padding: 20px;
    }

    .container {
      background-color: white;
      padding: 30px;
      border-radius: 15px;
      width: 100%;
      max-width: 400px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
      animation: fadeIn 0.8s ease-in;
    }

    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(-20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #333;
    }

    .form-group {
      margin-bottom: 15px;
    }

    label {
      display: block;
      margin-bottom: 6px;
      color: #555;
    }

    input {
      width: 100%;
      padding: 10px;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 15px;
    }

    input:focus {
      outline: none;
      border-color: #8e44ad;
    }

    .btn {
      width: 100%;
      padding: 12px;
      background: #8e44ad;
      color: white;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: 0.3s;
    }

    .btn:hover {
      background: #732d91;
    }

    .register-link {
      margin-top: 12px;
      text-align: center;
    }

    .register-link a {
      text-decoration: none;
      color: #8e44ad;
      font-weight: bold;
    }
  </style>
</head>
<body>

 
  <div class="container">
    <h2>Login</h2>
    <%-- show error message if login fails --%>
    <%
    String error = request.getParameter("error");
    if ("invalid".equals(error)) {
%>
    <p style="color:red; text-align:center;">Invalid company name or password!</p>
<%
    }
%>
   <form action="<%=request.getContextPath()%>/CompanyLogin" method="post">
   <!--<form action="/Placement-Management-System/CompanyLogin" method="post">
     -->
      <div class="form-group">
        <label>Company Name</label>
        <input type="text" id="loginCompany" name="company" required>
      </div>
      <div class="form-group">
        <label>Password</label>
        <input type="password" id="loginPassword" name="password" required>
      </div>
      <button class="btn" type="submit">Login</button>
    </form>
    <div class="register-link">
      Not registered? <a href="./companyhome.jsp">Register Here</a>
    </div>
  </div>
    <script>
/*  function loginUser(event) {
      event.preventDefault();
      
      const company = document.getElementById("loginCompany").value;
      const password = document.getElementById("loginPassword").value;

      const user = JSON.parse(localStorage.getItem("registeredUser"));

      if (user && user.company === company && user.password === password) {
        alert("Login successful!");
        // Redirect or do something after login
        // window.location.href = "dashboard.html"; // future use
      } else {
        alert("Invalid credentials!");
      
      }
      
    }  */
  </script>
</body>
</html>

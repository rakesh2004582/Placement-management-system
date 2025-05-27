<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Company Register</title>
</head>
<link rel="stylesheet" href="./CompanyReg/style.css">
<script src="./CompanyReg/script.js"></script>
<body>
 <div class="container">
    <h2> Company Register</h2>
    
       <!-- <form onsubmit="registerUser()" action="CompanyReg" method="post" style="padding-left:28px">-->
      <form action="<%= request.getContextPath() %>/CompanyReg" method="post" style="padding-left:28px">
      <!--        <form onsubmit="registerUser()" action="../CompanyReg" method="post" style="padding-left:28px"> -->
      <div class="form-row">
        <div class="form-group">
          <label>Company Name</label>
          <input type="text" id="company" name="cname" required>
        </div>
        <div class="form-group">
          <label>10th Percentage</label>
          <input type="number" id="tenth"  name="tength"required>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>12th Percentage</label>
          <input type="number" id="twelfth" name="twelfth" required>
        </div>
        <div class="form-group">
          <label>Higher Education Name</label>
          <input type="text" id="education" name="heducation" required>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Higher Education % / CGPA</label>
          <input type="text" id="edu_percent" name="hpersentage" required>
        </div>
        <div class="form-group">
          <label>Password</label>
          <input type="password" id="password" name="cpass" required>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Confirm Password</label>
          <input type="password" id="confirmPassword" required oninput="validatePasswordMatch()">
          <div id="passwordError" class="error"></div>
        </div>
      </div>

      <button class="btn" type="submit" id="submitBtn">Register</button>
    </form>
    <div class="login-link">
      Already Registered? <a href="./companyLogin.jsp">Login Here</a>
    </div>
  </div>

</body>
</html>

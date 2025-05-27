<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Student Registration</title>
    <link rel="stylesheet" href="./StudentRegistration_css/style.css" />
  </head>

  <body>
    <h1>🎓 Student Registration</h1>

    <!-- <form action="${pageContext.request.contextPath}/RegisterStudentServlet" method="post" onsubmit="return validatePasswords()" id="myForm uploadForm"> -->
      <!-- <form action="${pageContext.request.contextPath}/RegisterStudentServlet" method="post" enctype="multipart/form-data" onsubmit="return validatePasswords()" id="myForm uploadForm"> -->
        <form action="${pageContext.request.contextPath}/RegisterStudentServlet" method="post" enctype="multipart/form-data" onsubmit="return validatePasswords()" id="myForm">


      <h3>Personal Details</h3>

      <!-- First row -->
      <div class="row">
        <div class="group">
          <input required type="text" class="input" name="name" />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Full Name </label>
        </div>
        <div class="group">
          <input required type="email" class="input" name="email" />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>email </label>
        </div>
      </div>

      <!-- Second row -->
      <div class="row">
        <div class="group">
          <input required type="text" class="input" name="contact" />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Mobile Number </label>
        </div>
        <div class="group">
          <input required type="text" class="input" name="address"/>
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>City </label>
        </div>
      </div>

      <h3>Educational Details</h3>
      <div class="row">
        <div class="group">
          <input required type="text" class="input" name="tenth"/>
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>10th Percentage </label>
        </div>
        <div class="group">
          <input required type="text" class="input" name="twelfth" />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>12th Percentage </label>
        </div>
      </div>

      <div class="row">
        <div class="group">
          <input required type="text" class="input" name="degree" />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>UG Degree </label>
        </div>
        <div class="group">
          <input required type="text" class="input" name="gradPercent"/>
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Graduation Percentage </label>
        </div>
      </div>

      <div class="row">
        <div class="group">
          <input required type="text" class="input" name="gradYear" />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>UG passing year </label>
        </div>
        <div class="group">
          <input required type="text" class="input" name="pgDegree" />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label> PG Degree</label>
        </div>
      </div>

      <h3>Skills & Experience</h3>
      <div class="row">
        <div class="group">
          <input required type="text" class="input" name="skills"/>
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Skills </label>
        </div>
        <div class="group">
          <input
            required
            type="text"
            class="input"
            name="experience"

          />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Experience </label>
        </div>
      </div>
<div class="row">
   <div class="group">
          <input
            required
            type="text"
            class="input"
           name="jobTitle"

          />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>job Title </label>
        </div>
</div>
      <h3>Project Details</h3>
      <div class="row">
        <div class="group">
          <input required type="text" class="input" name="projectTitle" />
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Project Name </label>
        </div>
        <!-- --tech used input -->
                <div class="group">
          <input required type="text" class="input" name="techUsed"/>
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Technology used  </label>
        </div>
        <div class="group">
          <input required type="text" class="input" name="projectDescription"/>
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Project Description </label>
        </div>
      </div>

      <div id="project-container"></div>
      <button type="button" class="add-prj-btn" onclick="addProject()">
        Add Project
      </button>

      <!-----security------->
<h3>Security</h3>
 <div class="row">
    <div class="group">
      <input required type="password" class="input" id="password" name="password" />
      <span class="highlight"></span>
      <span class="bar"></span>
      <label>Password</label>
      <span class="toggle-password" onclick="togglePassword('password', this)">👁️</span>
    </div>

    <div class="group">
      <input required type="password" class="input" id="confirmPassword" name="confirmPassword" />
      <span class="highlight"></span>
      <span class="bar"></span>
      <label>Confirm Password</label>
      <span class="toggle-password" onclick="togglePassword('confirmPassword', this)">👁️</span>
      <div id="passwordError" style="color: red; font-size: 14px; margin-top: 5px;"></div>
    </div>
  </div>

  <h3>Upload Details</h3>
  <div class="row">
    <div class="group">
    <span for="pdf">Upload Resume</span>
      <input required type="file" class="input" name="resume" id="pdf" accept=".pdf" />
      <span class="highlight"></span>
      <span class="bar"></span>
     <!--  <label for="image">Upload Resume</label>-->
    </div>
    <div class="group">
        <span for="pdf">Upload Image</span>
      <input required type="file" class="input" name="photo"  accept=".jpg, .jpeg, .png"/>
      <span class="highlight"></span>
      <span class="bar"></span>
      <!-- <label for="pdf">Upload Photo</label>  -->
    </div>
  </div>
    <p id="message" style="color: red"></p>
<!-- <br> -->
 <div class="row">
   <input type="submit" value="Submit" />
      <input type="reset" value="Reset" />
 </div>
      
    </form>
     <script src="./StudentRegistration_js/Script.js"></script>
  </body>
</html>

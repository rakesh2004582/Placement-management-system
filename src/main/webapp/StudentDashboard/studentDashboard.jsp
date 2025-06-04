 

<%@ page import="java.sql.*, javax.sql.*,java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 
 

<%
    String email = (String) session.getAttribute("studentEmail");
System.out.println("Get Gmail : "+email);

    if (email == null) {
        response.sendRedirect(request.getContextPath() + "/Student_Login/StudentLogin.jsp");
        return;
    }

    String name = "", gmail = "", contact = "", city = "", degree = "", imageurl = "", skills = "";
    int companyCount = 0;
    int eligibleCompanyCount = 0;

    float tenthPercent = 0, twelfthPercent = 0, graduationPercent = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementManagementSystem", "root", "123456");

        // Get student details and percentages
        PreparedStatement ps = con.prepareStatement("SELECT * FROM student_registration WHERE email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            gmail = rs.getString("email");
            contact = rs.getString("contact");
            city = rs.getString("address");
            degree = rs.getString("degree");
            imageurl = rs.getString("image");
            skills = rs.getString("skills");

            tenthPercent = rs.getFloat("tenth_percent");
            twelfthPercent = rs.getFloat("twelfth_percent");
            graduationPercent = rs.getFloat("grad_percent");
            System.out.println("Image URL : "+imageurl);
        }

        // Total registered companies
        PreparedStatement cs = con.prepareStatement("SELECT COUNT(*) AS total FROM company_register");
        ResultSet crs = cs.executeQuery();
        if (crs.next()) {
            companyCount = crs.getInt("total");
        }

        // Count companies student is eligible for based on percentages
        PreparedStatement eligiblePs = con.prepareStatement(
            "SELECT COUNT(*) AS eligibleTotal FROM company_register " +
            "WHERE ? >= tenthpercentage AND ? >= twelfthpercentage AND ? >= highereducation_percent"
        );
        eligiblePs.setFloat(1, tenthPercent);
        eligiblePs.setFloat(2, twelfthPercent);
        eligiblePs.setFloat(3, graduationPercent);

        ResultSet ers = eligiblePs.executeQuery();
        if (ers.next()) {
            eligibleCompanyCount = ers.getInt("eligibleTotal");
        }

        // Close all
        rs.close();
        ps.close();
        crs.close();
        cs.close();
        ers.close();
        eligiblePs.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!-- update 04-06-25  -->

<%
String StudentName=name;
String StudentMob=contact;
int countcompany=0;
List<String> compnies = new ArrayList<>();
try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");
	String sql="SELECT companyname FROM SelectedStudent WHERE name = ? AND mob = ?";
	 PreparedStatement ps = con.prepareStatement(sql);
     ps.setString(1, StudentName);
     ps.setString(2, StudentMob);
     ResultSet rs = ps.executeQuery();
     
     while(rs.next()){
    	 compnies.add(rs.getString("companyname"));
     }
     countcompany=compnies.size();
     
     rs.close();
     ps.close();
     con.close();
}catch(Exception e){
	out.println("Error : "+e.getMessage());
	System.out.println("Error :"+e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>

    <link rel="stylesheet" href="./StudentDashBoard_Style/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/StudentDashBoard_Style/style.css">
    
    <style>
    .charts {
      width: 90%;
      max-width: 900px;
      margin: 20px auto;
      background: #fff;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
    }

    #placementProcessChart {
      width: 100% !important;
      height: 400px !important;
    }
    .btn {
            padding: 10px 20px;
            margin-top: 10px;
            font-weight: bold;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
     .btn:hover {
            background-color: #45a049;
        }
        .company-list {
            margin-top: 15px;
            display: none;
            text-align: left;
        }
    </style>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/StudentDashBoard_script/script.js"></script>
	<script type="text/javascript" src="./StudentDashboard_script/script.js"></script>
     
    <script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        const ctx = document.getElementById("placementProcessChart").getContext("2d");

        const data = {
            labels: ["All Companies", "Eligiable Company", "Pass Count", "Fail Count", "Placed Company"],
            datasets: [{
                label: "Count",
                data: [<%=companyCount%>, <%= eligibleCompanyCount %>, <%= countcompany%>, 2, 1],
                backgroundColor: [
                    "rgba(54, 162, 235, 0.7)",
                    "rgba(255, 206, 86, 0.7)",
                    "rgba(75, 192, 192, 0.7)",
                    "rgba(255, 99, 132, 0.7)",
                    "rgba(153, 102, 255, 0.7)"
                ],
                borderColor: [
                    "rgba(54, 162, 235, 1)",
                    "rgba(255, 206, 86, 1)",
                    "rgba(75, 192, 192, 1)",
                    "rgba(255, 99, 132, 1)",
                    "rgba(153, 102, 255, 1)"
                ],
                borderWidth: 1
            }]
        };

        const options = {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    stepSize: 1,
                    ticks: {
                        precision: 0
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                },
                title: {
                    display: true,
                    text: "Placement Process Overview",
                    font: {
                        size: 18
                    }
                }
            }
        };

        new Chart(ctx, {
            type: "bar",
            data: data,
            options: options
        });
    });
    </script>
       <style>
     
    .renderbtn{
    display:flex;
    justify-content: space-evenly;
    }
    .renderbtn a{
    margin-top:0;
    }
    .renderbtn h1{
    font-size:4.5rem;
    }
    </style>
</head>
<body>
  <div class="renderbtn">
 <a href="${pageContext.request.contextPath}/">

  <img src="${pageContext.request.contextPath}/home.png" alt="home" class="homelogo">
</a>
 <h1>🎓 Student Dashboard</h1>
<a href="${pageContext.request.contextPath}/Student_Login/StudentLogin.jsp" class="backlogo">
<img src="${pageContext.request.contextPath}/back.png">
</a>
 
  </div>
    <div class="dashboard">
<!--       <header>
        <h1>🎓 Student Dashboard</h1>
      </header> -->

      <div class="top-bar">
        <div class="profile-section" style="gap: 2rem;">
          <!-- ✅ Image from DB -->
          <!-- <img src="<%= imageurl %>" alt="Profile Image" class="profile-img" id="profileImage" /> -->
         <!--  <img src="../<%=imageurl %>" alt="Profile Image" class="profile-img" id="profileImage" />-->
          <img src="<%=request.getContextPath()%>/<%=imageurl %>" alt="Profile Image" class="profile-img" id="profileImage"/>
          

<%-- 			<img src="${pageContext.request.contextPath}/StudentDashboard/UserImage/${student.contact}.jpg" width="150"/> --%>
			
          <div class="profile-info">
            <h3 class="profile-name" id="studentName"><span>Name: </span><%= name %></h3>
            <span class="profile-contact" id="mobile"><span>Mon: </span><%= contact %></span>
            <span class="profile-contact" id="gmail"><span>Email: </span><%= email %></span>
            <span class="profile-contact" id="skills"><span>Skills: </span><%= skills %></span>
            
            <div class="action-buttons">
              <button class="edit-btn" onclick="editDetails()">Edit Profile</button>
              <button class="logout-btn" onclick="logout()">Logout</button>
            </div>
          </div>
        </div>
      </div>

      <div class="cards">
        <div class="card">
          <div class="card-content">
            <h2 id="eligibleCompanies"><%= companyCount %></h2>
            <p> All Companies</p>
            <button class="view-btn" onclick="viewCompanies('all')">View All</button>
          </div>
        </div>
        <div class="card">
          <div class="card-content">
            <h2 id="interviewsAttended"><%= eligibleCompanyCount %></h2>
          
            <p>Eligible Company</p>
            <button class="view-btn" onclick="viewCompanies('eligible')">View All</button>
          </div>
        </div>
        <div class="card">
          <div class="card-content">
            <h2 id="passCount"> <%=countcompany %></h2>
            <p>Pass Count</p>
            <button class="view-btn btn" onclick="viewCompanies('passed')">View Companies</button>
                <div id="companyList" class="company-list">
        <ul>
            <% for(String company : compnies) { %>
                <li><%= company %></li>
            <% } %>
        </ul>
    </div>
          </div>
        </div>
        <div class="card">
          <div class="card-content">
            <h2 id="failCount">2</h2>
            <p>Interviews Attendedt</p>
            <button class="view-btn" onclick="viewCompanies('failed')">View Companies</button>
          </div>
        </div>
        <div class="card">
          <div class="card-content">
            <h2 id="placedCompany">1</h2>
            <p>Placed Company</p>
            <button class="view-btn" onclick="viewCompanies('placed')">View Companies</button>
          </div>
        </div>
      </div>

      <div class="charts">
        <canvas id="placementProcessChart"></canvas>
      </div>
    </div>
    <script>
function viewCompanies(type) {
    if (type === 'all') {
        window.location.href = 'AllCompanies.jsp';
    } else if (type === 'eligible') {
        window.location.href = 'EligibleCompanies.jsp';
    }
    // Aap passed, failed, placed ke liye bhi yahi kar sakte ho
}
function logout(){
	window.location.href="../Student_Login/StudentLogin.jsp";
	 
}
 
function viewCompanies(type) {
	if(type=='passed'){
    var list = document.getElementById("companyList");
    list.style.display = list.style.display === "none" ? "block" : "none";
}
}
 
</script>
    
</body>
</html>




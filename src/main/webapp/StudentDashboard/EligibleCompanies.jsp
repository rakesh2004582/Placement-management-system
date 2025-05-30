<%@ page import="java.sql.*, java.util.*" %>
<%
    String email = (String) session.getAttribute("studentEmail");

    float tenth = 0, twelfth = 0, grad = 0;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementManagementSystem", "root", "123456");

        ps = con.prepareStatement("SELECT tenth_percent, twelfth_percent, grad_percent FROM student_registration WHERE email = ?");
        ps.setString(1, email);
        rs = ps.executeQuery();

        if (rs.next()) {
            tenth = rs.getFloat("tenth_percent");
            twelfth = rs.getFloat("twelfth_percent");
            grad = rs.getFloat("grad_percent");
        }

        rs.close();
        ps.close();

        ps = con.prepareStatement(
            "SELECT * FROM company_register WHERE ? >= tenthpercentage AND ? >= twelfthpercentage AND ? >= highereducation_percent"
        );
        ps.setFloat(1, tenth);
        ps.setFloat(2, twelfth);
        ps.setFloat(3, grad);

        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eligible Companies</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef1f5;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-top: 30px;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            animation: fadeIn 0.8s ease-in-out;
        }

        thead {
            background-color: #007bff;
            color: white;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ccc;
            text-align: center;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e3f1ff;
            transition: background-color 0.3s ease;
        }

        .no-eligible {
            text-align: center;
            color: red;
            font-weight: bold;
            padding: 20px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            table {
                font-size: 14px;
                width: 100%;
            }

            th, td {
                padding: 10px;
            }
        }
    </style>
      <style>
       .renderbtn{
    display:flex;
    justify-content: space-evenly;
    }
    .renderbtn a{
    margin-top:0;
    }
    .renderbtn h1{
    font-size:3.2rem;
    }
    </style>
</head>
<body>
  <div class="renderbtn">
 <a href="${pageContext.request.contextPath}/">

  <img src="${pageContext.request.contextPath}/home.png" alt="home" class="homelogo">
</a>
 <h1>Eligible Companies for You</h1>
<a  href="${pageContext.request.contextPath}/StudentDashboard/studentDashboard.jsp" class="backlogo">
<img src="${pageContext.request.contextPath}/back.png">
</a>
 
  </div>
 

<table>
    <thead>
        <tr>
        	<th>Sr</th>
            <th>Company Name</th>
            <th>10th % Requirement</th>
            <th>12th % Requirement</th>
            <th>Graduation % Requirement</th>
            <th>Location</th>
        </tr>
    </thead>
    <tbody>
    <%
    int i=1;
        boolean found = false;
        while (rs.next()) {
            found = true;
    %>
        <tr>
        	<td><%=i %></td>
            <td><%= rs.getString("companyname") %></td>
            <td><%= rs.getFloat("tenthpercentage") %></td>
            <td><%= rs.getFloat("twelfthpercentage") %></td>
            <td><%= rs.getFloat("highereducation_percent") %></td>
            <td><%= rs.getString("location") %></td>
        </tr>
    <%
    i++;
        }
        if (!found) {
    %>
        <tr>
            <td colspan="5" class="no-eligible">You are not eligible for any company yet.</td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <p style="text-align:center; color:red;">Something went wrong. Please try again later.</p>
<%
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

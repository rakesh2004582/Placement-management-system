<%@ page import="java.sql.*, java.util.*" %>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementManagementSystem", "root", "123456");
        ps = con.prepareStatement("SELECT * FROM company_register");
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Registered Companies</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
            color: #333;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.8s ease-in-out;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ccc;
            text-align: center;
        }

        thead {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e0f0ff;
            transition: 0.3s ease;
        }

        .no-data {
            color: red;
            text-align: center;
            font-weight: bold;
            padding: 20px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            table {
                width: 100%;
                font-size: 14px;
            }

            th, td {
                padding: 10px;
            }
        }
    </style>
    <style type="text/css">
     .renderbtn{
    display:flex;
    justify-content: space-evenly;
    }
    .renderbtn a{
    margin-top:0%;
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
 <h1> All Registered Companies</h1>
<a   href="${pageContext.request.contextPath}/StudentDashboard/studentDashboard.jsp" class="backlogo">
 <img src="${pageContext.request.contextPath}/back.png">
</a>
 
  </div>
 

<table cellpadding="10" cellspacing="0">
    <thead>
        <tr>
        	<th>Sr</th>
            <th>Company Name</th>
            <th>10th %</th>
            <th>12th %</th>
            <th>Graduation %</th>
            <th>Location</th>
        </tr>
    </thead>
    <tbody>
    <%
    	int i=1;
        boolean dataFound = false;
        while (rs.next()) {
            dataFound = true;
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

        if (!dataFound) {
    %>
        <tr>
            <td colspan="5" class="no-data">No company registered yet.</td>
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
%>
    <p style="color:red; text-align:center;">Error occurred: <%= e.getMessage() %></p>
<%
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
%>

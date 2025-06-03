<%-- <%@ page import="java.sql.*, java.util.*" %>
<%
    String company = (String) request.getAttribute("company");
    out.println("Company received: " + company);
    if (company == null) {
        out.println("Company name is null!");
        return;
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM selectedstudent WHERE companyname = ?");
    ps.setString(1, company);
    ResultSet rs = ps.executeQuery();
%>


<html>
<head>
    <title>Selected Students</title>
</head>
<body>
    <h2>Selected Students for Company: <%= company %></h2>
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Contact</th>
            <th>Select / Delete</th>
        </tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("mob") %></td>
        </tr>
        <%
            }
            con.close();
        %>
    </table>
</body>
</html>
 --%>
 
<%@ page import="java.sql.*, java.util.*" %>
<%
    String company = (String) request.getAttribute("company");
    if (company == null) {
        out.println("<h3 style='color:red;'>Company name is null!</h3>");
        return;
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM selectedstudent WHERE companyname = ?");
    ps.setString(1, company);
    ResultSet rs = ps.executeQuery();
    /* String msg=(String) request.getAttribute("message"); */
%>

<!DOCTYPE html>
<html>
<head>
    <title>Selected Students</title>
<head>
    <title>Selected Students</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #f9f9f9, #dfe9f3);
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            animation: fadeInDown 1s ease-in-out;
            font-size: 24px;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 90%;
            max-width: 900px;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            animation: slideIn 0.8s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        th, td {
            padding: 12px 18px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #3498db;
            color: white;
            font-size: 16px;
        }

        tr:hover {
            background-color: #f2f2f2;
        }

        .action-btn {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 25px;
        }

        .btn {
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.3s ease-in-out;
        }

        .btn-select {
            background-color: #2ecc71;
            color: white;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }

        .btn:hover {
            transform: scale(1.05);
            opacity: 0.95;
        }

        .checkbox {
            transform: scale(1.2);
            height:100%;
            width:100%;
        }

        #selectAll {
            cursor: pointer;
        }
input[type="number"] {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
}

        input[type="text"] {
            width: 90%;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .renderbtn {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .renderbtn img {
            max-height: 50px;
            margin: 10px;
        }

        .renderbtn h1 {
            font-size: 22px;
            margin: 0 auto;
            text-align: center;
        }

        @media (max-width: 600px) {
            .renderbtn {
                flex-direction: column;
                align-items: center;
            }

            .renderbtn h1 {
                font-size: 18px;
            }

            table, th, td {
                font-size: 14px;
            }

            .btn {
                font-size: 14px;
                padding: 8px 16px;
            }

            input[type="text"] {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <div class="renderbtn">
 <a href="${pageContext.request.contextPath}/">

  <img src="${pageContext.request.contextPath}/home.png" alt="home" class="homelogo">
</a>
 <h1>Selected Students for Company: <%= company %></h1>
<a href="${pageContext.request.contextPath}/Company/companyLogin.jsp" >
<img src="${pageContext.request.contextPath}/back.png" class="backlogo">
</a>
 
  </div>
 
<%
    String msg = (String) request.getAttribute("message");
    if (msg != null) {
%>
    <p style="color:red;text-align:center"><%= msg %></p>
<%
    }
%>

<form action="FinalStudent" method="post">
    <input type="hidden" name="company" value="<%= company %>">
    <table>
        <tr>
            <th><input type="checkbox" id="selectAll" onclick="toggleAll(this)"> All</th>
            <th>Name</th>
            <th>Contact</th>
            <th>Package/LPA</th>
        </tr>

        <%
            while (rs.next()) {
                String name = rs.getString("name");
                String mob = rs.getString("mob");
                String uniqueId = name+"_"+mob;
        %>
<tr>
    <td>
        <input type="checkbox" name="selectedStudents" value="<%= name %>::<%= mob %>" class="checkbox" onchange="toggleLPARequirement('<%= uniqueId %>', this)">
    </td>
    <td><%= name %></td>
    <td><%= mob %></td>
   <td style="vertical-align: middle;">
    <input type="number"  id="lpa_<%= uniqueId %>" name="lpa_<%= name %>_<%= mob %>" placeholder="Enter package in LPA" step="0.01" min="0">
</td>

</tr>

        <%
            }
            con.close();
        %>
    </table>

    <div class="action-btn">
        <button type="submit" name="action" value="select" class="btn btn-select">Select</button>
       <!-- <button type="submit" name="action" value="delete" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete selected students?')">Delete</button>-->
    </div>
</form>
<p style="color:blue;text-align:center">Select those Student that Student is pass in final round...</p>
<script>
function toggleAll(source) {
    const checkboxes = document.querySelectorAll('.checkbox');
    checkboxes.forEach(checkbox => {
        checkbox.checked = source.checked;
        toggleLPARequirement(getUniqueId(checkbox.value), checkbox);
    });
}
// Generate unique ID from value
function getUniqueId(value) {
    return value.replace("::", "_");
}
// Enable/disable required on LPA input
function toggleLPARequirement(id, checkbox) {
    const lpaInput = document.getElementById('lpa_' + id);
    if (checkbox.checked) {
        lpaInput.setAttribute('required', 'required');
    } else {
        lpaInput.removeAttribute('required');
    }
}
</script>

</body>
</html>
 
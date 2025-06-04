<%@ page import="java.util.List" %>
<%@ page import="com.example.company.Student" %>
<%@ page isELIgnored="false" %>

<%
    List<Student> students = (List<Student>) request.getAttribute("eligibleStudents");
    String CompanyName = (String) request.getAttribute("CompanyName");
    System.out.println("Company name in dashboard file : " + CompanyName);
%>
 
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: #f9f9f9;
        }

        h1 {
            text-align: center;
            margin: 20px 0;
            color: #2c3e50;
        }

        .renderbtn {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 30px;
            background-color: #ffffff;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        }

        .renderbtn a img {
            height: 50px;
            width: 50px;
            transition: transform 0.3s ease;
        }

        .renderbtn a img:hover {
            transform: scale(1.1);
        }

        table {
            width: 95%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            text-align: center;
            word-wrap: break-word;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f8f8f8;
        }

        form {
            margin: 0;
        }

        button {
            padding: 5px 12px;
            background-color: #2980b9;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background-color: #1c5980;
        }
    </style>
</head>
<body>

<div class="renderbtn">
    <a href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/home.png" alt="Home" class="homelogo">
    </a>

    <h1>Welcome to <%= CompanyName %></h1>

    <a href="${pageContext.request.contextPath}/Company/companyLogin.jsp">
        <img src="${pageContext.request.contextPath}/back.png" alt="Back" class="backlogo">
    </a>
</div>

<form action="${pageContext.request.contextPath}/ProcessSelectedStudents" method="post">
    <input type="hidden" name="companyname" value="<%= CompanyName %>"/>
    <table>
        <thead>
            <tr>
                <th>Sr</th>
                <th>Name</th>
                <th>10th %</th>
                <th>12th %</th>
                <th>Higher Education %</th>
                <th>Contact</th>
                <th>Select</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (students != null && !students.isEmpty()) {
                    int index = 0;
                    for (Student s : students) {
            %>
            <tr>
                <td><%= index + 1 %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getTenth() %></td>
                <td><%= s.getTwelfth() %></td>
                <td><%= s.getHigherEducation() %></td>
                <td><%= s.getContact() %></td>
                <td>
                    <input type="checkbox" name="selectedStudents" value="<%= s.getName() %>|<%= s.getContact() %>"/>
                </td>
                <td>
                    <input type="checkbox" name="deletedStudents" value="<%= s.getName() %>|<%= s.getContact() %>"/>
                </td>
            </tr>
            <%
                        index++;
                    }
                } else {
            %>
            <tr>
                <td colspan="8" style="text-align:center;">No eligible students found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <div style="text-align:center; margin-top:20px;">
        <button type="submit" name="submitAction" value="submitAll" style="padding:10px 25px; font-size:16px;">Submit Final Selection</button>
    </div>
</form>

<script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const selected = document.querySelectorAll("input[name='selectedStudents']:checked");
        const deleted = document.querySelectorAll("input[name='deletedStudents']:checked");

        if (selected.length === 0 && deleted.length === 0) {
            alert("Please select at least one student to proceed.");
            e.preventDefault(); // Stop form submission
        }
    });
</script>


</body>
</html>

<%-- <%@ page import="java.util.List" %>
<%@ page import="com.example.company.Student" %>
<%@ page isELIgnored="false" %>

<%
    List<Student> students = (List<Student>) request.getAttribute("eligibleStudents");
    String CompanyName = (String) request.getAttribute("CompanyName");
    System.out.println("Company name in dashboard file : " + CompanyName);
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: #f9f9f9;
        }

        h1 {
            text-align: center;
            margin: 20px 0;
            color: #2c3e50;
        }

        .renderbtn {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 30px;
            background-color: #ffffff;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        }

        .renderbtn a img {
            height: 50px;
            width: 50px;
            transition: transform 0.3s ease;
        }

        .renderbtn a img:hover {
            transform: scale(1.1);
        }

        table {
            width: 95%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            text-align: center;
            word-wrap: break-word;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f8f8f8;
        }

        .select-btn,
        .delete-btn {
            padding: 6px 12px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .selected {
            background-color: blue;
            color: white;
        }

        .deleted {
            background-color: red;
            color: white;
        }

        @media screen and (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
                width: 100%;
            }

            tr {
                margin-bottom: 15px;
                border-bottom: 2px solid #ccc;
            }

            th {
                display: none;
            }

            td {
                text-align: right;
                padding-left: 50%;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 10px;
                width: 45%;
                padding-right: 10px;
                font-weight: bold;
                text-align: left;
            }
        }
    </style>

    <script>
        function toggleButtons(rowIndex, type) {
            var selectBtn = document.getElementById("select-" + rowIndex);
            var deleteBtn = document.getElementById("delete-" + rowIndex);

            if (type === 'select') {
                selectBtn.classList.add("selected");
                deleteBtn.classList.remove("deleted");
            } else if (type === 'delete') {
                deleteBtn.classList.add("deleted");
                selectBtn.classList.remove("selected");
            }
        }
    </script>
</head>
<body>

    <div class="renderbtn">
        <a href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/home.png" alt="Home" class="homelogo">
        </a>

        <h1>Welcome to <%= CompanyName %></h1>

        <a href="${pageContext.request.contextPath}/Company/companyLogin.jsp">
            <img src="${pageContext.request.contextPath}/back.png" alt="Back" class="backlogo">
        </a>
    </div>

    <table>
        <thead>
            <tr>
                <th>Sr</th>
                <th>Name</th>
                <th>10th %</th>
                <th>12th %</th>
                <th>Higher Education %</th>
                <th>Contact</th>
                <th>Select/Delete</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (students != null && !students.isEmpty()) {
                    int index = 0;
                    for (Student s : students) {
            %>
            <tr>
                <td><%= index + 1 %></td>
                <td data-label="Name"><%= s.getName() %></td>
                <td data-label="10th %"><%= s.getTenth() %></td>
                <td data-label="12th %"><%= s.getTwelfth() %></td>
                <td data-label="Higher Education %"><%= s.getHigherEducation() %></td>
                <td data-label="contact"><%= s.getContact() %></td>
                <td data-label="Select/Delete">
                    <button class="select-btn" id="select-<%= index %>" onclick="toggleButtons(<%= index %>, 'select')">Select</button>
                    <button class="delete-btn" id="delete-<%= index %>" onclick="toggleButtons(<%= index %>, 'delete')">Delete</button>
                </td>
            </tr>
            <%
                        index++;
                    }
                } else {
            %>
            <tr>
                <td colspan="6" style="text-align:center;">No eligible students found.</td>
            </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>
   --%>
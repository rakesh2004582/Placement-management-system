<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
    // Step 1: Get the student's mobile number from the session
String studentMob = (String) session.getAttribute("studentMob");
String StudentName=(String) session.getAttribute("studentName");

    // Redirect to login if session doesn't have mobile number
    if (studentMob == null) {
        response.sendRedirect("Company/companyLogin.jsp");
        return;
    }

    // Step 2: Declare JDBC objects
    Connection conn = null;
    PreparedStatement psAllCompanies = null;
    PreparedStatement psCheckStudent = null;
    PreparedStatement psCompanyInfo = null;
    ResultSet rsCompanies = null;
    ResultSet rsStudentCheck = null;
    ResultSet rsCompanyInfo = null;

    // Step 3: Initialize structures to store company data where student is not selected
    List<String> failedCompanies = new ArrayList<>();
    Map<String, String> companyLocations = new HashMap<>();

    try {
        // Step 4: Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");

        // Step 5: Get distinct companies that conducted the 1st round
        String sql = "SELECT DISTINCT companyname FROM SelectedStudent";
        psAllCompanies = conn.prepareStatement(sql);
        rsCompanies = psAllCompanies.executeQuery();

        // Step 6: Prepare query to check if student is selected in each company
        String checkSql = "SELECT * FROM SelectedStudent WHERE companyname = ? AND mob = ?";
        psCheckStudent = conn.prepareStatement(checkSql);

        // Step 7: Prepare query to fetch company location from company_register
        String companyInfoSql = "SELECT location FROM company_register WHERE companyname = ?";
        psCompanyInfo = conn.prepareStatement(companyInfoSql);

        // Step 8: Loop through each company and check if student is NOT selected
        while (rsCompanies.next()) {
            String company = rsCompanies.getString("companyname");

            // Check if student exists in SelectedStudent for this company
            psCheckStudent.setString(1, company);
            psCheckStudent.setString(2, studentMob);
            rsStudentCheck = psCheckStudent.executeQuery();

            // If no result, student is not selected in this company
            if (!rsStudentCheck.next()) {
                // Get company location from company_register table
                psCompanyInfo.setString(1, company);
                rsCompanyInfo = psCompanyInfo.executeQuery();

                String location = "Not Available";
                if (rsCompanyInfo.next()) {
                    location = rsCompanyInfo.getString("location");
                }

                failedCompanies.add(company);
                companyLocations.put(company, location);
            }
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Step 9: Close JDBC resources
        try { if (rsCompanies != null) rsCompanies.close(); } catch (Exception e) {}
        try { if (rsStudentCheck != null) rsStudentCheck.close(); } catch (Exception e) {}
        try { if (rsCompanyInfo != null) rsCompanyInfo.close(); } catch (Exception e) {}
        try { if (psAllCompanies != null) psAllCompanies.close(); } catch (Exception e) {}
        try { if (psCheckStudent != null) psCheckStudent.close(); } catch (Exception e) {}
        try { if (psCompanyInfo != null) psCompanyInfo.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

<html>
<head>
    <title>Failed Companies</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            padding: 20px;
        }

       

        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 20px;
            width: 300px;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0,0,0,0.2);
        }

        .card strong {
            color: #555;
        }

        .no-fail {
            text-align: center;
            font-size: 18px;
            color: green;
        }
       .headerInfo {
    text-align: center;
    margin-bottom: 50px;
}

.headerInfo h2 {
    font-size: 2rem;
    font-weight: normal;
    color: #333;
}

.student-name {
    color: #007BFF;
    font-weight: bold;
    font-size: 2.5rem;
}

.highlight-msg {
    display: block;
    margin-top: 10px;
    color: #d9534f;
    font-weight: bold;
    font-size: 1.5rem;
}

    </style>
</head>
<body>

    <div class="headerInfo">
    <h2>
        <span class="student-name"><%= StudentName %></span>,
        <span class="highlight-msg">you are not selected in these companies</span>
    </h2>
</div>

    <div class="card-container">
    <%
        // Step 10: Show company cards
        if (failedCompanies.isEmpty()) {
    %>
        <p class="no-fail">🎉 Congratulations! You are selected in all companies.</p>
    <%
        } else {
            for (String company : failedCompanies) {
    %>
        <div class="card">
            <p><strong>Company Name:</strong> <%= company %></p>
            <p><strong>Location:</strong> <%= companyLocations.get(company) %></p>
        </div>
    <%
            }
        }
    %>
    </div>

</body>
</html>

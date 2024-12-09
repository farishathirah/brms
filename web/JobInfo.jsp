<%-- 
    Document   : JobInfo
    Created on : 7 May 2024, 11:24:28 am
    Author     : afrin
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.DAO.JobDAO" %>
<%@ page import="com.Model.Job" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Joblink @ Employer Jobs</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

            body {
                margin: 0;
                box-sizing: border-box;
                font-family: "Poppins";
                background-color: black;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: black;
            }

            .logo {
                font-size: 25px;
                color: white;
                text-decoration: none;
                margin-left: 30px;
            }

            .logout {
                font-size: 20px;
                color: white;
                text-decoration: none;
                margin-top: 5px;
                margin-right: 30px;
            }

            .intro {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding-top: 50px;
                width: 100%;
                min-height: 850px;
                background-color: #8BABB2;
                background: linear-gradient(to bottom, rgba(0, 0, 0, 0.9) 0%, rgba(0, 0, 1, 0.7) 60%), url('https://i.pinimg.com/564x/1e/92/64/1e9264f19c477b18787847fc6307ae84.jpg');
                opacity: 70%; /* Apply blend mode to blend with the linear gradient */
                background-position: center;
                background-repeat: repeat;
            }


            .container {
                max-width: 2000px;
                margin: 0 auto;
                background-color: #8BABB2;
                font-family: "Poppins";
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }

            .nav-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .nav-item {
                list-style-type: none;
                display: inline-block;
                margin-right: 20px;
            }

            .nav-link {
                color: white;
                text-decoration: none;
                font-size: 18px;
                font-weight: 600;
            }

            .nav-link:hover {
                color: lightgrey;
                transition: background-color 0.3s ease;
            }

            .content {
                max-width: 1000px;
                max-height: 800px;
                padding: 20px;
                margin: 100px auto;
                font-size: 20px;
                padding: 20px;
                background-color: white;
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            .content h2 {
                margin-bottom: 20px;
            }
            .nav-right {
                margin-left: auto;
            }


            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }

            th {
                background-color: #d1d1d1;
            }


            .clkbtn {
                height: 60px;
                width: 200px; /* Increased width for a bigger button */
                border-radius: 30px;
                color: green; /* Added text color to white */
                font-size: 22px;
                border: none;
                cursor: pointer;
            }

            .login-box {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 0px; /* Adjust overall padding as needed */
                height: 111%;
            }

            .input-container {
                margin-bottom: 15px; /* Adjust the margin between each input */
                display: flex;
                gap: 6px; /* Adjust the gap between label and input */
            }

            .ele {
                height: 40px;
                width: 700px;
                outline: none;
                border: none;
                color: rgb(77, 77, 77);
                background-color: rgb(240, 240, 240);
                border-radius: 50px;
                padding-left: 30px;
                font-size: 18px;
            }

            .clkbtn {
                height: 60px;
                width: 230px;
                border-radius: 50px;
                background-color:  #829EA6;
                font-size: 22px;
                border: none;
                cursor: pointer;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }

            .clkbtn:hover {
                background-color: #2e3e42;
                font-size: 25px;
            }
            table {
                width: 90%;
                border-collapse: collapse;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }
            .label1 {
                text-align: left;
                width: 220px; /* Adjust the width of the label */
            }

            .h3 {
                color: black;
            }

            .popup-container {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }

            .popup-content {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
            }

            .popup-buttons {
                display: flex;
                justify-content: space-around;
                margin-top: 20px;
            }

            .popup-button {
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
            }

            .confirm-button {
                background-color: #2e3e42;
                color: white;
            }

            .cancel-button {
                background-color: #d1d1d1;
                color: white;
            }

            /* Add styles for update icon */
            .update-icon {
                color: green;
                margin-right: 10px; /* Add right margin for spacing */
            }

            /* Add styles for delete icon */
            .delete-icon {
                color: red;
            }

            .job-container {
                display: flex;
                flex-direction: column;
            }

            .job-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px; /* Adjust as needed */
            }

            .job-card {
                width: 30%; /* Adjust width as needed */
                padding: 20px;
                margin-right: 20px; /* Adjust as needed */
                margin-bottom: 20px; /* Add margin bottom to create vertical gap */
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background-color: #fff;
            }
            .job-card:hover {
                transform: scale(1.05); /* Increase scale on hover */
                background-color: #E6F0E0;
            }

            /* Additional styling for action icons */
            .actions {
                margin-top: 10px;
            }

            .action-icon {
                margin-right: 10px;
                color: #333;
                text-decoration: none;
            }

            .update-icon:hover,
            .delete-icon:hover {
                color: #f00; /* Change icon color on hover */
            }

            .clkbtn2 {
                height: 40px;
                width: 200px;
                border-radius: 50px;
                background-color: #829EA6;
                border: none;
                cursor: pointer;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }

            .clkbtn2:hover {
                background-color: #55737C;
            }

            .clkbtn3 {
                height: 40px;
                width: 200px;
                border-radius: 50px;
                background-color: #143C49;
                border: none;
                cursor: pointer;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }
            .update-btn, .delete-btn {
                background-color: #4CAF50; /* Default green background */
                color: white; /* White text */
                border: none; /* No border */
                padding: 5px 10px; /* Smaller padding */
                border-radius: 3px; /* Rounded corners */
                cursor: pointer; /* Pointer cursor on hover */
                transition: background-color 0.3s ease; /* Smooth transition */
                font-size: 12px; /* Smaller font size */
                margin-right: 5px; /* Space between buttons */
            }

            .delete-btn {
                background-color: #f44336; /* Red background */
            }

            .delete-btn:hover {
                background-color: #d32f2f; /* Darker red on hover */
            }

            .update-btn:hover {
                background-color: #45a049; /* Darker green on hover */
            }

            .approved-row {
                background-color: #c3e6cb; /* Green background for approved applications */
            }
            .not-approved-row {
                background-color: #f5c6cb; /* Red background for not approved applications */
            }
            .section-heading {
                background-color: white;
                color: black;
                padding: 10px 20px;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
                border: 1px solid #ccc;
                border-bottom: none; /* Remove bottom border */
                margin-bottom: 0; /* Remove default margin */
                margin-left: 20px; /* Adjust margin to position at the left */
            }
        </style>

    </head>
    <body>

        <header><header style="display: flex; justify-content: space-between; align-items: center; background-color: black;">
                <a href="ParentHomepage.jsp" class="logo">BRMS</a>
                <div class="centered-text" style="color: white; flex-grow: 1; text-align: center;">Parent</div>
                <a href="ParentSignIn.jsp" class="logout">
                    <img src="Images/logout_icon.png" alt="Logout Icon" style="width:20px; height:20px; vertical-align:middle; margin-right: 5px;">
                    LogOut
                </a>
            </header>

            <div class="container">
                <nav class="nav-bar">
                    <ul>
                        <li class="nav-item"><a class="nav-link" href="ParentDash.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="ParentHomepage.jsp">Profile</a></li>
                        <li class="nav-item"><a class="nav-link" href="BookingForm.jsp">Create Booking</a></li>
                        <li class="nav-item"><a class="nav-link" href="http://localhost:8080/BabysitterProject/BookingServlet?action=tlist">Booking Posted</a></li>
                        <li class="nav-item"><a class="nav-link" href="BookingInfo.jsp">Booking Applications</a></li>
                    </ul>
                </nav>
            </div>

        </header>
        <main>
            <div class="container">
                <div class="intro">

                    <h1 class="text-center" style="color: white"; >Job Applications</h1>
                    <div class="button-group">
                        <button onclick="jobinfo()" class="clkbtn3">Pending Applications</button>
                        <button onclick="jobstatus()" class="clkbtn2">Approved Bookings</button>
                    </div><br>

                    <h4 class="section-heading">Pending Applications</h4>
                    <table>
                        <thead>
                            <tr>
                                <th>Applicant ID</th>
                                <th>Applicant Name</th>
                                <th>Contact</th>
                                <th>Application Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Iterate through pending applied jobs and display them -->
                            <%
                                String jdbcUrl = "jdbc:mysql://localhost:3306/babysitter";
                                String dbUser = "root";
                                String dbPassword = "admin"; // Ensure the correct password is set

                                // Assuming employID is stored in session attribute "employID"
                                int parentID = (int) session.getAttribute("parentID");

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                                    Statement statement = connection.createStatement();

                                    // Retrieve pending applied jobs with details from job, appliedjob, and babyer tables
                                    ResultSet rs = statement.executeQuery("SELECT a.applicationID,s.babyEmail, js.babyPhone, j.parentID, a.applyStatus, a.babyID, a.applicationDate, js.babyName "
                                            + "FROM appliedjob a "
                                            + "JOIN booking j ON a.bookingID = j.bookingID "
                                            + "JOIN babysitter js ON a.babyID = js.babyID "
                                            + "WHERE j.parentID = " + parentID + " AND a.applyStatus = 'Pending'");

                                    // Check if there are pending applications
                                    boolean hasPendingApplications = false;
                                    while (rs.next()) {
                                        hasPendingApplications = true;

                                        // Retrieve applied job details from ResultSet
                                        int applicationID = rs.getInt("applicationID");
                                        String jobName = rs.getString("jobName");
                                        String babyEmail = rs.getString("babyEmail");
                                        String babyPhone = rs.getString("babyPhone");
                                        String applyStatus = rs.getString("applyStatus");
                                        int babyID = rs.getInt("babyID");
                                        String babyName = rs.getString("babyName");
                                        String applicationDate = rs.getString("applicationDate");
                            %>
                            <tr>
                                <td><%= applicationID%></td>
                                <td><%= jobName%></td>
                                <td><%= babyEmail%> <%= babyPhone%></td>
                                <td><a href="ProfileJobseeker.jsp?babyID=<%= babyID%>&applicationID=<%= applicationID%>"><%= babyName%></a></td>
                                <td><%= applicationDate%></td>
                                <td>
                                    <form action="UpdateJobStatus.jsp" method="post">
                                        <select name="applyStatus">
                                            <option value="Pending" <%= applyStatus.equals("Pending") ? "selected" : ""%>>Pending</option>
                                            <option value="Approved">Approved</option>
                                            <option value="Not Approved">Not Approved</option>
                                        </select>
                                </td>
                                <td>
                                    <input type="hidden" name="applicationID" value="<%= applicationID%>">
                                    <input type="submit" value="Update" class="update-btn">
                                    </form>
                                    <% if (applyStatus.equals("Pending")) {%>
                                    <form action="DeleteJobApplication.jsp" method="post" onsubmit="return confirmDelete();">
                                        <input type="hidden" name="applicationID" value="<%= applicationID%>">
                                        <input type="submit" value="Delete" class="delete-btn">
                                    </form>
                                    <% } %>
                                </td>
                            </tr>
                            <%
                                }
                                rs.close();
                                statement.close();
                                connection.close();

                                // Display message if no pending applications found
                                if (!hasPendingApplications) {
                            %>
                            <tr>
                                <td colspan="6">No pending job applications found.</td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.println("Database connection error: " + e.getMessage());
                                }
                            %>
                        </tbody>


                    </table><br>


                    <h4 class="section-heading">Confirmed Applications</h4>
                    <table>
                        <thead>
                            <tr>
                                <th>Applicant ID</th>
                                <th>Job Title</th>
                                <th>Applicant Name</th>
                                <th>Contact</th>
                                <th>Application Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Iterate through applied jobs and display them -->
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                                    Statement statement = connection.createStatement();

                                    // Retrieve applied jobs with details from job, appliedjob, and babyer tables
                                    ResultSet rs = statement.executeQuery("SELECT a.applicationID, js.babyEmail, js.babyPhone, j.parentID, a.applyStatus, a.babyID, a.applicationDate, js.babyName "
                                            + "FROM appliedjob a "
                                            + "JOIN job j ON a.jobID = j.jobID "
                                            + "JOIN babyer js ON a.babyID = js.babyID "
                                            + "WHERE j.parentID = " + parentID + " AND a.applyStatus != 'Pending'");

                                    while (rs.next()) {
                                        // Retrieve applied job details from ResultSet
                                        int applicationID = rs.getInt("applicationID");
//                                        String jobName = rs.getString("jobName");
                                        String babyEmail = rs.getString("babyEmail");
                                        String babyPhone = rs.getString("babyPhone");
                                        String applyStatus = rs.getString("applyStatus");
                                        int babyID = rs.getInt("babyID");
                                        String babyName = rs.getString("babyName");
                                        String applicationDate = rs.getString("applicationDate");

                                        // Determine row color based on applyStatus
                                        String rowClass = "";
                                        if (applyStatus.equals("Approved")) {
                                            rowClass = "approved-row";
                                        } else if (applyStatus.equals("Not Approved")) {
                                            rowClass = "not-approved-row";
                                        }
                            %>

                            <tr class="<%= rowClass%>">
                                <td><%= applicationID%></td>
                                <td><a href="ProfileBabysitter.jsp?babyID=<%= babyID%>&applicationID=<%= applicationID%>"><%= babyName%></a></td>
                                <td><%= babyEmail%>, <%= babyPhone%></td>
                                <td><%= applicationDate%></td>
                                <td><%= applyStatus%></td>

                            </tr>
                            <%
                                    }
                                    rs.close();
                                    statement.close();
                                    connection.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.println("Database connection error: " + e.getMessage());
                                }
                            %>
                        </tbody>

                    </table>
                </div>
            </div>
        </main>

        <script>
            function confirmDelete() {
                return confirm("Are you sure you want to delete this application?");
            }

            function jobinfo() {
                // Redirect to the owner login page
                window.location.href = "JobInfo.jsp";
            }

            function jobstatus() {
                // Redirect to the employee login page
                window.location.href = "JobStatus.jsp";
            }
        </script>
    </body>
</html>

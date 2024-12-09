<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.DAO.BookingDAO" %>
<%@ page import="com.Model.Booking" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking</title>
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
                max-width: 1800px;
                margin: 30px auto;
                padding: 20px;
                background-color: rgba(255, 255, 255); /* white background with 80% opacity */
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
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
                background-color: #829EA6;
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

            .job-table th, .job-table td {
                border: 1px solid #ddd;
                padding: 8px;
            }

            .job-table th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #4CAF50;
                color: white;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0,0,0);
                background-color: rgba(0,0,0,0.4);
                padding-top: 60px;
            }

            .modal-content {
                background-color: #fefefe;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 50%;
                border-radius: 5px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .modal-content a {
                text-decoration: none; /* Remove underline */
                font-size: 1.2em; /* Increase font size */
                display: inline-block; /* Ensure block-level display */
                width: 100%; /* Make the anchor tag take up the full width */
                padding: 10px; /* Add padding for spacing */
                margin: 10px 0; /* Add margin for spacing */
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            .applicant-item {
                width: 100%;
                text-align: center;
                color: black;
                border: 1px solid #ddd;
                box-sizing: border-box; /* Include padding and border in width calculation */
                border-radius: 5px;
                margin: 5px 0;
                transition: background-color 0.3s;
            }

            .applicant-item:hover {
                background-color: #f1f1f1;
            }
        </style>
    </head>
    <body>

        <header>
            <header style="display: flex; justify-content: space-between; align-items: center; background-color: black;">
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
                    <h1 class="text-center" style="color: white;">List of Job Posted</h1>
                    <div class="content">
                        <div class="job-container">
                            <%
                                String jdbcUrl = "jdbc:mysql://localhost:3306/babysitter";
                                String dbUser = "root";
                                String dbPassword = "admin";

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                                    Statement statement = connection.createStatement();

                                    // Retrieve employID from the session
                                    int parentIDFromSession = (int) session.getAttribute("parentID");

                                    ResultSet rs = statement.executeQuery("SELECT booking.*, (SELECT COUNT(*) FROM appliedjob WHERE appliedjob.bookingID = booking.bookingID) AS applicantCount FROM booking WHERE parentID = " + parentIDFromSession);
                                    int count = 0;
                            %>
                            <table class="job-table" style="width: 100%; border-collapse: collapse;">
                                <thead>
                                    <tr style="background-color: #333; color: white;">
                                        <th>Description</th>
                                        <th>Address</th>
                                        <th>Salary</th>
                                        <th>Date Created</th>
                                        <th>Date</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                        <th>Applicants</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        while (rs.next()) {
                                            // Retrieve job details from ResultSet
                                            int bookingID = rs.getInt("bookingID");
                                            String bookingDesc = rs.getString("bookingDesc");
                                            String bookingAddress = rs.getString("bookingAddress");
                                            float bookingReward = rs.getFloat("bookingReward");
                                            String dateCreated = rs.getString("dateCreated");
                                            String date = rs.getString("date");
                                            String startTime = rs.getString("startTime");
                                            String endTime = rs.getString("endTime");
                                            int applicantCount = rs.getInt("applicantCount");

                                            // Alternate row colors
                                            String rowColor = (count % 2 == 0) ? "#f2f2f2" : "#ffffff";
                                    %>
                                    <tr style="background-color: <%= rowColor%>;">
                                        <td style="padding: 10px;"><%= bookingDesc%></td>
                                        <td style="padding: 10px;"><%= bookingAddress%></td>
                                        <td style="padding: 10px;">RM<%= bookingReward%></td>
                                        <td style="padding: 10px;"><%= dateCreated%></td>
                                        <td style="padding: 10px;"><%= date%></td>
                                        <td style="padding: 10px;"><%= startTime%></td>
                                        <td style="padding: 10px;"><%= endTime%></td>
                                        <td style="padding: 10px;">
                                            <a href="#" onclick="showApplicants('<%= bookingID%>)"><%= applicantCount%> Applied</a>
                                        </td>
                                        <td style="padding: 10px;">
                                            <div style="display: flex; flex-direction: column; align-items: center;">
                                                <a href="BookingServlet?action=tedit&bookingID=<%= bookingID%>" class="action-icon update-icon" title="Update" style="color: green; display: flex; align-items: center;">
                                                    <i class="fas fa-edit"></i>
                                                    <span style="margin-left: 5px;">Edit</span>
                                                </a>
                                                <a href="#" onclick="showConfirmationPopup('<%= bookingID%>')" class="action-icon delete-icon" title="Delete" style="color: red; display: flex; align-items: center; margin-top: 5px;">
                                                    <i class="fas fa-trash-alt"></i>
                                                    <span style="margin-left: 5px;">Delete</span>
                                                </a>
                                            </div>
                                        </td>

                                    </tr>
                                    <%
                                                count++;
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
                </div>

                <!-- Popup Modal -->
                <div id="applicantsModal" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="closeModal()">&times;</span>
                        <h2 style="text-align: center;">List of Applicants</h2>
                        <div class="row" style="background-color: #f2f2f2; padding: 5px; text-align: center;">
                            <div class="col-md-12">
                                <h2 style="font-size: 1.2em;"> (ID: <span id="bookingID"></span>)</h2>
                            </div>
                        </div>
                        <div id="applicantsList"></div>
                    </div>
                </div>
        </main>

        <div class="popup-container" id="confirmationPopup">
            <div class="popup-content">
                <h2>Confirm Deletion</h2>
                <p>Are you sure you want to delete this job?</p>
                <div class="popup-buttons">
                    <form id="deleteForm" method="post" action="BookingServlet?action=tdelete">
                        <input type="hidden" name="bookingID" id="deleteBookingID">
                        <button type="button" class="popup-button confirm-button" style="background-color: green;" onclick="confirmDelete()">Confirm</button>
                    </form>
                    <button type="button" class="popup-button cancel-button" style="background-color: red;" onclick="cancelDelete()">Cancel</button>
                </div>
            </div>
        </div>

        <script>
            function showApplicants(bookingID) {
                // Set job ID and job name in the respective elements
                document.getElementById('bookingID').textContent = bookingID;

                var modal = document.getElementById('applicantsModal');
                var applicantsList = document.getElementById('applicantsList');

                // Clear any existing content in the modal
                applicantsList.innerHTML = '';

                // Fetch applicant list and display in the modal
                var xhr = new XMLHttpRequest();
                xhr.open('GET', 'fetchApplicants.jsp?bookingID=' + bookingID, true);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        if (xhr.responseText.trim() === "0") {
                            // No applicants found, display a message
                            applicantsList.innerHTML = "<p>No applicants found for this job.</p>";
                        } else {
                            // Applicants found, display them in the modal
                            applicantsList.innerHTML += xhr.responseText;
                        }
                        modal.style.display = 'block';
                    }
                };

                xhr.send();
            }

            function closeModal() {
                document.getElementById('applicantsModal').style.display = 'none';
            }

            function showConfirmationPopup(jobID) {
                document.getElementById('deleteJobID').value = bookingID;
                document.getElementById('confirmationPopup').style.display = 'flex';
            }

            function hideConfirmationPopup() {
                document.getElementById('confirmationPopup').style.display = 'none';
            }

            function confirmDelete() {
                document.getElementById('deleteForm').submit();
                hideConfirmationPopup();
            }

            function cancelDelete() {
                hideConfirmationPopup();
            }
        </script>

    </body>
</html>

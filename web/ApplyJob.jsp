<%@page import="java.io.InputStream"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.DAO.JobDAO" %>
<%@ page import="com.Model.Job" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.util.List" %>
<%@ page import="com.DAO.JobDAO" %>
<%@ page import="com.Model.Job" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Joblink @ Jobseeker Profile</title>
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
                justify-content: center;
                width: 100%;
                min-height: 850px;
                background-color: #8BABB2;
                background: linear-gradient(to bottom, rgba(0, 0, 0, 0.6) 0%, rgba(0, 0, 0, 0.9) 60%), url('https://i.pinimg.com/564x/3a/d6/79/3ad6794a32b8d30a683457d6d434e8dd.jpg');
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

            .main-content {
                display: flex;
            }

            .job-listing {
                width: 500px;
                background-color: #f4f4f4;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
                overflow-y: auto;
                max-height: 700px; /* Adjust height to make the container scrollable */
            }

            .job-details {
                width: 900px;
                background-color: white;
                padding: 20px;
                border-top-right-radius: 10px;
                border-bottom-right-radius: 10px;
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
            }
            .job-title-box {
                background: linear-gradient(105deg, #daf1ff, #6a9e95);
                padding: 10px;
                border-radius: 5px;
                width: 860px;
                text-align: center;
                font-size: 1.5em;
                font-weight: bold;
                color: #333;
                margin: 10px;
            }

            .job-employer-info {
                display: flex;
                background-color: white;
                align-items: center;
                margin-bottom: 20px;
                margin: 10px
            }

            .profile-picture {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                margin-right: 20px;
                align-items: center;
                justify-content: center; /* Horizontally center the content */

            }
            .job-info {
                width: 100%;
                background-color: white;
            }

            .job-info p {
                color: #555;
                margin-left: 10px
            }

            .job-card {
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 10px;
                cursor: pointer;
            }

            .job-card:hover {
                transform: scale(1.05);
            }

            .job-card h3 {
                margin: 0;
                font-size: 1.2em;
                color: #333;
            }

            .job-card p {
                margin: 5px 0;
                color: #555;
            }

            .filters {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .filters input,
            .filters select {
                padding: 10px;
                font-size: 1em;
                border: 2px solid #ddd;
                border-radius: 5px;
                flex: 1; /* This makes the elements take up equal space */
                margin-right: 10px; /* Add some space between elements */
            }

            .filters input:last-child,
            .filters select:last-child {
                margin-right: 0; /* Remove the margin for the last element */
            }

            .popup {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .popup-content {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            }

            .popup-buttons {
                display: flex;
                justify-content: space-around;
                margin-top: 20px;
            }

            .apply-btn {
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                background-color: #78E678;
                color: white;
                font-size: 18px;
                font-weight: bold;
                transition: transform 0.3s ease;
            }

            .cancel-btn {
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                background-color: #EE5E5E;
                color: white;
                font-size: 18px;
                font-weight: bold;
                transition: transform 0.3s ease;
            }

            .apply-btn:hover, .cancel-btn:hover {
                transform: scale(1.1);
            }

            p {
                font-size: 17px;
            }

            .apply-button {
                background-color: #A7D88B;
                color: #000;
                padding: 10px 25px;
                border: none;
                border-radius: 5px;
                font-size: 20px;
                font-weight: bold;
                cursor: pointer;
                box-shadow: 0px 0px 20px rgba(255, 255, 255, 0.4);
            }

            .apply-button:hover {
                background-color: #8BC34A;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
                min-width: 100px;
                font-size: 18px;
            }

            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <header>
            <a href="JobseekerHomepage.jsp" class="logo">JobLink</a>
            <a href="JobseekerSignIn.jsp" class="logout" style="float: right;">
                <img src="Images/logout_icon.png" alt="Logout Icon" style="width:20px; height:20px; vertical-align:middle; margin-right: 5px;">
                LogOut
            </a>
            <div class="container">
                <nav class="nav-bar">
                    <ul>
                        <li class="nav-item"><a class="nav-link" href="JobseekerDash.jsp">Homepage</a></li>
                        <li class="nav-item"><a class="nav-link" href="JobseekerHomepage.jsp">Profile</a></li>
                        <li class="nav-item"><a class="nav-link" href="JobHistory.jsp">Job History</a></li>
                        <li class="nav-item"><a class="nav-link" href="ApplyJob.jsp">Find Job</a></li>
                    </ul>
                </nav>
            </div>
        </header>
        <main>
            <div class="intro">
                <h1 class="text-center" style="color:white; font-weight: bold; font-size: 40px;">List of Job Available</h1>
                <div class="containerjob">
                    <div class="filters">
                        <input type="text" id="searchInput" placeholder="Search...">
                        <select id="jobCategory">
                            <option value="All">All Categories</option>
                            <option value="Operations">Operations</option>
                            <option value="Sales/Marketing">Sales/Marketing</option>
                            <option value="Logistic">Logistic</option>
                            <option value="Home">Home</option>
                            <option value="Information Technology">Information Technology</option>
                            <option value="Others">Others</option>
                        </select>
                        <select id="dateFilter">
                            <option value="latest">Latest to Oldest</option>
                            <option value="oldest">Oldest to Latest</option>
                        </select>
                    </div>

                    <div class="main-content">
                        <div class="job-listing">
                            <div id="jobCards">
                                <%
                                    String jdbcUrl = "jdbc:mysql://localhost:3306/joblinkdata";
                                    String dbUser = "root";
                                    String dbPassword = "admin";

                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                                        Statement statement = connection.createStatement();
                                        String query = "SELECT job.*, employer.employID, employer.employName, employer.employPP FROM job "
                                                + "JOIN employer ON job.employID = employer.employID";
                                        ResultSet rs = statement.executeQuery(query);

                                        while (rs.next()) {
                                            int jobID = rs.getInt("jobID");
                                            int employID = rs.getInt("employID"); // Retrieve the employID
                                            String jobName = rs.getString("jobName");
                                            String jobDesc = rs.getString("jobDesc");
                                            String jobCategory = rs.getString("jobCategory");
                                            String jobAddress = rs.getString("jobAddress");
                                            float jobReward = rs.getFloat("jobReward");
                                            String dateCreated = rs.getString("dateCreated");
                                            String dateDue = rs.getString("dateDue");
                                            String employName = rs.getString("employName"); // Retrieve the employName
                                            InputStream employPPStream = rs.getBinaryStream("employPP");
                                            String employPPBase64 = "";

                                            if (employPPStream != null) {
                                                // Convert InputStream to Base64
                                                byte[] employPPBytes = employPPStream.readAllBytes();
                                                employPPBase64 = Base64.getEncoder().encodeToString(employPPBytes);
                                            }
                                %>
                                <div class="job-card" data-date-created="<%= dateCreated%>" onclick="showJobDetails('<%= jobID%>', '<%= jobName%>', '<%= jobDesc%>', '<%= jobAddress%>', '<%= jobReward%>', '<%= dateCreated%>', '<%= employName%>', '<%= employID%>', '<%= employPPBase64%>')">
                                    <h3><%= jobName%></h3>
                                    <p>Category: <%= jobCategory%></p>
                                    <p>Location: <%= jobAddress%></p>
                                    <p>Salary: RM<%= jobReward%></p>
                                    <p style="text-align: right; font-size: 0.8em; color: #888;">Posted on: <%= dateCreated%></p>
                                </div>

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
                            </div>
                        </div>
                        <div class="job-details">
                            <div class="job-title-box" id="jobTitle">Job Title</div>
                            <div class="job-employer-info"> 
                                <img src="data:image/jpeg;base64, id="employerProfilePicture"" alt="Profile Picture" id="employerProfilePicture" class="profile-picture">
                                <div>
                                    <p id="jobEmployer">Posted by <a id="employerLink" href="#">Employer Name</a></p>
                                </div>
                            </div>
                            <div class="job-info">
                                <p id="jobDescription">Description: </p>
                                <div class="location-container">
                                    <p id="jobLocation">Location: </p>
                                    <button id="viewOnMapButton" class="map-button">
                                        <i class="fas fa-map-marker-alt"></i> View on Map
                                    </button>
                                </div>
                                <p id="jobSalary">Salary: </p>
                                <p id="jobDateCreated">Date Created: </p>
                            </div>

                            <style>
                                .location-container {
                                    display: flex;
                                    align-items: center;
                                    gap: 10px;
                                }

                                .map-button {
                                    background-color: #007BFF;
                                    color: white;
                                    padding: 5px 15px;
                                    border: none;
                                    border-radius: 5px;
                                    cursor: pointer;
                                    display: flex;
                                    align-items: center;
                                    font-size: 14px;
                                }

                                .map-button i {
                                    margin-right: 5px;
                                }

                                .map-button:hover {
                                    background-color: #0056b3;
                                }
                            </style>

                            <c:choose>
                                <c:when test="${applicationStatus[job.jobID]}">
                                    <button class="apply-button applied" disabled>Applied</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="apply-button" onclick="showApplyPopup()">Apply</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- Popup Code -->
                <div class="popup" id="applyPopup">
                    <div style="text-align: center;" class="popup-content">
                        <h1>Confirmation</h1>
                        <p>Do you want to apply for this job?</p>
                        <!-- Job Details -->
                        <form id="applyForm" action="JobServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="tapply">
                            <div class="job-details">
                                <input type="hidden" id="jobID" name="jobID" value="">
                                <table>
                                    <tr>
                                        <td><strong>Job Title:</strong></td>
                                        <td><span id="popupJobTitle"></span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Description:</strong></td>
                                        <td><span id="popupJobDescription"></span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Address:</strong></td>
                                        <td><span id="popupJobLocation"></span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Salary:</strong></td>
                                        <td>RM<span id="popupJobSalary"></span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Date Created:</strong></td>
                                        <td><span id="popupJobDateCreated"></span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Employer:</strong></td>
                                        <td><span id="popupJobEmployer"></span></td>
                                    </tr>
                                </table>
                            </div>

                            <!-- Input field for jobseekID -->
                            <input type="hidden" id="jobseekID" name="jobseekID" required>
                            <input type="hidden" id="applyStatus" name="applyStatus" value="Pending">
                            <input type="hidden" id="jobStatus" name="jobStatus" value="Ongoing">
                            <!-- File input for resume --><br>
                            <div class="file-input-container">
                                <label for="resume">Upload Resume (PDF or DOC):</label>
                                <input type="file" id="resume" name="resume" class="file-input" accept=".pdf, .doc, .docx" required>
                                <div id="fileError" style="color: red; display: none;">Invalid file type. Please upload a PDF or DOC file.</div>
                            </div>
                            <div class="popup-buttons">
                                <button type="submit" class="apply-btn">Apply</button>
                                <button type="button" class="cancel-btn" onclick="cancelApply(event)">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <script>
            function showJobDetails(jobID, jobName, jobDesc, jobAddress, jobReward, dateCreated, employName, employID, employPPBase64, hasApplied) {
                document.getElementById('jobID').value = jobID; // Set job ID in a hidden input field
                document.getElementById('jobTitle').textContent = jobName;
                document.getElementById('jobDescription').textContent = "Description: " + jobDesc;
                document.getElementById('jobLocation').textContent = "Location: " + jobAddress;
                document.getElementById('jobSalary').textContent = "Salary: RM" + jobReward;
                document.getElementById('jobDateCreated').textContent = "Date Created: " + dateCreated;

                // Set employer name and link
                var employerLink = document.getElementById('employerLink');
                employerLink.textContent = employName;
                employerLink.href = 'ProfileEmployer.jsp?employID=' + employID;

                // Set employer profile picture
                var employerProfilePicture = document.getElementById('employerProfilePicture');
                employerProfilePicture.src = 'data:image/jpeg;base64, ' + employPPBase64;

                var jobseekID = '<%= session.getAttribute("jobseekID")%>';
                console.log("jobseekID:", jobseekID);
                document.getElementById('jobseekID').value = jobseekID;

                var applyButton = document.querySelector('.apply-button');
                if (hasApplied) {
                    applyButton.textContent = 'Applied';
                    applyButton.classList.add('applied');
                    applyButton.disabled = true;
                } else {
                    applyButton.textContent = 'Apply';
                    applyButton.classList.remove('applied');
                    applyButton.disabled = false;
                }

                // Set the onclick event for the view on map button
                var viewOnMapButton = document.getElementById('viewOnMapButton');
                viewOnMapButton.onclick = function () {
                    viewOnMap(jobAddress);
                };
            }

            function showApplyPopup() {
                document.getElementById('applyPopup').style.display = 'flex';
                document.getElementById('popupJobTitle').textContent = document.getElementById('jobTitle').textContent;
                document.getElementById('popupJobDescription').textContent = document.getElementById('jobDescription').textContent.replace('Description: ', '');
                document.getElementById('popupJobLocation').textContent = document.getElementById('jobLocation').textContent.replace('Location: ', '');
                document.getElementById('popupJobSalary').textContent = document.getElementById('jobSalary').textContent.replace('Salary: RM', '');
                document.getElementById('popupJobDateCreated').textContent = document.getElementById('jobDateCreated').textContent.replace('Date Created: ', '');
                document.getElementById('popupJobEmployer').textContent = document.getElementById('jobEmployer').textContent.replace('Employer: ', '');
            }

            function cancelApply(event) {
                event.preventDefault();
                document.getElementById('applyPopup').style.display = 'none';
            }

            document.getElementById('resume').addEventListener('change', function (event) {
                var fileInput = event.target;
                var filePath = fileInput.value;
                var allowedExtensions = /(\.pdf|\.doc|\.docx)$/i;
                var fileError = document.getElementById('fileError');

                if (!allowedExtensions.exec(filePath)) {
                    fileError.style.display = 'block';
                    fileInput.value = ''; // Clear the file input
                } else {
                    fileError.style.display = 'none';
                }
            });

            function handleFormSubmit(event) {
                event.preventDefault();

                var fileInput = document.getElementById('resume');
                var filePath = fileInput.value;
                var allowedExtensions = /(\.pdf|\.doc|\.docx)$/i;
                var fileError = document.getElementById('fileError');

                if (!allowedExtensions.exec(filePath)) {
                    fileError.style.display = 'block';
                    return false;
                } else {
                    fileError.style.display = 'none';
                }

                // Simulate successful form submission (replace with actual form submission logic)
                setTimeout(function () {
                    // Instead of hiding the popup, redirect to jobHistory.jsp
                    window.location.href = 'jobHistory.jsp';
                }, 1000); // Simulate a delay for the form submission
            }

            document.getElementById('searchInput').addEventListener('input', function () {
                var filter = this.value.toLowerCase();
                var jobCards = document.querySelectorAll('.job-card');

                jobCards.forEach(function (card) {
                    var title = card.querySelector('h3').textContent.toLowerCase();
                    var company = card.querySelector('p:nth-of-type(1)').textContent.toLowerCase();
                    var location = card.querySelector('p:nth-of-type(2)').textContent.toLowerCase();

                    if (title.includes(filter) || company.includes(filter) || location.includes(filter)) {
                        card.style.display = '';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });

            document.getElementById('jobCategory').addEventListener('change', function () {
                var filter = this.value;
                var jobCards = document.querySelectorAll('.job-card');

                jobCards.forEach(function (card) {
                    if (filter === 'All' || card.querySelector('p:nth-of-type(1)').textContent.includes(filter)) {
                        card.style.display = '';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });

            document.getElementById('dateFilter').addEventListener('change', function () {
                var filter = this.value;
                var jobCards = Array.from(document.querySelectorAll('.job-card'));

                jobCards.sort(function (a, b) {
                    var dateA = new Date(a.getAttribute('data-date-created'));
                    var dateB = new Date(b.getAttribute('data-date-created'));

                    if (filter === 'latest') {
                        return dateB - dateA; // Sort latest to oldest
                    } else {
                        return dateA - dateB; // Sort oldest to latest
                    }
                });

                var jobCardsContainer = document.getElementById('jobCards');
                jobCardsContainer.innerHTML = '';
                jobCards.forEach(function (card) {
                    jobCardsContainer.appendChild(card);
                });
            });

            function viewOnMap(placeName) {
                // Use Google Maps API to open the map with the given place name
                window.open("https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent(placeName));
            }
        </script>
    </body>
</html>

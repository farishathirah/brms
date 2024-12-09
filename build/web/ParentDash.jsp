<%@page import="java.io.InputStream"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.DAO.EmployerDAO" %>
<%@ page import="com.Model.Employer" %>
<%@ page import="com.DAO.BookingDAO" %>
<%@ page import="com.Model.Booking" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Parent Dashboard</title>
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
                margin: 50px auto;
                padding: 20px;
                background-color: rgba(255, 255, 255, 0.8); /* white background with 80% opacity */
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

            .welcome {
                font-size: 24px;
                margin-bottom: 20px;
                font-weight: 600;
            }

            .dashboard {
                display: flex;
                justify-content: space-around;
                text-align: center;
                margin-bottom: 20px;
            }

            .dashboard div {
                width: 500px;
                background-color: #fff; /* White background */
                border-radius: 5px; /* Rectangular shape */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                position: relative; /* For positioning the icon */
                margin: 0 5px; /* Spacing between elements */
            }

            .dashboard div h3 {
                margin-bottom: 10px;
                font-size: 16px; /* Smaller font size */
                color: #888; /* Grey color */
                font-weight: normal; /* Normal font weight */
            }

            .dashboard div p {
                font-size: 24px; /* Larger font size */
                font-weight: bold;
                color: #333; /* Darker color */
            }

            .dashboard div a {
                position: absolute;
                top: 10px; /* Positioning at the top right */
                right: 10px;
                color: #333; /* Icon color */
                font-size: 18px;
                text-decoration: none;
            }

            .dashboard div a:hover {
                color: #555; /* Hover color */
            }

            .dashboard div::after {
                content: '';
                display: block;
                width: 100%;
                height: 4px;
                background-color: #007BFF; /* Blue color line */
                position: absolute;
                bottom: 0;
                left: 0;
                border-bottom-left-radius: 5px;
                border-bottom-right-radius: 5px;
            }

            .find-jobs-now a {
                margin-top: 5px;
                text-decoration: none;
                color: white;
                background-color: #829EA6;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 18px;
                font-weight: 600;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .find-jobs-now a:hover {
                background-color: #2e3e42;
                transition: background-color 0.3s ease;
            }

            .joblink-info {
                margin-top: 20px;
                padding: 15px;
                background-color: #f5f5f5;
                border-radius: 10px;
                text-align: center;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .profile-pic {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                margin-bottom: 20px;
                background-color: #ddd;
                display: flex;
                align-items: center;
                justify-content: center;
                overflow: hidden;
            }

            .profile-pic img {
                width: 100%;
                height: auto;
            }

        </style>
    </head>
    <body>
        <header>
            <header style="display: flex; justify-content: space-between; align-items: center; background-color: black;">
                <a href="EmployerHomepage.jsp" class="logo">JobLink</a>
                <div class="centered-text" style="color: white; flex-grow: 1; text-align: center;">Employer</div>
                <a href="EmployerSignIn.jsp" class="logout">
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
        <div class="intro">
            <div class="content">
                <%
                    String jdbcUrl = "jdbc:mysql://localhost:3306/babysitter";
                    String dbUser = "root";
                    String dbPassword = "admin";
                    Integer parentID = (Integer) session.getAttribute("parentID");
                    String parentName = "";
                    String parentPPBase64 = ""; // Placeholder for profile picture in Base64
                    int bookingsPosted = 0;
                    int applicationsPending = 0;

                    if (parentID != null) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                            // Get parent name and profile picture
                            PreparedStatement ps = con.prepareStatement("SELECT parentName, parentPP FROM parenter WHERE parentID = ?");
                            ps.setInt(1, parentID);
                            ResultSet rs = ps.executeQuery();
                            if (rs.next()) {
                                parentName = rs.getString("parentName");
                                InputStream parentPPStream = rs.getBinaryStream("parentPP");

                                if (parentPPStream != null) {
                                    // Convert InputStream to Base64
                                    byte[] parentPPBytes = parentPPStream.readAllBytes();
                                    parentPPBase64 = Base64.getEncoder().encodeToString(parentPPBytes);
                                }
                            }
                            rs.close();
                            ps.close();

                            // Get bookings posted
                            ps = con.prepareStatement("SELECT COUNT(*) AS bookingID FROM booking WHERE parentID = ?");
                            ps.setInt(1, parentID);
                            rs = ps.executeQuery();
                            if (rs.next()) {
                                bookingsPosted = rs.getInt("bookingID");
                            }
                            rs.close();
                            ps.close();

                            // Get applications pending
                            ps = con.prepareStatement(
                                    "SELECT COUNT(*) AS applicationsPending "
                                    + "FROM appliedbooking "
                                    + "JOIN booking ON appliedbooking.bookingID = booking.bookingID "
                                    + "WHERE booking.parentID = ? AND appliedbooking.applyStatus = 'pending'"
                            );
                            ps.setInt(1, parentID);
                            rs = ps.executeQuery();
                            if (rs.next()) {
                                applicationsPending = rs.getInt("applicationsPending");
                            }
                            rs.close();
                            ps.close();

                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("Database connection error: " + e.getMessage());
                        }
                    } else {
                        response.sendRedirect("EmployerSignIn.jsp");
                    }
                %>
                <div class="profile-pic">
                    <img src="data:image/jpeg;base64,<%= parentPPBase64%>" alt="Profile Picture" class="profile-picture">
                </div>
                <div class="welcome">
                    Welcome, <%= parentName%>!
                </div>
                <div class="dashboard">
                    <div>
                        <h3>Bookings Posted</h3>
                        <p><%= bookingsPosted%></p>
                        <a href="http://localhost:8080/BabysitterProject/BookingServlet?action=tlist" class="fas fa-list"></a> <!-- List icon -->
                    </div>
                    <div>
                        <h3>Applications Pending</h3>
                        <p><%= applicationsPending%></p>
                        <a href="BookingInfo.jsp" class="fas fa-list"></a> <!-- List icon -->
                    </div>
                </div>

                <div class="find-jobs-now">
                    <a href="BookingForm.jsp">Post a Booking</a>
                </div>
                <div class="joblink-info">
                    <h2>About JobLink</h2>
                    <p>JobLink is your go-to platform for finding the perfect candidates tailored to your job requirements. Whether you're looking for part-time workers, full-time employees, or freelancers, JobLink has it all. Start posting jobs today and find the best talent for your business!</p>
                </div>
            </div>
        </div>
    </body>
</html>

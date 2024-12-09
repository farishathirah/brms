<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - BRMS</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Sriracha&display=swap');

            body {
                margin: 0;
                box-sizing: border-box;
                background-color:  black;
            }

            /* CSS for header */
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
                color:white;
                text-decoration: none;
                margin-top: 5px;
                margin-right: 30px;
            }
            .container {
                max-width: 2000px;
                margin: 0 auto;
                background-color: #8BABB2;
                font-family: "Poppins";
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }
            .nav-items {
                display: flex;
                justify-content: space-around;
                align-items: center;
                background-color: #8BABB2;
                margin-right: 20px;

            }

            .nav-items a {
                text-decoration: none;
                color: #000;
                padding: 35px 20px;
            }

            /* CSS for main element */

            .main {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh; /* 100% of the viewport height */
            }
            .intro {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center; /* Center content vertically */
                width: 100%;
                min-height: 900px;
                max-height: 10000px;
                background: gainsboro;

            }
            .intro h1 {
                font-family: "Times new roman";
                font-size: 40px;
                color: black;
                font-weight: bold;
                text-transform: uppercase;
                margin: 5px;
            }

            .intro p {
                font-size: 20px;
                margin: 20px 0;
            }

            .intro button {
                color: #000;
                padding: 10px 25px;
                border: none;
                border-radius: 5px;
                font-size: 20px;
                font-weight: bold;
                cursor: pointer;
                box-shadow: 0px 0px 20px rgba(255, 255, 255, 0.4)
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

            .dashboard-row {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
                margin-top: 20px;
            }

            .dashboard-item {
                flex: 1 1 calc(25% - 20px); /* Adjust width as needed */
                margin: 10px;
                padding: 20px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .dashboard-item:hover {
                transform: scale(1.05);
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
                background-color: #DBDEE8;
            }

            .dashboard-item h2 {
                margin-bottom: 15px;
                color: #7B8092;
            }

            .dashboard-item .count {
                font-size: 36px;
                font-weight: bold;
                color: #007bff;
            }

            .dashboard-item a {
                display: inline-block;
                margin-top: 20px;
                text-decoration: none;
                background-color: #28a745;
                color: white;
                padding: 12px 25px;
                border-radius: 15px;
                font-size: 18px;
                transition: background-color 0.3s ease, padding 0.3s ease, font-size 0.3s ease;
            }

            .dashboard-item a:hover {
                background-color: #218838;
                padding: 14px 27px;
                font-size: 20px;
            }

            .chart-container {
                width: 100%;
                max-width: 800px; /* Adjust max-width as needed */
                height: 400px;
                margin: 50px auto;
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }

            .commission-table {
                width: 80%;
                border-radius: 50px;
                margin: 20px auto;
                border-color: grey;
            }

            .commission-table th,
            .commission-table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .commission-table th {
                background-color: #f2f2f2;
            }

            .commission-table tr:nth-child(even) {
                background-color: #f9f9f9; /* Alternate row color */
            }

            .commission-table tr:hover {
                background-color: #f0f0f0; /* Hover color */
            }


        </style>
    </head>
    <body>
        <header>
            <a href="posterHomepage.jsp" class="logo">BRMS</a>
            <a href="AdminSignIn.jsp" class="logout" style="float: right;">LogOut</a>

            <div class="container">
                <nav class="nav-bar">
                    <ul>
                        <li class="nav-item"><a class="nav-link" href="adminHomepage.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="ParentServlet?action=plist">Manage Parents</a></li>
                        <li class="nav-item"><a class="nav-link" href="BabysitterServlet?action=prlist">Manage Babysitter</a></li>
                        <li class="nav-item"><a class="nav-link" href="Report.jsp">Reports</a></li>
                    </ul>
                </nav>
            </div>
        </header>
        <main>
            <div class="intro">
                <p style="color: Black; margin:10px auto">Welcome Administrator!</p>

                <%
                    // Initialize variables for database connection
                    String url = "jdbc:mysql://localhost:3306/babysitter";
                    String user = "root"; // replace with your database username
                    String password = "admin"; // replace with your database password
                    Connection con = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    // Initialize counts
                    int parentCount = 0;
                    int babysitterCount = 0;
                    int bookCount = 0;
                    double totalCommission = 0.0;
                    Map<Integer, Double> parentCommissionMap = new HashMap<>();

                    try {
                        // Load the JDBC driver
                        Class.forName("com.mysql.jdbc.Driver");

                        // Establish database connection
                        con = DriverManager.getConnection(url, user, password);
                        stmt = con.createStatement();

                        // Query to count number of parents
                        String sqlParent = "SELECT COUNT(parentID) AS count FROM parent";
                        rs = stmt.executeQuery(sqlParent);
                        if (rs.next()) {
                            parentCount = rs.getInt("count");
                        }

                        // Query to count number of jobseekers
                        String sqlBabysitters = "SELECT COUNT(babysitterID) AS count FROM babysitter";
                        rs = stmt.executeQuery(sqlBabysitters);
                        if (rs.next()) {
                            babysitterCount = rs.getInt("count");
                        }

                        // Query to count number of jobs submitted
                        String sqlJobs = "SELECT COUNT(bookID) AS count FROM book";
                        rs = stmt.executeQuery(sqlJobs);
                        if (rs.next()) {
                            bookCount = rs.getInt("count");
                        }

                        // Query to calculate total commission earned from completed jobs
                        String sqlCommission = "SELECT j.parentID, e.parentName, j.bookReward "
                                + "FROM Payment p "
                                + "JOIN Book j ON p.bookID = j.bookID "
                                + "JOIN Parent e ON j.parentID = e.parentID "
                                + "WHERE p.paymentStatus = 'Completed'";

                        // Execute query
                        rs = stmt.executeQuery(sqlCommission);

                        // Process result set to calculate commissions
                        while (rs.next()) {
                            int parentID = rs.getInt("parentID");
                            String parentName = rs.getString("parentName");
                            double bookReward = rs.getDouble("bookReward");
                            double commission = bookReward * 0.01; // Calculate commission (5% of jobReward)

                            // Update total commission
                            totalCommission += commission;

                            // Update parent commission map
                            if (parentCommissionMap.containsKey(parentID)) {
                                double currentCommission = parentCommissionMap.get(parentID);
                                parentCommissionMap.put(parentID, currentCommission + commission);
                            } else {
                                parentCommissionMap.put(parentID, commission);
                            }
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                    } finally {
                        // Close all the connections
                        try {
                            if (rs != null) {
                                rs.close();
                            }
                            if (stmt != null) {
                                stmt.close();
                            }
                            if (con != null) {
                                con.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>

                <!-- Display the dashboard with the retrieved counts -->
                <div class="dashboard-row">
                    <div class="dashboard-item">
                        <h2>Number of Parents Registered</h2>
                        <div class="count"><%= parentCount%></div>
                        <a href="ParentServlet?action=plist">View Parents</a>
                    </div>

                    <div class="dashboard-item">
                        <h2>Number of Babysitters Registered</h2>
                        <div class="count"><%= babysitterCount%></div>
                        <a href="BabysitterServlet?action=prlist">View Babysitters</a>
                    </div>

                    <div class="dashboard-item">
                        <h2>Number of Booking Submitted</h2>
                        <div class="count"><%= bookCount%></div>
                        <a href="Report.jsp">View Bookings</a>
                    </div>

                </div>

                <!-- Chart container -->
                <div class="chart-container">
                    <canvas id="dashboardChart"></canvas>
                </div>

                <div class="dashboard-item">
                    <h2>Total Commission Earned</h2>
                    <div class="count">RM <%= String.format("%.2f", totalCommission)%></div>
                </div>
                <!-- Table for parent commission details -->
                <table class="commission-table">
                    <thead>
                        <tr>
                            <th>Parents ID</th>
                            <th>Parents Name</th>
                            <th>Commission Paid (RM)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                con = DriverManager.getConnection(url, user, password);
                                stmt = con.createStatement();
                                String sqlParentCommission = "SELECT e.parentID, e.parentName FROM parent e";
                                rs = stmt.executeQuery(sqlParentCommission);
                                while (rs.next()) {
                                    int parentID = rs.getInt("parentID");
                                    String parentName = rs.getString("parentName");
                                    double commissionPaid = parentCommissionMap.getOrDefault(parentID, 0.0);
                        %>
                        <tr>
                            <td><%= parentID%></td>
                            <td><%= parentName%></td>
                            <td>RM <%= String.format("%.2f", commissionPaid)%></td>
                        </tr>
                        <%
                                }
                                rs.close();
                                stmt.close();
                                con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </main>

        <!-- JavaScript for Chart.js -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var ctx = document.getElementById('dashboardChart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: ['Parents', 'Babysitters', 'Booking Submitted'],
                        datasets: [{
                                label: 'Count',
                                data: [<%= parentCount%>, <%= babysitterCount%>, <%= bookCount%>],
                                backgroundColor: ['#007bff', '#28a745', '#ffc107']
                            }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            });
        </script>
    </body>
</html>

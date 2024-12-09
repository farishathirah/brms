<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
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
                min-width: 1200px;
                margin: 10px auto;
                padding: 10px;
                background-color: rgba(255, 255, 255); /* white background with 80% opacity */
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

            .content h3 {
                margin-bottom: 20px;
            }

            .form-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
                width: 100%;
            }

            .form-grid div {
                display: flex;
                flex-direction: column;
            }

            .ele {
                height: 40px;
                min-width: 500px;
                width:100%;
                border: 1px solid #ccc;
                color: rgb(77, 77, 77);
                background-color: rgb(240, 240, 240);
                border-radius: 4px;
                font-size: 14px;
                padding: 10px;
                box-sizing: border-box;
            }

            input[type="text"],
            select,
            textarea,
            input[type="date"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
                box-sizing: border-box;
            }

            textarea {
                height: 100px; /* Larger height for description */
            }

            input[type="text"]::placeholder,
            textarea::placeholder {
                color: #ccc;
            }

            button {
                padding: 15px;
                background-color: #007bff;
                border: none;
                border-radius: 50px;
                color: #fff;
                font-size: 18px;
                cursor: pointer;
                margin-top: 20px;
                width: 200px;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #0056b3;
            }

            .login-box {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
            }

            .label1 {
                text-align: left;
                width: 220px;
            }

            .h3 {
                color: black;
            }

        </style>
    </head>
    <body>
        <header>
            <header style="display: flex; justify-content: space-between; align-items: center; background-color: black;">
                <a href="BabysitterHomepage.jsp" class="logo">BRMS</a>
                <div class="centered-text" style="color: white; flex-grow: 1; text-align: center;">Parent</div>
                <a href="BabysitterSignIn.jsp" class="logout">
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
            </div>        </header>
        <main>
            <div class="intro">
                <div class="content">
                    <h3 align="center">
                        <c:if test="${booking!= null}">
                            Edit Booking Information
                        </c:if>
                        <c:if test="${booking== null}">
                            Fill in the Booking Form
                        </c:if>
                    </h3>
                    <c:if test ="${booking!=null}">
                        <form action="BookingServlet" method="post" onsubmit="return validateForm();">
                            <input type="hidden" name="action" value="tupdate">
                        </c:if>
                        <c:if test="${booking== null}">
                            <form action="BookingServlet" method="post" onsubmit="return validateForm();">
                                <input type="hidden" name="action" value="tinsert">
                            </c:if>
                            <c:if test="${booking!=null}">
                                <input type="hidden" name ="bookingID" id="bookingID" value="<c:out value='${booking.bookingID}'/>"/>
                            </c:if>
                            <div class="form-grid">
                                <div>
                                    <label>User ID</label>
                                    <input type="text" name="parentID" id="parentID" class="ele" value="<c:out value='${sessionScope.parentID}'/>" readonly style="background-color: #848e94; color: #fff;">
                                </div>
                                <div style="grid-column: span 2;">
                                    <label>Description</label>
                                    <textarea name="bookingDesc" id="bookingDesc" class="ele" placeholder="Enter Description. E.g. Requirements, Responsibilities, etc." required><c:out value="${booking.bookingDesc}"/></textarea>
                                </div>
                                    <div>
                                        <label for="addressLine1">Address</label>
                                        <input type="text" name="bookingAddress" id="bookingAddress" class="ele" required placeholder="Enter Address" value="<c:out value='${booking.bookingAddress}'/>">
                                </div>
                                <div>
                                    <label for="city">City</label>
                                    <input type="text" name="bookingCity" id="bookingCity" class="ele" required value="<c:out value='${booking.bookingCity}'/>" placeholder="Enter City">
                                </div>
                                <div>
                                    <label for="bookingState">State/Province</label>
                                    <select name="bookingState" id="bookingState" class="ele" required>
                                        <option value="">Select</option>
                                        <option value="Johor"<c:if test="${booking.bookingState eq 'Johor'}">selected</c:if>>Johor</option>
                                        <option value="Kedah" <c:if test="${booking.bookingState eq 'Kedah'}">selected</c:if>>Kedah</option>
                                        <option value="Kelantan"<c:if test="${booking.bookingState eq 'Kelantan'}">selected</c:if>>Kelantan</option>
                                        <option value="Kuala Lumpur"<c:if test="${booking.bookingState eq 'Kuala Lumpur'}">selected</c:if>>Kuala Lumpur</option>
                                        <option value="Labuan" <c:if test="${booking.bookingState eq 'Labuan'}">selected</c:if>>Labuan</option>
                                        <option value="Melaka" <c:if test="${booking.bookingState eq 'Melaka'}">selected</c:if>>Melaka</option>
                                        <option value="Negeri Sembilan"<c:if test="${booking.bookingState eq 'Negeri Sembilan'}">selected</c:if>>Negeri Sembilan</option>
                                        <option value="Pahang"<c:if test="${booking.bookingState eq 'Pahang'}">selected</c:if>>Pahang</option>
                                        <option value="Perak"<c:if test="${booking.bookingState eq 'Perak'}">selected</c:if>>Perak</option>
                                        <option value="Perlis"<c:if test="${booking.bookingState eq 'Perlis'}">selected</c:if>>Perlis</option>
                                        <option value="Pulau Pinang" <c:if test="${booking.bookingState eq 'Pulau Pinang'}">selected</c:if>>Pulau Pinang</option>
                                        <option value="Sabah"<c:if test="${booking.bookingState eq 'Sabah'}">selected</c:if>>Sabah</option>
                                        <option value="Sarawak" <c:if test="${booking.bookingState eq 'Sarawak'}">selected</c:if>>Sarawak</option>
                                        <option value="Selangor"<c:if test="${booking.bookingState eq 'Selangor'}">selected</c:if>>Selangor</option>
                                        <option value="Terengganu" <c:if test="${booking.bookingState eq 'Terengganu'}">selected</c:if>>Terengganu</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label for="bookingZip">Zip/Postal Code</label>
                                        <input type="text" name="bookingZip" id="bookingZip" class="ele" required value="<c:out value='${booking.bookingZip}'/>" placeholder="Enter Postal Code">
                                </div>                               
                                <div>
                                    <label>Salary</label>
                                    <input type="text" name="bookingReward" id="bookingReward" class="ele" value="<c:out value='${booking.bookingReward}'/>" placeholder="Enter Amount" required>
                                </div>


                                <input type="hidden" name="dateCreated" id="dateCreated" class="ele" placeholder="Date Today" readonly>

                                <div>
                                    <label>Date</label>
                                    <input type="date" name="date" id="date" class="ele" value="<c:out value='${booking.date}'/>" required>
                                </div>
                                <div>
                                    <label>Start Time</label>
                                    <input type="time" name="startTime" id="startTime" class="ele" value="<c:out value='${booking.startTime}'/>" placeholder="Enter Job Start Time" required>
                                </div>
                                <div>
                                    <label>End Time</label>
                                    <input type="time" name="endTime" id="endTime" class="ele" value="<c:out value='${booking.endTime}'/>" placeholder="Enter Job End Time" required>
                                </div>



                            </div>   
                            <div class="login-box">
                                <button type="submit" class="clkbtn">Save</button>
                            </div>
                        </form>
                </div>
            </div>
            <script>

                function getTodayDate() {
                    const today = new Date();
                    const year = today.getFullYear();
                    const month = (today.getMonth() + 1).toString().padStart(2, '0');
                    const day = today.getDate().toString().padStart(2, '0');
                    return `${year}-${month}-${day}`;
                        }

                        // Set the min attribute for the date inputs on page load
                        document.addEventListener("DOMContentLoaded", function () {
                            const todayDate = getTodayDate();
                            const bookingStartDateInput = document.getElementById('bookingStartDate');
                            const dateDueInput = document.getElementById('dateDue');

                            bookingStartDateInput.setAttribute('min', todayDate);
                            dateDueInput.setAttribute('min', todayDate);

                            // Prevent manual entry of dates before today and alert the user
                            bookingStartDateInput.addEventListener('change', function () {
                                if (bookingStartDateInput.value < todayDate) {
                                    alert("You cannot select a date before today.");
                                    bookingStartDateInput.value = todayDate;
                                }
                            });

                            dateDueInput.addEventListener('change', function () {
                                if (dateDueInput.value < todayDate) {
                                    alert("You cannot select a date before today.");
                                    dateDueInput.value = todayDate;
                                }
                            });
                        });

                        function getCurrentDate() {
                            var today = new Date();
                            var year = today.getFullYear();
                            var month = (today.getMonth() + 1).toString().padStart(2, '0');
                            var day = today.getDate().toString().padStart(2, '0');
                            return year + '-' + month + '-' + day;
                        }

                        document.addEventListener('DOMContentLoaded', function () {
                            document.getElementById('dateCreated').value = getCurrentDate();
                        });

                        function validateForm() {
                            var parentID = document.getElementById('parentID').value;
                            var bookingName = document.getElementById('bookingName').value;
                            var bookingDesc = document.getElementById('bookingDesc').value;
                            var bookingCategory = document.getElementById('bookingCategory').value;
                            var bookingReward = document.getElementById('bookingReward').value;
                            var dateDue = document.getElementById('dateDue').value;

                            concatenateJobDesc();
                            concatenateJobAddress();

                            if (!parentID || !bookingName || !bookingDesc || !bookingCategory || !bookingReward || !dateDue) {
                                alert('Please fill in all fields before submitting the form.');
                                return false;
                            }

                            alert('Form submitted successfully!');
                            return true;
                        }

                        function concatenateJobDesc() {
                            var bookingDesc = document.getElementById("bookingDesc").value.trim();
                            var bookingType = document.getElementById("bookingType").value;
                            var bookingStartDate = document.getElementById("bookingStartDate").value;

                            var bookingTypeRegex = /Job Type: [^,]+/;
                            var bookingStartDateRegex = /Start Date: [^\n]+/;

                            if (bookingTypeRegex.test(bookingDesc)) {
                                bookingDesc = bookingDesc.replace(bookingTypeRegex, "Job Type: " + bookingType);
                            } else {
                                bookingDesc += (bookingDesc ? ", " : "") + "Job Type: " + bookingType;
                            }

                            if (bookingStartDateRegex.test(bookingDesc)) {
                                bookingDesc = bookingDesc.replace(bookingStartDateRegex, "Start Date: " + bookingStartDate);
                            } else {
                                bookingDesc += (bookingDesc ? ", " : "") + "Start Date: " + bookingStartDate;
                            }

                            document.getElementById("bookingDesc").value = bookingDesc;
                        }

                        function concatenateJobAddress() {
                            var bookingAddress = document.getElementById("bookingAddress").value;
                            var bookingCity = document.getElementById("bookingCity").value;
                            var bookingState = document.getElementById("bookingState").value;
                            var bookingZip = document.getElementById("bookingZip").value;

                            var fullAddress = bookingAddress + ", " + bookingCity + ", " + bookingState + " " + bookingZip;

                            document.getElementById("bookingAddress").value = fullAddress;
                        }
            </script>
        </main>
    </body>
</html>


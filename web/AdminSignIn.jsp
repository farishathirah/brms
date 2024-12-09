<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - BRMS</title>
        <style>
            @import url("https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Poppins", sans-serif;
            }
 
            body {
                height: 100vh;
                width: 100vw;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                gap: 30px;
                background: whitesmoke;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;

            }

            header {
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }

            .heading {
                color: black;
            }

            .heading-link {
                cursor: pointer;
                text-decoration: none;
                color: inherit; /* Inherit the color from the parent element */
                transition: color 0.3s ease; /* Smooth color transition */
            }

            .title {
                font-weight: 400;
                letter-spacing: 1.5px;
                color: black;

            }

            .container {
                height: 490px;
                width: 700px;
                background-color: #afc3c9;
                box-shadow: 8px 8px 10px black;
                position: relative;
                overflow: hidden;
                border-radius: 50px;
            }

            .login-box {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 0px 40px;
            }

            /* email password field box */
            .ele {
                height: 60px;
                width: 400px;
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
                width: 150px;
                border-radius: 50px;
                background-color: #829EA6;
                font-size: 22px;
                border: none;
                cursor: pointer;
            }
            .clkbtn2 {
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

            .clkbtn2:hover {
                background-color: #55737C;
            }

            .clkbtn3 {
                height: 60px;
                width: 230px;
                border-radius: 50px;
                background-color: #143C49;
                font-size: 22px;
                border: none;
                cursor: pointer;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }


            .label1 {
                text-align: left;
            }

            .h3 {
                color: black;
            }

            .button-group {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
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
            
        </style>
    </head>
    <body>
        <header>
            <a href="FirstHomepage.jsp" class="heading-link">
                <h1 class="heading">BRMS</h1></a>
            <h3 class="title">Trusted Babysitter You Looking For</h3>
        </header>

        <!-- container div -->
        <div class="container">
            <br>
            <h3 align="center">Admin Log In</h3>
            <div class="form-section">

                <!-- login form -->
                <div class="login-box">
                    <div class="button-group">
                        
                    </div><br>
                        <label class="label1">Username</label>
                    <input type="text" id="username" class="ele" placeholder="Enter your Username"><br>
                    <label class="label1">Password</label>
                    <input type="password" id="password" class="password ele" placeholder="Enter your Password"><br>
                    <button class="clkbtn" onclick="login()">Login</button>
                </div>
                <br>
                <h3 align="center"><a href="ForgotPassword.jsp">Forgot password?</a></h3>
            </div>
        </div>

        <script>
            function login() {
                var username = document.getElementById("username").value;
                var password = document.getElementById("password").value;

                if (username === "farisha" && password === "12345") {
                    // Redirect to the owner's desired page upon successful login
                    window.location.href = "adminHomepage.jsp";
                } else {
                    alert("Invalid username or password. Please try again.");
                }
            }

        </script>

        
        
    </body>
</html>

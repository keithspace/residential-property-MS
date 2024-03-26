<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Remove Property</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        button {
    background: var(--main-color);
    color: #fff;
    height: 37px;
    border-radius: 4px;
    padding: 0rem 1rem;
    border: none;
    margin-top: 5px;
    font-weight: 600;
}
    </style>
</head>
<body>
    <input type="checkbox" id="menu-toggle">
    <div class="sidebar">
        <div class="side-header">
            <h3><span>NestQuest</span></h3>
        </div>
        
        <div class="side-content">
            <div class="profile">
                <div class="profile-img bg-img" style="background-image: url(img/1.jpeg)"></div>
                <h4>Administrator</h4>
                <small>PM1</small>
            </div>

            <div class="side-menu">
                <ul>
                    <li>
                       <a href="displayProperties.jsp" class="active">
                            <span class="las la-home"></span>
                            <small>Properties</small>
                        </a>
                    </li>
                    <li>
                       <a href="booking.jsp">
                            <span class="las la-clipboard-list"></span>
                            <small>Bookings</small>
                        </a>
                    </li>
                    <!--<li>
                       <a href="profile.html">
                            <span class="las la-user-alt"></span>
                            <small>Profile</small>
                        </a>
                    </li>-->
                </ul>
            </div>
        </div>
    </div>
    
    <div class="main-content">
        <header>
            <div class="header-content">
                <label for="menu-toggle">
                    <span class="las la-bars"></span>
                </label>
                
                <div class="header-menu">
                  <!--  <label for="">
                        <span class="las la-search"></span>
                    </label>
                    
                    <div class="notify-icon">
                        <span class="las la-bell"></span>
                        <span class="notify">3</span>
                    </div>-->
                    
                    <div class="user">
                        <div class="bg-img" style="background-image: url(img/1.jpeg)"></div>
                        
                        <span class="las la-power-off"></span>
                        <a href="AdminLogoutServlet">Logout</a>
                    </div>
                </div>
            </div>
        </header>
        
        <main>
            <div class="page-header">
                <h1>Remove Property</h1>
                <small>Home / Remove Property</small>
            </div>
            
            <div class="page-content">
                <div class="remove-form">
                    <form action="removePropertyAction.jsp" method="post">
                        <label for="propertyName">Enter Property Name:</label>
                        <input type="text" id="propertyName" name="propertyName" required>
                        <button type="submit">Search and Remove</button>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="style.css" type="text/css"/>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking</title>
    <style>
        body {
            background-color: white; /* White blended with blue */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .booking-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .booking-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }

        .booking-form label {
            display: block;
            margin-bottom: 10px;
            text-align: left;
            font-weight: bold;
            color: #555;
        }

        .booking-form input[type="text"],
        .booking-form input[type="tel"],
        .booking-form input[type="email"],
        .booking-form input[type="submit"],
        .booking-form input[type="date"]{
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .booking-form input[type="submit"] {
            background-color: #0073CF; 
            color: white;
            border: none;
            cursor: pointer;
        }

        .booking-form input[type="submit"]:hover {
            background-color:  blue;
        }
    </style>
</head>
<body>
    <div class="booking-container">
        <p class="booking-title">BOOKING</p>
        <form class="booking-form" id="bookingForm" action="BookingServlet" method="post">
            <label for="customerName">Your Name:</label>
            <input type="text" id="customername" name="customername" required>

            <label for="phoneNumber">Phone Number:</label>
            <input type="tel" id="phonenumber" name="phonenumber" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            
            <label for="date">Book a Day For The House Visit:</label>
            <input type="date" id="date" name="date" required><br><br>
            
             <input type="hidden" id="propertyID" name="propertyID" value="${param.propertyID}"><br><br>

            <input type="submit" value="Book Property">
        </form>
    </div>
    <script>
        // Function to validate name input
        function validateName() {
            var nameInput = document.getElementById('customername');
            var name = nameInput.value.trim(); // Remove leading and trailing spaces
            
            // Regular expression to check for numbers
            var regex = /^[a-zA-Z\s]*$/;
            
            if (!regex.test(name)) { // If input contains numbers
                nameInput.classList.add('error'); // Add error class to input
                return false;
            } else {
                nameInput.classList.remove('error'); // Remove error class from input
                return true;
            }
        }

        // Add event listener for form submission
        document.getElementById('bookingForm').addEventListener('submit', function(event) {
            if (!validateName()) { // If name validation fails
                event.preventDefault(); // Prevent form submission
                alert("Please Enter a valid Name!");
            }
        });
    </script>

</body>
</html>




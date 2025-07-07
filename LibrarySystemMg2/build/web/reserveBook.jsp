<!DOCTYPE html>
<html lang="en">
<head>
     <%
    // Set cache control headers
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.

    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Reservation</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('https://images5.alphacoders.com/919/thumb-1920-919004.jpg');
            background-size: cover;
            background-repeat:no-repeat;
            color:#432818;
            height: 100vh;
            width: 100%;
            background-attachment: fixed;
        }

        .header {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            width: 100vw;
            z-index: 1000; 
            top: 0;
        }

        .header h1 {
            font-size: 24px;
            margin: 0;
        }

        .header .user-info {
            font-size: 14px;
            padding-right:50px;
        }

        .sidebar {
            position: fixed;
            width: 180px;
            background-color: rgba(170, 143, 105, 0.9);
            padding: 15px;
            position: fixed;
            top: 50px;
            bottom: 0;
            left: 0;
            overflow-y: auto;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 10px;
            margin: 5px 0;
            text-decoration: none;
            color: seashell;
            font-weight: 750;
            font-size: 15px;
            background-color: rgba(54, 36, 12, 0.9);
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .sidebar a img {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }

        .sidebar a:hover {
            background: #432818;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to right, #ede0d4, #432818);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to right, #ede0d4, #432818); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
        }

        .content {
            margin-left: 20vw; /* Adjusted to match sidebar width */
            padding :20px;
            display: flex;
            flex-direction: column;
            align-items: center; /* Compensate for the fixed header */
            
        }

        .container {
            background-color: rgba(255, 255, 255, 0.8);
            margin-top: 8vh;
            width :80%;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 5px 8px rgba(54, 36, 12, 0.9);
            display: flex;
            flex-direction: column;
            align-items: center; /* Center the content inside the container */
        }

        .container h3{
            font-size: 3rem;
            padding: 0px;
            padding-top: 20px;
            margin: 0px;
        }
        
        form {
            display: flex;
            flex-direction: column;
            padding: 10px;
            width:80%;
         }
          
          label{
              padding-bottom:10px;
              padding-top:10px;
          }
          
        input[type="text"], 
        input[type="number"], 
        select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
        }
        
        
        input[type="submit"] {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: seashell;
            background-color: rgba(54, 36, 12, 0.9);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        input[type="submit"]:hover {
            background: #603813;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to right, #b29f94, #603813);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to right, #b29f94, #603813); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
            color:seashell;
            transform: translateY(-2px);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px; /* Added margin for table spacing */
            border-radius: 5px;
            
        }

        table, th, td {
            border: 1px solid rgba(54, 36, 12, 0.9); 
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: rgba(54, 36, 12, 0.9); 
            color: seashell;
        }

        @media (max-width: 768px) {
           
            .content {
                margin-left: 30vw;
                padding: 10px;
                margin-top: 30px;
            }
            
            .container{
                width:90%;
            }

            .container h3 {
                font-size: 2rem;
                text-align: center;
            }
            table{
                width: 70%;
                font-size: 0.7rem;
            }
            button{
                font-size: 0.5rem;
            }
        }
    </style>

</head>
<body>
    <div class="header">
        <h1>Student Homepage</h1>
        <div class="user-info">
            Logged in as: <strong>Student</strong>
        </div>
    </div>
    <div class="sidebar">
        <nav>
            <a href="homeStudent.jsp"><img src="icons/home.png" alt="Home"> HOME</a>
            <a href="reserveBook.jsp"><img src="icons/reserve.png" alt="New Book"> RESERVE BOOK</a>
            <a href="extendBook.jsp"><img src="icons/extend.png" alt="Catalog"> EXTEND DUE DATE</a>
            <a href="returnBook.jsp"><img src="icons/return.png" alt="Update Book"> RETURN BOOK</a>
            <a href="fine.jsp"><img src="icons/pay.png" alt="View Reservations"> PAY FINE</a>
            <a href="LogoutServlet"><img src="icons/logout.png" alt="Log Out"> LOG OUT</a>
        </nav>
    </div>
    <div class="content">
        <div class="container">
            <h3>Reserve a Book</h3>
            <form action="ReserveBookServlet" method="post">
                <label for="bookId">Book ID:</label>
                <input type="text" id="bookId" name="bookId" required>
                <label for="studentId">Student ID:</label>
                <input type="text" id="studentId" name="studentId" required>
                <input type="submit" value="Reserve Book" class="attractive-button">
            </form>
        </div>
        <div class="container">
            <h3>Book Catalog</h3>
            <table>
                <tbody id="catalogContent">
                    <!-- Books will be dynamically inserted here -->
                </tbody>
            </table>
        </div>
    </div>
    <script>
    document.addEventListener('DOMContentLoaded', displayBooks);

    function displayBooks() {
        fetch('ManageBook?view=student')
            .then(response => response.text())
            .then(data => {
                document.getElementById('catalogContent').innerHTML = data;
            })
            .catch(error => console.error('Error:', error));
    }
</script>

</body>
</html>


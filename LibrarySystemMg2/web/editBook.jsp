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
    <title>Library System Management - Staff</title>
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
            justify-content: center;
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
            padding: 20px;
            margin: 0px;
        }
        .form-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            padding: 10px;
            padding-right: 30px;
          }
          .form-container .form-group {
            flex: 0 0 48%; /* Adjust the percentage to control the width of the columns */
            margin-bottom: 15px;
            
        }
        
        .form-container input[type="text"], 
        .form-container input[type="number"], 
        .form-container select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
        }

        input[type="reset"], input[type="submit"]  {
            background-color: #ede0d4;
            color:#432818;
            font-weight: 700;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
            text-decoration: none;
        }

        input[type="reset"]:hover, input[type="submit"]:hover {
             background: #603813;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to right, #b29f94, #603813);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to right, #b29f94, #603813); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
            color:seashell;
            transform: translateY(-2px);
        }


        @media (max-width: 768px) {
            .content {
                margin-left: 35vw;
                width: 50%;
                padding: 10px;
                margin-top: 30px;
                
            }

            .container h3 {
                font-size: 2rem;
                text-align: center;
            }
            .form-container{
               flex-wrap:nowrap;
               flex-direction: column;
            }
            
        }

        @media (max-width: 480px) {
           
            .container h3 {
                font-size: 1rem;
            }
            .sidebar{
                width:10vw;
                
            }
            .sidebar a{
                font-size: 10px;
                padding: 6px;
                color:transparent;
            }

            .content {
                margin-left: 10vw;
                padding: 5px;
                width:100%;
            }
            
            .container{
                width :60%;
            }
            .form-container{
                font-size: 12px;
                margin-left: 10px;
            }
            
          .form-container input[type="text"],
          .form-container input[type="number"],
          .form-container select {
            width: 80%;
            padding: 10px;
            font-size: 14px;
          }
            .button-container {
            
            flex-direction: column;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Admin Library</h1>
    <div class="user-info">
        Logged in as: <strong>Staff</strong>
    </div>
</div>

<div class="sidebar">
    <nav>
        <a href="homeStaff.jsp"><img src="icons/home.png" alt="Home"> HOME</a>
        <a href="newBook.jsp"><img src="icons/new_book.png" alt="New Book"> NEW BOOK</a>
        <a href="catalog.jsp"><img src="icons/catalog.png" alt="Catalog"> CATALOG</a>
        <a href="editBook.jsp"><img src="icons/edit_book.png" alt="Update Book"> UPDATE BOOK</a>
        <a href="A_ReserveFromStud.jsp"><img src="icons/reservations.png" alt="View Reservations"> VIEW RESERVATIONS</a>
        <a href="LogoutServlet"><img src="icons/logout.png" alt="Log Out"> LOG OUT</a>
    </nav>
</div>

<div class="content">
    <div class="container">
        <h3>UPDATE BOOK</h3>
        <form action="UpdateBookServlet" method="post">
         <div class="form-container">
            <div class="form-group">
            <label for="bookId">Book ID:</label>
            <input type="text" id="bookId" name="bookId" required>
            </div>
            <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" required>
            </div>
            
            <div class="form-group">
            <label for="publicationYear">Publication Year:</label>
            <input type="number" id="publicationYear" name="publicationYear" required>
            </div>
            <div class="form-group">
            <label for="genre">Genre:</label>
            <input type="text" id="genre" name="genre" required>
            </div>
            <div class="form-group">
            <label for="status">Status:</label>
            <select id="status" name="status">
                <option value="Available">Available</option>
                <option value="Checked Out">Checked Out</option>
            </select>
            </div>
        </div>
            <input type="submit" value="Update Book">
        </form>
    </div>
</div>

</body>
</html>


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
            display: flex;
            flex-direction: column;
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
            height: 100vh;
            margin-left: 20vw;
            width :60%;
        }
        
        .head  {
            font-size: 4rem;
            padding: 5px;
            text-align: center;
            justify-content: center;
            color:seashell;
            text-shadow: 0 0 20px #432818;
        }

        .section {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 8px rgba(54, 36, 12, 0.9);
            margin: 0px;
        }

        
        .section p {
            text-align: justify;
            font-size: 18px;
            line-height: 1.6;
            font-family: 'Arial', sans-serif;
        }

        .section:hover {
            box-shadow: 0 4px 20px rgba(54, 36, 12, 0.9);
        }

        .attractive-button {
            background-color: #ede0d4;
            color:#432818;
            font-weight: 700;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
            text-decoration: none;
        }

        .attractive-button:hover {
            background: #603813;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to right, #b29f94, #603813);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to right, #b29f94, #603813); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
            color:seashell;
            transform: translateY(-2px);
        }
        /* Media Queries */
        @media (max-width: 768px) {
            .content {
                margin-left: 40vw;
                width: 50%;
                padding: 10px;
                margin-top: 30px;
            }

            .head {
                font-size: 2rem;
            }

            .section {
                padding: 15px;
            }

            .section p {
                font-size: 16px;
            }
        }

        @media (max-width: 480px) {
           
            .header h1 {
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
                margin-left: 30vw;
                padding: 5px;
                
            }
            .section{
                height:50%;
            }

            .section p {
                font-size: 0.7rem;
                
            }

            .attractive-button {
                padding: 8px 15px;
                font-size: 0.7rem;
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
    
    <section class="head">
        <h3>WELCOME TO OUR LIBRARY</h3>
    </section>
    <section class="section" id="welcome">
        
        <p>Welcome to the Library System Management Portal for Staff. 
            This platform empowers you to efficiently manage library resources,
            oversee student loans, and ensure the seamless operation of library 
            services. Utilize the comprehensive tools and resources available to
            streamline your work flow and enhance library management.</p>
        <a href="catalog.jsp" class="attractive-button">Manage Books</a>
    </section>
</div>

</body>
</html>

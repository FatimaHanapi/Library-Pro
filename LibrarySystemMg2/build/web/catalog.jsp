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
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('https://images5.alphacoders.com/919/thumb-1920-919004.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            color: #432818;
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
            padding-right: 50px;
        }

        .sidebar {
            position: fixed;
            width: 180px;
            background-color: rgba(170, 143, 105, 0.9);
            padding: 15px;
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
            background: #432818;
            background: -webkit-linear-gradient(to right, #ede0d4, #432818);
            background: linear-gradient(to right, #ede0d4, #432818);
        }

        .content {
            margin-left: 20vw;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.8);
            margin-top: 8vh;
            width: 80%;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 5px 8px rgba(54, 36, 12, 0.9);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .container h3 {
            font-size: 3rem;
            padding: 0px;
            padding-top: 20px;
            margin: 0px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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

        button {
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

        button:hover {
            background: #603813;
            background: -webkit-linear-gradient(to right, #b29f94, #603813);
            background: linear-gradient(to right, #b29f94, #603813);
            color: seashell;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .content {
                margin-left: 30vw;
                padding: 10px;
                margin-top: 30px;
            }

            .container {
                width: 90%;
                text-align: center;
            }

            .container h3 {
                font-size: 2rem;
            }

            table {
                width: 60%;
                font-size: 0.5rem;
            }

            button {
                font-size: 0.5rem;
            }
        }
    </style>
    <script>
        function deleteBook(id) {
            if (confirm('Are you sure you want to delete this book?')) {
                fetch('ManageBook?action=delete&idToDelete=' + id)
                    .then(response => response.text())
                    .then(data => {
                        alert(data);
                        displayBooks();  // Refresh the book list after deletion
                    })
                    .catch(error => console.error('Error deleting book:', error));
            }
        }

        function displayBooks() {
            fetch('ManageBook?view=catalog')
                .then(response => response.text())
                .then(data => {
                    document.getElementById('bookListContent').innerHTML = data;
                })
                .catch(error => console.error('Error fetching books:', error));
        }

        // Fetch and display books on page load
        document.addEventListener('DOMContentLoaded', displayBooks);
    </script>
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
        <h3>BOOK CATALOG</h3>
        <div id="bookListContent">
        </div>
    </div>
</div>



</body>
</html>

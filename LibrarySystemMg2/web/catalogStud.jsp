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
    <title>Catalog</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #FFFAF0;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        .navbar {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            padding: 10px;
            background-color: #800000;
            border-radius: 5px;
            margin-bottom: 20px;
            width: 100%;
        }

        .navbar a {
            padding: 10px 15px;
            margin: 5px;
            text-decoration: none;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
        }

        .navbar a:hover {
            background-color: #a1887f;
            transform: translateY(-2px);
        }

        .container {
            max-width: 800px;
            width: 100%;
            padding: 20px;
            background-color: #FFFFFF;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            margin-top: 20px;
            margin-bottom: 20px;
        }

        h2 {
            font-family: 'Baskerville', serif;
            text-align: center;
            margin-bottom: 20px;
            margin-top: 5px;
            font-size: 65px;
            color: #800000;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #800000;
            color: white;
        }

        button {
            padding: 10px;
            font-size: 16px;
            background-color: #800000;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        button:hover {
            background-color: #a1887f;
            transform: translateY(-2px);
        }
    </style>
    <script>
        
        function displayBooks() {
            fetch('ManageBook')
                .then(response => response.text())
                .then(data => {
                    document.getElementById('bookListContent').innerHTML = data;
                })
                .catch(error => console.error('Error:', error));
        }

        document.addEventListener('DOMContentLoaded', displayBooks);
    </script>
</head>
<body>
    <h2>Book Catalog</h2>
    <nav class="navbar">
        <a href="homeStudent.jsp">Home</a>
        <a href="requestBook.jsp">Request Book</a>
        <a href="reserveBook.jsp">Reserve Book</a>
        <a href="extendBook.jsp">Extend Reserve</a>
        <a href="fine.jsp">Pay Fine</a>
        <a href="LogoutServlet">Log Out</a>
    </nav>
    <div class="container">
        <div id="bookListContent"></div>
    </div>
</body>
</html>

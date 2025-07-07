<!DOCTYPE html>
<html lang="en">
<head>
    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color:seashell ;
            color:#432818;
        }

        .container {
            max-width: 800px;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url('https://images5.alphacoders.com/919/thumb-1920-919004.jpg');
            background-size: cover;
            border-radius: 20px;
            margin:10px;
            box-shadow: 10px 10px 5px #ccc;
        }
        .form-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            width: 100%;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            
        }

        .info-container {
            width: 90%;
        }

        h2 {
            font-family: 'arial', serif;
            margin-bottom: 20px;
            font-size: 28px; 
            text-align: center;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .input-group {
            
            margin-bottom: 15px;
            position: relative;
        }

        .input-group i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #c3a995;
        }

        .input-group input[type="text"],
        .input-group input[type="password"],
        .input-group select {
            padding: 8px 8px 8px 35px;
            border: 1px solid black; 
            border-radius: 5px;
            font-size: 14px;
            color: #99582a; 
        }

        .input-group input[type="text"]:focus,
        .input-group input[type="password"]:focus,
        .input-group select:focus {
            outline: none;
            border-color: black; 
        }

        .login-form input[type="submit"] {
            width: 50%;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            background-color: #f0ead2; 
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            text-decoration: none;
        }

        .login-form input[type="submit"]:hover {
            background-color: #dde5b6; 
            transform: translateY(-2px);
        }

        .profile-picture {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 20px;
        }

        .profile-picture img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .error-message {
            color: red;
            margin-bottom: 15px;
            display: none;
        }
        
        .register-link {
            text-align: center;
            margin-top: 10px;
        }

        .register-link a {
            color: #99582a;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
            color: #432818;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="info-container">
    </div>
    <div class="form-container">
        <div class="profile-picture">
            <img src="image/unknown.png" alt="Profile Picture">
        </div>
        <h2>LOG IN</h2>
        
        <form action="LoginServlet" method="post" class="login-form">
            <div id="error-message" class="error-message">Invalid username or password.</div>
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" id="name" name="name" placeholder="Username" required>
            </div>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" id="password" name="password" placeholder="Password" required>
            </div>
            <div class="input-group">
                <i class="fas fa-user-tag"></i>
                <select id="userType" name="userType" required>
                    <option value="" disabled selected>Select your role</option>
                    <option value="student">Student</option>
                    <option value="staff">Staff</option>
                </select>
            </div>
            <input type="submit" value="Login">
            
             <div class="register-link">
                    <a id="register" href="UserRegistration.jsp">Don't have an account? Register here</a>
                </div>
        </form>
    </div>
</div>

<script>
    
    function showLoginPopup() {
        alert("Please login first");
    }
     
    // Simulate error message display based on URL parameter
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error') && urlParams.get('error') === 'invalid') {
            document.getElementById('error-message').style.display = 'block';
        }
    };
    
    
</script>

</body>
</html>

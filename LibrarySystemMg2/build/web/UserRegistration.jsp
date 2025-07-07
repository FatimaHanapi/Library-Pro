<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
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
            font-family: 'Arial', serif;
            margin-bottom: 20px;
            text-align: center;
        }

        p {
            margin-bottom: 10px;
            font-size: 18px;
        }

        input[type="text"], input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            color:#432818;
            margin: 10px 0;
            font-size: 16px;
            border: 1px solid black;
            border-radius: 5px;
        }

        input[type="reset"], input[type="submit"] {
            padding: 10px 20px;
            color:#432818;
            background-color: #f0ead2; 
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            text-decoration: none;
        }

        input[type="reset"]:hover, input[type="submit"]:hover {
            background-color: #dde5b6; 
            transform: translateY(-2px);
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
    </style>

</head>
<body>
      
<div class="container">
    <div class="info-container">
    </div>
    <div class="form-container">
        <h2>USER REGISTRATION</h2>
        <form method="post" action="<%= request.getContextPath() %>/UserRegistration">
            <p>Username <font color="#FF0000">*</font>
                <input type="text" name="username" required>
            </p>
            <p>Password <font color="#FF0000">*</font>
                <input type="password" name="password" required>
            </p>
            <div class="button-container">
                <input type="reset" value="Reset">
                <input type="submit" value="Register">
            </div>
        </form>
    </div>
    
</div>
</body>
</html>

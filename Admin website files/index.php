<!DOCTYPE html>
<html>
    <head>
        <title>Admin login</title>
    </head>

    <body>
        <center>
            <h1>Admin login</h1>
            <form id ="loginForm" action="Login.php" method="post">
                <table>
                    <tr>
                        <th><label for="employeeID">Employee ID:</label></th>
                        <th><input type="text" name="username" id="username"></th>
                    </tr>
                    <tr>                
                        <th><label for="password">Password:</label></th>
                        <th><input type="password" name="password" id="password"></th>
                    </tr>
                    <tr>
                        <th colspan="2"><input type="submit" value="Login"></th>
                    </tr>
                </table>
            </form>
        </center>
    </body>
</html>

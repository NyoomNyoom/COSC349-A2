<!DOCTYPE html>
<html>
    <head>
        <title>Admin page</title>
    </head>

    <body>
        <h1>Admin page</h1>
        <p>Welcome to the admin page. Here you can view all the orders that have been placed.</p>
        <br>
        <p> <a href="orders.php">View orders</a> </p>
        <br>
        <?php
            require_once '/var/www/admin-web-files/config.php';

            $storeWeb = STORE_URL;
            echo "<p><a href=$storeWeb>Store page dynamic</a></p>";
        ?>
        <p> <a href="http://127.0.0.1:8080/index.php">Store page</a> </p>
        <p> <a href="../index.php">Logout</a> </p>
    
    </body>
</html>
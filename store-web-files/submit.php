<!DOCTYPE html>
<html>

    <head>
        <title>Order Recieved</title>
    </head>

    <body>
        <center>
            <h1>Order Recieved</h1>
            <?php
                require_once '/var/www/store-web-files/config.php';

                $serverIP = DB_HOST;
                $dbName = DB_NAME;
                $dbUser = DB_USER;
                $dbPass = DB_PASS;


                // This is the data source name or DSN.
                $pdo_dsn = "mysql:host=$serverIP;dbname=$dbName";

                // This is a try-catch block to connect to the database.
                try {
                    // This is the PDO object.
                    $pdo = new PDO("mysql:host=$serverIP;dbname=$dbName", $dbUser, $dbPass);

                    // This is the SQL query, and the data we want from the form.
                    $first_name =  $_REQUEST['first_name'];
                    $last_name = $_REQUEST['last_name'];
                    $phone =  $_REQUEST['phone'];
                    $address = $_REQUEST['address'];
                    $email = $_REQUEST['email'];
                    $order = $_REQUEST['items_wanted'];
                    
                    $sql = "INSERT INTO CustomerOrders (custFname, custLname, custPhone, custAddress, custEmail, custOrder) 
                            VALUES ('$first_name', '$last_name', '$phone', '$address', '$email', '$order')";
                    
                    // This is the PDO prepared statement.
                    $pdo->exec($sql);

                    // This is the success message, and a link to return to the store page.
                    echo "<p>Thank you for your order, $first_name $last_name. We will contact you shortly.</p>";
                } catch (PDOException $e) {
                    echo "Connection failed: " . $e->getMessage();
                }

            ?>
            <p> <a href="index.php">Return to the store page</a> </p>
        </center>
    </body>
</html>
<!DOCTYPE html>
<html>

    <head>
        <title>Order Recieved</title>
    </head>

    <body>
        <center>
            <h1>Order Recieved</h1>
            <?php
                require_once 'config.php';

                $serverIP = 'terraform-20231003084332632900000003.clsautq0toao.us-east-1.rds.amazonaws.com';
                $dbName = 'LollyStore';
                $dbUser = 'admin';
                $dbPass = 'password';

                echo "<p>Server IP: $serverIP</p>";
                echo "<p>Database Name: $dbName</p>";
                echo "<p>Database User: $dbUser</p>";
                echo "<p>Database Password: $dbPass</p>";
                echo "<p>Trying to connect</p>";

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
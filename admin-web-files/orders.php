<!DOCTYPE html>
<html>
    <head>
        <title>Customer orders</title>
    </head>

    <body>
        <center>
            <h1>Customer orders</h1>
            <p>Here you can view all the orders that have been placed by customers</p>
            <br>
            <p> <a href="admin.php">Back to admin page</a> </p>
            <?php
                require_once '/var/www/admin-web-files/config.php';

                $serverIP = DB_HOST;
                $dbName = DB_NAME;
                $dbUser = DB_USER;
                $dbPass = DB_PASS;

                $pdo_dsn = "mysql:host=$serverIP;dbname=$dbName";

                try {
                    $pdo = new PDO($pdo_dsn, $dbUser, $dbPass);
                    $sql = "SELECT * FROM CustomerOrders";

                    $result = $pdo->query($sql);

                    //Showing a table of all results from the query.
                    if ($result !== false) {
                        if ($result->rowCount() > 0) {
                            echo "<table>";
                            echo "<tr>";
                            echo "<th>Order ID</th>";
                            echo "<th>First name</th>";
                            echo "<th>Last name</th>";
                            echo "<th>Phone</th>";
                            echo "<th>Address</th>";
                            echo "<th>Email</th>";
                            echo "<th>Order items</th>";
                            echo "</tr>";
                            if($result){
                                while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                                    echo "<tr>";
                                    echo "<td>" . $row['orderID'] . "</td>";
                                    echo "<td>" . $row['custFname'] . "</td>";
                                    echo "<td>" . $row['custLname'] . "</td>";
                                    echo "<td>" . $row['custPhone'] . "</td>";
                                    echo "<td>" . $row['custAddress'] . "</td>";
                                    echo "<td>" . $row['custEmail'] . "</td>";
                                    echo "<td>" . $row['custOrder'] . "</td>";
                                    echo "</tr>";
                                }
                            }else{
                                echo "Error: " . $pdo->errorInfo()[2];
                            }
                            
                        } else {
                            echo "No orders have been placed yet";
                        }
                    } else {
                        echo "Error: " . $pdo->errorInfo()[2];
                    }
                } catch (PDOException $e) {
                    echo "Connection failed: " . $e->getMessage();
                }
            ?>
        </center>
    </body>
</html>

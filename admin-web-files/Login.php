<!DOCTYPE html>
<html>
    <head>
        <title>Logging in</title>
    </head>

    <body>
        <?php
            require_once '/var/www/store-web-files/config.php';

            $serverIP = DB_HOST;
            $dbName = DB_NAME;
            $dbUser = DB_USER;
            $dbPass = DB_PASSWORD;

            $pdo_dsn = "mysql:host=$serverIP;dbname=$dbName";

            try{
                $pdo = new PDO("mysql:host=$serverIP;dbname=$dbName", $dbUser, $dbPass);

                $username = $_REQUEST['username'];
                $password = $_REQUEST['password'];

                $sql = "SELECT * FROM employees WHERE username = '$username' AND password = '$password'";
                $result = $pdo->query($sql);
                header("Location: admin.php");
                exit();
            } catch (PDOException $e) {
                echo "Connection failed: " . $e->getMessage();
            }
        ?>
    </body>
</html>
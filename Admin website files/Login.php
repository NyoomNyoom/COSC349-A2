<!DOCTYPE html>
<html>
    <head>
        <title>Logging in</title>
    </head>

    <body>
        <?php
            $serverIP = '192.168.56.12';
            $dbName = 'lollystoredb';
            $dbUser = 'lollystore';
            $dbPass = 'insecure_db_pw';

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
<!DOCTYPE html>

<html>
    <head>
        <title>My App</title>
    </head>
    <body>
        <center>
            <h1>Welcome to the lolly store!</h1>
            <p> 
                Below you will see a form to order lollies from us. Please fill it out and we will get 
                back to you as soon as possible.
            </p>
            <!-- This is an order input form for all data needed for an order. -->
            <form id ="orderForm" action="submit.php" method="post">
                <table>
                    <tr>
                        <th><label for="firstName">First Name:</label></th>
                        <th><input type="text" name="first_name" id="firstName"></th>
                        <th><label for="lastName">Last Name:</label></th>
                        <th><input type="text" name="last_name" id="lastName"></th>
                    </tr>
                    <tr>                
                        <th><label for="email">Email:</label></th>
                        <th><input type="text" name="email" id="email"></th>
                        <th><label for="phone">Phone:</label></th>
                        <th><input type="text" name="phone" id="phone"></th>
                    </tr>
                    <tr>
                        <th><label for="address">Address:</label></th>
                        <th colspan="3"><input type="text" name="address" id="address" style="width: 100%"></th>
                    </tr>
                    <tr>
                        <th colspan="4">
                            <input type="text" name="items_wanted" id="ItemsWanted" style="width: 100%" placeholder="Input items and Quantity">
                        </th>
                    </tr>
                    <tr>
                        <th colspan="4"><input type="submit" value="Submit"></th>
                    </tr>
                </table>
            </form>
        </center>
        
        <!-- This is a script to prevent the enter key from submitting the form. -->
        <script>
            document.getElementById("orderForm").onkeypress = function(e){
                var key = e.charCode || e.keyCode || 0;
                if(key ==13) {
                    e.preventDefault();
                }
            }
        </script>

    </body>
</html>
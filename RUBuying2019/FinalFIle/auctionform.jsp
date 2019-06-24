<!DOCTYPE html>
<html lang = "en-US">
    <title>Create an auction</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <body>
        <header>Welcome to RUBuying</header>
        <h2>Start an auction for an item</h2>
        <div class = "sign_in"> <!--obv this isn't a sign in tho-->
        <form method ="POST" action="createauction.jsp">
                <label>Item ID (placeholder lol)</label>
                <input type ="text" name = "itemid" required ="required">
                <label>Initial price</label>
                <input type="text" name = "initPrice" required="required">
                <label>Bid increment amount</label>
                <input type = "text" name = "increment" required="required">
                <label>Minimum sale price</label>
                <input type = "text" name="minSalePrice" required="required">
				<label>Ends on (Format: [YYYY]-[MM]-[DD]T[hr]:[min]:[sec])</label>
				<input type="datetime-local" name = "endsOn" required = "required" placeholder="YYYY-MM-DDThh:mm:ss"> 
                <input type = "submit" value = "Create"/>
        </form>
        </div>
    </body>
</html>
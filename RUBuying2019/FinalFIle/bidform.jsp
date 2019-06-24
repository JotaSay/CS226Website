<!DOCTYPE html>
<html lang = "en-US">
    <title>Bid on an auction</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <body>
        <header>Welcome to RUBuying</header>
        <h2>Bid on an auction</h2>
        <div class = "sign_in"> <!--obv this isn't a sign in tho-->
        <form method ="POST" action="placebid.jsp">
                <label>Auction ID (placeholder lol)</label>
                <input type ="text" name = "auctionid" required ="required">
                <label>Bid amount</label>
                <input type="text" name = "bidAmt" required="required">
                <label>Auto-bid max price (leave blank to turn off)</label>
                <input type = "text" name="maxBid">
                <input type = "submit" value = "Place bid"/>
        </form>
        </div>
    </body>
</html>

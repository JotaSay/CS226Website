<!DOCTYPE html>

<html lang = "en-US">
    <title>Create an auction</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <body>
        <header>Welcome to RUBuying</header>
        <h2>Start an auction for an item</h2>
        
		<script type="text/javascript">
			function typeCheck(input) 
			{
				var elem = ["ifHP", "ifMonitor", "ifGame"];
				var check = ["Headphones", "Monitor", "Game"];

				for (var t = 0; t < 3; t++)
				{
					var disp = (input.value == check[t]) ? "block" : "none";
					document.getElementById(elem[t]).style.display = disp;
				}
			}
		</script>
     
        <div class = "sign_in"> 
        <form method ="POST" action="createitem.jsp">
            <label>Name</label>
            <input type ="text" name = "name" required ="required">
            
            <label>Brand</label>
            <input type="text" name = "brand" required="required">
            
            <label>Condition</label>
            <select name = "condition" required="required">
            <option value="Excellent">Excellent</option>
            <option value="Good">Good</option>
            <option value="Okay">Okay</option>
            <option value="Poor">Poor</option>
            </select>
            <br>
            
			<label>Type</label>
			<select name= "type" class="form-control" required="required" onchange="typeCheck(this)">
			  <option value="Headphones">Headphone</option>
			  <option value="Monitor">Monitor</option>
			  <option value="Game">Video Game</option>
			</select>    
			
			<!-- Fields for headphones -->
			<div id="ifHP" style="display: block">
			    <label>Color</label>
				<input type ="text" name = "hpColor">
				
				<label>Sound Quality</label>
				<select name = "hpQuality"> 
					<option value="Excellent">Excellent</option>
					<option value="Good">Good</option>
					<option value="Okay">Okay</option>
				</select>
				<br>
				
				<label>Fit</label>
				<select name = "hpFit">
					<option value="Over-ear">Over-ear</option>
					<option value="On-ear">On-ear</option>
					<option value="In-ear">In-ear</option>
				</select>
			</div>
			
			<!-- Fields for monitors -->
			<div id="ifMonitor" style="display: none">
			    <label>Size</label>
				<input type ="text" name = "monSize">
				
				<label>Hertz</label>
				<input type="text" name = "monHz">
				
				<label>Screen type</label>
				<input type="text" name="monType">
			</div>
			
			<!-- Fields for games -->
			<div id="ifGame" style="display: none">
			    <label>Title</label>
				<input type ="text" name = "gameTitle">
				
				<label>Console</label>
				<input type="text" name = "gameConsole">
				
				<label>Rating</label>
				<select type="text" name="gameRating">
					<option value="E">E</option>
					<option value="E10">E10+</option>
					<option value="T">T</option>
					<option value="M">M</option>
					<option value="AO">AO</option>
					<option value="RP">RP (Rating Pending)</option>
				</select>
			</div>			
			
			<input type = "submit" value = "Create"/>
        </form>
        </div>
    </body>
</html>


<!-- Suraj Kakkad spk101 -->
<div class="nav">
	<h3 align="right">
		Hi, User #
		<%=session.getAttribute("idUser")%>
	</h3>
	<ul>
		<li style="float: right"><a href="register.jsp">Log Out</a></li>
		<li><a href="homepage.jsp">Home</a></li>

		<li><a href="itemform.jsp" class="meep"> Create an item</a></li>
		<li><a href="auctionform.jsp" class="meep"> Start an auction</a></li>
		<li><a href="bidform.jsp" class="meep"> Place a bid</a></li>

		<li><a href="searchForm.html">View/search auctions, items, and bids</a></li>
		<li><a href="alertspage.jsp">Alerts</a></li>
		<li><a href="wishlist.jsp">Wish List</a></li>
		<li><a href="questions.jsp">Ask a customer representative</a></li>
		<li><a href="FAQ.jsp">Frequently asked questions</a></li>
	</ul>
</div>

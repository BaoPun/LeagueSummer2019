<!DOCTYPE html>
<html>
	<head>
		<title>LoL 2019 Summer Split</title>
		<link rel="stylesheet" href="home.css">
	</head>
	<body>
		<header>
			<h1 id = 'LUL'>League of Legends 2019 Summer Season</h1>
		</header>
		<?php
			include 'connection.php'; 
					
			#connect to server
			$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
			if (!$connect) 
				die('Could not connect: ' . mysql_error());

			#listing out all regions
			$region = "select LeagueID from Regions order by case when LeagueID = 'LCS' then 1 when LeagueID = 'LEC' then 2 else LeagueID end";
			
			#get results from regions
			$regionResults = mysqli_query($connect, $region);
			if(!$regionResults)
				die("Could not query through the regions for some reason");
			
			#there SHOULD be 4 rows exactly
			if(mysqli_num_rows($regionResults) > 0){
				echo "\t\t<nav class='navbar'>\n";
				echo "\t\t\t<ul class='navlist'>\n";
				while($row = mysqli_fetch_array($regionResults)){
					echo "\t\t\t<li class='navitem navlink active'><a href=".$row['LeagueID'].">" . $row['LeagueID'] . "</a></li>\n";
				}
				echo "\t\t\t</ul>\n";
				echo "\t\t</nav>\n"; 
				mysqli_free_result($regionResults);
			}
			
			#use the form template from addmatch.php
			echo "<br><br><br>\t\t<main class='add-match'>\n";
			echo "\t\t\t<h2>Fill out the entire form</h2>\n";
			echo "\t\t\t<form action='index.php' method='POST'>\n";
			
			#create text box for username
			echo "<br><br>\n";
			echo"\t\t\t<label for='user'>Username: </label>\n";
			echo"\t\t\t\t<input type='text' name='user' autocomplete='off'>\n";
			
			#create text box for password
			echo "<br><br>\n";
			echo"\t\t\t<label for='pass'>Password: </label>\n";
			echo"\t\t\t\t<input id='password' type='password' name='pass' autocomplete='off'>\n";
			
			echo"\t\t\t\t<br><br><button id='form-submit' type='submit' name='verify' value='$name' >Submit</button>\n";
			echo "\t\t\t</form>\n";
			
			mysqli_close($connect);
		?>
	</body>
	<script src="home.js"></script>
</html>
<?php session_start(); include 'connection.php'; ?>

<!DOCTYPE html>
<html>
	<head>
		<title>LCK 2019 Summer Split</title>
		<link rel="stylesheet" href="home.css">
	</head>
	<body>
		<header>
			<h1 id = 'LUL'>LCK 2019 Summer Season</h1>
			<?php 
				if(!isset($_SESSION['userid']))
					echo "<br><h1 id = 'LUL'><a href='login.php'>Click here if you are the admin</a></h1>"; 
				else{
					echo "<br><h1 id = 'LUL'>Welcome ".$_SESSION['userid']."</h1>";
					echo "<br><h1 id = 'LUL'><form action='index.php' method='POST'><button id='add' type='submit' name='logout' value='ok' ><b>Click to Log Out</b></button></form></h1>";
				}
				?>
		</header>
		<?php
			#include 'connection.php'; 
					
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
					if(strcmp($row['LeagueID'], "LCK"))
						echo "\t\t\t<li class='navitem navlink active'><a href=".$row['LeagueID'].".php>" . $row['LeagueID'] . "</a></li>\n";
					else
						echo "\t\t\t<li class='navitem navlink active'><a href='index.php'>Home</a></li>\n";
				}
				echo "\t\t\t</ul>\n";
				echo "\t\t</nav>\n"; 
				mysqli_free_result($regionResults);
			}
			
			echo "<br><br><h2 id='league'><b>Click on one of the teams in the table below to view their players and match history</b></h2>";

			#listing out all LEC teams
			$LCK = "select T.TeamID, Wins, Losses, League from Teams T, Regions R where R.LeagueID = T.League and T.League = 'LCK' order by Wins desc";

			echo "<main class = 'container'>";
	
			#get results from query
			$LCKResults = mysqli_query($connect, $LCK);
			if(!$LCKResults)
				die("Could not query through the regions for some reason");
			
			#query through all teams that are in the LCK
			$LCKResults = mysqli_query($connect, $LCK);
			if(!$LCKResults)
				die("Could not query through the regions for some reason");
			
			#list out all teams in the LCK
			if(mysqli_num_rows($LCKResults) > 0){
				#echo "\n\t\t\t<p>Viewing all LCK teams</p>";
				echo "\n\t\t\t<br><br>\n";
				echo "\t\t\t<table id='t03' border='1' align='center'>\n";
				echo "\t\t\t\t<thead>\n";
					echo "\t\t\t\t\t<tr>\n";
					echo "\t\t\t\t\t\t<th>Team</th>\n";
					echo "\t\t\t\t\t\t<th>Wins</th>\n";
					echo "\t\t\t\t\t\t<th>Losses</th>\n";
					echo "\t\t\t\t\t\t<th>Region</th>\n";
					echo "\t\t\t\t\t</tr>\n";
				echo "\t\t\t\t</thead>\n";
				echo "\t\t\t\t<tbody>\n";
				
				while($row = mysqli_fetch_array($LCKResults)){
					echo "\t\t\t\t\t<tr>\n";
					#echo "\t\t\t\t\t\t<td><a href=".$row['TeamID'].">" . $row['TeamID'] . "</td>\n";
					echo "\t\t\t\t\t\t<td><form action='team.php' method='POST'><input id='team' type='submit' name='teamname' value='".$row['TeamID']."' ></form></td>\n";
					echo "\t\t\t\t\t\t<td>" . $row['Wins'] . "</td>\n";
					echo "\t\t\t\t\t\t<td>" . $row['Losses'] . "</td>\n";
					echo "\t\t\t\t\t\t<td>" . $row['League'] . "</td>\n";
					echo "\t\t\t\t\t</tr>\n";
				}
				
				echo "\t\t\t\t</tbody>\n";                            
				echo "\t\t\t</table>\n\n";
				mysqli_free_result($LCKResults);
			}
			
			echo "</main>";
			
			mysqli_close($connect);	
		?>
		

	</body>
	<script src="home.js"></script>
</html>

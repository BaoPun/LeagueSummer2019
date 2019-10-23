<?php session_start(); include 'connection.php'; ?>

<!DOCTYPE html>
<html>
	<head>
		<title>LoL 2019 Summer Split</title>
		<link rel="stylesheet" href="home.css">
	</head>
	<body>
		<header>
			<!--<h1 id = 'LUL'>League of Legends 2019 Summer Season</h1>-->
			<?php
				#include 'connection.php';
				
				echo "\t\t\t<h1 id = 'LUL'>";
				
				#connect to server 
				$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
				if (!$connect) 
					die('Could not connect: ' . mysql_error());
				
				#get the URL from the clicked button
				$url = mysqli_real_escape_string($connect, $_POST['match']);
				
				#get both teams participating in this match 
				$blue = mysqli_query($connect, "select Team1_ID from MatchInfo where MatchID = '$url'");
				if(!$blue)
					die("could not retrieve the blue team...");
				$red = mysqli_query($connect, "select Team2_ID from MatchInfo where MatchID = '$url'");
				if(!$red)
					die("could not retrieve the red team...");
				
				#query to output the title 'blue' vs 'red'
				if(mysqli_num_rows($blue) > 0 and mysqli_num_rows($red) > 0){
					while($row1 = mysqli_fetch_array($blue)){
						echo "".$row1['Team1_ID']." (Blue Side)";
						$blue = $row1['Team1_ID'];
						#break;
					}
					echo " vs ";
					while($row2 = mysqli_fetch_array($red)){
						echo "".$row2['Team2_ID']." (Red Side)";
						$red = $row2['Team2_ID'];
						#break;
					}
				}
				
				echo "</h1>";
				
				mysqli_free_result($blue);
				mysqli_free_result($red);
				
				if(!isset($_SESSION))
					echo "<br><h1 id = 'LUL'><a href='login.php'>Click here if you are the admin</a></h1>"; 
				else{
					echo "<br><h1 id = 'LUL'>Welcome ".$_SESSION['userid']."</h1>";
					echo "<br><h1 id = 'LUL'><form action='index.php' method='POST'><button id='add' type='submit' name='logout' value='ok' ><b>Click to Log Out</b></button></form></h1>";
					}
	
				echo "</header>";
				
				
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
				
				#get the string of bans and picks on both sides
				$bluePicks = mysqli_query($connect, "select concat(PickT1_1, ' ', PickT1_2, ' ', PickT1_3, ' ', PickT1_4, ' ', PickT1_5) as 'Blue Side Picks' from MatchInfo, Matches where YT_URL = MatchID and MatchID = '$url'");
				if(!$bluePicks)
					die("Cannot view the picks...");
				$blueBans = mysqli_query($connect, "select concat(BanT1_1, ' ', BanT1_2, ' ', BanT1_3, ' ', BanT1_4, ' ', BanT1_5) as 'Blue Side Bans' from MatchInfo, Matches where YT_URL = MatchID and MatchID = '$url'");
				if(!$blueBans)
					die("Cannot view the bans...");
				$redPicks = mysqli_query($connect, "select concat(PickT2_1, ' ', PickT2_2, ' ', PickT2_3, ' ', PickT2_4, ' ', PickT2_5) as 'Red Side Picks' from MatchInfo, Matches where YT_URL = MatchID and MatchID = '$url'");
				if(!$redPicks)
					die("Cannot view the picks...");
				$redBans = mysqli_query($connect, "select concat(BanT2_1, ' ', BanT2_2, ' ', BanT2_3, ' ', BanT2_4, ' ', BanT2_5) as 'Red Side Bans' from MatchInfo, Matches where YT_URL = MatchID and MatchID = '$url'");
				if(!$redBans)
					die("Cannot view the bans...");
				
				echo "<br><h2 id='league'>Picks/Bans for the Match</h2>";
				
				if(mysqli_num_rows($bluePicks) > 0 and mysqli_num_rows($blueBans) > 0 and mysqli_num_rows($redPicks) > 0 and mysqli_num_rows($redBans) > 0){
					echo "\n\t\t\t<br><br>\n";
					echo "\t\t\t<table id='t07' border='1' align='center'>\n";
					echo "\t\t\t\t<thead>\n";
						echo "\t\t\t\t\t<tr>\n";
						echo "\t\t\t\t\t\t<th>Blue Side Picks</th>\n";
						echo "\t\t\t\t\t\t<th>Blue Side Bans</th>\n";
						echo "\t\t\t\t\t\t<th>Red Side Picks</th>\n";
						echo "\t\t\t\t\t\t<th>Red Side Bans</th>\n";
						echo "\t\t\t\t\t</tr>\n";
					echo "\t\t\t\t</thead>\n";
					echo "\t\t\t\t<tbody>\n";
					
					$bluePicksArray = explode(' ', mysqli_fetch_array($bluePicks)['Blue Side Picks']);
					$blueBansArray = explode(' ', mysqli_fetch_array($blueBans)['Blue Side Bans']);
					$redPicksArray = explode(' ', mysqli_fetch_array($redPicks)['Red Side Picks']);
					$redBansArray = explode(' ', mysqli_fetch_array($redBans)['Red Side Bans']);
					
					$i = 0;
					while($i < 5){
						echo "\t\t\t\t\t<tr>\n";
						echo "\t\t\t\t\t\t<td>". $bluePicksArray[$i] ."</td>\n";
						echo "\t\t\t\t\t\t<td>" . $blueBansArray[$i]. "</td>\n";
						echo "\t\t\t\t\t\t<td>". $redPicksArray[$i] ."</td>\n";
						echo "\t\t\t\t\t\t<td>" . $redBansArray[$i]. "</td>\n";
						echo "\t\t\t\t\t</tr>\n";
						$i++;
					}
					echo "\t\t\t\t</tbody>\n";                            
					echo "\t\t\t</table>\n";
					mysqli_free_result($bluePicks);
					mysqli_free_result($blueBans);
					mysqli_free_result($redPicks);
					mysqli_free_result($redBans);
				}
				
				#create two button, side by side, to direct back to team.php on one of two teams
				echo "\t\t<div id='go-back' align = 'center'>\n";
				echo "\t\t<br><p><b>Click on one of the buttons below to view that specific team's page</b></p>\n";
				echo "\t\t\t<form action='team.php' method='POST'><input class='redirect' type='submit' name='teamname' value='$blue' ></form>\n";
				echo "\t\t\t<form action='team.php' method='POST'><input class='redirect' type='submit' name='teamname' value='$red' ></form>\n";
				echo "\t\t</div>\n";
				
				mysqli_close($connect);
			?>
	</body>
</html>
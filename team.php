<?php
	session_start();
	include 'connection.php';

	#check if the form-submit button from addmatch was pressed
	$valid = true;
	if(isset($_POST['form-submit'])){
		#get us 
		$name = $_POST['form-submit'];
		#get the opponent
		$opponent = $_POST['teams'];
		
		#get the side, but first check if we have chosen something
		if(empty($_POST['side'])){
			echo "ERROR, YOU MUST DETERMINE WHICH TEAMS BELONG TO WHICH SIDES\n";
			$valid = false;
		}
		else{
			if(!strcmp($_POST['side'], "Blue")){
				$opponentSide = "Blue";
				$ourSide = "Red";
			}
			else{
				$opponentSide = "Red";
				$ourSide = "Blue";
			}
		}
		
		#list out all picks and bans from blue team
		$bluepick1 = $_POST['blue-pick-1'];
		$bluepick2 = $_POST['blue-pick-2'];
		$bluepick3 = $_POST['blue-pick-3'];
		$bluepick4 = $_POST['blue-pick-4'];
		$bluepick5 = $_POST['blue-pick-5'];
		$blueban1 = $_POST['blue-ban-1'];
		$blueban2 = $_POST['blue-ban-2'];
		$blueban3 = $_POST['blue-ban-3'];
		$blueban4 = $_POST['blue-ban-4'];
		$blueban5 = $_POST['blue-ban-5'];
		
		#list out all picks and bans from red team
		$redpick1 = $_POST['red-pick-1'];
		$redpick2 = $_POST['red-pick-2'];
		$redpick3 = $_POST['red-pick-3'];
		$redpick4 = $_POST['red-pick-4'];
		$redpick5 = $_POST['red-pick-5'];
		$redban1 = $_POST['red-ban-1'];
		$redban2 = $_POST['red-ban-2'];
		$redban3 = $_POST['red-ban-3'];
		$redban4 = $_POST['red-ban-4'];
		$redban5 = $_POST['red-ban-5'];
		
		#get the YouTube URL; ensure it contains AT LEAST 'https://youtu.be/' and it is not empty
		if(!empty($_POST['youtube']) and strlen(substr($_POST['youtube'], 0, strlen("https://youtu.be/"))) < strlen($_POST['youtube']))
			$youtubeLink = $_POST['youtube'];
		else{
			echo "Error, must provide a YouTube URL, ".$_POST['youtube']."";
			$valid = false;
		}
		
		#check to see if we entered in something to indicate that we won
		if(empty($_POST['didwin'])){
			echo "ERROR, YOU MUST DETERMINE WHICH TEAM WON\n";
			$valid = false;
		}
		else{
			if($_POST['didwin'] == 1){
				$opponentWin = 0;
				$weWin = 1;
			}
			else{
				$opponentWin = 1;
				$weWin = 0;
			}
		}
		
		#if the valid flag remains true, then execute queries
		if($valid){
				
			#connect to server 
			$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
			if(!$connect) 
				die('Could not connect: ' . mysql_error());
			
			#determine which side the teams are on to query from 
			if(!strcmp($ourSide, "Blue")){  #we are on blue side
				if($weWin){
					#insert into the matches table.  No need to display an error message here
					$insertMatch = "insert into Matches values ('$youtubeLink', '$name', 1, '$opponent', 0)";
					mysqli_query($connect, $insertMatch);
					mysqli_free_result($insertMatch);
					
					#insert into the MatchInfo table.  
					$insertMatchInfo = "insert into MatchInfo values ('$youtubeLink', '$name', '$bluepick1', '$bluepick2', '$bluepick3', '$bluepick4', '$bluepick5', '$blueban1',    '$blueban2', '$blueban3', '$blueban4', '$blueban5','$opponent', '$redpick1', '$redpick2', '$redpick3', '$redpick4', '$redpick5', '$redban1', '$redban2',         '$redban3', '$redban4', '$redban5')";
					
					#if nothing went wrong, check to see if the league is either in the LCS or the LEC.  If so, update the win/losses column for both participating teams
					if(!mysqli_query($connect, $insertMatchInfo))
						echo "Error: $insertMatchInfo ".mysqli_error($connect)."";
					else{
						$procedures = "call UpdateSeriesResult('$youtubeLink', '$name', '$opponent')";
						if(mysqli_query($connect, $procedures))
							mysqli_free_result($procedures);
						else
							echo "WHY?\n";
						mysqli_free_result($insertMatchInfo);
					}
				}
				else{
					#insert into the matches table.  No need to display an error message here
					$insertMatch = "insert into Matches values ('$youtubeLink', '$name', 0, '$opponent', 1)";
					mysqli_query($connect, $insertMatch);
					mysqli_free_result($insertMatch);
					
					#insert into the MatchInfo table.  
					$insertMatchInfo = "insert into MatchInfo values ('$youtubeLink', '$name', '$bluepick1', '$bluepick2', '$bluepick3', '$bluepick4', '$bluepick5', '$blueban1',    '$blueban2', '$blueban3', '$blueban4', '$blueban5','$opponent', '$redpick1', '$redpick2', '$redpick3', '$redpick4', '$redpick5', '$redban1', '$redban2',         '$redban3', '$redban4', '$redban5')";
					
					#if nothing went wrong, check to see if the league is either in the LCS or the LEC.  If so, update the win/losses column for both participating teams
					if(!mysqli_query($connect, $insertMatchInfo))
						echo "Error: $insertMatchInfo ".mysqli_error($connect)."";
					else{
						$procedures = "call UpdateSeriesResult('$youtubeLink', '$name', '$opponent')";
						if(mysqli_query($connect, $procedures))
							mysqli_free_result($procedures);
						else
							echo "WHY?\n";
						mysqli_free_result($insertMatchInfo);
					}
				}
				
			}				
			else{							#we are on red side
				if($weWin){
					#insert into the matches table.  No need to display an error message here
					$insertMatch = "insert into Matches values ('$youtubeLink', '$opponent', 0, '$name', 1)";
					mysqli_query($connect, $insertMatch);
					mysqli_free_result($insertMatch);
					
					#insert into the MatchInfo table.  
					$insertMatchInfo = "insert into MatchInfo values ('$youtubeLink', '$opponent', '$redpick1', '$redpick2', '$redpick3', '$redpick4', '$redpick5', '$redban1', '$redban2',         '$redban3', '$redban4', '$redban5', '$name', '$bluepick1', '$bluepick2', '$bluepick3', '$bluepick4', '$bluepick5', '$blueban1',    '$blueban2', '$blueban3', '$blueban4', '$blueban5')";
					
					#if nothing went wrong, check to see if the league is either in the LCS or the LEC.  If so, update the win/losses column for both participating teams
					if(!mysqli_query($connect, $insertMatchInfo))
						echo "Error: $insertMatchInfo ".mysqli_error($connect)."";
					else{
						$procedures = "call UpdateSeriesResult('$youtubeLink', '$opponent', '$name')";
						if(mysqli_query($connect, $procedures))
							mysqli_free_result($procedures);
						else
							echo "WHY?\n";
						mysqli_free_result($insertMatchInfo);
					}
				}
				else{
					#insert into the matches table.  No need to display an error message here
					$insertMatch = "insert into Matches values ('$youtubeLink', '$opponent', 1, '$name', 0)";
					mysqli_query($connect, $insertMatch);
					mysqli_free_result($insertMatch);
					
					#insert into the MatchInfo table.  
					$insertMatchInfo = "insert into MatchInfo values ('$youtubeLink', '$opponent', '$redpick1', '$redpick2', '$redpick3', '$redpick4', '$redpick5', '$redban1', '$redban2',         '$redban3', '$redban4', '$redban5', '$name', '$bluepick1', '$bluepick2', '$bluepick3', '$bluepick4', '$bluepick5', '$blueban1',    '$blueban2', '$blueban3', '$blueban4', '$blueban5')";
					
					#if nothing went wrong, check to see if the league is either in the LCS or the LEC.  If so, update the win/losses column for both participating teams
					if(!mysqli_query($connect, $insertMatchInfo))
						echo "Error: $insertMatchInfo ".mysqli_error($connect)."";
					else{
						$procedures = "call UpdateSeriesResult('$youtubeLink', '$opponent', '$name')";
						if(mysqli_query($connect, $procedures))
							mysqli_free_result($procedures);
						else
							echo "WHY?\n";
						mysqli_free_result($insertMatchInfo);
					}
				}
			}
			
			
			
		}
		#close connection
		mysqli_close($connect);
	}


?>
<!DOCTYPE html>
<html>
	<head>
		<title><?php
				#include 'connection.php';
				
				
				
				#connect to server 
				$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
				if (!$connect) 
					die('Could not connect: ' . mysql_error());
				
				#get the team ID from the clicked button
				if(isset($_POST['teamname']))
					$name = mysqli_real_escape_string($connect, $_POST['teamname']);
				else
					$name = mysqli_real_escape_string($connect, $_POST['form-submit']);
				
				#query for the teamname
				$teamname = mysqli_query($connect, "select TeamName from Teams T where T.TeamID = '$name'");
				if(!$teamname)
					die('Could not retrieve the full team name: ' .mysql_error());
				
				if(mysqli_num_rows($teamname)> 0){
					while($full = mysqli_fetch_array($teamname)){
						echo "".$full['TeamName']."";
						break;
					}
				}
				
				mysqli_free_result($teamname);
				mysqli_close($connect);
				?></title>
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
				
				#get the team ID from the clicked button
				if(isset($_POST['teamname']))
					$name = mysqli_real_escape_string($connect, $_POST['teamname']);
				else
					$name = mysqli_real_escape_string($connect, $_POST['form-submit']);
				
				#retrieve the full team name from the team ID that was retrieved
				$team = "select TeamName from Teams where Teams.TeamID = '$name'";
				$teamResult = mysqli_query($connect, $team);
				
				#should have 1 row only
				if(mysqli_num_rows($teamResult)> 0){
					while($id = mysqli_fetch_array($teamResult))
						echo "".$id['TeamName']." (".$name.")";
					echo "</h1>";
				}
				else
					die("Error, team name could not be pulled out");
				mysqli_free_result($teamResult);
				
				
				if(!isset($_SESSION['userid']))
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
				
				echo"<main class = 'teams-information'>";
				echo"<div class='team-profile'>";
				echo"<br><br><h2 id='scaling'>".$name."'s Lineup</h2><br>";
				#first, list out all the players in the team, order by role
				$player = "select P.IGN, Role, isStarterStatus(isStarter) from Player P where P.TeamID = '$name' order by (case when Role = 'Top Lane' then 1 end ) desc, (case when Role = 'Jungle' then 2 end) desc, (case when Role = 'Mid Lane' then 3 end) desc, (case when Role = 'Bot Lane Carry' then 4 end) desc, (case when Role = 'Bot Lane Support' then 5 end) desc";
				$playerResult = mysqli_query($connect, $player);
				if(!$playerResult)
					die("Could not list out the players on ".$name." for some reason...");
				if(mysqli_num_rows($playerResult)> 0){
					echo "\n\t\t\t<br><br>\n";
					echo "\t\t\t<table id='t05' border='1' align='center'>\n";
					echo "\t\t\t\t<thead>\n";
						echo "\t\t\t\t\t<tr>\n";
						echo "\t\t\t\t\t\t<th>IGN</th>\n";
						echo "\t\t\t\t\t\t<th>Role</th>\n";
						echo "\t\t\t\t\t\t<th>Is Starting Player</th>\n";
						echo "\t\t\t\t\t</tr>\n";
					echo "\t\t\t\t</thead>\n";
					echo "\t\t\t\t<tbody>\n";
					
					while($row = mysqli_fetch_array($playerResult)){
						echo "\t\t\t\t\t<tr>\n";
						echo "\t\t\t\t\t\t<td>". $row['IGN'] ."</td>\n";
						echo "\t\t\t\t\t\t<td>" . $row['Role'] . "</td>\n";
						echo "\t\t\t\t\t\t<td>" . $row['isStarterStatus(isStarter)'] . "</td>\n";
						echo "\t\t\t\t\t</tr>\n";
					}
					
					echo "\t\t\t\t</tbody>\n";                            
					echo "\t\t\t</table>\n";
					echo "\t\t\t</div>\n";
					mysqli_free_result($playerResult);
				}
				
				
				
				echo"<div class='team-history'>\n";
				echo"<br><br><h2 id='scaling'>".$name."'s Match History</h2><br>\n";
				
				#then, list all matches that the team is involved in
				$match = "select Team1, Team2, Team1_HasWon as 'Win?', YT_URL as 'Match VOD' from Matches where Team1 = '$name' or Team2 = '$name'";
				$matchResult = mysqli_query($connect, $match);
				if(!$matchResult)
					die("Could not list out ".$name."'s matches for some reason...");
				if(mysqli_num_rows($matchResult) > 0){
					echo "\n\t\t\t<br><br>\n";
					echo "\t\t\t<table id='t06' border='1' align='center'>\n";
					echo "\t\t\t\t<thead>\n";
						echo "\t\t\t\t\t<tr>\n";
						echo "\t\t\t\t\t\t<th>Blue Side</th>\n";
						echo "\t\t\t\t\t\t<th>Red Side</th>\n";
						echo "\t\t\t\t\t\t<th>Did $name Win?</th>\n";
						echo "\t\t\t\t\t\t<th>Match VOD</th>\n";
						echo "\t\t\t\t\t\t<th>Match Details</th>\n";
						echo "\t\t\t\t\t</tr>\n";
					echo "\t\t\t\t</thead>\n";
					echo "\t\t\t\t<tbody>\n";
					
					while($row = mysqli_fetch_array($matchResult)){
						echo "\t\t\t\t\t<tr>\n";
						echo "\t\t\t\t\t\t<td>". $row['Team1'] ."</td>\n";
						echo "\t\t\t\t\t\t<td>" . $row['Team2'] . "</td>\n";
						if($row['Win?'] == 1)
							echo "\t\t\t\t\t\t<td class='answer'>Yes</td>\n";
						else
							echo "\t\t\t\t\t\t<td class='answer'>No</td>\n";
						echo "\t\t\t\t\t\t<td><a href=".$row['Match VOD']." target='_blank'>".$row['Match VOD']."</a></td>\n";
						echo "\t\t\t\t\t\t<td><form action='matchdetail.php' method='POST'><button id='detail' type='submit' name='match' value='".$row['Match VOD']."' >Click to See Details</button></form></td>\n";
						echo "\t\t\t\t\t</tr>\n";
					}
					
					echo "\t\t\t\t</tbody>\n";                            
					echo "\t\t\t</table>\n";
					echo "\t\t</div>";
					mysqli_free_result($matchResult);
				}
				
				#create a button to be able to add a match
				if(isset($_SESSION['userid'])){
					echo "<br><br><br>\t\t\t<div id='addwrap'>\n";
					echo "\t\t\t\t<br><br><br><br><br><br><form action='addmatch.php' method='POST'><button id='add' type='submit' name='add-match' value='$name' ><b>Click to Add a Match for $name</b></button></form></td>\n";
					echo "\t\t\t</div>\n";
				}
				
				echo "</main>";
				mysqli_close($connect);
		?>
		

	</body>
	<script src="home.js"></script>
</html>

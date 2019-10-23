<!DOCTYPE html>
<html>
	<head>
		<title>LoL 2019 Summer Split</title>
		<link rel="stylesheet" href="home.css">
	</head>
	<body>
		<header>
			<h1 id = 'LUL'><!--League of Legends 2019 Summer Season</h1>-->
		
		<?php
			include 'connection.php'; 
					
			#connect to server
			$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
			if (!$connect) 
				die('Could not connect: ' . mysql_error());
			
			#get the team ID from the clicked button
			$name = mysqli_real_escape_string($connect, $_POST['add-match']);
			
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
			
			
			echo "\t</header>\n";

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
			
			#declare various queries before adding the match
			$name = mysqli_real_escape_string($connect, $_POST['add-match']); #will return value associated with this
			$league = mysqli_fetch_array(mysqli_query($connect, "select League from Teams T where T.TeamID = '$name'")); #return the League that this team belongs to
			if(!$league)
				die("Could not retrieve the League list for some reason...");
			$teams = mysqli_query($connect, "select T.TeamID from Teams T, Regions R where R.LeagueID = T.League and T.League = '$league[League]' and T.TeamID <> '$name'");
			if(!$teams)
				die("Could not retrieve the list of teams for some reason...");	
			
			#now, attempt to add the match
			echo "<br><br><br>\t\t<main class='add-match'>\n";
			echo "\t\t\t<h2>Fill out the entire form</h2>\n";
			echo "\t\t\t<form action='team.php' method='POST'>\n";
			
			#choose the opponent
			echo "\t\t\t<label for='opponent'>Opponent</label>\n";
			echo "\t\t\t\t<select name='teams'>\n";
			if(mysqli_num_rows($teams) > 0){
				while($row = mysqli_fetch_array($teams))
					echo "\t\t\t\t\t<option value='".$row['TeamID']."'>".$row['TeamID']."</option>\n";
			}
			
			#which side is the opponent at?
			echo "\t\t\t\t</select><br>\n";
			echo "<br>\t\t\t<label for='blue'>Opponent Blue Side</label>\n";
			echo "\t\t\t<input id='dot' type='radio' name='side' value='Blue'><br>\n";
			echo "<br>\t\t\t<label for='red'>Opponent Red Side</label>\n";
			echo "\t\t\t<input id='dot' type='radio' name='side' value='Red'><br><br>\n";
			
			#list out all champions that was picked by the blue team
			$i=0;
			while($i < 5){
				$champions = mysqli_query($connect, "select ChampionName from Champion"); #return an array of champions
				if(!$champions)
					die("Could not retrieve the list of champions...");
				echo "\t\t\t<label for='blue-pick'>Blue Pick</label>\n";
				echo "\t\t\t\t<select name='blue-pick-".($i+1)."'>\n";
				if(mysqli_num_rows($champions) > 0){
					while($row = mysqli_fetch_array($champions))
						echo "\t\t\t\t\t<option value='".$row['ChampionName']."'>".$row['ChampionName']."</option>\n";
				}
				echo "\t\t\t\t</select>\n";
				$i++;
				mysqli_free_result($champions);
			}
			
			#list out all champions that was banned by the blue team
			$i=0;
			echo "<br><br>\n";
			while($i < 5){
				$champions = mysqli_query($connect, "select ChampionName from Champion"); #return an array of champions
				if(!$champions)
					die("Could not retrieve the list of champions...");
				echo "\t\t\t<label for='blue-ban'>Blue Ban</label>\n";
				echo "\t\t\t\t<select name='blue-ban-".($i+1)."'>\n";
				if(mysqli_num_rows($champions) > 0){
					while($row = mysqli_fetch_array($champions))
						echo "\t\t\t\t\t<option value='".$row['ChampionName']."'>".$row['ChampionName']."</option>\n";
				}
				echo "\t\t\t\t</select>\n";
				$i++;
				mysqli_free_result($champions);
			}
			
			#list out all champions that was picked by the red team
			$i=0;
			echo "<br><br>\n";
			while($i < 5){
				$champions = mysqli_query($connect, "select ChampionName from Champion"); #return an array of champions
				if(!$champions)
					die("Could not retrieve the list of champions...");
				echo "\t\t\t<label for='red-pick'>Red Pick</label>\n";
				echo "\t\t\t\t<select name='red-pick-".($i+1)."'>\n";
				if(mysqli_num_rows($champions) > 0){
					while($row = mysqli_fetch_array($champions))
						echo "\t\t\t\t\t<option value='".$row['ChampionName']."'>".$row['ChampionName']."</option>\n";
				}
				echo "\t\t\t\t</select>\n";
				$i++;
				mysqli_free_result($champions);
			}
			
			#list out all champions that was banned by the red team
			$i=0;
			echo "<br><br>\n";
			while($i < 5){
				$champions = mysqli_query($connect, "select ChampionName from Champion"); #return an array of champions
				if(!$champions)
					die("Could not retrieve the list of champions...");
				echo "\t\t\t<label for='red-ban'>Red Ban</label>\n";
				echo "\t\t\t\t<select name='red-ban-".($i+1)."'>\n";
				if(mysqli_num_rows($champions) > 0){
					while($row = mysqli_fetch_array($champions))
						echo "\t\t\t\t\t<option value='".$row['ChampionName']."'>".$row['ChampionName']."</option>\n";
				}
				echo "\t\t\t\t</select>\n";
				$i++;
				mysqli_free_result($champions);
			}
			
			#create the text box for the YouTube URL
			echo "<br><br>\n";
			echo"\t\t\t<label for='url'>Match URL: </label>\n";
			echo"\t\t\t\t<input type='text' name='youtube' value ='https://youtu.be/'>\n";
			
			#Did we win?
			echo "\t\t\t\t</select><br>\n";
			echo "<br>\t\t\t<label for='yes'>#WON</label>\n";
			echo "\t\t\t<input id='dot' type='radio' name='didwin' value=1><br>\n";
			echo "<br>\t\t\t<label for='no'>#LOST</label>\n";
			echo "\t\t\t<input id='dot' type='radio' name='didwin' value=-1><br><br>\n";
			
			#finally, create the submit button
			echo"\t\t\t\t<button id='form-submit' type='submit' name='form-submit' value='$name'>Submit</button>\n";
			echo "\t\t\t</form>\n";
			
			mysqli_free_result("select League from Teams T where T.TeamID = '$name'");
			mysqli_free_result($teams);
			echo "\t\t</main>\n";
			
			mysqli_close($connect);
		?>
		

	</body>
	<script src="home.js"></script>
</html>

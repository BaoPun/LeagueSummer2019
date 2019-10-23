<?php
	session_start();
	include 'connection.php'; 
	

	#check if the logout button was clicked 
	if(isset($_POST['logout'])){
		session_destroy();
		session_start();
	}
	
					
	#connect to server
	$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
	if (!$connect) 
		die('Could not connect: ' . mysql_error());
	
	#add user and pass
	$addAdmin = "insert into Account values ('Nindoge', MD5('932341011'))";
	if (mysqli_query($connect, $addAdmin))
		mysqli_free_result($addAdmin);
		
	#check if the submit button from the login page has been pressed
	if(isset($_POST['verify'])){
		$user = $_POST['user'];
		$pass = MD5($_POST['pass']);
		$authenticate = "select * from Account where Username = '$user' and Password = '$pass'";		

		$login = mysqli_query($connect, $authenticate);
		if($login){
			if(mysqli_num_rows($login) > 0){
				$_SESSION['userid'] = $user;
				mysqli_free_result($login);
			}
		}
	}
	
	
	
		
	mysqli_close($connect);
?>
<!DOCTYPE html>
<html>
	<head>
		<title>LoL 2019 Summer Split</title>
		<link rel="stylesheet" href="home.css">
	</head>
	<body>
		<header>
			<h1 id = 'LUL'>League of Legends 2019 Summer Season</h1>
			<?php 	if(!isset($_SESSION['userid']))
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
					echo "\t\t\t<li class='navitem navlink active'><a href=".$row['LeagueID'].">" . $row['LeagueID'] . "</a></li>\n";
				}
				echo "\t\t\t</ul>\n";
				echo "\t\t</nav>\n"; 
				mysqli_free_result($regionResults);
			}
			echo "\t\t<main class='containers'>\n";			
			echo "\t\t\t<p class='description'>\n";
			echo "\t\t<br><br><br><b>Welcome to my CS 340 Databases project on the professional eSports scene of League of Legends (LoL).  This database aims to help LoL fans catch up on the major regions' teams and how they are performing over the course of the 2019 summer split.  To begin, please click on one of the four major regions above, that are labelled LCS (NA), LEC (EU), LCK (Korea), and LPL (China).  If you want to be able to login and update matches for teams, then click the login button instead.\n";
			echo "\t\t\t</b></p>\n";
			echo "<img src='./rito.jpeg' width='50%'></img>";
			echo "<p class = 'description'>\n";
			echo "These images are created by Riot Games and they own all rights to these logos.  Riot Games does not endorse nor sponsor this project.";
			echo "</p>\n\t\t</main>\n";
			mysqli_close($connect);
		?>
	</body>
	<script src="home.js"></script>
</html>



/*
	Mainly used for each team page on team.php
	Just a minigame where the user will have to click on the section "Click to reveal the answer" 
	In order to see if that user has won or not
	
	On the form login, also replace the password with some random character
*/

//Variable declarations
var revealAnswer = document.getElementsByClassName('answer');
var storeAnswer = [];
var passwords = document.getElementById('password');

//Replace the answer with the generic click sentence, but make sure to store the answers first
for(var i = 0; i < revealAnswer.length; i++){
	storeAnswer.push(revealAnswer[i].textContent);
	revealAnswer[i].textContent = "Click to find out";
}

//Upon clicking, reveal the answer
for(let i = 0; i < storeAnswer.length; i++){
	revealAnswer[i].addEventListener('click', function(){
		revealAnswer[i].textContent = storeAnswer[i];
	});
}

//Everytime we enter a password, store it in a temporary variable and replace the text output with some character 
passwords.addEventListener('keydown', function(){
	var pass = passwords.value;
	
	
}
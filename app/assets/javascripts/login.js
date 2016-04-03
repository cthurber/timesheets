var addButton= document.getElementsByClassName("add")[0];
var container= document.getElementsByClassName("container")[0];
var close= document.getElementsByClassName("close")[0];

// will add active class to container to activate css properties
console.log(document.getElementsByClassName("container"));
console.log(addButton);
console.log(close);
addButton.addEventListener("click", function(){
    container.className += " " + "active";
});

// will remove the active class
close.addEventListener("click", function(){
    container.className = "container";
});

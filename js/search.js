"use strict"

const searchBox = document.getElementById("search-box");
document.querySelector("form").addEventListener("submit", e => {
	e.preventDefault();
	window.location.href = `/${searchBox.value}`;
});
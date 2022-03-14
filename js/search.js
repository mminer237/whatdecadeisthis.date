---
layout: none
---
"use strict"

const searchBox = document.getElementById("search-box");
document.querySelector("form").addEventListener("submit", e => {
	e.preventDefault();
	if (searchBox.value <= {{ site.lastYear }})
		window.location.href = `/${searchBox.value}`;
	else
		window.location.href = `/other-year?year=${searchBox.value}`;
});
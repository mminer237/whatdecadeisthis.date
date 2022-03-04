"use strict";

const urlParams = new URLSearchParams(window.location.search);
if (urlParams.has("year")) {
	const year = urlParams.get("year");
	const yearUrl = year == '404' ? 'year-404' : year;
	const p = document.createElement("p");
	p.innerHTML = `For you, to look at the year ${year} BC, just look at <a href="/${yearUrl}">AD ${year}</a> and put a BC after stuff.`;
	document.getElementById("main-section").appendChild(p);
}
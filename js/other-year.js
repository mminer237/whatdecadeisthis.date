"use strict";

const urlParams = new URLSearchParams(window.location.search);
if (urlParams.has("year")) {
	const year = urlParams.get("year");
	document.querySelectorAll("span.year").forEach(x => x.textContent = year);

	let ordinal = Math.ceil(year / 10);
	switch (year % 10) {
		case 1:
			ordinal += "st"
			break;
		case 2:
			ordinal += "nd"
			break;
		case 3:
			ordinal += "rd"
			break;
		default:
			ordinal += "th"
			break;
	}
	document.querySelectorAll("span.ordinal").forEach(x => x.textContent = ordinal);

	const cardinal = Math.floor(year / 10) + "0s";
	document.querySelectorAll("span.cardinal").forEach(x => x.textContent = cardinal);
}
else
	window.location.href = '/404';
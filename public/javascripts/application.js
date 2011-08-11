// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// TEMP: Version Switcher
function setVersion(selected) {
	var expires = new Date();
	expires.setDate(expires.getDate() + 3);
	var value = escape(selected) + "; expires=" + expires.toUTCString() + ";path=/";
	document.cookie = "version=" + value;
}

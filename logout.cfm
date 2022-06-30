
<cfset SESSION.User.ID = 0 />

<cfcookie
	name="RememberMe"
	value=""
	expires="now"
	/>


<cflocation
	url="./"
	addtoken="false"
	/>
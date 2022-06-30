
<cfparam name="FORM.username" type="string" default="" />
<cfparam name="FORM.password" type="string" default="" />
<cfparam name="FORM.remember_me" type="boolean" default="false" />


<cfif (
	(FORM.username EQ "big") AND
	(FORM.password EQ "sexy")
	)>


	<cfset SESSION.User.ID = 1 />


	<cfif FORM.remember_me>

	
		<cfset strRememberMe = (
			CreateUUID() & ":" &
			SESSION.User.ID & ":" &
			CreateUUID()
			) />

		
		<cfset strRememberMe = Encrypt(
			strRememberMe,
			APPLICATION.EncryptionKey,
			"cfmx_compat",
			"hex"
			) />

		
		<cfcookie
			name="RememberMe"
			value="#strRememberMe#"
			expires="never"
			/>

	</cfif>


	
	<cflocation
		url="./"
		addtoken="false"
		/>

</cfif>


<cfoutput>

	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html>
	<head>
		<title>Login</title>
	</head>
	<body>

		<h1>
			Application Login
		</h1>

		<form action="#CGI.script_name#" method="post">

			<label>
				Username:
				<input type="text" name="username" size="20" />
			</label>
			<br />
			<br />

			<label>
				Password:
				<input type="password" name="password" size="20" />
			</label>
			<br />
			<br />

			<label>
				<input type="checkbox" name="remember_me" value="1" />
				Remember Me
			</label>
			<br />
			<br />

			<input type="submit" value="Login" />

		</form>

	</body>
	</html>

</cfoutput>
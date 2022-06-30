<cfcomponent
	output="false"
	hint="I define the application and root-level event handlers.">

	
	<cfset THIS.Name = "RememberMeapp" />
	<cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 5, 0 ) />
	<cfset THIS.SessionManagement = true />
	<cfset THIS.SessionTimeout = CreateTimeSpan( 0, 0, 0, 20 ) />
	<cfset THIS.SetClientCookies = true />

	
	<cfsetting
		showdebugoutput="false"
		requesttimeout="10"
		/>


	<cffunction
		name="OnApplicationStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="I run when the application boots up. If I return false, the application initialization will hault.">

	
		<cfset APPLICATION.EncryptionKey = "S3xy8run3tt3s" />

		<cfreturn true />
	</cffunction>


	<cffunction
		name="OnSessionStart"
		access="public"
		returntype="void"
		output="false"
		hint="I run when a session boots up.">

		
		<cfset var LOCAL = {} />

		<cfset LOCAL.CFID = SESSION.CFID />
		<cfset LOCAL.CFTOKEN = SESSION.CFTOKEN />

		
		<cfset StructClear( SESSION ) />

		<cfset SESSION.CFID = LOCAL.CFID />
		<cfset SESSION.CFTOKEN = LOCAL.CFTOKEN />

		<cfset SESSION.User = {
			ID = 0,
			DateCreated = Now()
			} />

		<cftry>

		
			<cfset LOCAL.RememberMe = Decrypt(
				COOKIE.RememberMe,
				APPLICATION.EncryptionKey,
				"cfmx_compat",
				"hex"
				) />

			<cfset LOCAL.RememberMe = ListGetAt(
				LOCAL.RememberMe,
				2,
				":"
				) />

		
			<cfif IsNumeric( LOCAL.RememberMe )>

				<cfset SESSION.User.ID = LOCAL.RememberMe />

			</cfif>

			
			<cfcatch>
			
			</cfcatch>
		</cftry>

		
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnRequestStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="I perform pre page processing. If I return false, I hault the rest of the page from processing.">
		<cfif StructKeyExists( URL, "reset" )>
			<cfset THIS.OnApplicationStart() />
			<cfset THIS.OnSessionStart() />
		</cfif>
		<cfreturn true />
	</cffunction>
	<cffunction
		name="OnRequest"
		access="public"
		returntype="void"
		output="true"
		hint="I execute the primary template.">
		<cfargument
			name="Page"
			type="string"
			required="true"
			hint="The page template requested by the user."
			/>
		<cfif SESSION.User.ID>
			<cfinclude template="#ARGUMENTS.Page#" />
		<cfelse>
			<cfinclude template="login.cfm" />

		</cfif>
		<cfreturn />
	</cffunction>

</cfcomponent>
<cfoutput>
	<h1>#prc.user.getUsername()#</h1>

	<h4>Rants</h4>

	<ul>
		<cfloop array="#prc.user.getRants()#" item="rant">
			#renderView( "_partials/_rant", { rant = rant } )#
		</cfloop>
	</ul>

</cfoutput>
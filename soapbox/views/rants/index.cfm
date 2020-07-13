<cfoutput>
    <cfif prc.aRants.isEmpty()>
        <h3>No rants yet</h3>
        <a href="#event.buildLink( "rants.new" )#" class="btn btn-primary">Start one now!</a>
    <cfelse>
        <a href="#event.buildLink( "rants.new" )#" class="btn btn-primary">Start a new rant!</a>
        <cfloop array="#prc.aRants#" item="rant">
            #renderView( "_partials/_rant", { rant = rant } )#
        </cfloop>
    </cfif>
</cfoutput>
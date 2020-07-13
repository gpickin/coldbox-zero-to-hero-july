<cfoutput>
    <div class="card mb-3">
        <div class="card-header">
            <strong><a href="#event.buildLink( "users.#args.rant.getUser().getUsername()#" )#">#args.rant.getUser().getUsername()#</a></strong>
            said at #dateTimeFormat( args.rant.getCreatedDate(), "h:nn:ss tt" )#
            on #dateFormat( args.rant.getCreatedDate(), "mmm d, yyyy")#
        </div>
        <div class="panel card-body">
            #args.rant.getBody()#
		</div>
		<cfprocessingdirective pageEncoding="utf-8">
		<div class="card-footer">
			<cfif auth().guest()>
				<button disabled class="btn btn-outline-dark">
					#args.rant.getBumpCount()# 👊
				</button>
			<cfelse>
				<button class="btn btn-dark rant_#args.rant.getID()#_bumpBtn" onClick="unbump( #args.rant.getID()# )" <cfif auth().user().hasBumped( args.rant )>style="display:'';"<cfelse>style="display:none;"</cfif>>
					<span class="rant_#args.rant.getID()#_bumpCount">#args.rant.getBumpCount()#</span> 👊
				</button>
				<button class="btn btn-outline-dark rant_#args.rant.getID()#_bumpBtn" onClick="bump( #args.rant.getID()# )" <cfif !auth().user().hasBumped( args.rant )>style="display:''"<cfelse>style="display:none;"</cfif>>
					<span class="rant_#args.rant.getID()#_bumpCount">#args.rant.getBumpCount()#</span> 👊
				</button>
			</cfif>

			<cfif auth().guest()>
				<button disabled class="btn btn-outline-dark">
					#args.rant.getPoopCount()# 💩
				</button>
			<cfelseif auth().user().hasPooped( args.rant )>
				<form method="POST" action="#event.buildLink( "rants.#args.rant.getId()#.poops" )#" style="display: inline;">
					<input type="hidden" name="_method" value="DELETE" />
					<button class="btn btn-dark">
						#args.rant.getPoopCount()# 💩
					</button>
				</form>
			<cfelse>
				<form method="POST" action="#event.buildLink( "rants.#args.rant.getId()#.poops" )#" style="display: inline;">
					<button class="btn btn-outline-dark">
						#args.rant.getPoopCount()# 💩
					</button>
				</form>
			</cfif>
		</div>
    </div>
</cfoutput>

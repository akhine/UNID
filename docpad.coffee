# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site:
			# The production url of our website
			url: "http://unid.khine.net/"

			# Here are some old site urls that you would like to redirect from
			oldUrls: [
				"www.unidi.net",
				"unidi.herokuapp.com"
			]

			# The default title of our website
			title: "Unid"
			company: "Unid."

			# The website description (for SEO)
			description: """
				UNID, based in United Kingdom, aims to stimulate sustainable development and economic opportunities through innovation, science, entrepreneurship, Education, Research and Development, and health.
				"""

			# The website keywords (for SEO) separated by commas
			keywords: """
				place, your, website, keywoards, here, keep, them, related, to, the, content, of, your, website
				"""

			# The website author"s name
			author: "Ayesha Khine"

			# The website author"s email
			email: "ayesha@khine.net"

			# Styles
			styles: [
				"/styles/all.css"
			]

			# Scripts
			scripts: [
				"/scripts/all.js"
			]
			# Services
			services:
				facebookLikeButton:
					applicationId: "496816650451290"
				twitterTweetButton: "UNIDINFO"
				twitterFollowButton: "UNIDINFO"
				googleplus: "100943480134278339756"
				googleAnalytics: "UA-294691-24"

		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page"s title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site"s title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it"s own title, then we should just use the site"s title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site"s description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(", ")


	# =================================
	# Collections
	# These are special collections that our website makes available to us

	collections:
		# list of documents which make up main nav. May be any content-type
		docsInMainNav: (database) ->
			database.findAllLive({includenInNavs: {$has: "main"}}, [pageOrder:1,title:1])

		docsInAboutNav: (database) ->
			database.findAllLive({includenInNavs: {$has: "about"}}, [pageOrder:1,title:1])
			
		docsInLeadershipNav: (database) ->
			database.findAllLive({includenInNavs: {$has: "leadership"}}, [pageOrder:1,title:1])

		# All documents with contenttype=pages (i.e: directory reflects contenttype which seemed a logical choice)
		# ordered by pageOrder (not required) and title
		pages: (database) ->
			database.findAllLive({relativeOutDirPath: "pages"}, [pageOrder:1,title:1])

		# All documents with contenttype=posts ordered by date
		posts: (database) ->
			database.findAllLive({relativeOutDirPath: "posts"}, [date:-1])

		# All documents with contenttype=faqs ordered by faqOrder (not required) and title
		faqs: (database) ->
			database.findAllLive({relativeOutDirPath: "faq"}, [faqOrder:1,title:1])
		# Team list
		leadership: (database) ->
			database.findAllLive({relativeOutDirPath: "leadership"}, [pageOrder:1,title:1])


	# =================================
	# Plugins

	plugins:
		nodesass:
			bourbon: true
		ghpages:
			deployRemote: "origin"
			deployBranch: "gh-pages"
		bowermount:
			excludes: ["live-reload-socket-io"]
		menu:
			menuOptions:
				optimize: true
				skipEmpty: true
				skipFiles: ///\.js|\.scss|\.css/// #regexp are delimited by three forward slashes in coffeescript
		feedr:
			feeds:
				twitter:
					url: "https://api.twitter.com/1/statuses/user_timeline.json?screen_name=WWHDF&count=1&include_entities=true&include_rts=true"
	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad
			gsheets = null
			spreadsheet = null
			worksheets = null
			worksheet = null
			rows = null

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()
			# =========================
			# Users

			# Store
			users = []

			# Class
			class User
				attributes: null

				constructor: (values) ->
					@attributes =
						name: null
						email: null
						skype: null
						github: null
						twitter: null
						twitterID: null  # id number
						facebook: null
						facebookID: null  # id number
						gender: null
						website: null
						bio: null
						confirmed: null
						avatar: null  # url
						spreadsheetUser: null
					@set(values)
					@

				toJSON: ->
					return @attributes

}

# Export our DocPad Configuration
module.exports = docpadConfig

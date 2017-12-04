"
I represent a mastodon server (i.e. mastodon.social)
"
Class {
	#name : #MdnServer,
	#superclass : #Object,
	#traits : 'TMdnRequest',
	#classTraits : 'TMdnRequest classTrait',
	#instVars : [
		'url',
		'application'
	],
	#category : #'Mastodon-Core'
}

{ #category : #accessing }
MdnServer class >> defaultApplicationName [
	^ 'pharo-mastodon-v1'
]

{ #category : #accessing }
MdnServer class >> defaultRedirectUri [
	^ 'urn:ietf:wg:oauth:2.0:oob'
]

{ #category : #'instance creation' }
MdnServer class >> new [
	self error: 'Use #newUrl:'
]

{ #category : #'instance creation' }
MdnServer class >> url: aStringOrUrl [
	^ self basicNew initializeUrl: aStringOrUrl
]

{ #category : #accessing }
MdnServer >> application [
	^ application ifNil: [ 
		application := self registerApplication: self class defaultApplicationName ]
]

{ #category : #initialization }
MdnServer >> initializeUrl: anUrl [
	url := anUrl asUrl.
	self initialize
]

{ #category : #api }
MdnServer >> instance [ 
	^ MdnInstance json: (self get: (self urlApi / 'instance'))
]

{ #category : #api }
MdnServer >> loginUsername: aName password: aPassword [
	^ self  
		loginUsername: aName 
		password: aPassword
		scopes: MdnScope allScopes
]

{ #category : #api }
MdnServer >> loginUsername: aName password: aPassword scopes: aScopes [
	| app loginJson |
	
	app := self application.
	loginJson := self 
		post: self urlOAuth
		with: [ :req |
			req
				formAt: 'client_id' put: app clientId;
				formAt: 'client_secret' put: app clientSecret;
				formAt: 'grant_type' put: 'authorization_code';
				formAt: 'scopes' put: (self scopesToString: aScopes);
				formAt: 'username' put: aName;
				formAt: 'password' put: aPassword;
				formAt: 'grant_type' put: 'password' ].
	
	^ MdnLogin new 
		server: self;
		json: loginJson;
		yourself
]

{ #category : #printing }
MdnServer >> printOn: stream [ 
	super printOn: stream.
	stream << '(' << self url asString << ')'
]

{ #category : #api }
MdnServer >> registerApplication: aName [
	^ self 
		registerApplication: aName 
		redirectUri: self class defaultRedirectUri
]

{ #category : #api }
MdnServer >> registerApplication: aName redirectUri: uriString [ 
	^ self 
		registerApplication: aName 
		redirectUri: uriString
		scopes: MdnScope allScopes
]

{ #category : #api }
MdnServer >> registerApplication: aName redirectUri: uriString scopes: aScopes [
	 ^ MdnApplication json: (self 
			post: self urlApiApps 
			with: [ :request |
				request
					formAt: 'client_name' put: aName;
					formAt: 'redirect_uris' put: uriString;
					formAt: 'scopes' put: (self scopesToString: aScopes) ])
]

{ #category : #api }
MdnServer >> registerApplicationCode: aName [
	 ^ MdnApplication json: (self 
			post: self urlApiApps 
			with: [ :request |
				request
					formAt: 'client_name' put: aName;
					formAt: 'redirect_uris' put: self class defaultRedirectUri;
					formAt: 'scopes' put: (self scopesToString: MdnScope allScopes);
					formAt: 'response_type' put: 'code' ])
]

{ #category : #private }
MdnServer >> scopesToString: scopes [
	^ ' ' join: (scopes collect: #name)
]

{ #category : #accessing }
MdnServer >> url [ 
	^ url copy
]

{ #category : #accessing }
MdnServer >> urlApi [
	^ self url / 'api' / 'v1'
]

{ #category : #accessing }
MdnServer >> urlApiAccounts [
	^ self urlApi / 'accounts'
]

{ #category : #accessing }
MdnServer >> urlApiApps [
	^ self urlApi / 'apps'
]

{ #category : #accessing }
MdnServer >> urlApiStreaming [
	^ self urlApi / 'streaming'
]

{ #category : #accessing }
MdnServer >> urlOAuth [
	^ self url / 'oauth' /  'token'
]

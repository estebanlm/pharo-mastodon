"
I represent a login into a mastodon instance. 
"
Class {
	#name : #MdnLogin,
	#superclass : #MdnEntity,
	#instVars : [
		'server',
		'account'
	],
	#category : #Mastodon
}

{ #category : #'accessing api' }
MdnLogin >> accessToken [
	^ self jsonAt: 'access_token'
]

{ #category : #accessing }
MdnLogin >> account [
	^ account ifNil: [ account := self verifyCredentials ]
]

{ #category : #accessing }
MdnLogin >> application [
	^ self server application
]

{ #category : #'accessing api' }
MdnLogin >> createdAt [
	^ DateAndTime fromUnixTime: (self jsonAt: 'created_at')
]

{ #category : #api }
MdnLogin >> refreshToken [
	self flag: #todo. "Not supported for the moment (seems that mastodon.social does 
	not supports it and that's where I have my account, so I cannot validate)"
	"| app refreshJson |
	
	app := self application.
	refreshJson := self 
		post: self server urlOAuth
		with: [ :req |
			req
				headerAt: 'Authorization' put: self bearerToken;
				formAt: 'client_id' put: app clientId;
				formAt: 'client_secret' put: app clientSecret;
				formAt: 'grant_type' put: 'refresh_token';
				formAt: 'refresh_token' put: self accessToken ]."
]

{ #category : #'accessing api' }
MdnLogin >> scope [
	^ self jsonAt: 'scope'
]

{ #category : #accessing }
MdnLogin >> server [
	^ server
]

{ #category : #accessing }
MdnLogin >> server: anObject [
	server := anObject
]

{ #category : #'accessing api' }
MdnLogin >> tokenType [
	^ self jsonAt: 'token_type'
]

{ #category : #api }
MdnLogin >> verifyCredentials [
	^ MdnAccount new 
		login: self;
		json: (self 
			get: (self server urlApiAccounts / 'verify_credentials')
			with: [ :request | request authorizationBearer: self accessToken ]);
		yourself
]

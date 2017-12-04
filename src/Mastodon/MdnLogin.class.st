Class {
	#name : #MdnLogin,
	#superclass : #MdnEntity,
	#instVars : [
		'server'
	],
	#category : #Mastodon
}

{ #category : #accessing }
MdnLogin >> accessToken [
	^ self jsonAt: 'access_token'
]

{ #category : #accessing }
MdnLogin >> application [
	^ self server application
]

{ #category : #private }
MdnLogin >> bearerToken [
	^ 'Bearer {1}' format: { self accessToken }
]

{ #category : #api }
MdnLogin >> refreshToken [
	| app refreshJson |
	
	app := self application.
	refreshJson := self 
		post: self server urlOAuth
		with: [ :req |
			req
				headerAt: 'Authorization' put: self bearerToken;
				formAt: 'client_id' put: app clientId;
				formAt: 'client_secret' put: app clientSecret;
				formAt: 'grant_type' put: 'refresh_token';
				formAt: 'refresh_token' put: self accessToken ].
	
	refreshJson
]

{ #category : #accessing }
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

{ #category : #accessing }
MdnLogin >> timestamp [
	^ self jsonAt: 'created_at'
]

{ #category : #accessing }
MdnLogin >> tokenType [
	^ self jsonAt: 'token_type'
]

{ #category : #api }
MdnLogin >> verifyCredentials [
	^ MdnAccount fromJson: (self 
		get: (self server urlApiAccounts addPathSegment: 'verify_credentials')
		with: [ :request |
			request
				headerAt: 'Authorization' put: self bearerToken ])
]

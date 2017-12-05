"
I represent a mastodon application.

https://github.com/tootsuite/documentation/blob/master/Using-the-API/API.md#application
"
Class {
	#name : #MdnApplication,
	#superclass : #MdnEntity,
	#category : #'Mastodon-Core'
}

{ #category : #accessing }
MdnApplication >> clientId [
	^ self jsonAt: 'client_id'
]

{ #category : #accessing }
MdnApplication >> clientSecret [
	^ self jsonAt: 'client_secret'
]

{ #category : #accessing }
MdnApplication >> id [
	^ self jsonAt: 'id'
]

{ #category : #accessing }
MdnApplication >> name [
	^ self jsonAt: 'name'
]

{ #category : #'as yet unclassified' }
MdnApplication >> openAuthorizeFor: aLogin [
	| url |
	
	url := aLogin server url / 'oauth' / 'authorize'.
	url 
		queryAt: 'client_id' put: self clientId;
		queryAt: 'client_name' put: self name;
		queryAt: 'redirect_uri' put: self redirectUri;
		queryAt: 'scopes' put: (' ' join: (MdnScope allScopes collect: #name));
		queryAt: 'response_type' put: 'code'.
		
	WebBrowser openOn: url asString
]

{ #category : #accessing }
MdnApplication >> redirectUri [
	^ self 
		jsonAt: 'redirect_uri' 
		ifAbsent: 'urn:ietf:wg:oauth:2.0:oob'
]

{ #category : #accessing }
MdnApplication >> website [
	^ self jsonAt: 'website'
]

Extension { #name : #ZnClient }

{ #category : #'*Mastodon' }
ZnClient >> authorizationBearer: aString [
	self headerAt: 'Authorization' put: 'Bearer ', aString
]

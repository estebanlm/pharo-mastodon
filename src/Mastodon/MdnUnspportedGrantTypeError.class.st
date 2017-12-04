Class {
	#name : #MdnUnspportedGrantTypeError,
	#superclass : #MdnRequestError,
	#category : #Mastodon
}

{ #category : #testing }
MdnUnspportedGrantTypeError class >> isError: aString [ 
	^ aString = 'unsupported_grant_type'
]

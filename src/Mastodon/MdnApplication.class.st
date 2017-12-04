Class {
	#name : #MdnApplication,
	#superclass : #MdnEntity,
	#category : #Mastodon
}

{ #category : #options }
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

{ #category : #accessing }
MdnApplication >> redirectUri [
	^ self 
		jsonAt: 'redirect_uri' 
		ifAbsent: 'urn:ietf:wg:oauth:2.0:oob'
]

{ #category : #actions }
MdnApplication >> register [
	self api registerApplication: self
]

{ #category : #accessing }
MdnApplication >> website [
	^ self jsonAt: 'website'
]

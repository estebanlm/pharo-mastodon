"
I represent a media file to be uploaded with a new status. 
While I can upload them separately, usually that does not has sense outside a status post.

"
Class {
	#name : #MdnPostMedia,
	#superclass : #Object,
	#instVars : [
		'login',
		'fileName',
		'reference'
	],
	#category : #'Mastodon-Core'
}

{ #category : #'instance creation' }
MdnPostMedia class >> fileName: aString reference: aReference [
	^ self new 
		fileName: aString;
		reference: aReference;
		yourself
]

{ #category : #'as yet unclassified' }
MdnPostMedia >> entityForReference [
	| mimeType fileStream size |
	mimeType := ZnMimeType forFilenameExtension: self fileName asFileReference extension.
	fileStream := self reference readStream.
	mimeType isBinary ifTrue: [ fileStream binary ].
	size := self reference entry size.
	^ (ZnStreamingEntity type: mimeType length: size)
		stream: fileStream;
		yourself
]

{ #category : #accessing }
MdnPostMedia >> fileName [
	^ fileName
]

{ #category : #accessing }
MdnPostMedia >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
MdnPostMedia >> login [
	^ login
]

{ #category : #accessing }
MdnPostMedia >> login: anObject [
	login := anObject
]

{ #category : #accessing }
MdnPostMedia >> reference [
	^ reference
]

{ #category : #accessing }
MdnPostMedia >> reference: anObject [
	reference := anObject
]

{ #category : #accessing }
MdnPostMedia >> server [
	^ self login server
]

{ #category : #'as yet unclassified' }
MdnPostMedia >> upload [
	^ MdnAttachment json: (self login 
		post: self server urlApi / 'media'
		with: [ :request |
			request authorizationBearer: self login accessToken.
			"WARNING: Mastodon server has a bug and it requires this fields to be separated by a space, 
			 hence we cannot use the creator method #fieldName:fileName:entity:, which will be the 
			 correct one :("
			request addPart: (ZnMimePart new
				setContentDisposition: 'form-data; name="file"; filename="', self fileName utf8Encoded asString, '"';
				entity: self entityForReference) ])
]

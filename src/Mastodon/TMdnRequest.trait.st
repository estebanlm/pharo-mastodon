"
I define behaviour for send requests to mastodon
"
Trait {
	#name : #TMdnRequest,
	#category : #'Mastodon-Core'
}

{ #category : #'private requesting' }
TMdnRequest >> executeRequest: requestMethod url: anUrl with: aBlock [
	^ self withResponseHandling: [ 
		ZnClient new 
			url: anUrl;
			in: aBlock;
			beOneShot;
			method: requestMethod;
			execute;
			response ]
]

{ #category : #'private requesting' }
TMdnRequest >> get: anUrl [
	^ STON fromString: (self 
		rawGet: anUrl 
		with: [ :request | ])
]

{ #category : #'private requesting' }
TMdnRequest >> get: anUrl with: aBlock [
	^ STON fromString: (self 
		rawGet: anUrl 
		with: aBlock)
]

{ #category : #'private requesting' }
TMdnRequest >> post: anUrl [
	^ STON fromString: (self 
		rawPost: anUrl 
		with: [ :request | ])
]

{ #category : #'private requesting' }
TMdnRequest >> post: anUrl with: aBlock [
	^ STON fromString: (self 
		rawPost: anUrl 
		with: aBlock)
]

{ #category : #'private requesting' }
TMdnRequest >> rawGet: anUrl with: aBlock [
	^ self executeRequest: #GET url: anUrl with: aBlock 
]

{ #category : #'private requesting' }
TMdnRequest >> rawPost: anUrl with: aBlock [
	^ self executeRequest: #POST url: anUrl with: aBlock
]

{ #category : #'private requesting' }
TMdnRequest >> withResponseHandling: aBlock [
	| response |
	
	response := aBlock value.
	response isSuccess
		ifFalse: [ MdnRequestError signalResponse: response ].
	^ response contents
]

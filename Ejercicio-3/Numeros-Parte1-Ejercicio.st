!classDefinition: #NumeroTest category: 'Numeros-Parte1-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroTest methodsFor: 'tests'!
test01isZeroReturnsTrueWhenAskToZero
	self assert: zero isZero.! !

!NumeroTest methodsFor: 'tests'!
test02isZeroReturnsFalseWhenAskToOthersButZero
	self deny: one isZero.! !

!NumeroTest methodsFor: 'tests'!
test03isOneReturnsTrueWhenAskToOne
	self assert: one isOne.! !

!NumeroTest methodsFor: 'tests'!
test04isOneReturnsFalseWhenAskToOtherThanOne
	self deny: zero isOne.! !

!NumeroTest methodsFor: 'tests'!
test05EnteroAddsWithEnteroCorrectly
	self
		assert: two
		equals: one + one.! !

!NumeroTest methodsFor: 'tests'!
test06EnteroMultipliesWithEnteroCorrectly
	self
		assert: four
		equals: two * two.! !

!NumeroTest methodsFor: 'tests'!
test07FraccionAddsWithFraccionCorrectly
	| temp1 |
	temp1 _ Numero
		with: (Numero with: 7)
		over: (Numero with: 10).
	self
		assert: temp1
		equals: oneFifth + oneHalf.! !

!NumeroTest methodsFor: 'tests'!
test08FraccionMultipliesWithFraccionCorrectly
	self
		assert: twoTwentyfifth
		equals: oneFifth * twoFifth.! !

!NumeroTest methodsFor: 'tests'!
test09AparentFraccionesAreEqual
	self
		assert: oneHalf
		equals:
			(Numero
				with: two
				over: four).! !

!NumeroTest methodsFor: 'tests'!
test10AddingFraccionesCanReturnAnEntero
	self
		assert: one
		equals: oneHalf + oneHalf.! !

!NumeroTest methodsFor: 'tests'!
test11MultiplyingFraccionesCanReturnAnEntero
	self
		assert: one
		equals: twoFifth * fiveHalfs.! !

!NumeroTest methodsFor: 'tests'!
test12AFraccionCanNotBeZero
	self deny: oneHalf isZero.! !

!NumeroTest methodsFor: 'tests'!
test13AFraccionCanNotBeOne
	self deny: oneHalf isOne.! !

!NumeroTest methodsFor: 'tests'!
test14NegationOfEnteroIsCorrect
	self
		assert: negativeTwo
		equals: two negated.! !

!NumeroTest methodsFor: 'tests'!
test15NegationOfFraccionIsCorrect
	self
		assert:
			(Numero
				with: negativeOne
				over: two)
		equals: oneHalf negated.! !

!NumeroTest methodsFor: 'tests'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives
	self
		assert: oneHalf
		equals:
			(Numero
				with: negativeOne
				over: negativeTwo).! !

!NumeroTest methodsFor: 'tests'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor
	self
		assert: oneHalf negated
		equals:
			(Numero
				with: one
				over: negativeTwo).! !


!NumeroTest methodsFor: 'setup'!
setUp
	zero _ Numero with: 0.
	one _ Numero with: 1.
	two _ Numero with: 2.
	three _ Numero with: 3.
	four _ Numero with: 4.
	five _ Numero with: 5.
	eight _ Numero with: 8.
	negativeOne _ Numero with: -1.
	negativeTwo _ Numero with: -2.
	oneHalf _ Numero
		with: one
		over: two.
	oneFifth _ Numero
		with: one
		over: five.
	twoFifth _ Numero
		with: two
		over: five.
	twoTwentyfifth _ Numero
		with: two
		over: (Numero with: 25).
	fiveHalfs _ Numero
		with: five
		over: two.! !


!classDefinition: #Numero category: 'Numeros-Parte1-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: 'type value numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'SJ 5/4/2022 22:21:29'!
* arg1
	^self subclassResponsibility.
	"
	(type = #Entero and: [ arg1 type = #Entero ]) ifTrue: [ ^ self class with: value * arg1 integerValue ].
	(type = #Fraccion and: [ arg1 type = #Fraccion ]) ifTrue: [ ^ self class
			with: numerator * arg1 numerator
			over: denominator * arg1 denominator ].
	self error: 'Tipo de n�mero no soportado'."! !

!Numero methodsFor: 'arithmetic operations' stamp: 'SJ 5/4/2022 22:50:19'!
+ arg1
	^self subclassResponsibility.
"
	| temp2 temp3 |

	(type = #Entero and: [ arg1 type = #Entero ]) ifTrue: [ ^ self class with: value + arg1 integerValue ].
	(type = #Fraccion and: [ arg1 type = #Fraccion ]) ifTrue: [
		temp2 _ numerator * arg1 denominator + (denominator * arg1 numerator).
		temp3 _ denominator * arg1 denominator.
		^ self class
			with: temp2
			over: temp3 ]."
	"self error: 'Tipo de n�mero no soportado'."! !

!Numero methodsFor: 'arithmetic operations' stamp: 'SJ 5/4/2022 22:28:56'!
negated
	^self subclassResponsibility.
	"type = #Entero ifTrue: [ ^ self * (self class with: -1) ].
	type = #Fraccion ifTrue: [ ^ self class
			with: numerator * (self class with: -1)
			over: denominator ]."! !


!Numero methodsFor: 'testing'!
isNegative
	^ self subclassResponsibility.! !

!Numero methodsFor: 'testing'!
isOne
	^ self subclassResponsibility.! !

!Numero methodsFor: 'testing'!
isZero
	^ self subclassResponsibility.! !


!Numero methodsFor: 'initialization'!
initializeWith: arg1
	type _ #Entero.
	value _ arg1.! !

!Numero methodsFor: 'initialization'!
initializeWith: arg1 over: arg2
	arg1 isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	arg2 isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	type _ #Fraccion.
	numerator _ arg1.
	denominator _ arg2.! !


!Numero methodsFor: 'accessing'!
denominator
	^ denominator.! !

!Numero methodsFor: 'accessing'!
integerValue
	^ value.! !

!Numero methodsFor: 'accessing'!
numerator
	^ numerator.! !

!Numero methodsFor: 'accessing'!
type
	^ type.! !


!Numero methodsFor: 'printing' stamp: 'SJ 5/4/2022 22:56:47'!
printOn: arg1
	^self subclassResponsibility.
"
	type = #Entero ifTrue: [ arg1 print: value ].
	type = #Fraccion ifTrue: [
		arg1
			print: numerator;
			nextPut: $/;
			print: denominator ]."! !


!Numero methodsFor: 'comparing' stamp: 'SJ 5/4/2022 23:09:41'!
= arg1
	^self subclassResponsibility.
"
	^ (arg1 isKindOf: self class) and: [
		type = arg1 type and: [
			type = #Entero
				ifTrue: [ value = arg1 integerValue ]
				ifFalse: [
					type = #Fraccion ifTrue: [ numerator * arg1 denominator = (denominator * arg1 numerator) ]]]]."! !

!Numero methodsFor: 'comparing' stamp: 'SJ 5/4/2022 22:47:18'!
hash
	^self subclassResponsibility.
"
	type = #Entero ifTrue: [ ^ value hash ].
	type = #Fraccion ifTrue: [ ^ (numerator hash / denominator hash) hash ]."! !


!Numero methodsFor: 'arithmetic operations - private' stamp: 'SJ 5/4/2022 22:53:13'!
// arg1
	^self subclassResponsibility.
"
	type = #Entero ifTrue: [ ^ self class with: value // arg1 integerValue ].
	self error: 'Tipo de n�mero no soportado'."! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'SJ 5/4/2022 22:54:56'!
greatestCommonDivisorWith: arg1
	^self subclassResponsibility.
"
	type = #Entero ifTrue: [ ^ self class with: (value gcd: arg1 integerValue) ].
	self error: 'Tipo de n�mero no soportado'."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte1-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions'!
canNotDivideByZeroErrorDescription
	^ 'No se puede dividir por cero'.! !


!Numero class methodsFor: 'instance creation'!
with: arg1
	arg1 isInteger ifFalse: [ self error: 'aValue debe ser anInteger' ].
	^ Entero new initializeWith: arg1.! !

!Numero class methodsFor: 'instance creation'!
with: arg1 over: arg2
	| temp3 temp4 temp5 |
	arg2 isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	arg1 isZero ifTrue: [ ^ arg1 ].
	arg2 isNegative ifTrue: [ ^ self
			with: arg1 negated
			over: arg2 negated ].
	temp3 _ arg1 greatestCommonDivisorWith: arg2.
	temp4 _ arg1 // temp3.
	temp5 _ arg2 // temp3.
	temp5 isOne ifTrue: [ ^ temp4 ].
	^ Fraccion new
		initializeWith: temp4
		over: temp5.! !


!classDefinition: #Entero category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'SJ 5/4/2022 22:24:10'!
* arg1
	^ self class with: value * arg1 integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SJ 5/4/2022 22:10:42'!
+ arg1
	^ self class with: value + arg1 integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SJ 5/4/2022 22:29:22'!
negated
	^ self * (self class with: -1) ! !


!Entero methodsFor: 'testing'!
isNegative
	^ value < 0.! !

!Entero methodsFor: 'testing'!
isOne
	^ value = 1.! !

!Entero methodsFor: 'testing'!
isZero
	^ value = 0.! !




!Entero methodsFor: 'printing' stamp: 'SJ 5/4/2022 22:37:59'!
printOn: arg1
	^arg1 print: value.! !


!Entero methodsFor: 'comparing' stamp: 'SJ 5/4/2022 23:15:56'!
= arg1
"	(arg1 isKindOf: self class) and: [
		type = arg1 type"
	^value = arg1 integerValue.! !

!Entero methodsFor: 'comparing' stamp: 'SJ 5/4/2022 22:46:19'!
hash
	^ value hash.! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'SJ 5/4/2022 22:54:08'!
// arg1
	^ self class with: value // arg1 integerValue.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'SJ 5/4/2022 22:55:29'!
greatestCommonDivisorWith: arg1
	^ self class with: (value gcd: arg1 integerValue).! !


!Entero methodsFor: 'as yet unclassified'!
initialize: arg1
	self initializeWith: arg1.
	^ self new.! !


!classDefinition: #Fraccion category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'SJ 5/4/2022 22:25:27'!
* arg1
	^ self class
		with: numerator * arg1 numerator
		over: denominator * arg1 denominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'SJ 5/4/2022 22:12:04'!
+ arg1
	|temp2 temp3|
	temp2 _ numerator * arg1 denominator + (denominator * arg1 numerator).
		temp3 _ denominator * arg1 denominator.
		^ self class
			with: temp2
			over: temp3 ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'SJ 5/4/2022 22:29:58'!
negated
	^ self class
		with: numerator * (self class with: -1)
		over: denominator.! !


!Fraccion methodsFor: 'testing'!
isNegative
	^ denominator < 0.! !

!Fraccion methodsFor: 'testing'!
isOne
	^ false.! !

!Fraccion methodsFor: 'testing'!
isZero
	^ false.! !




!Fraccion methodsFor: 'printing' stamp: 'SJ 5/4/2022 22:41:22'!
printOn: arg1
	arg1 print: numerator;
	nextPut: $/;
	print: denominator.! !


!Fraccion methodsFor: 'comparing' stamp: 'SJ 5/4/2022 23:08:25'!
= arg1
	^numerator * arg1 denominator = (denominator * arg1 numerator).! !

!Fraccion methodsFor: 'comparing' stamp: 'SJ 5/4/2022 22:46:55'!
hash
	^(numerator hash / denominator hash) hash.! !


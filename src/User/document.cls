Class User.Document Extends %Persistent
{

/// Тип документа
Property doctype As %String;

/// Номер
Property number As %String;

Storage Default
{
<Data name="DocumentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>doctype</Value>
</Value>
<Value name="3">
<Value>number</Value>
</Value>
</Data>
<DataLocation>^User.DocumentD</DataLocation>
<DefaultData>DocumentDefaultData</DefaultData>
<IdLocation>^User.DocumentD</IdLocation>
<IndexLocation>^User.DocumentI</IndexLocation>
<StreamLocation>^User.DocumentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

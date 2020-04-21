Class User.Address Extends %SerialObject
{

Property Street As %String;

Property House As %String;

Property Flat As %String;

Storage Default
{
<Data name="AddressState">
<Value name="1">
<Value>Street</Value>
</Value>
<Value name="2">
<Value>House</Value>
</Value>
<Value name="3">
<Value>Flat</Value>
</Value>
</Data>
<State>AddressState</State>
<StreamLocation>^User.AddressS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}

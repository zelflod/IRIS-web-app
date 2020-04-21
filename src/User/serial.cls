Class User.TestSerial Extends %SerialObject
{

Property Street As %String;

Property House As %String;

Property Flat As %String;

Storage Default
{
<Data name="TestSerialState">
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
<State>TestSerialState</State>
<StreamLocation>^User.TestSerialS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}

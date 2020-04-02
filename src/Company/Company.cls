/// Компании
Class Company.Company Extends %Persistent
{

Property name As %String;

Property inn As %Integer;

Storage Default
{
<Data name="CompanyDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>inn</Value>
</Value>
</Data>
<DataLocation>^Company.CompanyD</DataLocation>
<DefaultData>CompanyDefaultData</DefaultData>
<IdLocation>^Company.CompanyD</IdLocation>
<IndexLocation>^Company.CompanyI</IndexLocation>
<StreamLocation>^Company.CompanyS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
